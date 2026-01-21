<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs" version="2.0">


    <xsl:param name="p-from-date"/>
    <xsl:param name="p-to-date"/>
    <xsl:variable name="from-date">
        <xsl:choose>
            <xsl:when test="$p-from-date = ''">
                <xsl:value-of select="xs:dateTime('1900-01-01T00:00:00.00')"/>
            </xsl:when>
            <xsl:when test="matches($p-from-date, '[1-2]\d\d\d-[0-1]\d-[0-3]\dT\d\d:\d\d:\d\d')">
                <xsl:value-of select="xs:dateTime(concat($p-from-date, '.00'))"/>
            </xsl:when>
            <xsl:when test="matches($p-from-date, '[1-2]\d\d\d-[0-1]\d-[0-3]\d')">
                <xsl:value-of select="xs:dateTime(concat($p-from-date, 'T00:00:00.00'))"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:message terminate="yes"
                    >Fehlerhaftes Startdatumformat [YYYY-MM-DD] oder [YYYY-MM-DDTHH:MM:SS] benötigt!</xsl:message>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:variable>
    <xsl:variable name="to-date">
        <xsl:choose>
            <xsl:when test="$p-to-date = ''">
                <xsl:value-of select="xs:dateTime('2200-01-01T00:00:00.00')"/>
            </xsl:when>
            <xsl:when test="matches($p-to-date, '[1-2]\d\d\d-[0-1]\d-[0-3]\dT\d\d:\d\d:\d\d')">
                <xsl:value-of select="xs:dateTime(concat($p-to-date, '.00'))"/>
            </xsl:when>
            <xsl:when test="matches($p-to-date, '[1-2]\d\d\d-[0-1]\d-[0-3]\d')">
                <xsl:value-of select="xs:dateTime(concat($p-to-date, 'T00:00:00.00'))"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:message terminate="yes"
                    >Fehlerhaftes Enddatumformat [YYYY-MM-DD] oder [YYYY-MM-DDTHH:MM:SS] benötigt!</xsl:message>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:variable>

    <!-- Identity Pattern -->
    <xsl:template match="node() | @*" priority="-1">
        <xsl:copy>
            <xsl:apply-templates select="node() | @*"/>
        </xsl:copy>
    </xsl:template>
    
    <!-- Preserve conferences wrapper and source-file metadata -->
    <xsl:template match="conferences">
        <conferences>
            <xsl:apply-templates select="source-file"/>
        </conferences>
    </xsl:template>
    
    <!-- Process each source file -->
    <xsl:template match="source-file">
        <xsl:copy>
            <xsl:copy-of select="@*"/>
            <xsl:apply-templates select="node()"/>
        </xsl:copy>
    </xsl:template>
    <!--Alle HTML Elemente werden entfernt-->
    <xsl:template match="details">
        <xsl:copy>
            <xsl:value-of
                select="replace(replace(replace(replace(replace(., '&amp;amp;', '&amp;'), '&amp;shy;', '&#x00AD;'), '&amp;nbsp;', '&#x00A0;'),'&lt;p&gt;[\s ]*&lt;/p&gt;\s*', ''), '&lt;.*?&gt;', '')"
            />
        </xsl:copy>
    </xsl:template>


    <xsl:template match="sessions">
        <allSessions>
            <xsl:apply-templates select="session">
                <xsl:sort select="xs:dateTime(startDate)" order="ascending"/>
                <xsl:sort select="xs:dateTime(endDate)" order="ascending"/>
            </xsl:apply-templates>
        </allSessions>
        <xsl:if test="//sessiontype/appType/text() = 'KEYNOTE'">
            <xsl:variable name="typeID" select="//sessiontype[appType/text() = 'KEYNOTE']/uniqueId"/>            
            <keynotes>
                <xsl:apply-templates select="session[type = $typeID]">
                    <xsl:sort select="xs:dateTime(startDate)" order="ascending"/>
                    <xsl:sort select="xs:dateTime(endDate)" order="ascending"/>
                </xsl:apply-templates>
            </keynotes>
        </xsl:if>
        <xsl:if test="//sessiontype/appType/text() = 'SESSION'">
            <xsl:variable name="typeID" select="//sessiontype[appType/text() = 'SESSION']/uniqueId"/>
            <sessions>
                <xsl:apply-templates select="session[type = $typeID]">
                    <xsl:sort select="xs:dateTime(startDate)" order="ascending"/>
                    <xsl:sort select="xs:dateTime(endDate)" order="ascending"/>
                </xsl:apply-templates>
            </sessions>
        </xsl:if>
        <xsl:if test="//sessiontype/appType/text() = 'WORKSHOP'">
            <xsl:variable name="typeID" select="//sessiontype[appType/text() = 'WORKSHOP']/uniqueId"/>
            <workshops>
                <xsl:apply-templates select="session[type = $typeID]">
                    <xsl:sort select="xs:dateTime(startDate)" order="ascending"/>
                    <xsl:sort select="xs:dateTime(endDate)" order="ascending"/>
                </xsl:apply-templates>
            </workshops>
        </xsl:if>

        <xsl:for-each select="//track[specialDay/text() = 'true']">
            <xsl:sort select="xs:dateTime(startDate)" order="ascending"/>
            <xsl:variable name="specialDayID" select="uniqueId"/>
            <specialDay>
                <uniqueId>
                    <xsl:value-of select="$specialDayID"/>
                </uniqueId>
                <xsl:apply-templates select="name"/>
                <xsl:apply-templates select="endDate"/>
                <xsl:apply-templates select="startDate"/>
                
                <xsl:apply-templates select="//session[tracks/track/trackId = $specialDayID]">
                    <xsl:sort select="xs:dateTime(startDate)" order="ascending"/>
                    <xsl:sort select="xs:dateTime(endDate)" order="ascending"/>
                </xsl:apply-templates>
            </specialDay>
        </xsl:for-each>

    </xsl:template>

    <xsl:template match="session">
        <xsl:variable name="startDate" select="xs:dateTime(startDate)"/>
        <xsl:variable name="endDate" select="xs:dateTime(endDate)"/>
<!--        <xsl:message select="$from-date">f</xsl:message>
        <xsl:message select="$startDate">s</xsl:message>
        <xsl:message select="$to-date">t</xsl:message>
-->        <xsl:choose>
            <xsl:when test="$startDate >= $from-date and $startDate &lt;= $to-date">
                <xsl:copy>
                    <xsl:attribute name="day" select="format-dateTime(xs:dateTime(startDate), '[Y0001][M01][D01]')" />
                    <xsl:apply-templates select="node() | @*"/>
                </xsl:copy>
            </xsl:when>
            <xsl:otherwise>
                <xsl:message>
                    <xsl:text>Session </xsl:text>
                    <xsl:value-of select="name"/>
                    <xsl:text> aufgrund des Datums ausgeschlossen! Datum: </xsl:text>
                    <xsl:value-of select="startDate"/>
                </xsl:message>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

</xsl:stylesheet>
