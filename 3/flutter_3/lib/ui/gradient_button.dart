import 'package:flutter/material.dart';

class ReactiveGradientButton extends StatelessWidget {
  final VoidCallback? onTap;
  final List<Color>? colors;
  final Widget child;
  final EdgeInsets margin;
  final bool isLoading;
  final Color? foregroundColor;
  final ButtonStyle? style;

  const ReactiveGradientButton({
    super.key,
    required this.child,
    this.margin = EdgeInsets.zero,
    this.foregroundColor,
    this.onTap,
    this.colors,
    this.isLoading = false,
    this.style,
  });

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final shape = theme.elevatedButtonTheme.style?.shape
            ?.resolve(const {MaterialState.focused}) ??
        const StadiumBorder();
    final List<Color> gradientColors =
        colors ?? [theme.primaryColorDark, theme.primaryColorLight];
    late final Decoration decoration;
    if (onTap != null) {
      decoration = ShapeDecoration(
        shadows: const [
          BoxShadow(
            color: Color(0x20000000),
            blurRadius: 2.0,
            offset: Offset(2.0, 6.0),
          ),
        ],
        shape: shape,
        gradient: LinearGradient(colors: gradientColors),
      );
    } else {
      decoration = ShapeDecoration(
        shape: shape,
        color: theme.elevatedButtonTheme.style?.backgroundColor
            ?.resolve(const {MaterialState.disabled}) ?? Colors.grey,
      );
    }

    final Color indicatorColor;
    final MaterialStateProperty<Color?>? materialForeground;
    if (foregroundColor != null) {
      indicatorColor = foregroundColor!;
      materialForeground = MaterialStateProperty.all(indicatorColor);
    } else if (colors == null) {
      indicatorColor = theme.colorScheme.onPrimary;
      materialForeground = MaterialStateProperty.all(indicatorColor);
    } else {
      final colorBrightness =
        ThemeData.estimateBrightnessForColor(gradientColors.first);
      materialForeground = colorBrightness == Brightness.light
        ? MaterialStateProperty.all(Colors.white)
        : null;
      indicatorColor = colorBrightness == Brightness.light
        ? Colors.black
        : Colors.white;
    }

    return Padding(
      padding: margin,
      child: DecoratedBox(
        decoration: decoration,
        child: ElevatedButton.icon(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.transparent),
            elevation: MaterialStateProperty.all(0.0),
            overlayColor: MaterialStateProperty.all(
              Colors.grey.shade300.withOpacity(0.25),
            ),
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            minimumSize: MaterialStateProperty.all(
                const Size(150, kMinInteractiveDimension)),
            textStyle: MaterialStateProperty.all(
              theme.textTheme.titleMedium?.merge(
                const TextStyle(
                  fontSize: 18.0,
                  height: 1.20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            shape: MaterialStateProperty.all(shape),
            foregroundColor: materialForeground,
          ).merge(style),
          icon: isLoading
              ? ConstrainedBox(
                  constraints: const BoxConstraints.tightFor(
                    width: 16.0,
                    height: 16.0,
                  ),
                  child: CircularProgressIndicator(
                    strokeWidth: 2.0,
                    color: indicatorColor,
                  ),
                )
              : const SizedBox.shrink(),
          label: child,
          onPressed: isLoading ? null : onTap,
        ),
      ),
    );
  }
}