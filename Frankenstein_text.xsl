<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    version="2.0">

    <!-- Ignore the teiHeader -->
    <xsl:template match="tei:teiHeader"/>

    <!-- Transform the body -->
    <xsl:template match="tei:body">
        <div class="manuscript-page">
            <div class="row">
                <!-- Left margin for marginal text -->
                <div class="col-3">
                    <xsl:apply-templates select=".//tei:zone[@type='left_margin']"/>
                </div>
                <!-- Main content -->
                <div class="col-9">
                    <!-- Handle the page number -->
                    <xsl:if test=".//tei:metamark[@function='pagenumber']">
                        <div class="page-number-circle">
                            <xsl:value-of select=".//tei:metamark[@function='pagenumber']/tei:num/tei:hi[@rend='circled']"/>
                        </div>
                    </xsl:if>
                    <!-- Main text content -->
                    <div class="transcription">
                        <xsl:apply-templates select=".//tei:div[@type='page']/*[not(self::tei:metamark) and not(self::tei:zone)]"/>
                    </div>
                </div>
            </div>
        </div>
    </xsl:template>

    <!-- Handle Marginal Notes -->
    <xsl:template match="tei:zone[@type='left_margin']">
        <div class="left-margin">
            <xsl:for-each select="tei:p/tei:add[@place='marginleft']">
                <p class="marginal-text" data-hand="{@hand}">
                    <xsl:apply-templates/>
                </p>
            </xsl:for-each>
        </div>
    </xsl:template>

    <!-- Handle Superlinear Text -->
    <xsl:template match="tei:add[@place='superlinear']">
        <span class="superlinear">
            <xsl:if test="@hand">
                <xsl:attribute name="data-hand">
                    <xsl:value-of select="concat('hand-', substring-after(@hand, '#'))"/>
                </xsl:attribute>
            </xsl:if>
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

    <!-- Handle Bold Text -->
    <xsl:template match="tei:hi[@rend='bold']">
        <b>
            <xsl:apply-templates/>
        </b>
    </xsl:template>

    <!-- Handle Superscript Text -->
    <xsl:template match="tei:hi[@rend='sup']">
        <sup>
            <xsl:apply-templates/>
        </sup>
    </xsl:template>

    <!-- Handle Underlined Text -->
    <xsl:template match="tei:hi[@rend='u']">
        <u>
            <xsl:apply-templates/>
        </u>
    </xsl:template>

    <!-- Handle text by Mary Shelley -->
    <xsl:template match="*[@hand='#MWS']">
        <span class="hand-MWS">
            <xsl:apply-templates/>
        </span>
    </xsl:template>

    <!-- Handle text by Percy Shelley -->
    <xsl:template match="*[@hand='#PBS']">
        <span class="hand-PBS">
            <xsl:apply-templates/>
        </span>
    </xsl:template>

</xsl:stylesheet>