package com.example.deferred_components_test
import androidx.annotation.NonNull

import android.os.Bundle
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugins.GeneratedPluginRegistrant
import io.flutter.view.FlutterMain

import android.content.res.AssetManager;

class MainActivity: FlutterActivity() {

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, "test").setMethodCallHandler {
          call, result ->
          val inputstream = getAssets().open("flutter_assets/deferred_assets/books/vancouver.jpg");
          System.out.println(inputstream.available())
          result.success(inputstream.available())
        }
      }
}
