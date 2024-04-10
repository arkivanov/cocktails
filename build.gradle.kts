plugins {
    alias(libs.plugins.moko.resources.generator).apply(false)
    alias(libs.plugins.compose).apply(false)
    alias(libs.plugins.android.application).apply(false)
    alias(libs.plugins.kotlinx.serialization).apply(false)
    alias(libs.plugins.multiplatform).apply(false)
}

tasks.register<Delete>("clean") {
    delete(rootProject.buildDir)
}
