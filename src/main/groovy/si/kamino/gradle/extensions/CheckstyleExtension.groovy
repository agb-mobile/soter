package si.kamino.gradle.extensions

import org.gradle.api.tasks.Input

/**
 * Created by blazsolar on 02/09/14.
 */
class CheckstyleExtension extends PluginBaseExtension {

    @Input boolean showViolations = false
    @Input boolean enableXml = true
    @Input boolean enableHtml = true
    @Input boolean defaultHtmlReport = false

    String toolVersion = "7.3"

}
