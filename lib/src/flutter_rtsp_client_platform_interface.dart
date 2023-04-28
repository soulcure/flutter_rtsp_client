import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'flutter_rtsp_client_platform_impl.dart';

abstract class FlutterRtspClientPlatform extends PlatformInterface {
  /// Constructs a FlutterRtspClientPlatform.
  FlutterRtspClientPlatform() : super(token: _token);

  static final Object _token = Object();

  static FlutterRtspClientPlatform _instance = FlutterRtspClientPlatformImpl();

  /// The default instance of [FlutterRtspClientPlatform] to use.
  ///
  /// Defaults to [FlutterRtspClientPlatformImpl].
  static FlutterRtspClientPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [FlutterRtspClientPlatform] when
  /// they register themselves.
  static set instance(FlutterRtspClientPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  /// Returns a widget displaying the video.
  Widget buildView(
    BuildContext context,
    PlatformViewCreatedCallback onPlatformViewCreated,
  ) {
    throw UnimplementedError('buildView');
  }

  /// Creates an instance of a rtsp player
  Future<void> create({
    required int viewId,
    required String uri,
    int? type,
  }) {
    throw UnimplementedError('create');
  }

  /// Initializes the platform interface and disposes all existing players.
  ///
  /// This method is called when the plugin is first initialized
  /// and on every full restart.
  Future<void> init() {
    throw UnimplementedError('init');
  }

  /// Clears one video.
  Future<void> dispose(int viewId) {
    throw UnimplementedError('dispose');
  }
}
