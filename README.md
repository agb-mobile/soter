# Soter

Gradle plugin that adds support for Findbugs, Checkstyle and PMD to android projects.

[![Android Arsenal](https://img.shields.io/badge/Android%20Arsenal-Soter-brightgreen.svg?style=flat)](http://android-arsenal.com/details/1/1842)

## Compatibility

| Android plugin | Soter  |
| :------------: | :----: |
| 1.4.0+         | 1.0.2+ |
| 1.3.0 - 1.4.0  | 1.0.1+ |
| 1.2.2 - 1.3.0  | 0.6.1+ |
| 1.2.0 - 1.2.2  | 0.5.2+ |

## Usage

### Apply plugin

    buildscript {
        repositories {
            maven {
                url "https://plugins.gradle.org/m2/"
            }
        }
    
        dependencies {
             classpath "gradle.plugin.si.kamino.gradle:soter:2.0.0"
        }
    }
    
    apply plugin: 'si.kamino.soter'
    
### Adding plugin rules

    dependencies {
        checkstyleRules "<checkstyle_rules>"
        findbugsRules "<findbugs_rules>"
        pmdRules "<pmd_rules>"
    }
    
### Configuration

    soter {
        
        checkstyle {
            enabled true
            uploadReports true
            toolVersion "6.7"
            enableXml true
            enableHtml true
            defaultHtmlReport false
            maxErrors 0
            maxWarnings Integer.MAX_VALUES
        }
    
        findbugs {
            enabled true
            uploadReports true
            reportLevel "low"
            reportType "html"
            ignoreFailures false
        }
        
        pmd {
            enabled true
            uploadReports true
            ignoreFailures false
        }
        
        logs {
            uploadReports true
        }
        
        tests {
            uploadAndroidTestReports true
            uploadUnitTestReports true
        }

        docs {
            enabled true
            uploadReports true
        }

        codeCoverage {
            uploadReports true
        }
        
        publish {
            enabled true
        
            amazon {
                upload true
                uploadMapping true
                variants = ["release"]
            }

            fabric {
                upload true
                variants = ["release"]
            }

        }

        amazon {
            enabled true
            accessKey "<amazon_access_key>"
            secretKey "<amazon_secret_key>"
            bucket "<bucket>"
            path "path/in/amazon/bucket"
        }
        
        remote {
            pushToRemote true
            branch "<branch-to-push>" // current branch if `null`
            username "<username>"
            password "<passwird>"
        }
        
        afterAll {
            ghToken "<github_token>"
        }
        
    }

## License 

    The MIT License (MIT)
    
    Copyright (c) 2015 D·Labs
    Copyright (c) 2016 Kamino d.o.o.
    
    Permission is hereby granted, free of charge, to any person obtaining a copy
    of this software and associated documentation files (the "Software"), to deal
    in the Software without restriction, including without limitation the rights
    to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
    copies of the Software, and to permit persons to whom the Software is
    furnished to do so, subject to the following conditions:
    
    The above copyright notice and this permission notice shall be included in all
    copies or substantial portions of the Software.
    
    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
    IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
    FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
    AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
    LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
    OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
    SOFTWARE.
