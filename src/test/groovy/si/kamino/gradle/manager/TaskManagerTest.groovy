package si.kamino.gradle.manager

import org.gradle.api.Project
import org.gradle.testfixtures.ProjectBuilder
import org.junit.Test
import si.kamino.gradle.SoterPlugin
import si.kamino.gradle.task.Checkstyle
import si.kamino.gradle.task.UploadTask

import static org.junit.Assert.assertTrue

/**
 * Created by blazsolar on 18/04/15.
 */
class TaskManagerTest {

    @Test
    public void testCheckstyleBasicApp() throws Exception {

        Project project = ProjectBuilder.builder().build()
        project.apply plugin: 'com.android.application'
        project.apply plugin: 'si.kamino.soter'

        SoterPlugin plugin = project.plugins.getPlugin(SoterPlugin)

        plugin.createCheckTasks()

        assertTrue project.tasks.findByName("checkstyle") instanceof Checkstyle
        assertTrue project.tasks.findByName("uploadCheckstyle") instanceof UploadTask

    }

    @Test
    public void testCheckstyleBasicLib() throws Exception {

        Project project = ProjectBuilder.builder().build()
        project.apply plugin: 'com.android.library'
        project.apply plugin: 'si.kamino.soter'

        SoterPlugin plugin = project.plugins.getPlugin(SoterPlugin)

        plugin.createCheckTasks()

        assertTrue project.tasks.findByName("checkstyle") instanceof Checkstyle
        assertTrue project.tasks.findByName("uploadCheckstyle") instanceof UploadTask

    }

}
