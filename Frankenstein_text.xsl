<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    exclude-result-prefixes="xs tei"
    version="2.0">

    <!-- Ignore the teiHeader -->
    <xsl:template match="tei:teiHeader"/>

    <!-- Transform the body -->
    <xsl:template match="tei:body">
        <div class="row">
            <div class="col-3">
                <!-- Left margin additions -->
                <xsl:for-each select="//tei:add[@place = 'marginleft']">
                    <xsl:choose>
                        <xsl:when test="parent::tei:del">
                            <del>
                                <xsl:attribute name="class">
                                    <xsl:value-of select="@hand" />
                                </xsl:attribute>
                                <xsl:value-of select="."/>
                            </del><br/>
                        </xsl:when>
                        <xsl:otherwise>
                            <span>
                                <xsl:attribute name="class">
                                    <xsl:value-of select="@hand" />
                                </xsl:attribute>
                                <xsl:value-of select="."/><br/>
                            </span>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:for-each> 
            </div>
            <div class="col-9">
                <!-- Page number positioned at the top-right -->
                <xsl:if test="//tei:head/hi[@rend='circled']">
                    <div class="page-number" style="text-align: right; font-weight: bold; margin-top: 10px;">
                        <xsl:value-of select="//tei:head/hi[@rend='circled']"/>
                    </div>
                </xsl:if>
                <div class="transcription">
                    <xsl:apply-templates select="//tei:div"/>
                </div>
            </div>
        </div> 
    </xsl:template>

    <!-- Transform the div -->
    <xsl:template match="tei:div">
        <!-- Chapter heading: only display if it exists -->
        <xsl:if test="@type='metadata' and @n='chapter-heading'">
            <div class="chapter-heading" style="font-weight: bold; text-align: center; font-size: larger;">
                <xsl:value-of select="tei:head"/>
            </div>
        </xsl:if>

        <div class="#MWS">
            <xsl:apply-templates/>
        </div>
    </xsl:template>

    <!-- Transform the paragraphs -->
    <xsl:template match="tei:p">
        <p><xsl:apply-templates/></p>
    </xsl:template>

    <!-- Transform line breaks -->
    <xsl:template match="tei:lb">
        <br/>
    </xsl:template>

    <!-- Transform supralinear additions -->
    <xsl:template match="tei:add[@place = 'supralinear']">
        <span class="supraAdd">
            <xsl:apply-templates/>
        </span>
    </xsl:template>

    <!-- Transform underlined text -->
    <xsl:template match="tei:hi[@rend = 'u']">
        <u>
            <xsl:apply-templates/>
        </u>
    </xsl:template>

    <!-- Transform superscript text -->
    <xsl:template match="tei:hi[@rend = 'sup']">
        <sup>
            <xsl:apply-templates/>
        </sup>
    </xsl:template>

    <!-- Transform deleted text -->
    <xsl:template match="tei:del">
        <del>
            <xsl:attribute name="class">
                <xsl:value-of select="@hand"/>
            </xsl:attribute>
            <xsl:apply-templates/>
        </del>
    </xsl:template>

    <!-- Transform overwritten text -->
    <xsl:template match="tei:add[@place = 'overwritten']">
        <span class="overwritten">
            <xsl:apply-templates/>
        </span>
    </xsl:template>

    <!-- Transform marginleft additions -->
    <xsl:template match="tei:add[@place = 'marginleft']">
        <span class="marginAdd">
            <xsl:apply-templates/>
        </span>
    </xsl:template>
</xsl:stylesheet>