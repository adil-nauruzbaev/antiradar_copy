package com.antiradar.app
import android.content.Context
import android.media.AudioDeviceInfo
import android.media.AudioManager
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {
    private val CHANNEL = "com.example/antiradar/audio_channel"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL)
            .setMethodCallHandler { call, result ->
                if (call.method == "setAudioOutput") {
                    val output = call.argument<String>("output")
                    setAudioOutput(output)
                    result.success(null)
                } else {
                    result.notImplemented()
                }
            }
    }

    private fun setAudioOutput(output: String?) {
        val audioManager = getSystemService(Context.AUDIO_SERVICE) as AudioManager
        when (output) {
            "Bluetooth" -> {
                audioManager.startBluetoothSco()
                audioManager.mode = AudioManager.MODE_IN_CALL
            }
            "Speaker" -> {
                audioManager.mode = AudioManager.MODE_NORMAL
                audioManager.isSpeakerphoneOn = true
            }
            "Headphones" -> {
                audioManager.mode = AudioManager.MODE_IN_COMMUNICATION
            }
            "Automatically" -> {
                audioManager.mode = AudioManager.MODE_NORMAL
                audioManager.isSpeakerphoneOn = false
            }
            else -> {
                audioManager.mode = AudioManager.MODE_NORMAL
            }
        }
    }
}