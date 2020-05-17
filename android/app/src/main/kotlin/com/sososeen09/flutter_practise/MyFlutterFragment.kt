package com.sososeen09.flutter_practise

import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.fragment.app.Fragment
import io.flutter.view.FlutterView

/**
 * @author yunlong
 * @date 2019-10-14
 */
class MyFlutterFragment:Fragment() {

    override fun onCreateView(inflater: LayoutInflater, container: ViewGroup?, savedInstanceState: Bundle?): View? {


        val view = FlutterView(activity)

        return super.onCreateView(inflater, container, savedInstanceState)
    }
}