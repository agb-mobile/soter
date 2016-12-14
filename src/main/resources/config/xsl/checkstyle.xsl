<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
    <xsl:output method="html" indent="yes"/>
    <xsl:decimal-format decimal-separator="." grouping-separator="," />

    <xsl:key name="files" match="file" use="@name" />

    <xsl:template match="checkstyle">
        <xsl:text disable-output-escaping='yes'>&lt;!DOCTYPE html&gt;</xsl:text>
        <html>
            <head>
                <title>CheckStyle Report</title>
                <meta charset="utf-8" />
                <meta http-equiv="X-UA-Compatible" content="IE=edge" />
                <meta name="viewport" content="width=device-width, initial-scale=1" />
                <link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons" />
                <link rel="stylesheet" href="https://code.getmdl.io/1.2.1/material.indigo-pink.min.css" />
                <script src="https://code.getmdl.io/1.2.1/material.min.js" />
                <style>
                    .card-content {
                        max-width: 1080px;
                    }

                    .checkstyle-table {
                        table-layout: fixed;
                    }

                    .checkstyle-table td {
                        word-wrap: break-word;
                    }
                </style>
            </head>
            <body>
                <div class="mdl-layout mdl-js-layout mdl-layout--fixed-header">
                    <header class="mdl-layout__header">
                        <div class="mdl-layout__header-row">
                            <!-- Title -->
                            <span class="mdl-layout-title">CheckStyle Report</span>
                        </div>
                    </header>
                    <div class="mdl-layout__drawer">
                        <span class="mdl-layout-title">Severities</span>
                        <nav class="mdl-navigation">

                            <a class="mdl-navigation__link" href="#summary">Summary</a>

                            <xsl:variable name="errorCount" select="count(file/error[@severity='error'])"/>
                            <xsl:if test="$errorCount > 0">
                                <a class="mdl-navigation__link" href="#error">Errors</a>
                            </xsl:if>

                            <xsl:variable name="warningCount" select="count(file/error[@severity='warning'])"/>
                            <xsl:if test="$warningCount > 0">
                                <a class="mdl-navigation__link" href="#warning">Warnings</a>
                            </xsl:if>

                            <xsl:variable name="infoCount" select="count(file/error[@severity='info'])"/>
                            <xsl:if test="$infoCount > 0">
                                <a class="mdl-navigation__link" href="#info">Info</a>
                            </xsl:if>
                        </nav>
                    </div>
                    <main class="mdl-layout__content mdl-color--grey-100">
                        <div class="mdl-grid card-content">

                            <!-- Summary part -->
                            <xsl:apply-templates select="." mode="summary"/>

                            <!-- Package List part -->
                            <xsl:apply-templates select="." mode="filelist">
                                <xsl:with-param name="type" select="'error'" />
                                <xsl:with-param name="title" select="'Errors'" />
                            </xsl:apply-templates>

                            <!-- Package List part -->
                            <xsl:apply-templates select="." mode="filelist">
                                <xsl:with-param name="type" select="'warning'" />
                                <xsl:with-param name="title" select="'Warnings'" />
                            </xsl:apply-templates>

                            <!-- Package List part -->
                            <xsl:apply-templates select="." mode="filelist">
                                <xsl:with-param name="type" select="'info'" />
                                <xsl:with-param name="title" select="'Info'" />
                            </xsl:apply-templates>

                        </div>
                    </main>
                    <footer class="mdl-mini-footer">
                        <div class="mdl-mini-footer__left-section">
                            <div class="mdl-logo">Made with ♥ by <a href="http://www.kamino.si">Kamino</a></div>
                        </div>
                    </footer>
                </div>

            </body>
        </html>
    </xsl:template>

    <xsl:template match="checkstyle" mode="filelist">
        <xsl:param name="type" />
        <xsl:param name="title" />

        <xsl:variable name="count" select="count(file/error[@severity=$type])"/>
        <xsl:if test="$count > 0">

            <div class="mdl-color--white mdl-shadow--2dp mdl-cell mdl-cell--12-col mdl-grid">
                <a name="{$type}" />
                <div class="mdl-card__title">
                    <h2 class="mdl-card__title-text"><xsl:value-of select="$title"/></h2>
                </div>
                <div class="mdl-card__supporting-text">
                    <table class="mdl-data-table mdl-js-data-table checkstyle-table" width="100%">
                        <xsl:for-each select="file[descendant::error[@severity=$type] and @name and generate-id(.) = generate-id(key('files', @name))]">
                            <tr>
                                <th class="mdl-data-table__cell--non-numeric" colspan="3"><xsl:value-of select="@name"/></th>
                            </tr>

                            <xsl:for-each select="error[@severity=$type]">
                                <tr>
                                    <td class="mdl-data-table__cell--non-numeric"><xsl:value-of select="@line"/></td>
                                    <td class="mdl-data-table__cell--non-numeric"><xsl:value-of select="@message"/></td>
                                    <td>
                                        <button class="mdl-button mdl-js-button mdl-button--icon">

                                            <!-- Example template call -->
                                            <xsl:variable name="errorPath">
                                                <xsl:call-template name="string-replace">
                                                    <xsl:with-param name="string" select="@source" />
                                                    <xsl:with-param name="replace" select="'.'" />
                                                    <xsl:with-param name="with" select="'/'" />
                                                </xsl:call-template>
                                            </xsl:variable>

                                            <a href="http://checkstyle.sourceforge.net/apidocs/{$errorPath}.html" target="_blank" >
                                                <i class="material-icons">info</i>
                                            </a>
                                        </button>
                                    </td>
                                </tr>
                            </xsl:for-each>
                        </xsl:for-each>
                    </table>
                </div>
            </div>

        </xsl:if>
    </xsl:template>

    <xsl:template match="checkstyle" mode="summary">

        <div class="mdl-color--white mdl-shadow--2dp mdl-cell mdl-cell--12-col mdl-grid">
            <div class="mdl-card__title">
                <h2 class="mdl-card__title-text">Summary</h2>
            </div>
            <div class="mdl-card__supporting-text">
                <xsl:variable name="fileCount" select="count(file[@name and generate-id(.) = generate-id(key('files', @name))])"/>
                <xsl:variable name="errorCount" select="count(file/error[@severity='error'])"/>
                <xsl:variable name="warningCount" select="count(file/error[@severity='warning'])"/>
                <xsl:variable name="infoCount" select="count(file/error[@severity='info'])"/>
                <table class="mdl-data-table mdl-js-data-table" width="100%">
                    <tr>
                        <th>Files</th>
                        <th>Errors</th>
                        <th>Warnings</th>
                        <th>Infos</th>
                    </tr>
                    <tr>
                        <td><xsl:value-of select="$fileCount"/></td>
                        <td><xsl:value-of select="$errorCount"/></td>
                        <td><xsl:value-of select="$warningCount"/></td>
                        <td><xsl:value-of select="$infoCount"/></td>
                    </tr>
                </table>
            </div>
        </div>
    </xsl:template>

    <xsl:template name="string-replace">
        <xsl:param name="string" />
        <xsl:param name="replace" />
        <xsl:param name="with" />

        <xsl:choose>
            <xsl:when test="contains($string, $replace)">
                <xsl:value-of select="substring-before($string, $replace)" />
                <xsl:value-of select="$with" />
                <xsl:call-template name="string-replace">
                    <xsl:with-param name="string" select="substring-after($string,$replace)" />
                    <xsl:with-param name="replace" select="$replace" />
                    <xsl:with-param name="with" select="$with" />
                </xsl:call-template>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="$string" />
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

</xsl:stylesheet>

