package si.kamino.gradle.extensions

import org.gradle.api.tasks.Input

/**
 * Created by blazsolar on 02/09/14.
 */
class CheckstyleExtension extends PluginBaseExtension {

    @Input boolean showViolations = false

    String toolVersion = "6.7";

}
