package com.example.urban_app

import android.os.Bundle
import io.flutter.embedding.android.FlutterActivity
import com.yandex.mapkit.MapKitFactory

class MainActivity: FlutterActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        // Читаем ключ из манифеста, который подставляется из .env через build.gradle
        val apiKey = metadataValue("com.yandex.maps.api_key")
        MapKitFactory.setApiKey(apiKey)
        super.onCreate(savedInstanceState)
    }

    private fun metadataValue(key: String): String {
        return try {
            val ai = packageManager.getApplicationInfo(packageName, android.content.pm.PackageManager.GET_META_DATA)
            ai.metaData.getString(key) ?: ""
        } catch (e: Exception) {
            ""
        }
    }
}
