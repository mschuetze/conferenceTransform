<?xml version="1.0" encoding="UTF-8"?>
<!-- v0.4.0 -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:aid="http://ns.adobe.com/AdobeInDesign/4.0/"
    exclude-result-prefixes="xs" version="2.0">

    <xsl:strip-space elements="*"/>

    <xsl:param name="p-folder-out" select="'out'"/>

    <xsl:key name="speakers" match="conferenceData/speakers/speaker" use="uniqueId"/>

    <xsl:variable name="uhr">Uhr</xsl:variable>

    <xsl:variable name="isSoMe" select="false()"/>

    

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
            select="concat('file:///', $p-folder-out, '/Speaker_Namen.xml')"/>
        <xsl:result-document href="{$outPath}">
            <speakers>
                <xsl:apply-templates select="//conferenceData/speakers/speaker" mode="nameOnly"/>
            </speakers>
        </xsl:result-document>



        <!-- Keynotes -->
        <xsl:variable name="outPath"
            select="concat('file:///', $p-folder-out, '/Keynotes_mitDatum_mitRauemen.xml')"/>
        <xsl:result-document href="{$outPath}">
            <result is_array="true">
                <xsl:apply-templates select="//keynotes">
                    <xsl:with-param name="date" select="true()"/>
                    <xsl:with-param name="room" select="true()"/>
                    <xsl:with-param name="isSoMe" select="false()"/>
                </xsl:apply-templates>
            </result>
        </xsl:result-document>
        <xsl:variable name="outPath"
            select="concat('file:///', $p-folder-out, '/Keynotes_mitDatum_ohneRaueme.xml')"/>
        <xsl:result-document href="{$outPath}">
            <result is_array="true">
                <xsl:apply-templates select="//keynotes">
                    <xsl:with-param name="date" select="true()"/>
                    <xsl:with-param name="room" select="false()"/>
                    <xsl:with-param name="isSoMe" select="false()"/>
                </xsl:apply-templates>
            </result>
        </xsl:result-document>
        <xsl:variable name="outPath"
            select="concat('file:///', $p-folder-out, '/Keynotes_ohneDatum_mitRauemen.xml')"/>
        <xsl:result-document href="{$outPath}">
            <result is_array="true">
                <xsl:apply-templates select="//keynotes">
                    <xsl:with-param name="date" select="false()"/>
                    <xsl:with-param name="room" select="true()"/>
                    <xsl:with-param name="isSoMe" select="false()"/>
                </xsl:apply-templates>
            </result>
        </xsl:result-document>
        <xsl:variable name="outPath"
            select="concat('file:///', $p-folder-out, '/Keynotes_ohneDatum_ohneRaueme.xml')"/>
        <xsl:result-document href="{$outPath}">
            <result is_array="true">
                <xsl:apply-templates select="//keynotes">
                    <xsl:with-param name="date" select="false()"/>
                    <xsl:with-param name="room" select="false()"/>
                    <xsl:with-param name="isSoMe" select="false()"/>
                </xsl:apply-templates>
            </result>
        </xsl:result-document>
        <xsl:variable name="outPath"
            select="concat('file:///', $p-folder-out, '/SoMe_Keynotes_ohneDatum_ohneRaueme_ohneAbstract.xml')"/>
        <xsl:result-document href="{$outPath}">
            <result is_array="true">
                <xsl:apply-templates select="//keynotes">
                    <xsl:with-param name="date" select="false()"/>
                    <xsl:with-param name="room" select="false()"/>
                    <xsl:with-param name="isSoMe" select="true()"/>
                </xsl:apply-templates>
            </result>
        </xsl:result-document>

        <!-- Sessions -->
        <xsl:variable name="outPath"
            select="concat('file:///', $p-folder-out, '/Sessions_mitDatum_mitRauemen.xml')"/>
        <xsl:result-document href="{$outPath}">
            <result is_array="true">
                <xsl:apply-templates select="//sessions">
                    <xsl:with-param name="date" select="true()"/>
                    <xsl:with-param name="room" select="true()"/>
                    <xsl:with-param name="isSoMe" select="false()"/>
                </xsl:apply-templates>
            </result>
        </xsl:result-document>
        <xsl:variable name="outPath"
            select="concat('file:///', $p-folder-out, '/Sessions_mitDatum_ohneRaueme.xml')"/>
        <xsl:result-document href="{$outPath}">
            <result is_array="true">
                <xsl:apply-templates select="//sessions">
                    <xsl:with-param name="date" select="true()"/>
                    <xsl:with-param name="room" select="false()"/>
                    <xsl:with-param name="isSoMe" select="false()"/>
                </xsl:apply-templates>
            </result>
        </xsl:result-document>
        <xsl:variable name="outPath"
            select="concat('file:///', $p-folder-out, '/Sessions_ohneDatum_mitRauemen.xml')"/>
        <xsl:result-document href="{$outPath}">
            <result is_array="true">
                <xsl:apply-templates select="//sessions">
                    <xsl:with-param name="date" select="false()"/>
                    <xsl:with-param name="room" select="true()"/>
                    <xsl:with-param name="isSoMe" select="false()"/>
                </xsl:apply-templates>
            </result>
        </xsl:result-document>
        <xsl:variable name="outPath"
            select="concat('file:///', $p-folder-out, '/Sessions_ohneDatum_ohneRaueme.xml')"/>
        <xsl:result-document href="{$outPath}">
            <result is_array="true">
                <xsl:apply-templates select="//sessions">
                    <xsl:with-param name="date" select="false()"/>
                    <xsl:with-param name="room" select="false()"/>
                    <xsl:with-param name="isSoMe" select="false()"/>
                </xsl:apply-templates>
            </result>
        </xsl:result-document>
        <xsl:variable name="outPath"
            select="concat('file:///', $p-folder-out, '/SoMe_Sessions_ohneDatum_ohneRaueme_ohneAbstract.xml')"/>
        <xsl:result-document href="{$outPath}">
            <result is_array="true">
                <xsl:apply-templates select="//sessions">
                    <xsl:with-param name="date" select="false()"/>
                    <xsl:with-param name="room" select="false()"/>
                    <xsl:with-param name="isSoMe" select="true()"/>
                </xsl:apply-templates>
            </result>
        </xsl:result-document>

        <!-- Workshops -->
        <xsl:variable name="outPath"
            select="concat('file:///', $p-folder-out, '/Workshops_mitDatum_mitRauemen.xml')"/>
        <xsl:result-document href="{$outPath}">
            <result is_array="true">
                <xsl:apply-templates select="//workshops">
                    <xsl:with-param name="date" select="true()"/>
                    <xsl:with-param name="room" select="true()"/>
                    <xsl:with-param name="isSoMe" select="false()"/>
                </xsl:apply-templates>
            </result>
        </xsl:result-document>
        <xsl:variable name="outPath"
            select="concat('file:///', $p-folder-out, '/Workshops_mitDatum_ohneRaueme.xml')"/>
        <xsl:result-document href="{$outPath}">
            <result is_array="true">
                <xsl:apply-templates select="//workshops">
                    <xsl:with-param name="date" select="true()"/>
                    <xsl:with-param name="room" select="false()"/>
                    <xsl:with-param name="isSoMe" select="false()"/>
                </xsl:apply-templates>
            </result>
        </xsl:result-document>
        <xsl:variable name="outPath"
            select="concat('file:///', $p-folder-out, '/Workshops_ohneDatum_mitRauemen.xml')"/>
        <xsl:result-document href="{$outPath}">
            <result is_array="true">
                <xsl:apply-templates select="//workshops">
                    <xsl:with-param name="date" select="false()"/>
                    <xsl:with-param name="room" select="true()"/>
                    <xsl:with-param name="isSoMe" select="false()"/>
                </xsl:apply-templates>
            </result>
        </xsl:result-document>
        <xsl:variable name="outPath"
            select="concat('file:///', $p-folder-out, '/Workshops_ohneDatum_ohneRaueme.xml')"/>
        <xsl:result-document href="{$outPath}">
            <result is_array="true">
                <xsl:apply-templates select="//workshops">
                    <xsl:with-param name="date" select="false()"/>
                    <xsl:with-param name="room" select="false()"/>
                    <xsl:with-param name="isSoMe" select="false()"/>
                </xsl:apply-templates>
            </result>
        </xsl:result-document>
        <xsl:variable name="outPath"
            select="concat('file:///', $p-folder-out, '/SoMe_Workshops_ohneDatum_ohneRaueme_ohneAbstract.xml')"/>
        <xsl:result-document href="{$outPath}">
            <result is_array="true">
                <xsl:apply-templates select="//workshops">
                    <xsl:with-param name="date" select="false()"/>
                    <xsl:with-param name="room" select="false()"/>
                    <xsl:with-param name="isSoMe" select="true()"/>
                </xsl:apply-templates>
            </result>
        </xsl:result-document>

        <!--Timetable – Sessions Liste
Timetable – Sessions Konferenztabelle
Timetable – Special Days + Keynotes
Timetable – Raumplan-->
        <xsl:variable name="outPath"
            select="concat('file:///', $p-folder-out, '/Tabelle_Raumplaene_sortiert_nach_Raeumen.xml')"/>
        <xsl:result-document href="{$outPath}">
            <story>
                <xsl:apply-templates select="//allSessions" mode="roomListing"/>
            </story>
        </xsl:result-document>
        <xsl:variable name="outPath"
            select="concat('file:///', $p-folder-out, '/Tabelle_Zeitplaner_sortiert_nach_SpecialDays.xml')"/>
        <xsl:result-document href="{$outPath}">
            <story>
                <xsl:apply-templates select="//specialDay"/>
            </story>
        </xsl:result-document>
        <xsl:variable name="outPath"
            select="concat('file:///', $p-folder-out, '/Tabelle_Zeitplaner_sortiert_nach_Tagen.xml')"/>
        <xsl:result-document href="{$outPath}">
            <story>
                <xsl:apply-templates select="//allSessions" mode="dayListing"/>
            </story>
        </xsl:result-document>
    </xsl:template>


    <xsl:template match="keynotes | sessions | workshops">
        <xsl:param name="date"/>
        <xsl:param name="room"/>
        <xsl:param name="isSoMe"/>
        <xsl:for-each-group select="session" group-by="xs:dateTime(startDate)">
            <xsl:for-each-group select="current-group()" group-by="xs:dateTime(endDate)">
                <xsl:variable name="startDate" select="xs:dateTime(startDate)"/>
                <xsl:variable name="endDate" select="xs:dateTime(endDate)"/>
                <xsl:choose>
                    <xsl:when test="$date">
                        <item>
                            <day>
                                <xsl:value-of
                                    select="format-dateTime($startDate, '[F], [D01]. [MNn] [Y0001]')"/>
                                <xsl:text> </xsl:text>
                                <xsl:text>&#x0A;</xsl:text>
                            </day>
                        </item>
                        <item>
                            <time>
                                <xsl:value-of select="format-dateTime($startDate, '[H01]:[m01] - ')"/>
                                <xsl:value-of select="format-dateTime($endDate, '[H01]:[m01] ')"/>
                                <xsl:value-of select="$uhr"/>
                                <xsl:text> | </xsl:text>
                                <xsl:value-of
                                    select="format-dateTime($startDate, '[F], [D01]. [MNn] [Y0001]')"/>
                                <xsl:text>&#x0A;</xsl:text>
                            </time>
                            <xsl:apply-templates select="current-group()">
                                <xsl:with-param name="date" select="$date"/>
                                <xsl:with-param name="room" select="$room"/>
                                <xsl:with-param name="isSoMe" select="$isSoMe"/>
                            </xsl:apply-templates>
                        </item>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:apply-templates select="current-group()">
                            <xsl:with-param name="date" select="$date"/>
                            <xsl:with-param name="room" select="$room"/>
                            <xsl:with-param name="isSoMe" select="$isSoMe"/>
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

        <item>
            <!-- Titel generieren -->
            <title>
                <xsl:choose>
                    <xsl:when test="$isSoMe">
                        <xsl:value-of select="replace(name, '^Workshop: ', '')"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select="name"/>
                        <xsl:text>&#x0A;</xsl:text>
                    </xsl:otherwise>
                </xsl:choose>
            </title>
            <!-- Speakername + Firma generieren -->
            <xsl:apply-templates select="speakers">
                <xsl:with-param name="isSoMe" select="$isSoMe"/>
            </xsl:apply-templates>
            <!-- Abstract generieren -->
            <xsl:if test="details and details != ''">
                <xsl:if test="not($isSoMe)"> <!-- Unterschiedliche Behandlung von SoMe und Rest -->
                    <abstract>
                        <xsl:apply-templates select="details"/>
                    </abstract>
                </xsl:if>
            </xsl:if>
            <xsl:if test="$room and roomName and roomName != ''">
                <room>
                    <xsl:value-of select="roomName"/>
                    <xsl:text>&#x0A;</xsl:text>
                </room>
            </xsl:if>
        </item>
    </xsl:template>

    <xsl:template match="details">
        <xsl:value-of select="."/>
        <xsl:text>&#x0A;</xsl:text>
    </xsl:template>


    <xsl:template match="session/speakers">
        <xsl:param name="isSoMe" select="false()"/>
        <speakers>
            <xsl:choose>
                <xsl:when test="$isSoMe">
                    <!-- Handle output for SoMe -->
                    <xsl:apply-templates/>
                </xsl:when>
                <xsl:otherwise>
                    <!-- Handle output for non-SoMe -->
                    <xsl:apply-templates/>
                    <xsl:text>&#x0A;</xsl:text> <!-- Add line break for non-SoMe -->
                </xsl:otherwise>
            </xsl:choose>
        </speakers>
    </xsl:template>


    <!--   mode weil fehlender Zeilenumbruch, weil speaker in Tabellenzelle steht -->
    <xsl:template match="session/speakers" mode="table">
        <speakers>
            <xsl:apply-templates/>
        </speakers>
    </xsl:template>
    <xsl:template match="session/speakers/speaker">
        <xsl:apply-templates select="key('speakers', speakerId)"/>
        <xsl:if test="following-sibling::speaker">
            <xsl:text>, </xsl:text>
        </xsl:if>
    </xsl:template>

    <xsl:template match="conferenceData/speakers/speaker">
        <xsl:param name="isSoMe" select="false()"/>
        <xsl:choose>
            <xsl:when test="$isSoMe">
                <!-- Format for SoMe -->
                <xsl:value-of select="firstName"/>
                <xsl:text> </xsl:text>
                <xsl:value-of select="lastName"/>
                <xsl:text> | </xsl:text>
                <xsl:value-of select="company"/>
            </xsl:when>
            <xsl:otherwise>
                <!-- Default format -->
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
                        <xsl:value-of
                            select="format-dateTime(xs:dateTime(startDate), '[F], [D01]. [MNn] [Y0001]')"
                        />
                    </day>
                </Zelle>
                <xsl:apply-templates select="session" mode="specialDay"> </xsl:apply-templates>
            </Tabelle>
        </xsl:if>
    </xsl:template>
    <xsl:template match="session" mode="specialDay">
        <Zelle aid:table="cell" aid:crows="1" aid:ccols="1" aid:ccolwidth="59.52755905511811">
            <time>
                <xsl:value-of select="format-dateTime(xs:dateTime(startDate), '[H01]:[m01] - ')"/>
                <xsl:value-of select="format-dateTime(xs:dateTime(endDate), '[H01]:[m01] ')"/>
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

    <!--Tabelle_Zeitplaner_sortiert_nach_Tagen.xml<-->
    <xsl:template match="allSessions" mode="dayListing">
        <xsl:for-each-group select="session" group-by="@day">
            <xsl:variable name="rows" select="count(current-group()) + 1"/>

            <Tabelle xmlns:aid="http://ns.adobe.com/AdobeInDesign/4.0/" aid:table="table"
                aid:trows="{$rows}" aid:tcols="4">
                <Zelle aid:table="cell" aid:crows="1" aid:ccols="4">
                    <day>
                        <xsl:value-of
                            select="format-dateTime(xs:dateTime(current-group()[1]/startDate), '[F], [D01]. [MNn] [Y0001]')"
                        />
                    </day>
                </Zelle>

                <xsl:for-each-group select="current-group()" group-by="xs:dateTime(startDate)">
                    <xsl:for-each-group select="current-group()" group-by="xs:dateTime(endDate)">
                        <xsl:variable name="startDate" select="xs:dateTime(startDate)"/>
                        <xsl:variable name="endDate" select="xs:dateTime(endDate)"/>
                        <xsl:variable name="rowspan" select="count(current-group())"/>
                        <Zelle aid:table="cell" aid:crows="{$rowspan}" aid:ccols="1"
                            aid:ccolwidth="73.39614155471884">
                            <time>
                                <xsl:value-of
                                    select="format-dateTime(xs:dateTime(startDate), '[H01]:[m01] - ')"/>
                                <xsl:value-of
                                    select="format-dateTime(xs:dateTime(endDate), '[H01]:[m01] ')"/>
                            </time>
                        </Zelle>

                        <xsl:apply-templates select="current-group()" mode="dayListing"/>

                    </xsl:for-each-group>
                </xsl:for-each-group>

            </Tabelle>
        </xsl:for-each-group>

    </xsl:template>
    <xsl:template match="session" mode="dayListing">
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
    <xsl:template match="allSessions" mode="roomListing">
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
                            <xsl:value-of
                                select="format-dateTime(xs:dateTime(current-group()[1]/startDate), '[F], [D01]. [MNn] [Y0001]')"
                            />
                        </day>
                    </Zelle>

                    <xsl:for-each-group select="current-group()" group-by="xs:dateTime(startDate)">
                        <xsl:for-each-group select="current-group()" group-by="xs:dateTime(endDate)">
                            <xsl:variable name="startDate" select="xs:dateTime(startDate)"/>
                            <xsl:variable name="endDate" select="xs:dateTime(endDate)"/>
                            <Zelle aid:table="cell" aid:crows="1" aid:ccols="1">
                                <time>
                                    <xsl:value-of
                                        select="format-dateTime(xs:dateTime(startDate), '[H01]:[m01] - ')"/>
                                    <xsl:value-of
                                        select="format-dateTime(xs:dateTime(endDate), '[H01]:[m01] ')"
                                    />
                                </time>
                            </Zelle>

                            <xsl:apply-templates select="current-group()" mode="roomListing"/>

                        </xsl:for-each-group>
                    </xsl:for-each-group>
                </xsl:for-each-group>


            </Tabelle>
        </xsl:for-each-group>

    </xsl:template>
    <xsl:template match="session" mode="roomListing">
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
        </speaker>
    </xsl:template>


</xsl:stylesheet>
