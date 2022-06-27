package com.example.weekly_task


import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugins.googlemobileads.GoogleMobileAdsPlugin


class MainActivity : FlutterActivity() {
//

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        // TODO: Register the ListTileNativeAdFactory
        GoogleMobileAdsPlugin.registerNativeAdFactory(
                flutterEngine, "listTileSmall",
                NativeAdFactorySmall(context)
        )
        GoogleMobileAdsPlugin.registerNativeAdFactory(
                flutterEngine, "listTileMedium",
                NativeAdFactoryMedium(context)
        )
        GoogleMobileAdsPlugin.registerNativeAdFactory(
                flutterEngine, "listTile", ListTileNativeAdFactory(context))
    }

    override fun cleanUpFlutterEngine(flutterEngine: FlutterEngine) {
        super.cleanUpFlutterEngine(flutterEngine)

        // TODO: Unregister the ListTileNativeAdFactory
        GoogleMobileAdsPlugin.unregisterNativeAdFactory(flutterEngine, "listTileSmall")
        GoogleMobileAdsPlugin.unregisterNativeAdFactory(flutterEngine, "listTileMedium")
        GoogleMobileAdsPlugin.unregisterNativeAdFactory(flutterEngine, "listTile")
    }


}

