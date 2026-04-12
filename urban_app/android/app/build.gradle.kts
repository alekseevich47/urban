    plugins {
    id("com.android.application")
    id("kotlin-android")
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    namespace = "com.example.urban_app"
    compileSdk = 36
    buildToolsVersion = "36.0.0"
    ndkVersion = "26.1.10909125"
    
    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }

    kotlinOptions {
        jvmTarget = "17"
    }

    defaultConfig {
        applicationId = "com.example.urban_app"
        minSdk = 26 // Рекомендую 26 для лучшей поддержки библиотек чатов и карт
        targetSdk = 36
        versionCode = 1
        versionName = "1.0.0"

        // Интеграция API ключа из локального файла настроек (или через flutter_dotenv в Dart)
        // Для Android манифеста мы можем передать его через manifestPlaceholders
        manifestPlaceholders["yandexMapsApiKey"] = "98acadd3-6dfd-421f-8da8-7d63968921f4"
    }

    externalNativeBuild {
        cmake {
            version = "3.22.1"
        }
    }

    buildTypes {
        release {
            signingConfig = signingConfigs.getByName("debug")
        }
    }

    repositories {
        maven { url = uri("https://maven.yandex.ru") }
    }
}

flutter {
    source = "../.."
}

dependencies {
        implementation("com.yandex.android:maps.mobile:4.33.1-full")
    }