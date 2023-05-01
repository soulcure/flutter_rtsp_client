import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rtsp_client/src/video_player_api.dart';

import 'flutter_rtsp_client_platform_interface.dart';

class FlutterRtspClientPlatform extends FlutterRtspClientPlatformInterface {
  final _api = VideoPlayerApi();

  @override
  Future<void> init() async {
    return _api.initialize();
  }

  @override
  Future<void> create({
    required int viewId,
    required String uri,
    int? type,
  }) async {
    final message = ApiMessage();
    message.viewId = viewId;
    message.uri = uri;
    message.type = type;
    return _api.create(message);
  }

  @override
  Future<void> dispose(int viewId) async {
    return _api.dispose(ApiMessage()..viewId = viewId);
  }

  @override
  Widget buildView(
    BuildContext context,
    PlatformViewCreatedCallback onPlatformViewCreated, {
    required Map<String, dynamic> creationParams,
  }) {
    // This is used in the platform side to register the view.
    const String viewType = 'flutter_video_plugin/getVideoView';

    return PlatformViewLink(
      viewType: viewType,
      surfaceFactory: (context, controller) {
        return AndroidViewSurface(
          controller: controller as AndroidViewController,
          gestureRecognizers: const <Factory<OneSequenceGestureRecognizer>>{},
          hitTestBehavior: PlatformViewHitTestBehavior.opaque,
        );
      },
      onCreatePlatformView: (params) {
        return PlatformViewsService.initSurfaceAndroidView(
          id: params.id,
          viewType: viewType,
          layoutDirection: TextDirection.ltr,
          creationParams: creationParams,
          creationParamsCodec: const StandardMessageCodec(),
          onFocus: () {
            params.onFocusChanged(true);
          },
        )
          ..addOnPlatformViewCreatedListener(params.onPlatformViewCreated)
          //..addOnPlatformViewCreatedListener(onPlatformViewCreated)
          ..create();
      },
    );
  }
}
