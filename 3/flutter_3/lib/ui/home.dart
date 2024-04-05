
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_3/controller/profile_controller.dart';
import 'package:flutter_3/ui/appbar_paint.dart';
import 'package:provider/provider.dart';

class PaintedAppBar extends StatelessWidget implements PreferredSizeWidget {
  // ignore: unused_element
  const PaintedAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final List<Color> gradientColors = [
      theme.primaryColorDark,
      theme.primaryColorLight
    ];
    final Decoration decoration = BoxDecoration(
      gradient: LinearGradient(colors: gradientColors),
    );
    return DecoratedBox(
      decoration: decoration,
      child: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle.light,
        forceMaterialTransparency: true,
        centerTitle: true,
        titleTextStyle: const TextStyle(
          color: Colors.white,
          fontSize: 28.0,
          fontWeight: FontWeight.w300,
        ),
        title: Selector<UserProfileNotifier, String>(
          selector: (context, userNotifier) => userNotifier.profile.name,
          builder: (context, value, child) => Text(value, maxLines: 1),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(104.0),
          child: CustomPaint(
            painter: const AppBarPaint(foreground: Colors.white),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Card(
                margin: EdgeInsets.zero,
                color: Colors.white,
                shape: const CircleBorder(
                  side: BorderSide(color: Colors.grey),
                ),
                elevation: 2.0,
                surfaceTintColor: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: ShaderMask(
                    blendMode: BlendMode.srcIn,
                    shaderCallback: (Rect bounds) => LinearGradient(
                      colors: gradientColors,
                    ).createShader(bounds),
                    child: const Icon(
                      Icons.person_3_rounded,
                      size: 80,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  final Size preferredSize = const Size.fromHeight(160.0);
}
