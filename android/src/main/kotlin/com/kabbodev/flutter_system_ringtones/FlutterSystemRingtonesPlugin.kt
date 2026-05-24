package com.kabbodev.flutter_system_ringtones

import android.content.Context
import android.database.Cursor
import android.media.RingtoneManager
import androidx.annotation.NonNull
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result

class FlutterSystemRingtonesPlugin : FlutterPlugin, MethodCallHandler {
    private lateinit var channel: MethodChannel
    private lateinit var appContext: Context

    override fun onAttachedToEngine(
        @NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding,
    ) {
        appContext = flutterPluginBinding.applicationContext
        channel = MethodChannel(
            flutterPluginBinding.binaryMessenger,
            "flutter_system_ringtones",
        )
        channel.setMethodCallHandler(this)
    }

    override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
        try {
            when (call.method) {
                "getRingtones" -> {
                    val list = arrayListOf<HashMap<String, Any>>()
                    loadSounds(appContext, RingtoneManager.TYPE_RINGTONE, list)
                    result.success(list)
                }
                "getNotifications" -> {
                    val list = arrayListOf<HashMap<String, Any>>()
                    loadSounds(appContext, RingtoneManager.TYPE_NOTIFICATION, list)
                    result.success(list)
                }
                "getAlarms" -> {
                    val list = arrayListOf<HashMap<String, Any>>()
                    loadSounds(appContext, RingtoneManager.TYPE_ALARM, list)
                    result.success(list)
                }
                else -> result.notImplemented()
            }
        } catch (e: Exception) {
            result.error("ringtone_error", e.message, null)
        }
    }

    override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }

    private fun loadSounds(
        context: Context,
        type: Int,
        list: ArrayList<HashMap<String, Any>>,
    ) {
        val ringtoneManager = RingtoneManager(context)
        ringtoneManager.setType(type)
        load(ringtoneManager.cursor, list)
    }

    private fun load(cursor: Cursor?, list: ArrayList<HashMap<String, Any>>) {
        if (cursor == null) {
            return
        }
        cursor.use {
            if (it.count == 0) {
                return
            }
            val titleIndex = RingtoneManager.TITLE_COLUMN_INDEX
            val idIndex = RingtoneManager.ID_COLUMN_INDEX
            val uriIndex = RingtoneManager.URI_COLUMN_INDEX
            if (it.moveToFirst()) {
                do {
                    val itemTitle = it.getString(titleIndex) ?: continue
                    val itemId = it.getString(idIndex) ?: continue
                    val uriBase = it.getString(uriIndex) ?: continue
                    list.add(
                        hashMapOf(
                            "id" to itemId,
                            "title" to itemTitle,
                            "uri" to "$uriBase/$itemId",
                        ),
                    )
                } while (it.moveToNext())
            }
        }
    }
}
