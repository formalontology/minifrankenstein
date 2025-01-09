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
            <div class="col-12">
                <!-- Display the page number (both formats are supported) -->
                <xsl:choose>
                    <xsl:when test="//tei:metamark[@function='pagenumber']/num/hi[@rend='circled']">
                        <p style="text-align:left; font-weight:bold; margin-top:10px;">
                            Page <xsl:value-of select="//tei:metamark[@function='pagenumber']/num/hi[@rend='circled']"/>
                        </p>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:if test="//tei:p[@style='text-align:right; font-weight:bold;']">
                            <xsl:apply-templates select="//tei:p[@style='text-align:right; font-weight:bold;']"/>
                        </xsl:if>
                    </xsl:otherwise>
                </xsl:choose>

                <!-- Render the manuscript content -->
                <div class="transcription">
                    <xsl:apply-templates select="//tei:div"/>
                </div>
            </div>
        </div>
    </xsl:template>

    <!-- Transform the div -->
    <xsl:template match="tei:div">
        <div>
            <xsl:apply-templates/>
        </div>
    </xsl:template>

    <!-- Transform centered paragraph (like Chapter 7) -->
    <xsl:template match="tei:p[@style='text-align:center']">
        <p style="text-align:center; font-weight:bold;">
            <xsl:apply-templates/>
        </p>
    </xsl:template>

    <!-- Transform standard paragraphs -->
    <xsl:template match="tei:p">
        <p>
            <xsl:apply-templates/>
        </p>
    </xsl:template>

    <!-- Handle line breaks -->
    <xsl:template match="tei:lb">
        <br/>
    </xsl:template>

    <!-- Transform circled text -->
    <xsl:template match="tei:hi[@rend='circled']">
        <span class="circled" style="border: 1px solid black; border-radius: 50%; padding: 2px;">
            <xsl:apply-templates/>
        </span>
    </xsl:template>

    <!-- Transform supralinear additions -->
    <xsl:template match="tei:add[@place='superlinear']">
        <span class="superlinear">
            <xsl:apply-templates/>
        </span>
    </xsl:template>

    <!-- Transform deletions -->
    <xsl:template match="tei:del">
        <del>
            <xsl:apply-templates/>
        </del>
    </xsl:template>

    <!-- Transform intralinear additions -->
    <xsl:template match="tei:add[@place='intralinear']">
        <span class="intralinear">
            <xsl:apply-templates/>
        </span>
    </xsl:template>
</xsl:stylesheet>