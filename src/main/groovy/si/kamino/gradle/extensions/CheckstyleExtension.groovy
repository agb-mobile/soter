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

    private int maxErrors;
    private int maxWarnings = Integer.MAX_VALUE;

    String toolVersion = "7.4"

    public int getMaxErrors() {
        return maxErrors;
    }

    public void setMaxErrors(int maxErrors) {
        this.maxErrors = maxErrors;
    }

    int getMaxWarnings() {
        return maxWarnings
    }

    void setMaxWarnings(int maxWarnings) {
        this.maxWarnings = maxWarnings
    }

}
