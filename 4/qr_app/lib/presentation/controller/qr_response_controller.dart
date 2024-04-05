import 'dart:async';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:qr_app/model/history.dart';
import 'package:qr_app/model/qr_ui_response.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:url_launcher/url_launcher.dart';

final qrControllerProvider = Provider.autoDispose<QRViewController>(
  (_) => throw UnimplementedError(),
);

final _qrScanDataProvider = StreamProvider.autoDispose<History>(
  (ref) async* {
    final controller = ref.watch(qrControllerProvider);
    yield* controller.scannedDataStream
        .where((event) => event.code != null)
        .map((event) => event.code!)
        .asyncMap(History.now);
  },
  dependencies: [qrControllerProvider],
);

final qrResponseNotifier =
    AsyncNotifierProvider.autoDispose<_QRMessageNotifier, List<ResponseQR>>(
  _QRMessageNotifier.new,
  dependencies: [_qrScanDataProvider],
);

class _QRMessageNotifier extends AutoDisposeAsyncNotifier<List<ResponseQR>> {
  int _previousLoaders = 0;

  @override
  FutureOr<List<ResponseQR>> build() async {
    ref.listen(
      _qrScanDataProvider,
      (previous, next) {
        if (next is! AsyncData<History> || previous == next) {
          return;
        }
        final value = state.valueOrNull;
        final nextDataOrNull = previous?.valueOrNull?.message;
        if (value != null &&
            value.isNotEmpty &&
            value.first.message.message == nextDataOrNull) {
          return;
        }
        _addMessge(next.value);
      },
      fireImmediately: false,
    );
    return [];
  }

  Future<ResponseQR> _transformResponse(History history) async {
    final message = history.message;
    final possibleUri = Uri.tryParse(message);
    try {
      if (possibleUri != null && await canLaunchUrl(possibleUri)) {
        return LinkResponseQR(message: history);
      }
    } catch (e) {
      // log error
    }
    return SimpleResponseQR(message: history);
  }

  Future<void> _addMessge(History history) async {
    _previousLoaders++;
    state = const AsyncLoading<List<ResponseQR>>().copyWithPrevious(state);
    final response = await AsyncValue.guard(() => _transformResponse(history));
    _previousLoaders--;
    state = response.when(
      data: (data) {
        final List<ResponseQR>? possibleList = state.valueOrNull;
        final newState = AsyncData([data, ...?possibleList]);
        return _previousLoaders == 0
            ? newState
            : const AsyncLoading<List<ResponseQR>>().copyWithPrevious(newState);
      },
      error: (error, stack) =>
          AsyncError<List<ResponseQR>>(error, stack).copyWithPrevious(state),
      loading: () => state,
    );
  }
}
