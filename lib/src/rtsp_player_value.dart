import 'dart:ui';

import 'package:flutter/widgets.dart';

class RtspPlayerValue {
  /// Define no error string
  static const String noError = '';
  static const String unknownError = 'An Unknown Error Occurred!';

  /// True if the video is playing. False if it's paused or stopped.
  final bool isPlaying;

  /// A description of the error if present.
  ///
  /// If [hasError] is false this is [RtspPlayerValue.noError].
  final String errorDescription;

  /// The [size] of the currently loaded video.
  ///
  /// The size is [Size.zero] if the video hasn't been initialized.
  final Size size;

  /// Indicates whether or not the vlc is ready to play.
  final bool isInitialized;

  /// Indicates whether or not the video is in an error state. If this is true
  /// [errorDescription] should have information about the problem.
  bool get hasError => errorDescription != RtspPlayerValue.noError;

  /// Returns [size.width] / [size.height] when the player is initialized, or `1.0.` when
  /// the player is not initialized or the aspect ratio would be less than or equal to 0.0.
  double get aspectRatio {
    if (!isInitialized || size.width == 0 || size.height == 0) {
      return 1.0;
    }
    final aspectRatio = size.width / size.height;
    if (aspectRatio <= 0) {
      return 1.0;
    }

    return aspectRatio;
  }

  /// Constructs a video with the given values. Only [duration] is required. The
  /// rest will initialize with default values when unset.
  RtspPlayerValue({
    this.size = Size.zero,
    this.isInitialized = false,
    this.isPlaying = false,
    this.errorDescription = RtspPlayerValue.noError,
  });

  /// Returns an instance with a `null` [Duration].
  factory RtspPlayerValue.uninitialized() {
    return RtspPlayerValue(
      isInitialized: false,
    );
  }

  /// Returns an instance with the playing state error
  /// and the given [errorDescription].
  factory RtspPlayerValue.erroneous(String? errorDescription) {
    return RtspPlayerValue(
      isInitialized: false,
      errorDescription: errorDescription ?? RtspPlayerValue.unknownError,
    );
  }

  /// Returns a new instance that has the same values as this current instance,
  /// except for any overrides passed in as arguments to [copyWidth].
  RtspPlayerValue copyWith({
    Size? size,
    bool? isInitialized,
    bool? isPlaying,
    String? errorDescription,
  }) {
    return RtspPlayerValue(
      size: size ?? this.size,
      isInitialized: isInitialized ?? this.isInitialized,
      isPlaying: isPlaying ?? this.isPlaying,
      errorDescription: errorDescription ?? this.errorDescription,
    );
  }

  @override
  String toString() {
    return 'RtspPlayerValue('
        'size: $size, '
        'isInitialized $isInitialized, '
        'isPlaying: $isPlaying, '
        'errorDescription: $errorDescription)';
  }
}
