import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:qr_app/model/qr_features.dart';
import 'package:qr_app/presentation/controller/camera_permission_controller.dart';
import 'package:qr_app/presentation/controller/qr_features_controller.dart';
import 'package:qr_app/presentation/controller/qr_response_controller.dart';
import 'package:qr_app/presentation/widget/pill_painter.dart';
import 'package:qr_app/presentation/widget/qr_data_list_tile.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class Home extends ConsumerWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final permissionNotifier = ref.watch(cameraPermission);
    return permissionNotifier.when(
      data: (data) {
        if (data) {
          return const QRScreen();
        }
        return Scaffold(
          body: Center(
            child: OutlinedButton.icon(
              icon: const Icon(Icons.camera),
              onPressed: () =>
                  ref.read(cameraPermission.notifier).askPermission(),
              label: const Text('Needs camera permission!'),
            ),
          ),
        );
      },
      error: (_, __) {
        return Scaffold(
          body: Center(
            child: OutlinedButton.icon(
              icon: const Icon(Icons.error),
              onPressed: () =>
                  ref.read(cameraPermission.notifier).askPermission(),
              label: const Text('Error asking permission, try again'),
            ),
          ),
        );
      },
      loading: () => const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      ),
    );
  }
}

class QRScreen extends StatefulWidget {
  const QRScreen({super.key});

  @override
  State<StatefulWidget> createState() => _QRScreenState();
}

class _QRScreenState extends State<QRScreen> {
  final GlobalKey<State<StatefulWidget>> qrKey = GlobalKey();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  QRViewController? controller;

  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller?.pauseCamera().then((_) => controller?.resumeCamera());
    } else if (Platform.isIOS) {
      controller?.resumeCamera();
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
  }

  @override
  Widget build(BuildContext context) {
    final qrWidget = Expanded(
      child: Align(
        alignment: const Alignment(0, -0.75),
        child: Container(
          padding: const EdgeInsets.all(16.0),
          constraints: BoxConstraints.loose(const Size.square(350.0)),
          child: QRView(
            key: qrKey,
            onQRViewCreated: _onQRViewCreated,
            overlay: QrScannerOverlayShape(
              borderColor: Colors.red,
              borderRadius: 10,
              borderLength: 30,
              borderWidth: 10,
              cutOutSize: 300,
            ),
          ),
        ),
      ),
    );
    final scaffold = Scaffold(
      key: scaffoldKey,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (controller != null) const _Features(),
            qrWidget,
          ],
        ),
      ),
      bottomSheet: controller == null
          ? null
          : DraggableScrollableSheet(
              shouldCloseOnMinExtent: false,
              maxChildSize: 0.5,
              builder: (context, scrollController) {
                final theme = Theme.of(context);
                final color = theme.colorScheme.brightness == Brightness.dark
                    ? Colors.white24
                    : Colors.black26;
                return Material(
                  type: MaterialType.transparency,
                  clipBehavior: Clip.hardEdge,
                  child: CustomPaint(
                    foregroundPainter: PillIconPaint(foreground: color),
                    child: _QRHistoryWidget(controller: scrollController),
                  ),
                );
              },
              expand: false,
              minChildSize: 0.15,
              initialChildSize: 0.35,
            ),
    );
    if (controller == null) {
      return scaffold;
    }
    return ProviderScope(
      overrides: [qrControllerProvider.overrideWithValue(controller!)],
      child: scaffold,
    );
  }
}

class _Features extends HookConsumerWidget {
  // ignore: unused_element
  const _Features({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final features = ref.watch(qrFeaturesProvider);
    ref.listen(
      qrFeaturesProvider.select((m) => m.error),
      (previous, next) {
        if (next == previous || next == null) {
          return;
        }
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('error changing the configuration')));
      },
    );

    return features.maybeWhen(
      skipLoadingOnReload: true,
      skipError: true,
      data: (data) {
        final flash = data.flash;
        final camera = data.camera;
        return Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16.0,
            vertical: 24.0,
          ),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                if (flash != null)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: IconButton.filledTonal(
                      iconSize: 32,
                      icon: Icon(flash
                          ? Icons.flash_on_rounded
                          : Icons.flash_off_rounded),
                      onPressed: camera?.camera == Camera.front
                          ? null
                          : ref.read(qrFeaturesProvider.notifier).toggleFlash,
                      tooltip: flash ? 'Turn off flash' : 'Turn on flash',
                    ),
                  ),
                if (camera != null)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: IconButton.filledTonal(
                      iconSize: 32,
                      icon: Icon(camera.camera == Camera.back
                          ? Icons.camera_alt_rounded
                          : Icons.camera_front_rounded),
                      onPressed: camera.hasBoth
                          ? ref.read(qrFeaturesProvider.notifier).toggleCamera
                          : null,
                      tooltip: camera.camera == Camera.front
                          ? 'Back camera'
                          : 'Front camera',
                    ),
                  ),
              ],
            ),
          ),
        );
      },
      orElse: () => const SizedBox(),
    );
  }
}

class _QRHistoryWidget extends ConsumerWidget {
  final ScrollController? controller;

  // ignore: unused_element
  const _QRHistoryWidget({super.key, this.controller});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncList = ref.watch(qrResponseNotifier);
    final Widget sliver = asyncList.when(
      skipError: true,
      error: (_, __) => const SliverToBoxAdapter(
        child: Center(
          child: Text('Error reading QR'),
        ),
      ),
      loading: () => const SliverToBoxAdapter(
        child: Center(child: CircularProgressIndicator()),
      ),
      data: (data) {
        return SliverList.separated(
          itemBuilder: (context, index) {
            final response = data[index];
            return QRListTile(responseQR: response);
          },
          separatorBuilder: (context, index) => const Divider(),
          itemCount: data.length,
        );
      },
    );
    return CustomScrollView(
      controller: controller,
      slivers: [
        SliverPadding(
          padding: const EdgeInsets.symmetric(vertical: 24.0),
          sliver: sliver,
        ),
      ],
    );
  }
}
