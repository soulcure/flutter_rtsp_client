package com.skyfend.rtsp.flutter_rtsp_client;

import androidx.annotation.NonNull;

import io.flutter.FlutterInjector;
import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.embedding.engine.plugins.activity.ActivityAware;
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding;

/**
 * FlutterRtspCodePlugin
 */
public class FlutterRtspClientPlugin implements FlutterPlugin, ActivityAware {

    private static FlutterRtspPlayerFactory flutterRtspPlayerFactory;
    private FlutterPluginBinding flutterPluginBinding;
    private static final String VIEW_TYPE = "flutter_video_plugin/getVideoView";


    @Override
    public void onAttachedToEngine(@NonNull FlutterPluginBinding binding) {
        flutterPluginBinding = binding;
        if (flutterRtspPlayerFactory == null) {
            final FlutterInjector injector = FlutterInjector.instance();
            flutterRtspPlayerFactory = new FlutterRtspPlayerFactory(
                    flutterPluginBinding.getBinaryMessenger(),
                    flutterPluginBinding.getTextureRegistry(),
                    injector.flutterLoader()::getLookupKeyForAsset,
                    injector.flutterLoader()::getLookupKeyForAsset);
            flutterPluginBinding.getPlatformViewRegistry()
                    .registerViewFactory(VIEW_TYPE, flutterRtspPlayerFactory);
        }
        startListening();

    }

    @Override
    public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
        stopListening();
        flutterPluginBinding = null;
    }

    @Override
    public void onAttachedToActivity(@NonNull ActivityPluginBinding activityPluginBinding) {

    }

    @Override
    public void onDetachedFromActivityForConfigChanges() {

    }

    @Override
    public void onReattachedToActivityForConfigChanges(@NonNull ActivityPluginBinding activityPluginBinding) {

    }

    @Override
    public void onDetachedFromActivity() {

    }


    private static void startListening() {
        if (flutterRtspPlayerFactory != null)
            flutterRtspPlayerFactory.start();
    }

    private static void stopListening() {
        if (flutterRtspPlayerFactory != null) {
            flutterRtspPlayerFactory.stop();
            flutterRtspPlayerFactory = null;
        }
    }
}
