package com.skyfend.rtsp.flutter_rtsp_client;

import android.content.Context;
import android.view.TextureView;
import android.view.View;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;

import io.flutter.plugin.platform.PlatformView;

class FlutterRtspPlayer implements PlatformView {

    private final TextureView textureView;

    FlutterRtspPlayer(@NonNull Context context, int id, @Nullable Object creationParams) {
        textureView = new TextureView(context);
    }

    @NonNull
    @Override
    public View getView() {
        return textureView;
    }

    @Override
    public void dispose() {
    }
}
