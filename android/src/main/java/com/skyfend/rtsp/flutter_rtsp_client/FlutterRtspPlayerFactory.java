package com.skyfend.rtsp.flutter_rtsp_client;

import android.content.Context;

import androidx.annotation.NonNull;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import io.flutter.plugin.common.BasicMessageChannel;
import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.StandardMessageCodec;
import io.flutter.plugin.platform.PlatformView;
import io.flutter.plugin.platform.PlatformViewFactory;
import io.flutter.view.TextureRegistry;


class FlutterRtspPlayerFactory extends PlatformViewFactory {

    public interface KeyForAssetFn {
        String get(String asset);
    }

    public interface KeyForAssetAndPackageName {
        String get(String asset, String packageName);
    }

    private final BinaryMessenger binaryMessenger;
    private final TextureRegistry textureRegistry;
    private final KeyForAssetFn keyForAsset;
    private final KeyForAssetAndPackageName keyForAssetAndPackageName;
    //

    private FlutterRtspPlayer flutterRtspPlayer;

    public FlutterRtspPlayerFactory(BinaryMessenger messenger,
                                    TextureRegistry textureRegistry,
                                    KeyForAssetFn keyForAsset,
                                    KeyForAssetAndPackageName keyForAssetAndPackageName) {
        super(StandardMessageCodec.INSTANCE);
        this.binaryMessenger = messenger;
        this.textureRegistry = textureRegistry;
        this.keyForAsset = keyForAsset;
        this.keyForAssetAndPackageName = keyForAssetAndPackageName;
    }

    @NonNull
    @Override
    public PlatformView create(Context context, int viewId, Object args) {
        final Map<String, Object> creationParams = (Map<String, Object>) args;
        if (flutterRtspPlayer == null) {
            flutterRtspPlayer = new FlutterRtspPlayer(context, viewId, creationParams, binaryMessenger, textureRegistry);
        }
        return flutterRtspPlayer;
    }

//    public void start() {
//        BasicMessageChannel<Object> channel =
//                new BasicMessageChannel<>(binaryMessenger, "flutter.video.RTspPlayerApi.initialize", new StandardMessageCodec());
//        channel.setMessageHandler((message, reply) -> {
//            Map<String, Object> wrapped = new HashMap<>();
//            @SuppressWarnings("ConstantConditions")
//            ApiMessage input = ApiMessage.fromMap((Map<String, Object>) message);
//            wrapped.put("result", null);
//            reply.reply(wrapped);
//        });
//    }
//
//    public void stop() {
//        flutterRtspPlayer.stop();
//    }
}
