package com.sososeen09.flutter_practise

import android.app.Activity
import android.content.Intent
import android.graphics.Color
import android.os.Bundle
import android.view.View
import android.widget.Button
import android.widget.FrameLayout
import io.flutter.view.FlutterView

/**
 * @author yunlong
 * @date 2019-10-14
 */
class NativeAndroidActivity : Activity() {

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        val button = Button(this)
        button.setAllCaps(false)
        button.setText("跳转到 flutter页面")

        addContentView(button, FrameLayout.LayoutParams(FrameLayout.LayoutParams.WRAP_CONTENT, FrameLayout.LayoutParams.WRAP_CONTENT))

        button.setOnClickListener(
                object : View.OnClickListener {
                    override fun onClick(v: View) {
                        val intent = Intent(this@NativeAndroidActivity, MainActivity::class.java)
                        startActivity(intent)
                    }
                })

        val flutterView = FlutterView(this)
        flutterView.setBackgroundColor(Color.RED)
        setContentView(flutterView)

    }

}