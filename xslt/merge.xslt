<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs" version="2.0">

    <xsl:param name="folder-in" select="''"/>

    <xsl:template name="mergeStart">        
        <xsl:message select="$folder-in"></xsl:message>
        <xsl:if test="$folder-in = ''">
            <xsl:message terminate="yes">Bitte geben Sie einen Ordner mit mindestens einer Konferenz-XML als Parameter an.</xsl:message>
        </xsl:if>
        <conferences>
            <xsl:for-each select="collection(concat('file:///', replace($folder-in, '\\', '/'), '?select=*.xml'))">
                <xsl:variable name="fileName" select="tokenize(base-uri(), '/')[last()]"/>
                <source-file name="{$fileName}">
                    <xsl:copy-of select="."/>
                </source-file>
            </xsl:for-each>
        </conferences>
    </xsl:template>

</xsl:stylesheet>
