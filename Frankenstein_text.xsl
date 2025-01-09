<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    exclude-result-prefixes="xs tei"
    version="2.0">
    
    <!-- <xsl:output method="xml" omit-xml-declaration="yes" indent="yes" /> -->
    <xsl:template match="tei:teiHeader"/>

    <!-- Existing body structure -->
    <xsl:template match="tei:body">
        <div class="row">
        <div class="col-3"><br/><br/><br/><br/><br/>
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
    </xsl:template>
    
    <!-- Existing div template -->
    <xsl:template match="tei:div">
        <div class="#MWS"><xsl:apply-templates/></div>
    </xsl:template>
    
    <!-- Existing paragraph template -->
    <xsl:template match="tei:p">
        <p><xsl:apply-templates/></p>
    </xsl:template>

    <!-- Addition 1: Handle line breaks (place this template below <xsl:template match="tei:p">) -->
    <xsl:template match="tei:lb">
        <br/>
    </xsl:template>
    
    <!-- Existing supralinear additions template -->
    <xsl:template match="tei:add[@place = 'supralinear']">
        <span class="supraAdd">
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    
    <!-- Addition 2: Handle underlined text (add this below the supralinear template) -->
    <xsl:template match="tei:hi[@rend='u']">
        <span class="underlined">
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    
    <!-- Addition 3: Handle superscript text (add this below the underlined text template) -->
    <xsl:template match="tei:hi[@rend='sup']">
        <sup>
            <xsl:apply-templates/>
        </sup>
    </xsl:template>

    <!-- Existing marginleft additions -->
    <xsl:template match="tei:add[@place = 'marginleft']">
        <span class="marginAdd">
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    
    <!-- Existing deletions -->
    <xsl:template match="tei:del">
        <del>
            <xsl:attribute name="class">
                <xsl:value-of select="@hand"/>
            </xsl:attribute>
            <xsl:apply-templates/>
        </del>
    </xsl:template>
    
    <!-- New template for additions with "overwritten" type -->
    <xsl:template match="tei:add[@place='overwritten']">
        <span class="overwrittenAdd">
            <xsl:apply-templates/>
        </span>
    </xsl:template>
</xsl:stylesheet>