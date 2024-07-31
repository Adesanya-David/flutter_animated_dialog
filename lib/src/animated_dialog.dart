import 'dart:async';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'custom_dialog_transitions.dart';

/// Is dialog showing
bool isShowing = false;

enum DialogTransitionType {
  /// Fade animation
  fade,

  /// Slide from top animation
  slideFromTop,

  /// Slide from top fade animation
  slideFromTopFade,

  /// Slide from bottom animation
  slideFromBottom,

  /// Slide from bottom fade animation
  slideFromBottomFade,

  /// Slide from left animation
  slideFromLeft,

  /// Slide from left fade animation
  slideFromLeftFade,

  /// Slide from right animation
  slideFromRight,

  /// Slide from right fade animation
  slideFromRightFade,

  /// Scale animation
  scale,

  /// Fade scale animation
  fadeScale,

  /// Rotation animation
  rotate,

  /// Scale rotate animation
  scaleRotate,

  /// Fade rotate animation
  fadeRotate,

  /// 3D Rotation animation
  rotate3D,

  /// Size animation
  size,

  /// Size fade animation
  sizeFade,

  /// No animation
  none,
}

/// Displays a Material dialog above the current contents of the app
Future<T?>? showAnimatedDialog<T>({
  required BuildContext context,
  bool barrierDismissible = false,
  required WidgetBuilder builder,
  DialogTransitionType animationType = DialogTransitionType.fade,
  Curve curve = Curves.linear,
  Duration? duration,
  Alignment alignment = Alignment.center,
  Axis? axis,
}) {
  assert(debugCheckHasMaterialLocalizations(context));

  final ThemeData theme = Theme.of(context);

  isShowing = true;
  return showGeneralDialog(
    context: context,
    pageBuilder: (BuildContext buildContext, Animation<double> animation,
        Animation<double> secondaryAnimation) {
      final Widget pageChild = Builder(builder: builder);
      return SafeArea(
        top: false,
        child: Theme(
          data: theme,
          child: pageChild,
        ),
      );
    },
    barrierDismissible: barrierDismissible,
    barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
    barrierColor: Colors.black54,
    transitionDuration: duration ?? const Duration(milliseconds: 400),
    transitionBuilder: (BuildContext context, Animation<double> animation,
        Animation<double> secondaryAnimation, Widget child) {
      switch (animationType) {
        case DialogTransitionType.fade:
          return FadeTransition(opacity: animation, child: child);
        case DialogTransitionType.slideFromRight:
          return SlideTransition(
            transformHitTests: false,
            position: Tween<Offset>(
              begin: const Offset(1.0, 0.0),
              end: Offset.zero,
            ).chain(CurveTween(curve: curve)).animate(animation),
            child: child,
          );
        case DialogTransitionType.slideFromLeft:
          return SlideTransition(
            transformHitTests: false,
            position: Tween<Offset>(
              begin: const Offset(-1.0, 0.0),
              end: Offset.zero,
            ).chain(CurveTween(curve: curve)).animate(animation),
            child: child,
          );
        case DialogTransitionType.slideFromRightFade:
          return SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(1.0, 0.0),
              end: Offset.zero,
            ).chain(CurveTween(curve: curve)).animate(animation),
            child: FadeTransition(
              opacity: animation,
              child: child,
            ),
          );
        case DialogTransitionType.slideFromLeftFade:
          return SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(-1.0, 0.0),
              end: Offset.zero,
            ).chain(CurveTween(curve: curve)).animate(animation),
            child: FadeTransition(
              opacity: animation,
              child: child,
            ),
          );
        case DialogTransitionType.slideFromTop:
          return SlideTransition(
            transformHitTests: false,
            position: Tween<Offset>(
              begin: const Offset(0.0, -1.0),
              end: Offset.zero,
            ).chain(CurveTween(curve: curve)).animate(animation),
            child: child,
          );
        case DialogTransitionType.slideFromTopFade:
          return SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0.0, -1.0),
              end: Offset.zero,
            ).chain(CurveTween(curve: curve)).animate(animation),
            child: FadeTransition(
              opacity: animation,
              child: child,
            ),
          );
        case DialogTransitionType.slideFromBottom:
          return SlideTransition(
            transformHitTests: false,
            position: Tween<Offset>(
              begin: const Offset(0.0, 1.0),
              end: Offset.zero,
            ).chain(CurveTween(curve: curve)).animate(animation),
            child: child,
          );
        case DialogTransitionType.slideFromBottomFade:
          return SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0.0, 1.0),
              end: Offset.zero,
            ).chain(CurveTween(curve: curve)).animate(animation),
            child: FadeTransition(
              opacity: animation,
              child: child,
            ),
          );
        case DialogTransitionType.scale:
          return ScaleTransition(
            alignment: alignment,
            scale: CurvedAnimation(
              parent: animation,
              curve: Interval(
                0.00,
                0.50,
                curve: curve,
              ),
            ),
            child: child,
          );
        case DialogTransitionType.fadeScale:
          return ScaleTransition(
            alignment: alignment,
            scale: CurvedAnimation(
              parent: animation,
              curve: Interval(
                0.00,
                0.50,
                curve: curve,
              ),
            ),
            child: FadeTransition(
              opacity: CurvedAnimation(
                parent: animation,
                curve: curve,
              ),
              child: child,
            ),
          );
        case DialogTransitionType.scaleRotate:
          return ScaleTransition(
            alignment: alignment,
            scale: CurvedAnimation(
              parent: animation,
              curve: Interval(
                0.00,
                0.50,
                curve: curve,
              ),
            ),
            child: CustomRotationTransition(
              alignment: alignment,
              turns: Tween<double>(begin: 1, end: 2).animate(CurvedAnimation(
                  parent: animation, curve: Interval(0.0, 1.0, curve: curve))),
              child: child,
            ),
          );
        case DialogTransitionType.rotate:
          return CustomRotationTransition(
            alignment: alignment,
            turns: Tween<double>(begin: 1, end: 2).animate(CurvedAnimation(
                parent: animation, curve: Interval(0.0, 1.0, curve: curve))),
            child: child,
          );
        case DialogTransitionType.fadeRotate:
          return CustomRotationTransition(
            alignment: alignment,
            turns: Tween<double>(begin: 1, end: 2).animate(CurvedAnimation(
                parent: animation, curve: Interval(0.0, 1.0, curve: curve))),
            child: FadeTransition(
              opacity: CurvedAnimation(
                parent: animation,
                curve: curve,
              ),
              child: child,
            ),
          );
        case DialogTransitionType.rotate3D:
          return Rotation3DTransition(
            alignment: alignment,
            turns: Tween<double>(begin: math.pi, end: 2.0 * math.pi).animate(
                CurvedAnimation(
                    parent: animation,
                    curve: Interval(0.0, 1.0, curve: curve))),
            child: FadeTransition(
              opacity: Tween<double>(begin: 0.0, end: 1.0).animate(
                  CurvedAnimation(
                      parent: animation,
                      curve: Interval(0.5, 1.0, curve: Curves.elasticOut))),
              child: child,
            ),
          );
        case DialogTransitionType.size:
          return Align(
            alignment: alignment,
            child: SizeTransition(
              sizeFactor: CurvedAnimation(
                parent: animation,
                curve: curve,
              ),
              axis: axis ?? Axis.vertical,
              child: child,
            ),
          );
        case DialogTransitionType.sizeFade:
          return Align(
            alignment: alignment,
            child: SizeTransition(
              sizeFactor: CurvedAnimation(
                parent: animation,
                curve: curve,
              ),
              child: FadeTransition(
                opacity: CurvedAnimation(
                  parent: animation,
                  curve: curve,
                ),
                child: child,
              ),
            ),
          );
        case DialogTransitionType.none:
          return child;
        default:
          return FadeTransition(opacity: animation, child: child);
      }
    },
  );
}

/// created time: 2019-07-19 14:35
/// author linzhiliang
/// version 1.0
/// since
/// file name: animated_dialog.dart
/// description: Custom dialog widget
///
class CustomDialogWidget extends StatelessWidget {
  /// Creates an alert dialog.
  ///
  /// Typically used in conjunction with [showDialog].
  ///
  /// The [contentPadding] must not be null. The [actionsPadding] must not be
  /// null.
  const CustomDialogWidget({
    super.key,
    this.title,
    this.titlePadding,
    this.titleTextStyle,
    this.content,
    this.contentPadding = const EdgeInsets.fromLTRB(24.0, 20.0, 24.0, 24.0),
    this.contentTextStyle,
    this.actions,
    this.actionsPadding = EdgeInsets.zero,
    this.actionsOverflowDirection,
    this.actionsOverflowButtonSpacing,
    this.buttonPadding,
    this.backgroundColor,
    this.elevation,
    this.semanticLabel,
    this.shape,
    this.insetPadding =
        const EdgeInsets.symmetric(horizontal: 40.0, vertical: 24.0),
    this.clipBehavior,
    this.alignment,
  });

  /// The (optional) title of the dialog is displayed in a large font at the top of the dialog.
  final Widget? title;

  /// Padding around the title. Default is EdgeInsets.fromLTRB(24.0, 24.0, 24.0, 0.0).
  final EdgeInsetsGeometry? titlePadding;

  /// Style for the text in the [title] widget.
  final TextStyle? titleTextStyle;

  /// The (optional) content of the dialog is displayed in the center of the dialog in a lighter font.
  final Widget? content;

  /// Padding around the content.
  final EdgeInsetsGeometry contentPadding;

  /// Style for the text in the [content] widget.
  final TextStyle? contentTextStyle;

  /// A list of actions that are displayed at the bottom of the dialog.
  final List<Widget>? actions;

  /// Padding around the set of [actions] at the bottom of the dialog.
  final EdgeInsetsGeometry actionsPadding;

  /// Specifies how the [actions] overflow should be handled.
  final VerticalDirection? actionsOverflowDirection;

  /// The spacing between buttons in the overflow of [actions].
  final double? actionsOverflowButtonSpacing;

  /// Padding between the button and the dialog.
  final EdgeInsetsGeometry? buttonPadding;

  /// The background color of the surface of this dialog.
  final Color? backgroundColor;

  /// The elevation of the dialog.
  final double? elevation;

  /// The semantic label of the dialog used by accessibility frameworks.
  final String? semanticLabel;

  /// The shape of the dialog's border.
  final ShapeBorder? shape;

  /// The padding that surrounds the dialog.
  final EdgeInsets insetPadding;

  /// The clip behavior of the dialog.
  final Clip? clipBehavior;

  /// The alignment of the dialog.
  final AlignmentGeometry? alignment;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final DialogTheme dialogTheme = DialogTheme.of(context);
    return Semantics(
      namesRoute: true,
      label: semanticLabel,
      child: Dialog(
        backgroundColor: backgroundColor ?? dialogTheme.backgroundColor,
        elevation: elevation ?? dialogTheme.elevation,
        insetPadding: insetPadding,
        clipBehavior: clipBehavior ?? Clip.none,
        shape: shape ?? dialogTheme.shape,
        alignment: alignment,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            if (title != null)
              Padding(
                padding: titlePadding ??
                    const EdgeInsets.fromLTRB(24.0, 24.0, 24.0, 0.0),
                child: DefaultTextStyle(
                  style: titleTextStyle ??
                      dialogTheme.titleTextStyle ??
                      theme.textTheme.titleLarge!,
                  child: Semantics(namesRoute: true, child: title),
                ),
              ),
            Flexible(
              child: Padding(
                padding: contentPadding,
                child: DefaultTextStyle(
                  style: contentTextStyle ??
                      dialogTheme.contentTextStyle ??
                      theme.textTheme.titleMedium!,
                  child: content ?? const SizedBox.shrink(),
                ),
              ),
            ),
            if (actions != null)
              ButtonBar(
                buttonPadding: buttonPadding ?? const EdgeInsets.all(8.0),
                overflowDirection: actionsOverflowDirection,
                overflowButtonSpacing: actionsOverflowButtonSpacing,
                alignment: MainAxisAlignment.end,
                children: actions!,
              ),
          ],
        ),
      ),
    );
  }
}
