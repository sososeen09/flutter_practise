package com.sososeen09.flutter_practise

import android.content.Context
import android.graphics.Color
import android.util.Log
import android.util.TypedValue
import android.view.View
import android.view.ViewGroup
import android.widget.LinearLayout
import android.widget.TextView
import android.widget.Toast
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.StandardMessageCodec
import io.flutter.plugin.platform.PlatformView
import io.flutter.plugin.platform.PlatformViewFactory

/**
 * @author yunlong
 * @date 2019-10-14
 */
class SampleViewFactory(var messenger: BinaryMessenger) : PlatformViewFactory(StandardMessageCodec.INSTANCE) {
    override fun create(context: Context, id: Int, p2: Any?): PlatformView {
        return SampleViewControl(context, id, messenger)
    }

    class SampleViewControl// 初始化方法，提前创建好视图
    (context: Context, id: Int, messenger: BinaryMessenger) : PlatformView, MethodChannel.MethodCallHandler {
        private var mContext: Context
        private val methodChannel: MethodChannel
        private var methodChannel2: MethodChannel? = null
        private val mRootView: View// 缓存原生视图

        init {
            mRootView = LinearLayout(context)
            //
            val view = TextView(context)
            view.text = "原生View,点击关闭当前页面"
            view.setTextSize(TypedValue.COMPLEX_UNIT_DIP, 16f)
            view.setOnClickListener {
                Toast.makeText(context, "close page", Toast.LENGTH_SHORT).show()
                methodChannel2?.invokeMethod("closePage", null)
            }
            //
            mRootView.addView(view)
            mRootView.setBackgroundColor(Color.rgb(255, 0, 0))
            methodChannel = MethodChannel(messenger, "sample.view/native_views_$id")
            methodChannel2 = MethodChannel(messenger, "sample.view/native_views")
            methodChannel.setMethodCallHandler(this)


            Log.e(TAG, "SampleViewControl: context: $context")
            this.mContext = context

        }

        // 返回原生视图
        override fun getView(): View {

//
//            val view = ViewManager.getInstance().view
//            val viewGroup = view?.parent
//            viewGroup?.let {
//                val viewGroup1 = it as ViewGroup
//                viewGroup1.removeView(view)
//            }

            return mRootView
        }


        // 原生视图销毁回调
        override fun dispose() {}

        override fun onMethodCall(methodCall: MethodCall, result: MethodChannel.Result) {
            Log.e(TAG, "onMethodCall: " + methodCall.method)
            if (methodCall.method == "changeBackgroundColor") {
                mRootView.setBackgroundColor(Color.rgb(0, 0, 255))
                result.success(0)
            } else {
                result.notImplemented()
            }
        }

        companion object {
            val TAG = "flutter.view"
        }
    }
}