package com.sososeen09.flutter_practise

import android.content.ComponentName
import android.content.Context
import android.content.Intent
import android.content.pm.PackageInfo
import android.content.pm.PackageManager
import android.content.pm.ResolveInfo
import android.net.Uri

/**
 * @author yunlong
 * @date 2019-10-14
 */
class PackageUtils {

    companion object{
        fun startPackage(context: Context, packageName: String) {
            var pi: PackageInfo? = null

            try {
                pi = context.packageManager.getPackageInfo(packageName, 0)
            } catch (var17: PackageManager.NameNotFoundException) {
                var17.printStackTrace()
                return
            }

            val resolveIntent = Intent("android.intent.action.MAIN", null as Uri?)
            resolveIntent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
            resolveIntent.addCategory("android.intent.category.LAUNCHER")
            resolveIntent.setPackage(pi!!.packageName)
            val apps = context.packageManager.queryIntentActivities(resolveIntent, 0)
            val ri = apps.iterator().next() as ResolveInfo
            if (ri != null) {
                val packageName1 = ri.activityInfo.packageName
                val className = ri.activityInfo.name
                val intent = Intent("android.intent.action.MAIN")
                intent.addCategory("android.intent.category.LAUNCHER")
                intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
                val cn = ComponentName(packageName1, className)
                intent.component = cn
                context.startActivity(intent)
            }

        }
    }

}