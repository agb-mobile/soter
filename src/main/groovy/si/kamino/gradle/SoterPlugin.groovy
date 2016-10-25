package si.kamino.gradle

import com.android.annotations.VisibleForTesting
import org.gradle.api.Plugin
import org.gradle.api.Project
import org.gradle.internal.reflect.Instantiator
import si.kamino.gradle.extensions.SoterExtension
import si.kamino.gradle.manager.TaskManager

import javax.inject.Inject
/**
 * Created by blazsolar on 02/09/14.z
 */
class SoterPlugin implements Plugin<Project> {

    private final Instantiator instantiator

    private Project project;
    private TaskManager taskManager;

    private SoterExtension extension;

    @Inject
    SoterPlugin(Instantiator instantiator) {
        this.instantiator = instantiator
    }

    def isAndroidProject(Project project) {
        project.plugins.hasPlugin('com.android.application') || project.plugins.hasPlugin('com.android.library') || project.plugins.hasPlugin('com.android.test')
    }

    @Override
    void apply(Project project) {
        if (!isAndroidProject(project)) {
            throw new IllegalStateException("SoterPlugin only works with Android projects but \"${project.name}\" is none")
        }

        this.project = project;

        createExtensions()
        createTasks()
    }

    private void createExtensions() {
        extension = project.extensions.create('soter', SoterExtension,
                instantiator)
        taskManager = new TaskManager(project, extension);
    }

    private void createTasks() {

        taskManager.createTasks()

        project.afterEvaluate {
            createCheckTasks()
        }

    }

    @VisibleForTesting(visibility = VisibleForTesting.Visibility.PROTECTED)
    final void createCheckTasks() {
        taskManager.createCheckTasks()
    }

}
