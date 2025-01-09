<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    exclude-result-prefixes="xs tei"
    version="2.0">
    
    <!-- Remove the teiHeader -->
    <xsl:template match="tei:teiHeader"/>

    <!-- Modified template for tei:body -->
    <xsl:template match="tei:body">
        <body class="manuscript-page">
            <div class="row">
                <div class="col-3">
                    <xsl:for-each select="//tei:add[@place = 'marginleft']">
                        <xsl:choose>
                            <xsl:when test="parent::tei:del">
                                <del>
                                    <xsl:attribute name="class">
                                        <xsl:value-of select="attribute::hand" />
                                    </xsl:attribute>
                                    <xsl:value-of select="."/></del><br/>
                            </xsl:when>
                            <xsl:otherwise>
                                <span>
                                    <xsl:attribute name="class">
                                        <xsl:value-of select="attribute::hand" />
                                    </xsl:attribute>
                                    <xsl:value-of select="."/><br/>
                                </span>
                            </xsl:otherwise>
                        </xsl:choose>
                    </xsl:for-each> 
                </div>
                <div class="col-9">
                    <div class="transcription">
                        <xsl:apply-templates select="//tei:div"/>
                    </div>
                </div>
            </div>
        </body>
    </xsl:template>
    
    <!-- Template for tei:div -->
    <xsl:template match="tei:div">
        <div class="#MWS"><xsl:apply-templates/></div>
    </xsl:template>
    
    <!-- Template for tei:p -->
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

    <!-- Template for page numbers -->
    <xsl:template match="tei:metamark[@function='pagenumber']">
        <span class="page-number">
            <xsl:value-of select="tei:num/tei:hi"/>
        </span>
    </xsl:template>
</xsl:stylesheet>