package com.skyfend.rtsp.flutter_rtsp_client;

import android.content.Context;

import androidx.annotation.NonNull;

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

    private final BinaryMessenger messenger;
    private final TextureRegistry textureRegistry;
    private final KeyForAssetFn keyForAsset;
    private final KeyForAssetAndPackageName keyForAssetAndPackageName;
    //

    public FlutterRtspPlayerFactory(BinaryMessenger messenger,
                                    TextureRegistry textureRegistry,
                                    KeyForAssetFn keyForAsset,
                                    KeyForAssetAndPackageName keyForAssetAndPackageName) {
        super(StandardMessageCodec.INSTANCE);
        this.messenger = messenger;
        this.textureRegistry = textureRegistry;
        this.keyForAsset = keyForAsset;
        this.keyForAssetAndPackageName = keyForAssetAndPackageName;
    }

    @NonNull
    @Override
    public PlatformView create(Context context, int viewId, Object args) {
//        Map<String, Object> params = (Map<String, Object>) args;
        return new FlutterRtspPlayer(context, viewId, args);
    }

}
