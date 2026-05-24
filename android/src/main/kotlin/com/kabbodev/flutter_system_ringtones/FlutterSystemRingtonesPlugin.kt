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

    private val ringtones = arrayListOf<HashMap<String, Any>>()
    private val alarms = arrayListOf<HashMap<String, Any>>()
    private val notifications = arrayListOf<HashMap<String, Any>>()

    override fun onAttachedToEngine(
        @NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding,
    ) {
        channel = MethodChannel(
            flutterPluginBinding.binaryMessenger,
            "flutter_system_ringtones",
        )
        channel.setMethodCallHandler(this)
        val context = flutterPluginBinding.applicationContext
        loadRingtones(context)
        loadAlarms(context)
        loadNotifications(context)
    }

    override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
        when (call.method) {
            "getRingtones" -> result.success(ringtones)
            "getNotifications" -> result.success(notifications)
            "getAlarms" -> result.success(alarms)
            else -> result.notImplemented()
        }
    }

    override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
        clear()
        channel.setMethodCallHandler(null)
    }

    private fun loadRingtones(context: Context) {
        val ringtoneManager = RingtoneManager(context)
        ringtoneManager.setType(RingtoneManager.TYPE_RINGTONE)
        load(ringtoneManager.cursor, ringtones)
    }

    private fun loadAlarms(context: Context) {
        val ringtoneManager = RingtoneManager(context)
        ringtoneManager.setType(RingtoneManager.TYPE_ALARM)
        load(ringtoneManager.cursor, alarms)
    }

    private fun loadNotifications(context: Context) {
        val ringtoneManager = RingtoneManager(context)
        ringtoneManager.setType(RingtoneManager.TYPE_NOTIFICATION)
        load(ringtoneManager.cursor, notifications)
    }

    private fun load(cursor: Cursor, list: ArrayList<HashMap<String, Any>>) {
        if (!cursor.isFirst) {
            cursor.moveToFirst()
        }
        do {
            val itemTitle = cursor.getString(RingtoneManager.TITLE_COLUMN_INDEX)
            val itemId = cursor.getString(RingtoneManager.ID_COLUMN_INDEX)
            val itemUri =
                cursor.getString(RingtoneManager.URI_COLUMN_INDEX) + "/" + itemId
            list.add(
                hashMapOf(
                    "id" to itemId,
                    "title" to itemTitle,
                    "uri" to itemUri,
                ),
            )
        } while (cursor.moveToNext())
        cursor.close()
    }

    private fun clear() {
        ringtones.clear()
        alarms.clear()
        notifications.clear()
    }
}
