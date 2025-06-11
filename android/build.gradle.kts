plugins {
    id("com.google.gms.google-services") version "4.4.2" apply false
    // здесь могут быть другие плагины
}

allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

// Остальной код без изменений...
val newBuildDir: Directory = rootProject.layout.buildDirectory.dir("../../build").get()
rootProject.layout.buildDirectory.value(newBuildDir)

subprojects {
    val newSubprojectBuildDir: Directory = newBuildDir.dir(project.name)
    project.layout.buildDirectory.value(newSubprojectBuildDir)
}
subprojects {
    project.evaluationDependsOn(":app")
}

tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}

tasks.withType<JavaCompile>().configureEach {
    sourceCompatibility = "11"
    targetCompatibility = "11"
    options.compilerArgs.add("-Xlint:-options")
    options.compilerArgs.add("-Xlint:-deprecation")
}
