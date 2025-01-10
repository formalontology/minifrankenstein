<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    version="2.0">

    <!-- Ignore the teiHeader -->
    <xsl:template match="tei:teiHeader"/>

    <!-- Transform the body -->
    <xsl:template match="tei:body">
        <div class="row">
            <!-- Left margin for marginal text -->
            <div class="col-3 left-margin">
                <xsl:apply-templates select="//tei:zone[@type='left_margin']"/>
            </div>
            <!-- Main content -->
            <div class="col-9">
                <xsl:apply-templates/>
            </div>
        </div>
    </xsl:template>

    <!-- Handle page div and its contents -->
    <xsl:template match="tei:div[@type='page']">
        <div>
            <!-- Handle the page number -->
            <xsl:if test=".//tei:metamark[@function='pagenumber']">
                <div class="page-number-circle">
                    <xsl:value-of select=".//tei:metamark[@function='pagenumber']/tei:num/tei:hi[@rend='circled']"/>
                </div>
            </xsl:if>
            <!-- Process the rest of the content, excluding the metamark -->
            <xsl:apply-templates select="*[not(self::tei:metamark)]"/>
        </div>
    </xsl:template>

    <!-- Handle Marginal Notes -->
    <xsl:template match="tei:zone[@type='left_margin']">
        <div class="left-margin">
            <xsl:for-each select="tei:line/add">
                <p class="marginal-text" data-hand="{@hand}">
                    <xsl:apply-templates/>
                </p>
            </xsl:for-each>
        </div>
    </xsl:template>

    <!-- Transform Supralinear Additions -->
    <xsl:template match="tei:add[@place='supralinear']">
        <span class="supralinear">
            <xsl:apply-templates/>
        </span>
    </xsl:template>

    <!-- Transform Standard Paragraph -->
    <xsl:template match="tei:p">
        <p>
            <xsl:apply-templates/>
        </p>
    </xsl:template>

    <!-- Handle Line Breaks -->
    <xsl:template match="tei:lb">
        <br/>
    </xsl:template>

    <!-- Transform Deletions -->
    <xsl:template match="tei:del">
        <del>
            <xsl:apply-templates/>
        </del>
    </xsl:template>
</xsl:stylesheet>