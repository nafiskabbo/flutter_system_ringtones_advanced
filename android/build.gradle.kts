group = "com.kabbodev.flutter_system_ringtones"
version = "1.0-SNAPSHOT"

plugins {
    id("com.android.library")
}

val agpMajor =
    com.android.Version.ANDROID_GRADLE_PLUGIN_VERSION.substringBefore('.').toInt()

if (agpMajor < 9) {
    apply(plugin = "org.jetbrains.kotlin.android")
}

android {
    namespace = "com.kabbodev.flutter_system_ringtones"
    compileSdk = 36

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }

    defaultConfig {
        minSdk = 16
    }

    lint {
        disable.add("InvalidPackage")
    }

    sourceSets {
        getByName("main") {
            java.srcDirs("src/main/kotlin")
        }
    }
}

project.extensions.configure(
    org.jetbrains.kotlin.gradle.dsl.KotlinAndroidProjectExtension::class.java,
) {
    compilerOptions {
        jvmTarget = org.jetbrains.kotlin.gradle.dsl.JvmTarget.JVM_17
    }
}
