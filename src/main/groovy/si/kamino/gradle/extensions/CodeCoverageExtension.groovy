package si.kamino.gradle.extensions

import org.gradle.api.tasks.Input

/**
 * Created by blazsolar on 11/01/15.
 */
class CodeCoverageExtension {

    @Input boolean uploadReports = false;

}
