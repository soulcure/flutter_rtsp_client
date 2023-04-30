package com.skyfend.rtsp.flutter_rtsp_client;

import android.content.Context;
import android.net.Uri;
import android.util.Log;
import android.view.SurfaceHolder;
import android.view.View;

import androidx.annotation.NonNull;

import java.util.List;
import java.util.Map;
import java.util.Objects;

import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.platform.PlatformView;
import io.flutter.view.TextureRegistry;

import com.alexvas.rtsp.widget.RtspSurfaceView;

class FlutterRtspPlayer implements PlatformView {

    private static final String TAG = FlutterRtspPlayer.class.getSimpleName();
    private final RtspSurfaceView rtspSurfaceView;

    FlutterRtspPlayer(@NonNull Context context, int viewId, Map<String, Object> creationParams,
                      BinaryMessenger binaryMessenger, TextureRegistry textureRegistry) {
        rtspSurfaceView = new RtspSurfaceView(context);
        rtspSurfaceView.getHolder().addCallback(new SurfaceHolder.Callback() {
            @Override
            public void surfaceCreated(SurfaceHolder holder) {
                Log.d(TAG, "surfaceCreated=" + System.currentTimeMillis());
                String url = Objects.requireNonNull(creationParams.get("url")).toString();
                String username = Objects.requireNonNull(creationParams.get("username")).toString();
                String password = Objects.requireNonNull(creationParams.get("password")).toString();
                start(url, username, password);

            }

            @Override
            public void surfaceChanged(SurfaceHolder holder, int format, int width, int height) {
                Log.d(TAG, "surfaceChanged=" + System.currentTimeMillis());
            }

            @Override
            public void surfaceDestroyed(SurfaceHolder holder) {
                Log.d(TAG, "surfaceDestroyed=" + System.currentTimeMillis());
            }
        });
    }

    @NonNull
    @Override
    public View getView() {
        return rtspSurfaceView;
    }

    @Override
    public void dispose() {
        Log.d(TAG, "PlatformView dispose");
        stop();
    }


    public void start(String url, String username, String password) {
        Uri uri = Uri.parse(url);
        rtspSurfaceView.init(uri, username, password);
        rtspSurfaceView.start(true, false);

    }

    public void stop() {
        rtspSurfaceView.stop();
    }

}
