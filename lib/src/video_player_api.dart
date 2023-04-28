import 'package:flutter/services.dart';

class VideoPlayerApi {
  final BinaryMessenger? _binaryMessenger;

  /// Constructor for [VideoPlayerApi].  The [binaryMessenger] named argument is
  /// available for dependency injection.  If it is left null, the default
  /// BinaryMessenger will be used which routes to the host platform.
  VideoPlayerApi({BinaryMessenger? binaryMessenger})
      : _binaryMessenger = binaryMessenger;

  Future<void> initialize() async {
    final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
      'flutter.video.RTspPlayerApi.initialize',
      const StandardMessageCodec(),
      binaryMessenger: _binaryMessenger,
    );
    final Map<Object?, Object?>? replyMap =
        await channel.send(null) as Map<Object?, Object?>?;
    if (replyMap == null) {
      throw PlatformException(
        code: 'channel-error',
        message: 'Unable to establish connection on channel.',
        details: null,
      );
    } else if (replyMap['error'] != null) {
      final Map<Object?, Object?> error =
          replyMap['error'] as Map<Object?, Object?>? ?? {};
      throw PlatformException(
        code: error['code'] as String? ?? "",
        message: error['message'] as String?,
        details: error['details'],
      );
    }
  }

  Future<void> create(ApiMessage arg) async {
    final Object encoded = arg.encode();
    final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
      'flutter.video.RTspPlayerApi.create',
      const StandardMessageCodec(),
      binaryMessenger: _binaryMessenger,
    );
    final Map<Object?, Object?>? replyMap =
        await channel.send(encoded) as Map<Object?, Object?>?;
    if (replyMap == null) {
      throw PlatformException(
        code: 'channel-error',
        message: 'Unable to establish connection on channel.',
        details: null,
      );
    } else if (replyMap['error'] != null) {
      final Map<Object?, Object?> error =
          replyMap['error'] as Map<Object?, Object?>? ?? {};
      throw PlatformException(
        code: error['code'] as String? ?? "",
        message: error['message'] as String?,
        details: error['details'],
      );
    }
  }

  Future<void> dispose(ApiMessage arg) async {
    final Object encoded = arg.encode();
    final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
      'flutter.video.RTspPlayerApi.dispose',
      const StandardMessageCodec(),
      binaryMessenger: _binaryMessenger,
    );
    final Map<Object?, Object?>? replyMap =
        await channel.send(encoded) as Map<Object?, Object?>?;
    if (replyMap == null) {
      throw PlatformException(
        code: 'channel-error',
        message: 'Unable to establish connection on channel.',
        details: null,
      );
    } else if (replyMap['error'] != null) {
      final Map<Object?, Object?> error =
          replyMap['error'] as Map<Object?, Object?>? ?? {};
      throw PlatformException(
        code: error['code'] as String? ?? "",
        message: error['message'] as String?,
        details: error['details'],
      );
    }
  }
}

class ApiMessage {
  int? viewId;
  String? uri;
  int? type;

  ApiMessage();

  ApiMessage.decode(Object message) {
    final Map<Object?, Object?> pigeonMap = message as Map<Object?, Object?>;
    viewId = pigeonMap['viewId'] as int?;
    uri = pigeonMap['uri'] as String?;
    type = pigeonMap['type'] as int?;
  }

  Object encode() {
    final Map<Object?, Object?> pigeonMap = <Object?, Object?>{};
    pigeonMap['viewId'] = viewId;
    pigeonMap['uri'] = uri;
    pigeonMap['type'] = type;
    return pigeonMap;
  }
}
