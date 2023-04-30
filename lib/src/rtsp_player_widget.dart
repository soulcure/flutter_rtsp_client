import 'package:flutter/widgets.dart';
import 'package:flutter_rtsp_client/src/rtsp_player_controller.dart';

import 'flutter_rtsp_client_platform_interface.dart';

class FlutterRtspPlayer extends StatefulWidget {
  final RtspPlayerController controller;
  final double aspectRatio;

  const FlutterRtspPlayer({
    Key? key,
    required this.controller,

    /// The aspect ratio used to display the video.
    /// This MUST be provided, however it could simply be (parentWidth / parentHeight) - where parentWidth and
    /// parentHeight are the width and height of the parent perhaps as defined by a LayoutBuilder.
    required this.aspectRatio,
  }) : super(key: key);

  @override
  State createState() => _FlutterRtspPlayerState();
}

class _FlutterRtspPlayerState extends State<FlutterRtspPlayer>
    with AutomaticKeepAliveClientMixin {
  bool _isInitialized = false;

  //ignore: avoid-late-keyword
  late VoidCallback _listener;

  @override
  bool get wantKeepAlive => true;

  _FlutterRtspPlayerState() {
    _listener = () {
      if (!mounted) return;
      //
      final isInitialized = widget.controller.value.isInitialized;
      if (isInitialized != _isInitialized) {
        setState(() {
          _isInitialized = isInitialized;
        });
      }
    };
  }

  @override
  void initState() {
    super.initState();
    _isInitialized = widget.controller.value.isInitialized;
    // Need to listen for initialization events since the actual initialization value
    // becomes available after asynchronous initialization finishes.
    widget.controller.addListener(_listener);
  }

  @override
  void didUpdateWidget(FlutterRtspPlayer oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.controller != widget.controller) {
      oldWidget.controller.removeListener(_listener);
      _isInitialized = widget.controller.value.isInitialized;
      widget.controller.addListener(_listener);
    }
  }

  @override
  void deactivate() {
    super.deactivate();
    widget.controller.removeListener(_listener);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return AspectRatio(
      aspectRatio: widget.aspectRatio,
      child: rtspPlayerPlatform.buildView(
        context,
        widget.controller.onPlatformViewCreated,
        creationParams: {
          'url': 'rtsp://192.168.0.105:8554/video',
          'username': 'admin',
          'password': 'Autel123',
        },
      ),
    );
  }
}
