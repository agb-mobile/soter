package si.kamino.gradle.task

import com.android.SdkConstants
import com.android.build.gradle.api.AndroidSourceSet
import si.kamino.gradle.commons.Utils
import org.gradle.api.tasks.TaskAction
import si.kamino.gradle.extensions.CheckstyleExtension

/**
 * Created by blazsolar on 07/04/15.
 */
class Checkstyle extends org.gradle.api.plugins.quality.Checkstyle {

    @Override @TaskAction
    void run() {

        configFile project.configurations.checkstyleRules.singleFile

        super.run()
    }

    void setup(CheckstyleExtension extension) {

        description "Checkstyle for debug source"
        group "Check"

        ignoreFailures extension.ignoreFailures
        showViolations extension.showViolations

        if (Utils.isGradle34orAbove(project)) {
            maxErrors extension.maxErrors
            maxWarnings extension.maxWarnings
        } else {
            if (extension.maxErrors != 0) {
                logger.warn("To use soter.checkstyle.maxErrors you have to update gradle to 3.4 or above")
            }

            if (extension.maxWarnings != Integer.MAX_VALUE) {
                logger.warn("To use soter.checkstyle.maxWarnings you have to update gradle to 3.4 or above")
            }
        }

        def sets
        if (Utils.is140orAbove()) {
            sets = project.android.sourceSets;
        } else {
            sets = project.android.sourceSetsContainer;
        }

        sets.all { AndroidSourceSet sourceSet ->
            if (!sourceSet.name.startsWith("test") && !sourceSet.name.startsWith(SdkConstants.FD_TEST)) {
                source sourceSet.java.srcDirs
            }
        }

        include '**/*.java'
        exclude '**/gen/**'

        classpath = project.files()

    }
}
