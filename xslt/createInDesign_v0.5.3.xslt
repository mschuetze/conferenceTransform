<?xml version="1.0" encoding="UTF-8"?>
<!-- v0.5.1 -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:aid="http://ns.adobe.com/AdobeInDesign/4.0/"
    xmlns:px="http://www.publishingx.de"
    exclude-result-prefixes="xs" version="2.0">

    <xsl:strip-space elements="*"/>

    <xsl:output method="xml" indent="no" encoding="UTF-8"/>

    <xsl:param name="p-folder-out" select="'out'"/>

    <xsl:key name="speakers" match="conferenceData/speakers/speaker" use="uniqueId"/>

    <xsl:variable name="uhr">Uhr</xsl:variable>

    <xsl:variable name="isSoMe" select="false()"/>
    
    <!-- Extraktion der Eingabedateinamen aus den source-file Elementen -->
    <xsl:variable name="sourceFileNames">
        <xsl:value-of select="string-join(//source-file/@name, '__')"/>
    </xsl:variable>
    
    <!-- Entfernung der .xml Endungen -->
    <xsl:variable name="sourceFileNameSuffix">
        <xsl:value-of select="replace($sourceFileNames, '\.xml', '')"/>
    </xsl:variable>

    <!-- Identity Pattern -->
    <xsl:template match="node() | @*" priority="-1">
        <xsl:copy>
            <xsl:apply-templates select="node() | @*"/>
        </xsl:copy>
    </xsl:template>

    <xsl:template match="/">
        <!--Erstellung von Auflistungen für:
Speakers
Keynotes
Sessions
Workshops
jeweils in vier Versionen:
Mit Raum ohne Datum
Mit Raum mit Datum
Ohne Raum mit Datum
Ohne Raum ohne Datum
Es werden alle Varianten als einzelne Datei erstellt => 12 Dateien.
-->
        <!-- Speakers -->
        <xsl:variable name="outPath"
            select="concat('file:///', $p-folder-out, '/Speaker_Namen--', $sourceFileNameSuffix, '.xml')"/>
        <xsl:result-document href="{$outPath}">
            <speakers>
                <xsl:apply-templates select="//conferenceData/speakers/speaker" mode="nameOnly"/>
            </speakers>
        </xsl:result-document>

        <!-- Keynotes (preserve trailing whitespace/newlines) -->
        <xsl:variable name="outPath"
            select="concat('file:///', $p-folder-out, '/Keynotes_mitDatum_mitRauemen--', $sourceFileNameSuffix, '.xml')"/>
        <xsl:result-document href="{$outPath}">
            <result is_array="true">
                <xsl:apply-templates select="//keynotes">
                    <xsl:with-param name="date" select="true()"/>
                    <xsl:with-param name="room" select="true()"/>
                    <xsl:with-param name="isSoMe" select="false()"/>
                    <xsl:with-param name="preserveTrailing" select="true()"/>
                </xsl:apply-templates>
            </result>
        </xsl:result-document>
        <xsl:variable name="outPath"
            select="concat('file:///', $p-folder-out, '/Keynotes_mitDatum_ohneRaueme--', $sourceFileNameSuffix, '.xml')"/>
        <xsl:result-document href="{$outPath}">
            <result is_array="true">
                <xsl:apply-templates select="//keynotes">
                    <xsl:with-param name="date" select="true()"/>
                    <xsl:with-param name="room" select="false()"/>
                    <xsl:with-param name="isSoMe" select="false()"/>
                    <xsl:with-param name="preserveTrailing" select="true()"/>
                </xsl:apply-templates>
            </result>
        </xsl:result-document>
        <xsl:variable name="outPath"
            select="concat('file:///', $p-folder-out, '/Keynotes_ohneDatum_mitRauemen--', $sourceFileNameSuffix, '.xml')"/>
        <xsl:result-document href="{$outPath}">
            <result is_array="true">
                <xsl:apply-templates select="//keynotes">
                    <xsl:with-param name="date" select="false()"/>
                    <xsl:with-param name="room" select="true()"/>
                    <xsl:with-param name="isSoMe" select="false()"/>
                    <xsl:with-param name="preserveTrailing" select="true()"/>
                </xsl:apply-templates>
            </result>
        </xsl:result-document>
        <xsl:variable name="outPath"
            select="concat('file:///', $p-folder-out, '/Keynotes_ohneDatum_ohneRaueme--', $sourceFileNameSuffix, '.xml')"/>
        <xsl:result-document href="{$outPath}">
            <result is_array="true">
                <xsl:apply-templates select="//keynotes">
                    <xsl:with-param name="date" select="false()"/>
                    <xsl:with-param name="room" select="false()"/>
                    <xsl:with-param name="isSoMe" select="false()"/>
                    <xsl:with-param name="preserveTrailing" select="true()"/>
                </xsl:apply-templates>
            </result>
        </xsl:result-document>
        <xsl:variable name="outPath"
            select="concat('file:///', $p-folder-out, '/SoMe_Keynotes_ohneDatum_ohneRaueme_ohneAbstract--', $sourceFileNameSuffix, '.xml')"/>
        <xsl:result-document href="{$outPath}">
            <result is_array="true">
                <xsl:apply-templates select="//keynotes">
                    <xsl:with-param name="date" select="false()"/>
                    <xsl:with-param name="room" select="false()"/>
                    <xsl:with-param name="isSoMe" select="true()"/>
                    <xsl:with-param name="preserveTrailing" select="false()"/>
                </xsl:apply-templates>
            </result>
        </xsl:result-document>

        <!-- Sessions (preserve trailing whitespace/newlines) -->
        <xsl:variable name="outPath"
            select="concat('file:///', $p-folder-out, '/Sessions_mitDatum_mitRauemen--', $sourceFileNameSuffix, '.xml')"/>
        <xsl:result-document href="{$outPath}">
            <result is_array="true">
                <xsl:apply-templates select="//sessions">
                    <xsl:with-param name="date" select="true()"/>
                    <xsl:with-param name="room" select="true()"/>
                    <xsl:with-param name="isSoMe" select="false()"/>
                    <xsl:with-param name="preserveTrailing" select="true()"/>
                </xsl:apply-templates>
            </result>
        </xsl:result-document>
        <xsl:variable name="outPath"
            select="concat('file:///', $p-folder-out, '/Sessions_mitDatum_ohneRaueme--', $sourceFileNameSuffix, '.xml')"/>
        <xsl:result-document href="{$outPath}">
            <result is_array="true">
                <xsl:apply-templates select="//sessions">
                    <xsl:with-param name="date" select="true()"/>
                    <xsl:with-param name="room" select="false()"/>
                    <xsl:with-param name="isSoMe" select="false()"/>
                    <xsl:with-param name="preserveTrailing" select="true()"/>
                </xsl:apply-templates>
            </result>
        </xsl:result-document>
        <xsl:variable name="outPath"
            select="concat('file:///', $p-folder-out, '/Sessions_ohneDatum_mitRauemen--', $sourceFileNameSuffix, '.xml')"/>
        <xsl:result-document href="{$outPath}">
            <result is_array="true">
                <xsl:apply-templates select="//sessions">
                    <xsl:with-param name="date" select="false()"/>
                    <xsl:with-param name="room" select="true()"/>
                    <xsl:with-param name="isSoMe" select="false()"/>
                    <xsl:with-param name="preserveTrailing" select="true()"/>
                </xsl:apply-templates>
            </result>
        </xsl:result-document>
        <xsl:variable name="outPath"
            select="concat('file:///', $p-folder-out, '/Sessions_ohneDatum_ohneRaueme--', $sourceFileNameSuffix, '.xml')"/>
        <xsl:result-document href="{$outPath}">
            <result is_array="true">
                <xsl:apply-templates select="//sessions">
                    <xsl:with-param name="date" select="false()"/>
                    <xsl:with-param name="room" select="false()"/>
                    <xsl:with-param name="isSoMe" select="false()"/>
                    <xsl:with-param name="preserveTrailing" select="true()"/>
                </xsl:apply-templates>
            </result>
        </xsl:result-document>
        <xsl:variable name="outPath"
            select="concat('file:///', $p-folder-out, '/SoMe_Sessions_ohneDatum_ohneRaueme_ohneAbstract--', $sourceFileNameSuffix, '.xml')"/>
        <xsl:result-document href="{$outPath}">
            <result is_array="true">
                <xsl:apply-templates select="//sessions">
                    <xsl:with-param name="date" select="false()"/>
                    <xsl:with-param name="room" select="false()"/>
                    <xsl:with-param name="isSoMe" select="true()"/>
                    <xsl:with-param name="preserveTrailing" select="false()"/>
                </xsl:apply-templates>
            </result>
        </xsl:result-document>

        <!-- Workshops (preserve trailing whitespace/newlines) -->
        <xsl:variable name="outPath"
            select="concat('file:///', $p-folder-out, '/Workshops_mitDatum_mitRauemen--', $sourceFileNameSuffix, '.xml')"/>
        <xsl:result-document href="{$outPath}">
            <result is_array="true">
                <xsl:apply-templates select="//workshops">
                    <xsl:with-param name="date" select="true()"/>
                    <xsl:with-param name="room" select="true()"/>
                    <xsl:with-param name="isSoMe" select="false()"/>
                    <xsl:with-param name="preserveTrailing" select="true()"/>
                </xsl:apply-templates>
            </result>
        </xsl:result-document>
        <xsl:variable name="outPath"
            select="concat('file:///', $p-folder-out, '/Workshops_mitDatum_ohneRaueme--', $sourceFileNameSuffix, '.xml')"/>
        <xsl:result-document href="{$outPath}">
            <result is_array="true">
                <xsl:apply-templates select="//workshops">
                    <xsl:with-param name="date" select="true()"/>
                    <xsl:with-param name="room" select="false()"/>
                    <xsl:with-param name="isSoMe" select="false()"/>
                    <xsl:with-param name="preserveTrailing" select="true()"/>
                </xsl:apply-templates>
            </result>
        </xsl:result-document>
        <xsl:variable name="outPath"
            select="concat('file:///', $p-folder-out, '/Workshops_ohneDatum_mitRauemen--', $sourceFileNameSuffix, '.xml')"/>
        <xsl:result-document href="{$outPath}">
            <result is_array="true">
                <xsl:apply-templates select="//workshops">
                    <xsl:with-param name="date" select="false()"/>
                    <xsl:with-param name="room" select="true()"/>
                    <xsl:with-param name="isSoMe" select="false()"/>
                    <xsl:with-param name="preserveTrailing" select="true()"/>
                </xsl:apply-templates>
            </result>
        </xsl:result-document>
        <xsl:variable name="outPath"
            select="concat('file:///', $p-folder-out, '/Workshops_ohneDatum_ohneRaueme--', $sourceFileNameSuffix, '.xml')"/>
        <xsl:result-document href="{$outPath}">
            <result is_array="true">
                <xsl:apply-templates select="//workshops">
                    <xsl:with-param name="date" select="false()"/>
                    <xsl:with-param name="room" select="false()"/>
                    <xsl:with-param name="isSoMe" select="false()"/>
                    <xsl:with-param name="preserveTrailing" select="true()"/>
                </xsl:apply-templates>
            </result>
        </xsl:result-document>
        <xsl:variable name="outPath"
            select="concat('file:///', $p-folder-out, '/SoMe_Workshops_ohneDatum_ohneRaueme_ohneAbstract--', $sourceFileNameSuffix, '.xml')"/>
        <xsl:result-document href="{$outPath}">
            <result is_array="true">
                <xsl:apply-templates select="//workshops">
                    <xsl:with-param name="date" select="false()"/>
                    <xsl:with-param name="room" select="false()"/>
                    <xsl:with-param name="isSoMe" select="true()"/>
                    <xsl:with-param name="preserveTrailing" select="false()"/>
                </xsl:apply-templates>
            </result>
        </xsl:result-document>

        <!--Timetable – Sessions Liste
Timetable – Sessions Konferenztabelle
Timetable – Special Days + Keynotes
Timetable – Raumplan-->
        <xsl:variable name="outPath"
            select="concat('file:///', $p-folder-out, '/Tabelle_Raumplaene_sortiert_nach_Raeumen--', $sourceFileNameSuffix, '.xml')"/>
        <xsl:result-document href="{$outPath}">
            <story>
                <xsl:apply-templates select="//allSessions" mode="roomListing">
                    <xsl:with-param name="trim" select="true()"/>
                </xsl:apply-templates>
            </story>
        </xsl:result-document>
        <xsl:variable name="outPath"
            select="concat('file:///', $p-folder-out, '/Tabelle_Zeitplaner_sortiert_nach_SpecialDays--', $sourceFileNameSuffix, '.xml')"/>
        <xsl:result-document href="{$outPath}">
            <story>
                <xsl:apply-templates select="//specialDay"/>
            </story>
        </xsl:result-document>
        <xsl:variable name="outPath"
            select="concat('file:///', $p-folder-out, '/Tabelle_Zeitplaner_sortiert_nach_Tagen--', $sourceFileNameSuffix, '.xml')"/>
        <xsl:result-document href="{$outPath}">
            <story>
                <xsl:apply-templates select="//allSessions" mode="dayListing">
                    <xsl:with-param name="trim" select="true()"/>
                </xsl:apply-templates>
            </story>
        </xsl:result-document>
        <xsl:variable name="outPath"
            select="concat('file:///', $p-folder-out, '/Tabelle_Zeitplaner_sortiert_nach_Tagen_Konferenzspalte--', $sourceFileNameSuffix, '.xml')"/>
        <xsl:result-document href="{$outPath}">
            <story>
                <xsl:choose>
                    <xsl:when test="/conferences/mergedSessions">
                        <xsl:apply-templates select="/conferences/mergedSessions" mode="dayListingConf">
                            <xsl:with-param name="trim" select="true()"/>
                        </xsl:apply-templates>
                    </xsl:when>
                    <xsl:when test="//allSessions">
                        <xsl:apply-templates select="//allSessions" mode="dayListingConf">
                            <xsl:with-param name="trim" select="true()"/>
                        </xsl:apply-templates>
                    </xsl:when>
                    <xsl:otherwise/>
                </xsl:choose>
            </story>
        </xsl:result-document>
    </xsl:template>

    <xsl:template match="keynotes | sessions | workshops">
        <xsl:param name="date"/>
        <xsl:param name="room"/>
        <xsl:param name="isSoMe"/>
        <xsl:param name="preserveTrailing" select="false()"/>

        <xsl:for-each-group select="session" group-by="startDate">
            <xsl:for-each-group select="current-group()" group-by="endDate">

                <xsl:variable name="startDateDT" select="
                    px:adjust-dateTime-to-local-time(
                        xs:dateTime(
                            if (matches(startDate, '^\d{4}-\d{2}-\d{2}T\d{2}:\d{2}$'))
                            then concat(startDate, ':00')
                            else startDate
                        )
                    )
                "/>

                <xsl:variable name="endDateDT" select="
                    px:adjust-dateTime-to-local-time(
                        xs:dateTime(
                            if (matches(endDate, '^\d{4}-\d{2}-\d{2}T\d{2}:\d{2}$'))
                            then concat(endDate, ':00')
                            else endDate
                        )
                    )
                "/>

                <xsl:choose>
                    <xsl:when test="$date">
                        <!-- emit day as its own top-level item -->
                        <item>
                            <day>
                                <xsl:value-of select="format-dateTime($startDateDT, '[F], [D01]. [MNn] [Y0001]')"/>
                                <xsl:if test="$preserveTrailing"><xsl:text>&#x0A;</xsl:text></xsl:if>
                            </day>
                        </item>

                        <!-- ORIGINAL-LIKE: open one outer <item> that contains <time> and all session <item>s -->
                        <item>
                            <time>
                                <xsl:value-of select="concat(format-dateTime($startDateDT, '[H01]:[m01]'), ' - ', format-dateTime($endDateDT, '[H01]:[m01]'), ' ', $uhr, ' | ', format-dateTime($startDateDT, '[F], [D01]. [MNn] [Y0001]'))"/>
                                <xsl:if test="$preserveTrailing"><xsl:text>&#x0A;</xsl:text></xsl:if>
                            </time>

                            <!-- nested session <item> elements -->
                            <xsl:apply-templates select="current-group()">
                                <xsl:with-param name="date" select="$date"/>
                                <xsl:with-param name="room" select="$room"/>
                                <xsl:with-param name="isSoMe" select="$isSoMe"/>
                                <xsl:with-param name="preserveTrailing" select="$preserveTrailing"/>
                            </xsl:apply-templates>
                        </item>

                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:apply-templates select="current-group()">
                            <xsl:with-param name="date" select="$date"/>
                            <xsl:with-param name="room" select="$room"/>
                            <xsl:with-param name="isSoMe" select="$isSoMe"/>
                            <xsl:with-param name="preserveTrailing" select="$preserveTrailing"/>
                        </xsl:apply-templates>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:for-each-group>
        </xsl:for-each-group>
    </xsl:template>

    <xsl:template match="session">
        <xsl:param name="date"/>
        <xsl:param name="room"/>
        <xsl:param name="isSoMe"/>
        <xsl:param name="preserveTrailing" select="false()"/>

        <item>
            <!-- Titel generieren -->
            <title>
                <xsl:choose>
                    <xsl:when test="$isSoMe">
                        <xsl:value-of select="
                            replace(
                                replace(name, '^Workshop: ', ''),
                                '\s*\[((Montag)|(Dienstag)|(Mittwoch)|(Donnerstag)|(Freitag)|(Monday)|(Tuesday)|(Wednesday)|(Thursday)|(Friday)),?.*?\]',
                                ''
                            )
                        "/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select="name"/>
                    </xsl:otherwise>
                </xsl:choose>
                <xsl:if test="$preserveTrailing"><xsl:text>&#x0A;</xsl:text></xsl:if>
            </title>

            <!-- Nur in SoMe-Dateien: alle firstNames/lastNames zusammenführen -->
            <xsl:if test="$isSoMe">
                <firstName>
                    <xsl:value-of
                        select="string-join(
                                    speakers/speaker/key('speakers', speakerId)/firstName,
                                    ', '
                            )"/>
                </firstName>
                <xsl:if test="$preserveTrailing"><xsl:text>&#x0A;</xsl:text></xsl:if>

                <lastName>
                    <xsl:value-of
                        select="string-join(
                                    speakers/speaker/key('speakers', speakerId)/lastName,
                                    ', '
                            )"/>
                </lastName>
                <xsl:if test="$preserveTrailing"><xsl:text>&#x0A;</xsl:text></xsl:if>
            </xsl:if>

            <!-- Speakers-Ausgabe wie bisher (speakers template emits its own trailing newline) -->
            <xsl:apply-templates select="speakers">
                <xsl:with-param name="isSoMe" select="$isSoMe"/>
                <xsl:with-param name="preserveTrailing" select="$preserveTrailing"/>
            </xsl:apply-templates>

            <!-- Abstract generieren -->
            <xsl:if test="details and details != ''">
                <xsl:if test="not($isSoMe)"> <!-- Unterschiedliche Behandlung von SoMe und Rest -->
                    <abstract>
                        <xsl:apply-templates select="details">
                            <xsl:with-param name="preserveTrailing" select="$preserveTrailing"/>
                        </xsl:apply-templates>
                    </abstract>
                </xsl:if>
            </xsl:if>

            <xsl:if test="$room and roomName and roomName != ''">
                <room>
                    <xsl:value-of select="roomName"/>
                    <xsl:if test="$preserveTrailing"><xsl:text>&#x0A;</xsl:text></xsl:if>
                </room>
            </xsl:if>
        </item>
    </xsl:template>

    <xsl:template match="details">
        <xsl:param name="preserveTrailing" select="false()"/>
        <xsl:value-of select="."/>
        <xsl:if test="$preserveTrailing"><xsl:text>&#x0A;</xsl:text></xsl:if>
    </xsl:template>

    <xsl:template match="session/speakers">
        <xsl:param name="isSoMe" select="false()"/>
        <xsl:param name="preserveTrailing" select="false()"/>
        <speakers>
            <xsl:choose>
                <xsl:when test="$isSoMe">
                    <xsl:apply-templates>
                        <xsl:with-param name="isSoMe" select="$isSoMe"/>
                        <xsl:with-param name="preserveTrailing" select="$preserveTrailing"/>
                    </xsl:apply-templates>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:apply-templates>
                        <xsl:with-param name="isSoMe" select="$isSoMe"/>
                        <xsl:with-param name="preserveTrailing" select="$preserveTrailing"/>
                    </xsl:apply-templates>
                </xsl:otherwise>
            </xsl:choose>
            <xsl:if test="$preserveTrailing"><xsl:text>&#x0A;</xsl:text></xsl:if>
        </speakers>
    </xsl:template>

    <!--   mode weil fehlender Zeilenumbruch, weil speaker in Tabellenzelle steht -->
    <xsl:template match="session/speakers" mode="table">
        <xsl:param name="isSoMe" select="false()"/>
        <xsl:param name="preserveTrailing" select="false()"/>
        <speakers>
            <xsl:apply-templates>
                <xsl:with-param name="isSoMe" select="$isSoMe"/>
                <xsl:with-param name="preserveTrailing" select="$preserveTrailing"/>
            </xsl:apply-templates>
        </speakers>
        <xsl:if test="$preserveTrailing"><xsl:text>&#x0A;</xsl:text></xsl:if>
    </xsl:template>
    <xsl:template match="session/speakers/speaker">
        <xsl:param name="isSoMe" select="false()"/>
        <xsl:param name="preserveTrailing" select="false()"/>
        <xsl:apply-templates select="key('speakers', speakerId)">
            <xsl:with-param name="isSoMe" select="$isSoMe"/>
            <xsl:with-param name="preserveTrailing" select="$preserveTrailing"/>
        </xsl:apply-templates>
        <xsl:if test="following-sibling::speaker">
            <xsl:text>, </xsl:text>
        </xsl:if>
    </xsl:template>

    <xsl:template match="conferenceData/speakers/speaker">
        <xsl:param name="isSoMe" select="false()"/>
        <xsl:param name="preserveTrailing" select="false()"/>
        <xsl:choose>
            <xsl:when test="$isSoMe">
                <!-- Apply replace pattern for SoMe output files -->
                <xsl:value-of select="
                    replace(
                        concat(firstName, ' ', lastName, ' (', company, ')'),
                        '\s*\((.+)\)',
                        ' | $1'
                    )
                "/>
            </xsl:when>
            <xsl:otherwise>
                <!-- Default format for other files -->
                <xsl:value-of select="firstName"/>
                <xsl:text> </xsl:text>
                <xsl:value-of select="lastName"/>
                <xsl:text> (</xsl:text>
                <xsl:value-of select="company"/>
                <xsl:text>)</xsl:text>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <!-- Erstellt Tabelle_Zeitplaner_sortiert_nach_SpecialDays.xml  -->
    <xsl:template match="specialDay">
    <xsl:if test="session">
        <xsl:variable name="rows" select="count(session) + 1"/>
        <Tabelle xmlns:aid="http://ns.adobe.com/AdobeInDesign/4.0/" aid:table="table"
                aid:trows="{$rows}" aid:tcols="2">
            <Zelle aid:table="cell" aid:crows="1" aid:ccols="2">
                <specialday>
                    <xsl:value-of select="name"/>
                </specialday>
                <xsl:text>&#x0A;</xsl:text>
                <day>
                    <xsl:variable name="startDateDT" select="
                        px:adjust-dateTime-to-local-time(
                            xs:dateTime(
                                if (matches(startDate, '^\d{4}-\d{2}-\d{2}T\d{2}:\d{2}$'))
                                then concat(startDate, ':00')
                                else startDate
                            )
                        )
                    "/>
                    <xsl:value-of select="format-dateTime($startDateDT, '[F], [D01]. [MNn] [Y0001]')"/>
                    <xsl:text> </xsl:text>
                    <xsl:text>&#x0A;</xsl:text>
                </day>
            </Zelle>
            <xsl:apply-templates select="session" mode="specialDay"/>
        </Tabelle>
    </xsl:if>
</xsl:template>

    <xsl:template match="session" mode="specialDay">
        <Zelle aid:table="cell" aid:crows="1" aid:ccols="1" aid:ccolwidth="59.52755905511811">
            <time>
                <xsl:variable name="startDateDT" select="
                    px:adjust-dateTime-to-local-time(
                        xs:dateTime(
                            if (matches(startDate, '^\d{4}-\d{2}-\d{2}T\d{2}:\d{2}$'))
                            then concat(startDate, ':00')
                            else startDate
                        )
                    )
                "/>
                <xsl:variable name="endDateDT" select="
                    px:adjust-dateTime-to-local-time(
                        xs:dateTime(
                            if (matches(endDate, '^\d{4}-\d{2}-\d{2}T\d{2}:\d{2}$'))
                            then concat(endDate, ':00')
                            else endDate
                        )
                    )
                "/>
                <xsl:value-of select="format-dateTime($startDateDT, '[H01]:[m01] - ')"/>
                <xsl:value-of select="format-dateTime($endDateDT, '[H01]:[m01] ')"/>
                <xsl:text>&#x0A;</xsl:text>
            </time>
        </Zelle>
        <Zelle aid:table="cell" aid:crows="1" aid:ccols="1" aid:ccolwidth="192.12519685030313">
            <title>
                <xsl:value-of select="name"/>
            </title>
            <xsl:text>&#x0A;</xsl:text>
            <xsl:apply-templates select="speakers" mode="table"/>
        </Zelle>
    </xsl:template>

    <!--Tabelle_Zeitplaner_sortiert_nach_Tagen.xml-->
    <xsl:template match="allSessions | mergedSessions" mode="dayListing">
        <xsl:param name="trim" select="false()"/>
        <xsl:for-each-group select="session" group-by="@day">
            <xsl:variable name="rows" select="count(current-group()) + 1"/>
            <Tabelle xmlns:aid="http://ns.adobe.com/AdobeInDesign/4.0/" aid:table="table"
                    aid:trows="{$rows}" aid:tcols="4">
                <Zelle aid:table="cell" aid:crows="1" aid:ccols="4">
                    <day>
                        <xsl:variable name="startDateDT" select="
                            px:adjust-dateTime-to-local-time(
                                xs:dateTime(
                                    if (matches(current-group()[1]/startDate, '^\d{4}-\d{2}-\d{2}T\d{2}:\d{2}$'))
                                    then concat(current-group()[1]/startDate, ':00')
                                    else current-group()[1]/startDate
                                )
                            )
                        "/>
                        <xsl:value-of select="format-dateTime($startDateDT, '[F], [D01]. [MNn] [Y0001]')"/>
                    </day>
                </Zelle>

                <xsl:for-each-group select="current-group()" group-by="startDate">
                    <xsl:for-each-group select="current-group()" group-by="endDate">
                        <xsl:variable name="startDateDT" select="
                            px:adjust-dateTime-to-local-time(
                                xs:dateTime(
                                    if (matches(startDate, '^\d{4}-\d{2}-\d{2}T\d{2}:\d{2}$'))
                                    then concat(startDate, ':00')
                                    else startDate
                                )
                            )"/>
                        <xsl:variable name="endDateDT" select="
                            px:adjust-dateTime-to-local-time(
                                xs:dateTime(
                                    if (matches(endDate, '^\d{4}-\d{2}-\d{2}T\d{2}:\d{2}$'))
                                    then concat(endDate, ':00')
                                    else endDate
                                )
                            )"/>

                        <xsl:variable name="rowspan" select="count(current-group())"/>
                        <Zelle aid:table="cell" aid:crows="{$rowspan}" aid:ccols="1"
                            aid:ccolwidth="73.39614155471884">
                            <time>
                                <xsl:value-of select="format-dateTime($startDateDT, '[H01]:[m01] - ')"/>
                                <xsl:value-of select="format-dateTime($endDateDT, '[H01]:[m01] ')"/>
                            </time>
                        </Zelle>

                        <xsl:apply-templates select="current-group()" mode="dayListing">
                            <xsl:with-param name="trim" select="$trim"/>
                        </xsl:apply-templates>
                    </xsl:for-each-group>
                </xsl:for-each-group>

            </Tabelle>
        </xsl:for-each-group>
    </xsl:template>

    <xsl:template match="session" mode="dayListing">
        <xsl:param name="trim" select="false()"/>
        <Zelle aid:table="cell" aid:crows="1" aid:ccols="1" aid:ccolwidth="201.25984251968504">
            <title>
                <xsl:value-of select="name"/>
            </title>
        </Zelle>
        <Zelle aid:table="cell" aid:crows="1" aid:ccols="1" aid:ccolwidth="172.91338582677167">
            <xsl:apply-templates select="speakers" mode="table"/>
        </Zelle>
        <Zelle aid:table="cell" aid:crows="1" aid:ccols="1" aid:ccolwidth="68.03149606299212">
            <info>
                <xsl:apply-templates select="roomName"/>
            </info>
        </Zelle>
    </xsl:template>

    <!--Tabelle_Raumplaene_sortiert_nach_Raeumen.xml-->
    <xsl:template match="allSessions | mergedSessions" mode="roomListing">
        <xsl:param name="trim" select="false()"/>
        <xsl:for-each-group select="session" group-by="roomName">
            <xsl:variable name="rowTemp" select="count(current-group()) + 1"/>
            <xsl:variable name="rowGroups">
                <xsl:for-each-group select="current-group()" group-by="@day">
                    <group/>
                </xsl:for-each-group>
            </xsl:variable>
            <xsl:variable name="rows" select="count($rowGroups/group) + $rowTemp"/>

            <Tabelle xmlns:aid="http://ns.adobe.com/AdobeInDesign/4.0/" aid:table="table"
                    aid:trows="{$rows}" aid:tcols="3">
                <Zelle aid:table="cell" aid:crows="1" aid:ccols="3">
                    <room>
                        <xsl:value-of select="roomName"/>
                    </room>
                </Zelle>

                <xsl:for-each-group select="current-group()" group-by="@day">
                    <Zelle aid:table="cell" aid:crows="1" aid:ccols="3">
                        <day>
                            <xsl:variable name="startDateDT" select="
                                px:adjust-dateTime-to-local-time(
                                    xs:dateTime(
                                        if (matches(current-group()[1]/startDate, '^\d{4}-\d{2}-\d{2}T\d{2}:\d{2}$'))
                                        then concat(current-group()[1]/startDate, ':00')
                                        else current-group()[1]/startDate
                                    )
                                )
                            "/>
                            <xsl:value-of select="format-dateTime($startDateDT, '[F], [D01]. [MNn] [Y0001]')"/>
                        </day>
                    </Zelle>

                    <xsl:for-each-group select="current-group()" group-by="startDate">
                        <xsl:for-each-group select="current-group()" group-by="endDate">
                            <xsl:variable name="startDateDT" select="
                                px:adjust-dateTime-to-local-time(
                                    xs:dateTime(
                                        if (matches(startDate, '^\d{4}-\d{2}-\d{2}T\d{2}:\d{2}$'))
                                        then concat(startDate, ':00')
                                        else startDate
                                    )
                                )"/>
                            <xsl:variable name="endDateDT" select="
                                px:adjust-dateTime-to-local-time(
                                    xs:dateTime(
                                        if (matches(endDate, '^\d{4}-\d{2}-\d{2}T\d{2}:\d{2}$'))
                                        then concat(endDate, ':00')
                                        else endDate
                                    )
                                )"/>

                            <Zelle aid:table="cell" aid:crows="1" aid:ccols="1">
                                <time>
                                    <xsl:value-of select="format-dateTime($startDateDT, '[H01]:[m01] - ')"/>
                                    <xsl:value-of select="format-dateTime($endDateDT, '[H01]:[m01] ')"/>
                                </time>
                            </Zelle>

                            <xsl:apply-templates select="current-group()" mode="roomListing">
                                <xsl:with-param name="trim" select="$trim"/>
                            </xsl:apply-templates>
                        </xsl:for-each-group>
                    </xsl:for-each-group>
                </xsl:for-each-group>
            </Tabelle>
        </xsl:for-each-group>
    </xsl:template>

    <xsl:template match="session" mode="roomListing">
        <xsl:param name="trim" select="false()"/>
        <Zelle aid:table="cell" aid:crows="1" aid:ccols="1">
            <title>
                <xsl:value-of select="name"/>
            </title>
        </Zelle>
        <Zelle aid:table="cell" aid:crows="1" aid:ccols="1">
            <xsl:apply-templates select="speakers" mode="table"/>
        </Zelle>
    </xsl:template>

    <!-- Nur Namen der Speaker für die Speaker_Namen.xml -->
    <xsl:template match="speaker" mode="nameOnly">
        <speaker>
            <name>
                <xsl:value-of select="concat(firstName, ' ', lastName)"/>
            </name>
            <firstName>
                <xsl:value-of select="firstName"/>
            </firstName>
            <lastName>
                <xsl:value-of select="lastName"/>
            </lastName>
        </speaker>
    </xsl:template>

    <!-- Tabelle_Zeitplaner_sortiert_nach_Tagen_Konferenzspalte templates -->
    <xsl:template match="allSessions | mergedSessions" mode="dayListingConf">
        <xsl:param name="trim" select="false()"/>
        <xsl:for-each-group select="session" group-by="@day">
            <xsl:variable name="rows" select="count(current-group()) + 1"/>
            <Tabelle xmlns:aid="http://ns.adobe.com/AdobeInDesign/4.0/" aid:table="table"
                    aid:trows="{$rows}" aid:tcols="5">
                <Zelle aid:table="cell" aid:crows="1" aid:ccols="5">
                    <day>
                        <xsl:variable name="startDateDT" select="
                            px:adjust-dateTime-to-local-time(
                                xs:dateTime(
                                    if (matches(current-group()[1]/startDate, '^\d{4}-\d{2}-\d{2}T\d{2}:\d{2}$'))
                                    then concat(current-group()[1]/startDate, ':00')
                                    else current-group()[1]/startDate
                                )
                            )
                        "/>
                        <xsl:value-of select="format-dateTime($startDateDT, '[F], [D01]. [MNn] [Y0001]')"/>
                    </day>
                </Zelle>

                <xsl:for-each-group select="current-group()" group-by="startDate">
                    <xsl:for-each-group select="current-group()" group-by="endDate">
                        <xsl:variable name="startDateDT" select="
                            px:adjust-dateTime-to-local-time(
                                xs:dateTime(
                                    if (matches(startDate, '^\d{4}-\d{2}-\d{2}T\d{2}:\d{2}$'))
                                    then concat(startDate, ':00')
                                    else startDate
                                )
                            )
                        "/>
                        <xsl:variable name="endDateDT" select="
                            px:adjust-dateTime-to-local-time(
                                xs:dateTime(
                                    if (matches(endDate, '^\d{4}-\d{2}-\d{2}T\d{2}:\d{2}$'))
                                    then concat(endDate, ':00')
                                    else endDate
                                )
                            )
                        "/>

                        <xsl:variable name="rowspan" select="count(current-group())"/>
                        <Zelle aid:table="cell" aid:crows="{$rowspan}" aid:ccols="1"
                            aid:ccolwidth="73.39614155471884">
                            <time>
                                <xsl:value-of select="format-dateTime($startDateDT, '[H01]:[m01] - ')"/>
                                <xsl:value-of select="format-dateTime($endDateDT, '[H01]:[m01] ')"/>
                            </time>
                        </Zelle>

                        <xsl:apply-templates select="current-group()" mode="dayListingConf">
                            <xsl:with-param name="trim" select="$trim"/>
                        </xsl:apply-templates>
                    </xsl:for-each-group>
                </xsl:for-each-group>
            </Tabelle>
        </xsl:for-each-group>
    </xsl:template>

    <xsl:template match="session" mode="dayListingConf">
        <xsl:param name="trim" select="false()"/>
        <Zelle aid:table="cell" aid:crows="1" aid:ccols="1" aid:ccolwidth="172.91338582677167">
            <title>
                <xsl:value-of select="name"/>
            </title>
        </Zelle>
        <Zelle aid:table="cell" aid:crows="1" aid:ccols="1" aid:ccolwidth="172.91338582677167">
            <xsl:apply-templates select="speakers" mode="table"/>
        </Zelle>
        <Zelle aid:table="cell" aid:crows="1" aid:ccols="1" aid:ccolwidth="68.03149606299212">
            <info>
                <xsl:apply-templates select="roomName"/>
            </info>
        </Zelle>
        <Zelle aid:table="cell" aid:crows="1" aid:ccols="1" aid:ccolwidth="68.03149606299212">
            <conference>
                <xsl:for-each select="conferenceId">
                    <xsl:variable name="confID" select="string(.)"/>
                    <xsl:apply-templates select="/conferences//conferenceData/conference[uniqueId = $confID]/shortname"/>
                    <xsl:if test="following-sibling::conferenceId">
                        <xsl:text>/</xsl:text>
                    </xsl:if>
                </xsl:for-each>
            </conference>
        </Zelle>
    </xsl:template>

    <!-- adjusts a dateTime to UK local time account for GMT/BST -->
    <xsl:function name="px:adjust-dateTime-to-local-time"  as="xs:dateTime">
        <xsl:param name="DATETIMEIN" as="xs:dateTime"/>
        <xsl:variable name="ADJUSTGMT" select="adjust-dateTime-to-timezone($DATETIMEIN, xs:dayTimeDuration('PT1H'))"/>
        <!-- ST starts at 1 a.m UTC on last Sunday in March -->
        <xsl:variable name="BSTSTARTS" select="
            xs:dateTime(
                concat(
                    year-from-dateTime($ADJUSTGMT),
                    '-03-',
                    31 - xs:integer(
                        replace(
                            replace(
                                replace(
                                    replace(
                                        replace(
                                            replace(
                                                replace(
                                                    format-date(xs:date(concat(year-from-dateTime($ADJUSTGMT), '-03-31Z')), '[Fn, 2-2]'),
                                                    'su','0'),
                                                'mo','1'),
                                            'tu','2'),
                                        'we','3'),
                                    'th','4'),
                                'fr','5'),
                            'sa','6')
                    ),
                    'T01:00:00Z'
                )
            )
        " as="xs:dateTime"/>
        <!-- ST ends at 1 a.m UTC on last Sunday in October -->
        <xsl:variable name="BSTENDS" select="
            xs:dateTime(
                concat(
                    year-from-dateTime($ADJUSTGMT),
                    '-10-',
                    31 - xs:integer(
                        replace(
                            replace(
                                replace(
                                    replace(
                                        replace(
                                            replace(
                                                replace(
                                                    format-date(xs:date(concat(year-from-dateTime($ADJUSTGMT), '-10-31Z')), '[Fn, 2-2]'),
                                                    'su','0'),
                                                'mo','1'),
                                            'tu','2'),
                                        'we','3'),
                                    'th','4'),
                                'fr','5'),
                            'sa','6')
                    ),
                    'T01:00:00Z'
                )
            )
        " as="xs:dateTime"/>
        <xsl:choose>
            <xsl:when test="$ADJUSTGMT ge $BSTSTARTS and $ADJUSTGMT lt $BSTENDS">    
                <!--return UTC +1 in summer-->
                <xsl:sequence select="adjust-dateTime-to-timezone($DATETIMEIN, xs:dayTimeDuration('PT2H'))"/>
            </xsl:when>
            <xsl:otherwise>    <!--return UTC +0 in winter -->
                <xsl:sequence select="$ADJUSTGMT"/>
            </xsl:otherwise> 
        </xsl:choose>
    </xsl:function>

</xsl:stylesheet>