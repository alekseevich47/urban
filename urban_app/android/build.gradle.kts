// ✅ Корневой build.gradle.kts

// 👇 1. Добавляем репозитории для buildscript
buildscript {
    repositories {
        google()
        mavenCentral()
        // Зеркало для ускорения загрузки (Alibaba)
        maven { url = uri("https://maven.aliyun.com/repository/public") }
    }
}

// 👇 2. Добавляем репозитории для всех проектов + настройки путей
allprojects {
    repositories {
        google()
        mavenCentral()
        // Зеркало для ускорения загрузки
        maven { url = uri("https://maven.aliyun.com/repository/public") }
    }
}

// 👇 3. Твои настройки путей (современный Directory API)
val newBuildDir: Directory =
    rootProject.layout.buildDirectory
        .dir("../../build")
        .get()
rootProject.layout.buildDirectory.value(newBuildDir)

subprojects {
    val newSubprojectBuildDir: Directory = newBuildDir.dir(project.name)
    project.layout.buildDirectory.value(newSubprojectBuildDir)

    afterEvaluate {
        if (project.extensions.findByName("android") != null) {
            val android = project.extensions.getByName("android") as com.android.build.gradle.BaseExtension
            android.compileSdkVersion(36)
            android.ndkVersion = "26.1.10909125"
        }
    }
}

// 👇 4. Зависимости между проектами
subprojects {
    project.evaluationDependsOn(":app")
}

// 👇 5. Задача clean с новым API
tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}