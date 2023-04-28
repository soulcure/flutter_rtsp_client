package com.skyfend.rtsp.flutter_rtsp_client;

import android.content.Context;
import android.net.Uri;
import android.view.View;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;

import java.util.List;

import io.flutter.plugin.platform.PlatformView;

import com.alexvas.rtsp.widget.RtspSurfaceView;

class FlutterRtspPlayer implements PlatformView {

    private final RtspSurfaceView rtspSurfaceView;

    FlutterRtspPlayer(@NonNull Context context, int id, @Nullable Object creationParams) {
        rtspSurfaceView = new RtspSurfaceView(context);
    }

    @NonNull
    @Override
    public View getView() {
        return rtspSurfaceView;
    }

    @Override
    public void dispose() {
    }


    public void initialize(List<String> options) {
        Uri uri = Uri.parse("rtsps://10.0.1.3/test.sdp");
        String username = "admin";
        String password = "Autel123";
        rtspSurfaceView.init(uri, username, password);
        rtspSurfaceView.start(true, false);

    }

}
