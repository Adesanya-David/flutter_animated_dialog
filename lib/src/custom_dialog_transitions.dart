import 'dart:math' as math;
import 'package:flutter/material.dart';

/// Animates the rotation of a widget in 3D space.
///
/// This widget animates the rotation of a child widget around the Y-axis.
///
/// See also:
///  * [ScaleTransition], a widget that animates the scale of a transformed widget.
///  * [SizeTransition], a widget that animates its own size and clips and aligns its child.
class Rotation3DTransition extends AnimatedWidget {
  /// Creates a rotation transition.
  ///
  /// The [turns] argument must not be null.
  const Rotation3DTransition({
    Key? key,
    required Animation<double> turns,
    this.alignment = Alignment.center,
    required this.child,
  }) : super(key: key, listenable: turns);

  /// The animation that controls the rotation of the child.
  ///
  /// If the current value of the turns animation is v, the child will be
  /// rotated v * 2 * pi radians before being painted.
  Animation<double> get turns => listenable as Animation<double>;

  /// The alignment of the origin of the coordinate system around which the
  /// rotation occurs, relative to the size of the box.
  ///
  /// For example, to set the origin of the rotation to the top-right corner, use
  /// an alignment of (1.0, -1.0) or use [Alignment.topRight].
  final AlignmentGeometry alignment;

  /// The widget below this widget in the tree.
  ///
  /// {@macro flutter.widgets.child}
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final double turnsValue = turns.value;
    final Matrix4 transform = Matrix4.identity()
      ..setEntry(3, 2, 0.001) // Adjusted for better perspective effect
      ..rotateY(turnsValue * 2 * math.pi);
    return Transform(
      transform: transform,
      alignment: alignment,
      child: child,
    );
  }
}

/// Animates the rotation of a widget around the Z-axis.
///
/// This widget animates the rotation of a child widget around the Z-axis.
///
/// See also:
///  * [ScaleTransition], a widget that animates the scale of a transformed widget.
///  * [SizeTransition], a widget that animates its own size and clips and aligns its child.
class CustomRotationTransition extends AnimatedWidget {
  /// Creates a rotation transition.
  ///
  /// The [turns] argument must not be null.
  const CustomRotationTransition({
    Key? key,
    required Animation<double> turns,
    this.alignment = Alignment.center,
    required this.child,
  }) : super(key: key, listenable: turns);

  /// The animation that controls the rotation of the child.
  ///
  /// If the current value of the turns animation is v, the child will be
  /// rotated v * 2 * pi radians before being painted.
  Animation<double> get turns => listenable as Animation<double>;

  /// The alignment of the origin of the coordinate system around which the
  /// rotation occurs, relative to the size of the box.
  ///
  /// For example, to set the origin of the rotation to the top-right corner, use
  /// an alignment of (1.0, -1.0) or use [Alignment.topRight].
  final AlignmentGeometry alignment;

  /// The widget below this widget in the tree.
  ///
  /// {@macro flutter.widgets.child}
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final double turnsValue = turns.value;
    final Matrix4 transform = Matrix4.rotationZ(turnsValue * 2 * math.pi);
    return Transform(
      transform: transform,
      alignment: alignment,
      child: child,
    );
  }
}
