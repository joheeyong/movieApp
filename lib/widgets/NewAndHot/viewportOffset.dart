import 'package:flutter/animation.dart';
import 'package:flutter/foundation.dart';

enum ScrollDirection {
  idle,
  forward,
  reverse,
}

ScrollDirection flipScrollDirection(ScrollDirection direction) {
  switch (direction) {
    case ScrollDirection.idle:
      return ScrollDirection.idle;
    case ScrollDirection.forward:
      return ScrollDirection.reverse;
    case ScrollDirection.reverse:
      return ScrollDirection.forward;
  }
}

abstract class ViewportOffset extends ChangeNotifier {
  ViewportOffset();

  factory ViewportOffset.fixed(double value) = FixedViewportOffset;

  factory ViewportOffset.zero() = FixedViewportOffset.zero;

  double get pixels;

  bool get hasPixels;

  bool applyViewportDimension(double viewportDimension);

  bool applyContentDimensions(double minScrollExtent, double maxScrollExtent);

  void correctBy(double correction);

  void jumpTo(double pixels);

  Future<void> animateTo(
    double to, {
    required Duration duration,
    required Curve curve,
  });

  Future<void> moveTo(
    double to, {
    Duration? duration,
    Curve? curve,
    bool? clamp,
  }) {
    if (duration == null || duration == Duration.zero) {
      jumpTo(to);
      return Future<void>.value();
    } else {
      return animateTo(to, duration: duration, curve: curve ?? Curves.ease);
    }
  }

  ScrollDirection get userScrollDirection;

  bool get allowImplicitScrolling;

  @override
  String toString() {
    final List<String> description = <String>[];
    debugFillDescription(description);
    return '${describeIdentity(this)}(${description.join(", ")})';
  }

  @mustCallSuper
  void debugFillDescription(List<String> description) {
    if (hasPixels) {
      description.add('offset: ${pixels.toStringAsFixed(1)}');
    }
  }
}

class FixedViewportOffset extends ViewportOffset {
  FixedViewportOffset(this._pixels);

  FixedViewportOffset.zero() : _pixels = 0.0;

  double _pixels;

  @override
  double get pixels => _pixels;

  @override
  bool get hasPixels => true;

  @override
  bool applyViewportDimension(double viewportDimension) => true;

  @override
  bool applyContentDimensions(double minScrollExtent, double maxScrollExtent) =>
      true;

  @override
  void correctBy(double correction) {
    _pixels += correction;
  }

  @override
  void jumpTo(double pixels) {
    // Do nothing, viewport is fixed.
  }

  @override
  Future<void> animateTo(
    double to, {
    required Duration duration,
    required Curve curve,
  }) async {}

  @override
  ScrollDirection get userScrollDirection => ScrollDirection.idle;

  @override
  bool get allowImplicitScrolling => false;
}
