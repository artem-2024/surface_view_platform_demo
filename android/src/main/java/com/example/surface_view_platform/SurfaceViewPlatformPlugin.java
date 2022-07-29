package com.example.surface_view_platform;


import androidx.annotation.NonNull;


import io.flutter.embedding.engine.plugins.FlutterPlugin;

import io.flutter.plugin.platform.PlatformViewRegistry;

/**
 * SurfaceViewPlatformPlugin
 */
public class SurfaceViewPlatformPlugin implements FlutterPlugin {


    @Override
    public void onAttachedToEngine(@NonNull FlutterPluginBinding flutterPluginBinding) {
        final PlatformViewRegistry registry = flutterPluginBinding.getPlatformViewRegistry();
        registry.registerViewFactory("Test/surface_view_platform", new TestSurfaceViewFactory());
    }

    @Override
    public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
    }
}