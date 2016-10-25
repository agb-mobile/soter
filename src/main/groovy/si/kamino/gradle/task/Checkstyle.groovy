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

        def sets;
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
