package com.sososeen09.flutter_practise

import android.content.Intent
import android.os.Bundle
import android.util.Log
import android.view.ViewGroup
import android.widget.Button
import android.widget.Toast

import io.flutter.app.FlutterActivity
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugins.GeneratedPluginRegistrant

class MainActivity: FlutterActivity() {
  val TAG = "method call"

  override fun onCreate(savedInstanceState: Bundle?) {
    super.onCreate(savedInstanceState)
    GeneratedPluginRegistrant.registerWith(this)
    //创建于调用方法标识符一样的方法通道
    MethodChannel(flutterView, "sample.method/utils").setMethodCallHandler { methodCall, result ->
      Log.e(TAG, "onMethodCall: " + methodCall.method + "   argus: " + methodCall.arguments)
      when (methodCall.method) {
        "openApp" -> {
          val arguments = methodCall.arguments
          Log.e(TAG, "onMethodCall: $arguments")
          try {
            PackageUtils.startPackage(this@MainActivity, arguments.toString())
            Toast.makeText(this@MainActivity, "open app success", Toast.LENGTH_SHORT).show()
            result.success(0)
          } catch (e: Exception) {
            result.error("UNAVALIABLE", "没有安装", null)
          }

        }
        "openAppLogin" -> {
          val intent = Intent(this@MainActivity, NativeAndroidActivity::class.java)
          startActivity(intent)
        }
        else -> result.notImplemented()
      }
    }

    val registrar = registrarFor("sample.view/native_views")
    val sampleViewFactory = SampleViewFactory(registrar.messenger())
    registrar.platformViewRegistry().registerViewFactory("sampleView", sampleViewFactory)
  }
}
