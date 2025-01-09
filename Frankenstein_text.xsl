<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    exclude-result-prefixes="xs tei"
    version="2.0">

    <!-- Remove the teiHeader -->
    <xsl:template match="tei:teiHeader"/>

    <!-- Template for the body with page number and chapter title -->
    <xsl:template match="tei:body">
        <div class="manuscript-page">
            <!-- Page Number (always at the top right) -->
            <div class="page-number" style="position: absolute; top: 10px; right: 10px;">
                <xsl:value-of select="tei:div/tei:head/tei:metamark[@function='pagenumber']/tei:num"/>
            </div>

            <!-- Add space below page number -->
            <div style="height: 20px;"></div>

            <!-- Chapter Title (only show for page 21r) -->
            <xsl:choose>
                <xsl:when test="tei:div[@n='21r']">
                    <!-- Show Chapter Title for 21r -->
                    <div class="chapter-title" style="position: absolute; top: 40px; left: 10px;">
                        Chapter 7
                    </div>
                </xsl:when>
                <xsl:otherwise>
                    <!-- No Chapter Title for other pages -->
                    <div class="chapter-title"></div>
                </xsl:otherwise>
            </xsl:choose>

            <!-- Text Body -->
            <div class="text-body">
                <xsl:apply-templates select="tei:div/tei:p"/>
            </div>
        </div>
    </xsl:template>

    <!-- Template for div elements inside tei:body -->
    <xsl:template match="tei:div">
        <div class="text">
            <xsl:apply-templates/>
        </div>
    </xsl:template>
    
    <!-- Template for p elements inside tei:div -->
    <xsl:template match="tei:p">
        <p><xsl:apply-templates/></p>
    </xsl:template>

    <!-- Template for line breaks -->
    <xsl:template match="tei:lb">
        <br/>
    </xsl:template>
    
    <!-- Template for supralinear additions -->
    <xsl:template match="tei:add[@place = 'supralinear']">
        <span class="supraAdd">
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    
    <!-- Template for underlined text -->
    <xsl:template match="tei:hi[@rend='u']">
        <span class="underlined">
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    
    <!-- Template for superscript text -->
    <xsl:template match="tei:hi[@rend='sup']">
        <sup>
            <xsl:apply-templates/>
        </sup>
    </xsl:template>
    
    <!-- Template for marginleft additions -->
    <xsl:template match="tei:add[@place = 'marginleft']">
        <span class="marginAdd">
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    
    <!-- Template for deletions -->
    <xsl:template match="tei:del">
        <del>
            <xsl:attribute name="class">
                <xsl:value-of select="@hand"/>
            </xsl:attribute>
            <xsl:apply-templates/>
        </del>
    </xsl:template>
    
    <!-- Template for overwritten additions -->
    <xsl:template match="tei:add[@place='overwritten']">
        <span class="overwrittenAdd">
            <xsl:apply-templates/>
        </span>
    </xsl:template>

</xsl:stylesheet>