<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:dc="http://purl.org/dc/elements/1.1/" xmlns:oai_dc="http://www.openarchives.org/OAI/2.0/oai_dc/" xmlns:xlink="http://www.w3.org/1999/xlink" xmlns="http://www.loc.gov/mods/v3" xmlns:dhi="http://www.dhinitiative.org/dhi/" xmlns:dhiapw="http://www.dhinitiative.org/dhiapw/" xsi:schemaLocation="http://www.bepress.com/OAI/2.0/qualified-dublin-core/ 
    http://www.bepress.com/assets/xsd/oai_qualified_dc.xsd" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" exclude-result-prefixes="oai_dc dc dhi" version="2.0" xmlns:saxon="http://icl.com/saxon" extension-element-prefixes="saxon">
   <xsl:output omit-xml-declaration="yes" indent="yes"/>
   <xsl:param name="delimiter" select="';'"/>

   <xsl:include href="global-constants/modsRecordInfo.xsl"/>
   <!--
<xsl:include href="contentDmConstants.xsl"/>
<xsl:include href="collection-constants/amana.xsl"/>
<xsl:include href="collection-constants/asa.xsl"/>
<xsl:include href="collection-constants/apw.xsl"/> 
<xsl:include href="collection-constants/beinecke.xsl"/>
<xsl:include href="collection-constants/bishop_hill.xsl"/>
<xsl:include href="collection-constants/church_of_messiah.xsl"/>
<xsl:include href="collection-constants/cjf.xsl"/>
<xsl:include href="collection-constants/cwl.xsl"/>
<xsl:include href="collection-constants/fatherDivine.xsl"/>
<xsl:include href="collection-constants/hod.xsl"/>
<xsl:include href="collection-constants/jezreelites.xsl"/>
<xsl:include href="collection-constants/JazzPhotographs.xsl"/>
<xsl:include href="collection-constants/koresh.xsl"/>
<xsl:include href="collection-constants/oneida.xsl"/>
<xsl:include href="collection-constants/robinson.xsl"/>
<xsl:include href="collection-constants/sci.xsl"/>
<xsl:include href="collection-constants/snowHill.xsl"/>
<xsl:include href="collection-constants/woodhull.xsl"/>
-->

   <xsl:include href="collection-constants/JazzPhotographs.xsl"/>
   
   <xsl:template match="/">
      <allMD xmlns="http://www.loc.gov/mods/v3" xmlns:xlink="http://www.w3.org/1999/xlink" xmlns:dhi="http://www.dhinitiative.org/dhi/" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
         <xsl:for-each select="child::node()">
            <xsl:call-template name="row"/>
         </xsl:for-each>
      </allMD>
   </xsl:template>

   <xsl:template name="row">
      <xsl:for-each select="child::node()">
         <xsl:if test="child::node() != ''">
            <root>
               <!-- changed mods schema version from 3.4 to 3.6: 2017-10-30 -->
               <mods xmlns="http://www.loc.gov/mods/v3" xmlns:dhi="http://www.dhinitiative.org/dhi/" xmlns:dhiapw="http://www.dhinitiative.org/dhiapw/" xmlns:mods="http://www.loc.gov/mods/v3" xmlns:xlink="http://www.w3.org/1999/xlink" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" version="3.6" xsi:schemaLocation="http://www.loc.gov/mods/v3 http://www.loc.gov/standards/mods/v3/mods-3-6.xsd">
                  <xsl:attribute name="version">3.6</xsl:attribute>
                  <xsl:call-template name="modsMain"/>
                  <!-- <xsl:call-template name="collection-info"/> -->
                  <!--                  <xsl:call-template name="modsRights-apwa"/> -->
                  <!--                  <xsl:call-template name="modsRights-library"/> -->
                  <xsl:call-template name="collectionConstants"/>
                  <xsl:call-template name="modsRecordInfo"/>

               </mods>
            </root>
         </xsl:if>
      </xsl:for-each>
   </xsl:template>

   <!-- ##### START OF modsMain TEMPLATE ##### -->

   <xsl:template name="modsMain">

      <xsl:for-each select="title">
         <titleInfo>
            <xsl:choose>
               <xsl:when test="contains(text(), 't=') or contains(text(), 'l=')">
                  <xsl:if test="contains(text(), 't=')">
                     <xsl:variable name="t_string1" select="substring-after(text(), 't=')"/>
                     <xsl:variable name="t_string2" select="substring-before($t_string1, '|')"/>
                     <xsl:call-template name="add-type">
                        <xsl:with-param name="t" select="$t_string2"/>
                     </xsl:call-template>
                  </xsl:if>
                  <xsl:if test="contains(text(), 'l=')">
                     <xsl:variable name="l_string1" select="substring-after(text(), 'l=')"/>
                     <xsl:variable name="l_string2" select="substring-before($l_string1, '|')"/>
                     <xsl:call-template name="add-language">
                        <xsl:with-param name="l" select="$l_string2"/>
                     </xsl:call-template>
                  </xsl:if>
               </xsl:when>
            </xsl:choose>
            <title>
               <xsl:choose>
                  <xsl:when test="contains(text(), '|')">
                     <xsl:value-of select="substring-before(text(), '|')"/>
                  </xsl:when>
                  <xsl:otherwise>
                     <xsl:value-of select="text()"/>
                  </xsl:otherwise>
               </xsl:choose>
            </title>
            <!-- If this IS the main title -->
            <xsl:if test="not(contains(text(), '='))">
               <xsl:for-each select="../subTitle">
                  <subTitle>
                     <xsl:value-of select="text()"/>
                  </subTitle>
               </xsl:for-each>
            </xsl:if>
         </titleInfo>
      </xsl:for-each>
      
      <!-- ###### START OF NAME #####-->

      <!--
         <xsl:if test="((creator-personal) or (creator-corporate) or (addressee-personal) or (addressee-corporate) or (contributor-personal) or (contributor-corporate))">
         -->

      <xsl:if test="name">
         <xsl:for-each select="name">
            <name>

               <xsl:call-template name="name">
                  <!--
                   <xsl:with-param name="type">
                     <xsl:text>personal</xsl:text>
                  </xsl:with-param>
                  -->
               </xsl:call-template>
               <xsl:if test="contains(text(), 'r=')">
                  <xsl:variable name="r_string1" select="substring-after(text(), 'r=')"/>
                  <xsl:variable name="r_string2" select="substring-before($r_string1, '|')"/>
                  <xsl:call-template name="add-role">
                     <xsl:with-param name="r" select="$r_string2"/>
                  </xsl:call-template>
               </xsl:if>
            </name>
         </xsl:for-each>
      </xsl:if>

      <xsl:for-each select="typeOfResource">
         <xsl:call-template name="typeOfResource"/>
      </xsl:for-each>

      <xsl:for-each select="genre">

         <xsl:choose>
            <!-- First process genre elements that have type=subgenre -->

            <xsl:when test="contains(text(), 't=subgenre')">
               <genre>

                  <xsl:attribute name="authority">
                     <xsl:text>local</xsl:text>
                  </xsl:attribute> 
                  <xsl:attribute name="type">
                     <xsl:text>subgenre</xsl:text>
                  </xsl:attribute>

                  <!--
                  <xsl:if test="contains(text(), 'a=')">
                     <xsl:variable name="a_string1" select="substring-after(text(), 'a=')"/>
                     <xsl:variable name="a_string2" select="substring-before($a_string1, '|')"/>
                     <xsl:call-template name="add-authority">
                        <xsl:with-param name="a" select="$a_string2"/>
                     </xsl:call-template>
                  </xsl:if>
-->
                  <xsl:choose>
                     <xsl:when test="contains(text(), '|')">
                        <xsl:value-of select="substring-before(text(), '|')"/>
                     </xsl:when>
                     <xsl:otherwise>
                        <xsl:value-of select="text()"/>
                     </xsl:otherwise>
                  </xsl:choose>
               </genre>
            </xsl:when>
            <xsl:when test="contains(text(), 'u=primary')">
               <xsl:if test="not(contains(text(), 'Ephemera')) and not(contains(text(), 'Finding Aids')) and not(contains(text(), 'Publications')) and not(contains(text(), 'Manuscripts')) and not(contains(text(), 'Visual Materials'))">
                  <xsl:value-of select="."/>
                  <xsl:message terminate="yes">Oops! The value is not valid for this element. CHECK CAPITALIZATION AND EXACT WORDING.</xsl:message>
               </xsl:if>
               <genre>
                  <!--
                  <xsl:if test="contains(text(), '|t=') and not(contains(substring-after(text(), '='), 'subgenre'))">
                     <xsl:value-of select="text()"/>
                     <xsl:message terminate="yes">Oops! This type attribute is not valid.</xsl:message>
                  </xsl:if>
-->
                  
                  <xsl:attribute name="authority">
                     <xsl:text>local</xsl:text>
                  </xsl:attribute>

                  <xsl:attribute name="usage">
                     <xsl:text>primary</xsl:text>
                  </xsl:attribute>

                  <!--
                  <xsl:if test="contains(text(), 'a=')">
                     <xsl:variable name="a_string1" select="substring-after(text(), 'a=')"/>
                     <xsl:variable name="a_string2" select="substring-before($a_string1, '|')"/>
                     <xsl:call-template name="add-authority">
                        <xsl:with-param name="a" select="$a_string2"/>
                     </xsl:call-template>
                  </xsl:if>
-->

                  <xsl:choose>
                     <xsl:when test="contains(text(), '|')">
                        <xsl:value-of select="substring-before(text(), '|')"/>
                     </xsl:when>
                     <xsl:otherwise>
                        <xsl:value-of select="text()"/>
                     </xsl:otherwise>
                  </xsl:choose>
               </genre>
            </xsl:when>

            <xsl:when test="contains(text(), 'a=')">
               <genre>
                  <xsl:variable name="a_string1" select="substring-after(text(), 'a=')"/>
                  <xsl:variable name="a_string2" select="substring-before($a_string1, '|')"/>
                  <xsl:call-template name="add-authority">
                     <xsl:with-param name="a" select="$a_string2"/>
                  </xsl:call-template>
                  <xsl:choose>
                     <xsl:when test="contains(text(), '|')">
                        <xsl:value-of select="substring-before(text(), '|')"/>
                     </xsl:when>
                     <xsl:otherwise>
                        <xsl:value-of select="text()"/>
                     </xsl:otherwise>
                  </xsl:choose>
               </genre>
            </xsl:when>

            <xsl:otherwise>
               <genre>
                  <!-- When not "primary" or "subgenre" -->

                  <xsl:if test="contains(text(), 'a=')">
                     <xsl:variable name="a_string1" select="substring-after(text(), 'a=')"/>
                     <xsl:variable name="a_string2" select="substring-before($a_string1, '|')"/>
                     <xsl:call-template name="add-authority">
                        <xsl:with-param name="a" select="$a_string2"/>
                     </xsl:call-template>
                  </xsl:if>

                  <xsl:choose>
                     <xsl:when test="contains(text(), '|')">
                        <xsl:value-of select="substring-before(text(), '|')"/>
                     </xsl:when>
                     <xsl:otherwise>
                        <xsl:value-of select="text()"/>
                     </xsl:otherwise>
                  </xsl:choose>
               </genre>

            </xsl:otherwise>
         </xsl:choose>
      </xsl:for-each>

      <xsl:if test="((originInfoEventType) or (originInfoPublisher) or (originInfoPlace) or (dateIssued) or (dateCreated) or (copyrightDate) or (dateOther) or (issuance) or (frequency) or (edition))">

         <originInfo>
            <!-- deprecated 2017
            <xsl:for-each select="originInfoEventType">
               <xsl:if test="contains(text(), '|')">
                  <xsl:value-of select="."/>
                  <xsl:message terminate="yes">Oops! This field does not take any attributes.</xsl:message>
               </xsl:if>
               <xsl:attribute name="eventType">
                  <xsl:value-of select="text()"/>
               </xsl:attribute>
            </xsl:for-each>
-->
            <xsl:for-each select="originInfoPublisher">
               <xsl:if test="contains(text(), '|')">
                  <xsl:value-of select="."/>
                  <xsl:message terminate="yes">Oops! This field does not take any attributes.</xsl:message>
               </xsl:if>

               <publisher>
                  <xsl:value-of select="text()"/>
               </publisher>
            </xsl:for-each>

            <xsl:for-each select="originInfoPlace">
               <!-- type is allowed, but not required, as of 2017-01-17
               <xsl:if test="contains(text(), '|')">
                  <xsl:value-of select="."/>
                  <xsl:message terminate="yes">Oops! This field does not take any attributes.</xsl:message>
               </xsl:if>
 -->
               <place>
                  <placeTerm>
                     <!-- The @type is required by the Islandora XML form element detection -->
                     <xsl:attribute name="type">
                        <xsl:value-of select="text"/>
                        <xsl:text>text</xsl:text>
                     </xsl:attribute>
                     <xsl:choose>
                        <xsl:when test="contains(text(), '|')">
                           <xsl:value-of select="substring-before(text(), '|')"/>
                        </xsl:when>
                        <xsl:otherwise>
                           <xsl:value-of select="text()"/>
                        </xsl:otherwise>
                     </xsl:choose>
                  </placeTerm>
               </place>
            </xsl:for-each>

            <xsl:for-each select="dateIssued">
 <!--               <xsl:if test="contains(text(), '|')">
                  <xsl:value-of select="."/>
                  <xsl:message terminate="yes">Oops! This field does not take any attributes.</xsl:message>
               </xsl:if>
 -->
               <dateIssued keyDate="yes">
                  <!-- encoding should be "iso8601" but do not add the attribute; it interferes with some Islandora XML form element detection
                    <xsl:attribute name="encoding">
                        <xsl:text>iso8601</xsl:text>
                    </xsl:attribute>
                    -->
                  <xsl:if test="contains(text(), 'p=')">
                     <xsl:variable name="p_string1" select="substring-after(text(), 'p=')"/>
                     <xsl:variable name="p_string2" select="substring-before($p_string1, '|')"/>
                     <xsl:call-template name="add-point">
                        <xsl:with-param name="p" select="$p_string2"/>
                     </xsl:call-template>
                  </xsl:if>

                  <xsl:choose>
                     <xsl:when test="contains(text(), '|')">
                        <xsl:value-of select="substring-before(text(), '|')"/>
                     </xsl:when>
                     <xsl:otherwise>
                        <xsl:value-of select="text()"/>
                     </xsl:otherwise>
                  </xsl:choose>
               </dateIssued>
            </xsl:for-each>

            <xsl:for-each select="dateCreated">
               <dateCreated>
                  <!-- encoding should be "iso8601" but do not add the attribute; it interferes with some Islandora XML form element detection
                    <xsl:attribute name="encoding">
                        <xsl:text>iso8601</xsl:text>
                    </xsl:attribute>
                    -->
                  <xsl:choose>
                     <xsl:when test="contains(text(), '|')">
                        <xsl:value-of select="substring-before(text(), '|')"/>
                     </xsl:when>
                     <xsl:otherwise>
                        <xsl:value-of select="text()"/>
                     </xsl:otherwise>
                  </xsl:choose>
               </dateCreated>
            </xsl:for-each>

            <xsl:for-each select="copyrightDate">
               <copyrightDate>
                  <!-- encoding should be "iso8601" but do not add the attribute; it interferes with some Islandora XML form element detection
                    <xsl:attribute name="encoding">
                        <xsl:text>iso8601</xsl:text>
                    </xsl:attribute>
                    -->
                  <xsl:choose>
                     <xsl:when test="contains(text(), '|')">
                        <xsl:value-of select="substring-before(text(), '|')"/>
                     </xsl:when>
                     <xsl:otherwise>
                        <xsl:value-of select="text()"/>
                     </xsl:otherwise>
                  </xsl:choose>
               </copyrightDate>
            </xsl:for-each>

            <xsl:for-each select="dateOther">

               <dateOther>
                  <!-- encoding should be "iso8601" but do not add the attribute; it interferes with some Islandora XML form element detection
                    <xsl:attribute name="encoding">
                        <xsl:text>iso8601</xsl:text>
                    </xsl:attribute>
                    -->
                  <!--
                  <xsl:if test="contains(text(), 't=')">
                     <xsl:variable name="t_string1" select="substring-after(text(), 't=')"/>
                     <xsl:variable name="t_string2" select="substring-before($t_string1, '|')"/>
                     <xsl:call-template name="add-type">
                        <xsl:with-param name="t" select="$t_string2"/>
                     </xsl:call-template>
                  </xsl:if>
-->
                  <xsl:choose>
                     <xsl:when test="contains(text(), '|')">
                        <xsl:value-of select="substring-before(text(), '|')"/>
                     </xsl:when>
                     <xsl:otherwise>
                        <xsl:value-of select="text()"/>
                     </xsl:otherwise>
                  </xsl:choose>
               </dateOther>
            </xsl:for-each>

            <xsl:for-each select="issuance">

               <issuance>
                  <xsl:choose>
                     <xsl:when test="contains(text(), '|')">
                        <xsl:value-of select="substring-before(text(), '|')"/>
                     </xsl:when>
                     <xsl:otherwise>
                        <xsl:value-of select="text()"/>
                     </xsl:otherwise>
                  </xsl:choose>
               </issuance>
            </xsl:for-each>

            <xsl:for-each select="frequency">
               <xsl:if test="not(contains(text(), '|a='))">
                  <xsl:value-of select="."/>
                  <xsl:message terminate="yes">Oops! This field needs "|a=marcfrequency|" added.</xsl:message>
               </xsl:if>
               <frequency>
                  <xsl:if test="contains(text(), 'a=')">
                     <xsl:variable name="a_string1" select="substring-after(text(), 'a=')"/>
                     <xsl:variable name="a_string2" select="substring-before($a_string1, '|')"/>
                     <xsl:call-template name="add-authority">
                        <xsl:with-param name="a" select="$a_string2"/>
                     </xsl:call-template>
                  </xsl:if>

                  <xsl:if test="not(contains(text(), 'Daily')) and not(contains(text(), 'Continuously updated')) and not(contains(text(), 'Daily')) and not(contains(text(), 'Daily')) and not(contains(text(), 'Semiweekly')) and not(contains(text(), 'Weekly')) and not(contains(text(), 'Monthly')) and not(contains(text(), 'Biweekly')) and not(contains(text(), 'Quarterly')) and not(contains(text(), 'Annaul')) and not(contains(text(), 'Completely irregular'))">
                     <xsl:value-of select="."/>
                     <xsl:message terminate="yes">Oops! The value is not valid for this element. CHECK CAPITALIZATION AND EXACT WORDING.</xsl:message>
                  </xsl:if>
                  
                  <xsl:choose>
                     <xsl:when test="contains(text(), '|')">
                        <xsl:value-of select="substring-before(text(), '|')"/>
                     </xsl:when>
                     <xsl:otherwise>
                        <xsl:value-of select="text()"/>
                     </xsl:otherwise>
                  </xsl:choose>
               </frequency>
            </xsl:for-each>

            <xsl:for-each select="edition">
               <xsl:if test="contains(text(), '|')">
                  <xsl:value-of select="."/>
                  <xsl:message terminate="yes">Oops! This field does not take any attributes.</xsl:message>
               </xsl:if>

               <edition>
                  <xsl:value-of select="text()"/>
               </edition>
            </xsl:for-each>

         </originInfo>
      </xsl:if>

      <xsl:for-each select="language">
         <xsl:call-template name="language"/>
      </xsl:for-each>

      <!-- ##### form must have an authority attributre ###### -->
      <!-- form CV: https://www.loc.gov/standards/valuelist/marccategory.html -->

      <xsl:if test="(form) or (extent)">
         <physicalDescription>
            <xsl:for-each select="form">
               <xsl:if test="not(contains(text(), '|a='))">
                  <xsl:value-of select="."/>
                  <xsl:message terminate="yes">Oops! This field needs "|a=" added.</xsl:message>
               </xsl:if>

               <form>
                  <xsl:if test="contains(text(), 'a=')">
                     <xsl:variable name="a_string1" select="substring-after(text(), 'a=')"/>
                     <xsl:variable name="a_string2" select="substring-before($a_string1, '|')"/>
                     <xsl:call-template name="add-authority">
                        <xsl:with-param name="a" select="$a_string2"/>
                     </xsl:call-template>
                  </xsl:if>
                  <xsl:choose>
                     <xsl:when test="contains(text(), '|')">
                        <xsl:value-of select="substring-before(text(), '|')"/>
                     </xsl:when>
                     <xsl:otherwise>
                        <xsl:value-of select="text()"/>
                     </xsl:otherwise>
                  </xsl:choose>
               </form>
            </xsl:for-each>

            <xsl:for-each select="internetMediaType">
               <xsl:if test="contains(text(), '|')">
                  <xsl:value-of select="."/>
                  <xsl:message terminate="yes">Oops! This field does not take any attributes.</xsl:message>
               </xsl:if>

               <internetMediaType>
                  <xsl:value-of select="text()"/>
               </internetMediaType>
            </xsl:for-each>

            <xsl:for-each select="extent">
               <xsl:if test="contains(text(), '|')">
                  <xsl:value-of select="."/>
                  <xsl:message terminate="yes">Oops! This field does not take any attributes.</xsl:message>
               </xsl:if>

               <extent>
                  <xsl:if test="contains(text(), 'u=')">
                     <xsl:variable name="u_string1" select="substring-after(text(), 'u=')"/>
                     <xsl:variable name="u_string2" select="substring-before($u_string1, '|')"/>
                     <xsl:call-template name="add-unit">
                        <xsl:with-param name="u" select="$u_string2"/>
                     </xsl:call-template>
                  </xsl:if>
                  <xsl:choose>
                     <xsl:when test="contains(text(), '|')">
                        <xsl:value-of select="substring-before(text(), '|')"/>
                     </xsl:when>
                     <xsl:otherwise>
                        <xsl:value-of select="text()"/>
                     </xsl:otherwise>
                  </xsl:choose>
               </extent>
            </xsl:for-each>

            <xsl:for-each select="physicalDescriptionNote">
               <xsl:if test="contains(text(), '|')">
                  <xsl:value-of select="."/>
                  <xsl:message terminate="yes">Oops! This field does not take any attributes.</xsl:message>
               </xsl:if>
               <note>
                  <xsl:value-of select="text()"/>
               </note>
            </xsl:for-each>

         </physicalDescription>
      </xsl:if>

      <xsl:for-each select="abstract">
         <xsl:if test="contains(text(), '|')">
            <xsl:value-of select="."/>
            <xsl:message terminate="yes">Oops! This field does not take any attributes.</xsl:message>
         </xsl:if>

         <abstract>
            <!-- all displayLabels disabled, 2015-10-01, pjm
                <xsl:if test="contains(text(), 'd=')">
                    <xsl:variable name="d_string1" select="substring-after(text(), 'd=')"/>
                    <xsl:variable name="d_string2" select="substring-before($d_string1, '|')"/>
                    <xsl:call-template name="add-displayLabel">
                        <xsl:with-param name="d" select="$d_string2"/>
                    </xsl:call-template>
                </xsl:if>
                -->

            <xsl:choose>
               <xsl:when test="contains(text(), '|')">
                  <xsl:value-of select="substring-before(text(), '|')"/>
               </xsl:when>
               <xsl:otherwise>
                  <xsl:value-of select="text()"/>
               </xsl:otherwise>
            </xsl:choose>
         </abstract>
      </xsl:for-each>

      <xsl:for-each select="tableOfContents">
         <xsl:if test="contains(text(), '|')">
            <xsl:value-of select="."/>
            <xsl:message terminate="yes">Oops! This field does not take any attributes.</xsl:message>
         </xsl:if>

         <tableOfContents>
            <!-- all displayLabels disabled, 2015-10-01, pjm
                <xsl:if test="contains(text(), 'd=')">
                    <xsl:variable name="d_string1" select="substring-after(text(), 'd=')"/>
                    <xsl:variable name="d_string2" select="substring-before($d_string1, '|')"/>
                    <xsl:call-template name="add-displayLabel">
                        <xsl:with-param name="d" select="$d_string2"/>
                    </xsl:call-template>
                </xsl:if>
                -->

            <xsl:choose>
               <xsl:when test="contains(text(), '|')">
                  <xsl:value-of select="substring-before(text(), '|')"/>
               </xsl:when>
               <xsl:otherwise>
                  <xsl:value-of select="text()"/>
               </xsl:otherwise>
            </xsl:choose>
         </tableOfContents>
      </xsl:for-each>

      <xsl:for-each select="note">
         <note>

            <xsl:choose>
               <xsl:when test="contains(text(), 't=')">
                  <xsl:variable name="t_string1" select="substring-after(text(), 't=')"/>
                  <xsl:variable name="t_string2" select="substring-before($t_string1, '|')"/>
                  <!--                  <xsl:value-of select="substring-before($t_string1, '|')"/> -->
                  <xsl:value-of select="translate(substring($t_string1, 1, 1), 'abcdefghijklmnopqrstuvwxyz', 'ABCDEFGHIJKLMNOPQRSTUVWXYZ')"/>
                  <xsl:value-of select="substring(substring-before($t_string1, '|'), 2)"/>
                  <xsl:text>: </xsl:text>
                  <xsl:value-of select="substring-before(text(), '|')"/>
               </xsl:when>
               <xsl:otherwise>
                  <xsl:value-of select="text()"/>
               </xsl:otherwise>
            </xsl:choose>

            <!-- displayLabels disabled 2017-01-25, pjm
            <xsl:if test="contains(text(), 'd=')">
               <xsl:variable name="d_string1" select="substring-after(text(), 'd=')"/>
               <xsl:variable name="d_string2" select="substring-before($d_string1, '|')"/>
               <xsl:call-template name="add-displayLabel">
                  <xsl:with-param name="d" select="$d_string2"/>
               </xsl:call-template>
            </xsl:if>
 -->
            <!-- 
            <xsl:choose>
               <xsl:when test="contains(text(), '|')">
                  <xsl:value-of select="substring-before(text(), '|')"/>
               </xsl:when>
               <xsl:otherwise>
                  <xsl:value-of select="text()"/>
               </xsl:otherwise>
            </xsl:choose>
             -->
         </note>

      </xsl:for-each>

      <xsl:for-each select="subjectName">
         <xsl:if test="not(contains(text(), '|a=naf|')) and not(contains(text(), '|a=local|')) and not(contains(text(), '|a=none|'))">
            <xsl:value-of select="."/>
            <xsl:message terminate="yes">Oops! This field needs a valid "|a=" added.</xsl:message>
         </xsl:if>
      </xsl:for-each>

      <subject authority="lcsh">

         <xsl:for-each select="subjectName">
            <xsl:if test="contains(text(), '|a=naf')">
               <name>
                  <xsl:if test="contains(text(), 't=')">
                     <xsl:variable name="t_string1" select="substring-after(text(), 't=')"/>
                     <xsl:variable name="t_string2" select="substring-before($t_string1, '|')"/>
                     <xsl:call-template name="add-type">
                        <xsl:with-param name="t" select="$t_string2"/>
                     </xsl:call-template>
                  </xsl:if>
                  <xsl:if test="contains(text(), 'a=')">
                     <xsl:variable name="a_string1" select="substring-after(text(), 'a=')"/>
                     <xsl:variable name="a_string2" select="substring-before($a_string1, '|')"/>
                     <xsl:call-template name="add-authority">
                        <xsl:with-param name="a" select="$a_string2"/>
                     </xsl:call-template>
                  </xsl:if>
                  <namePart>
                     <xsl:choose>
                        <xsl:when test="contains(text(), '|')">
                           <xsl:value-of select="normalize-space(substring-before(text(), '|'))"/>
                        </xsl:when>
                        <xsl:otherwise>
                           <xsl:value-of select="text()"/>
                        </xsl:otherwise>
                     </xsl:choose>
                  </namePart>
               </name>
            </xsl:if>
         </xsl:for-each>
      </subject>

      <subject authority="lcsh">

         <xsl:for-each select="subjectName">
            <xsl:if test="contains(text(), '|a=lcsh')">
               <name>
                  <xsl:if test="contains(text(), 't=')">
                     <xsl:variable name="t_string1" select="substring-after(text(), 't=')"/>
                     <xsl:variable name="t_string2" select="substring-before($t_string1, '|')"/>
                     <xsl:call-template name="add-type">
                        <xsl:with-param name="t" select="$t_string2"/>
                     </xsl:call-template>
                  </xsl:if>
                  <namePart>
                     <xsl:choose>
                        <xsl:when test="contains(text(), '|')">
                           <xsl:value-of select="normalize-space(substring-before(text(), '|'))"/>
                        </xsl:when>
                        <xsl:otherwise>
                           <xsl:value-of select="text()"/>
                        </xsl:otherwise>
                     </xsl:choose>
                  </namePart>
               </name>
            </xsl:if>
         </xsl:for-each>

         <xsl:for-each select="subjectTopic">
            <xsl:if test="contains(text(), '|a=lcsh')">
               <!-- create subject topic entries -->
               <xsl:call-template name="subjectTopic"/>
            </xsl:if>
         </xsl:for-each>

         <xsl:for-each select="subjectGeographic">
            <xsl:if test="contains(text(), 'a=lcsh')">

               <geographic>
                  <xsl:choose>
                     <xsl:when test="contains(text(), '|')">
                        <xsl:value-of select="substring-before(text(), '|')"/>
                     </xsl:when>
                     <xsl:otherwise>
                        <xsl:value-of select="text()"/>
                     </xsl:otherwise>
                  </xsl:choose>
               </geographic>
            </xsl:if>
         </xsl:for-each>

      </subject>

      <subject authority="local">

         <xsl:for-each select="subjectName">
            <xsl:if test="contains(text(), '|a=local')">
               <name>
                  <xsl:if test="contains(text(), 't=')">
                     <xsl:variable name="t_string1" select="substring-after(text(), 't=')"/>
                     <xsl:variable name="t_string2" select="substring-before($t_string1, '|')"/>
                     <xsl:call-template name="add-type">
                        <xsl:with-param name="t" select="$t_string2"/>
                     </xsl:call-template>
                  </xsl:if>
                  <namePart>
                     <xsl:choose>
                        <xsl:when test="contains(text(), '|')">
                           <xsl:value-of select="normalize-space(substring-before(text(), '|'))"/>
                        </xsl:when>
                        <xsl:otherwise>
                           <xsl:value-of select="text()"/>
                        </xsl:otherwise>
                     </xsl:choose>
                  </namePart>
               </name>
            </xsl:if>
         </xsl:for-each>

         <xsl:for-each select="subjectTopic">
            <xsl:if test="contains(text(), '|a=local')">
               <!-- create subject topic entries -->
               <xsl:call-template name="subjectTopic"/>
            </xsl:if>
         </xsl:for-each>

         <xsl:for-each select="subjectGeographic">
            <xsl:if test="contains(text(), 'a=local')">

               <geographic>
                  <xsl:choose>
                     <xsl:when test="contains(text(), '|')">
                        <xsl:value-of select="substring-before(text(), '|')"/>
                     </xsl:when>
                     <xsl:otherwise>
                        <xsl:value-of select="text()"/>
                     </xsl:otherwise>
                  </xsl:choose>
               </geographic>
            </xsl:if>
         </xsl:for-each>

      </subject>

      <subject authority="none">

         <xsl:for-each select="subjectName">
            <xsl:if test="contains(text(), '|a=none')">
               <name>
                  <xsl:if test="contains(text(), 't=')">
                     <xsl:variable name="t_string1" select="substring-after(text(), 't=')"/>
                     <xsl:variable name="t_string2" select="substring-before($t_string1, '|')"/>
                     <xsl:call-template name="add-type">
                        <xsl:with-param name="t" select="$t_string2"/>
                     </xsl:call-template>
                  </xsl:if>
                  <namePart>
                     <xsl:choose>
                        <xsl:when test="contains(text(), '|')">
                           <xsl:value-of select="normalize-space(substring-before(text(), '|'))"/>
                        </xsl:when>
                        <xsl:otherwise>
                           <xsl:value-of select="text()"/>
                        </xsl:otherwise>
                     </xsl:choose>
                  </namePart>
               </name>
            </xsl:if>
         </xsl:for-each>

         <xsl:for-each select="subjectTopic">
            <xsl:if test="contains(text(), '|a=none')">
               <!-- create subject topic entries -->
               <xsl:call-template name="subjectTopic"/>
            </xsl:if>
         </xsl:for-each>

         <xsl:for-each select="subjectGeographic">
            <xsl:if test="contains(text(), 'a=none')">

               <geographic>
                  <xsl:choose>
                     <xsl:when test="contains(text(), '|')">
                        <xsl:value-of select="substring-before(text(), '|')"/>
                     </xsl:when>
                     <xsl:otherwise>
                        <xsl:value-of select="text()"/>
                     </xsl:otherwise>
                  </xsl:choose>
               </geographic>
            </xsl:if>
         </xsl:for-each>

      </subject>


      <xsl:if test="subjectHierarchicalGeographicTgn">

         <subject authority="tgn">
            <hierarchicalGeographic>
               <xsl:for-each select="subjectHierarchicalGeographicTgn">
                  <xsl:if test="contains(text(), '|')">
                     <xsl:value-of select="."/>
                     <xsl:message terminate="yes">Oops! This field does not take any attributes.</xsl:message>
                  </xsl:if>

                  <xsl:element name="{substring-before(text(), '=')}">

                     <!-- all displayLabels disabled, 2015-10-01, pjm
                                <xsl:if test="contains(text(), 'd=')">
                                    <xsl:variable name="d_string1" select="substring-after(text(), 'd=')"/>
                                    <xsl:variable name="d_string2" select="substring-before($d_string1, '|')"/>
                                    <xsl:call-template name="add-displayLabel">
                                        <xsl:with-param name="d" select="$d_string2"/>
                                    </xsl:call-template>
                                </xsl:if>
-->

                     <xsl:choose>
                        <!-- if an attribute was specified -->
                        <xsl:when test="contains(text(), '|')">
                           <xsl:value-of select="substring-before(substring-after(text(), '='), '|')"/>
                        </xsl:when>
                        <xsl:otherwise>
                           <xsl:value-of select="substring-after(text(), '=')"/>
                        </xsl:otherwise>
                     </xsl:choose>
                  </xsl:element>

               </xsl:for-each>
            </hierarchicalGeographic>
         </subject>
      </xsl:if>

      <xsl:if test="subjectHierarchicalGeographicTgn1">

         <subject authority="tgn">
            <hierarchicalGeographic>
               <xsl:for-each select="subjectHierarchicalGeographicTgn1">
                  <xsl:if test="contains(text(), '|')">
                     <xsl:value-of select="."/>
                     <xsl:message terminate="yes">Oops! This field does not take any attributes.</xsl:message>
                  </xsl:if>
                  <xsl:element name="{substring-before(text(), '=')}">

                     <!-- all displayLabels disabled, 2015-10-01, pjm
                                <xsl:if test="contains(text(), 'd=')">
                                    <xsl:variable name="d_string1" select="substring-after(text(), 'd=')"/>
                                    <xsl:variable name="d_string2" select="substring-before($d_string1, '|')"/>
                                    <xsl:call-template name="add-displayLabel">
                                        <xsl:with-param name="d" select="$d_string2"/>
                                    </xsl:call-template>
                                </xsl:if>
-->

                     <xsl:choose>
                        <!-- if an attribute was specified -->
                        <xsl:when test="contains(text(), '|')">
                           <xsl:value-of select="substring-before(substring-after(text(), '='), '|')"/>
                        </xsl:when>
                        <xsl:otherwise>
                           <xsl:value-of select="substring-after(text(), '=')"/>
                        </xsl:otherwise>
                     </xsl:choose>
                  </xsl:element>

               </xsl:for-each>
            </hierarchicalGeographic>
         </subject>
      </xsl:if>

      <xsl:if test="subjectHierarchicalGeographicTgn2">

         <subject authority="tgn">
            <hierarchicalGeographic>
               <xsl:for-each select="subjectHierarchicalGeographicTgn2">
                  <xsl:if test="contains(text(), '|')">
                     <xsl:value-of select="."/>
                     <xsl:message terminate="yes">Oops! This field does not take any attributes.</xsl:message>
                  </xsl:if>
                  <xsl:element name="{substring-before(text(), '=')}">

                     <!-- all displayLabels disabled, 2015-10-01, pjm
                                <xsl:if test="contains(text(), 'd=')">
                                    <xsl:variable name="d_string1" select="substring-after(text(), 'd=')"/>
                                    <xsl:variable name="d_string2" select="substring-before($d_string1, '|')"/>
                                    <xsl:call-template name="add-displayLabel">
                                        <xsl:with-param name="d" select="$d_string2"/>
                                    </xsl:call-template>
                                </xsl:if>
-->

                     <xsl:choose>
                        <!-- if an attribute was specified -->
                        <xsl:when test="contains(text(), '|')">
                           <xsl:value-of select="substring-before(substring-after(text(), '='), '|')"/>
                        </xsl:when>
                        <xsl:otherwise>
                           <xsl:value-of select="substring-after(text(), '=')"/>
                        </xsl:otherwise>
                     </xsl:choose>
                  </xsl:element>

               </xsl:for-each>
            </hierarchicalGeographic>
         </subject>
      </xsl:if>

      <!-- coordnates needs to be tested -->

      <xsl:if test="subjectHierarchicalGeographicTgn3">

         <subject authority="tgn">
            <hierarchicalGeographic>
               <xsl:for-each select="subjectHierarchicalGeographicTgn3">
                  <xsl:if test="contains(text(), '|')">
                     <xsl:value-of select="."/>
                     <xsl:message terminate="yes">Oops! This field does not take any attributes.</xsl:message>
                  </xsl:if>

                  <xsl:element name="{substring-before(text(), '=')}">

                     <!-- all displayLabels disabled, 2015-10-01, pjm
                                <xsl:if test="contains(text(), 'd=')">
                                    <xsl:variable name="d_string1" select="substring-after(text(), 'd=')"/>
                                    <xsl:variable name="d_string2" select="substring-before($d_string1, '|')"/>
                                    <xsl:call-template name="add-displayLabel">
                                        <xsl:with-param name="d" select="$d_string2"/>
                                    </xsl:call-template>
                                </xsl:if>
-->

                     <xsl:value-of select="substring-after(text(), '=')"/>
                  </xsl:element>

               </xsl:for-each>
            </hierarchicalGeographic>
         </subject>
      </xsl:if>

      <xsl:if test="coordinates">

         <xsl:for-each select="coordinates">
            <subject>

               <xsl:if test="contains(text(), 'a=')">
                  <xsl:variable name="a_string1" select="substring-after(text(), 'a=')"/>
                  <xsl:variable name="a_string2" select="substring-before($a_string1, '|')"/>
                  <xsl:call-template name="add-authority">
                     <xsl:with-param name="a" select="$a_string2"/>
                  </xsl:call-template>
               </xsl:if>

               <cartographics>
                  <coordinates>
                     <xsl:choose>
                        <xsl:when test="contains(text(), '|')">
                           <xsl:value-of select="substring-before(text(), '|')"/>
                        </xsl:when>
                        <xsl:otherwise>
                           <xsl:value-of select="text()"/>
                        </xsl:otherwise>
                     </xsl:choose>
                  </coordinates>
               </cartographics>
            </subject>
         </xsl:for-each>

      </xsl:if>

      <!--
      <xsl:if test="coordinates">

         <subject>
            <xsl:for-each select="coordinates">
               <xsl:if test="contains(text(), '|')">
                  <xsl:value-of select="."/>
                  <xsl:message terminate="yes">Oops! This field does not take any attributes.</xsl:message>
               </xsl:if>
               <cartographics>
                  <coordinates>
                     <xsl:value-of select="text()"/>
               </cartographics>
                  </coordinates>

            </xsl:for-each>

         </subject>
      </xsl:if>
-->

      <xsl:for-each select="identifier">

         <identifier type="local">
            <xsl:value-of select="text()"/>
         </identifier>

         <note>
            <xsl:text>Original digital object name: </xsl:text>
            <xsl:value-of select="text()"/>
         </note>

      </xsl:for-each>

      <xsl:if test="physicalLocation or shelfLocator">
         <location>
            <xsl:for-each select="physicalLocation">

               <xsl:if test="contains(text(), '|')">
                  <xsl:value-of select="."/>
                  <xsl:message terminate="yes">Oops! This field does not take any attributes.</xsl:message>
               </xsl:if>

               <physicalLocation>
                  <xsl:value-of select="."/>
               </physicalLocation>
            </xsl:for-each>

            <xsl:for-each select="shelfLocator">
               <xsl:if test="contains(text(), '|')">
                  <xsl:value-of select="."/>
                  <xsl:message terminate="yes">Oops! This field does not take any attributes.</xsl:message>
               </xsl:if>

               <shelfLocator>
                  <xsl:value-of select="."/>
               </shelfLocator>
            </xsl:for-each>
         </location>
      </xsl:if>

      <!-- Testing for a contentdmID -->
      <xsl:if test="contentdmID">
         <xsl:for-each select="contentdmID">
            <recordInfo>
               <recordIdentifier>
                  <xsl:if test="contains(text(), 't=')">
                     <xsl:variable name="t_string1" select="substring-after(text(), 't=')"/>
                     <xsl:variable name="t_string2" select="substring-before($t_string1, '|')"/>
                     <xsl:call-template name="add-type">
                        <xsl:with-param name="t" select="$t_string2"/>
                     </xsl:call-template>
                  </xsl:if>
                  <xsl:value-of select="concat('CONTENTdm ID: ', text())"/>
               </recordIdentifier>
            </recordInfo>
         </xsl:for-each>
      </xsl:if>

      <!-- Testing for a Collection title -->
      <xsl:if test="relatedItem">
         <xsl:for-each select="relatedItem">
            <!--
            <xsl:if test="contains(text(), '|')">
               <xsl:value-of select="."/>
               <xsl:message terminate="yes">Oops! This field does not take any attributes.</xsl:message>
            </xsl:if>
-->
            <relatedItem>
               <xsl:if test="contains(text(), 't=')">
                  <xsl:variable name="t_string1" select="substring-after(text(), 't=')"/>
                  <xsl:variable name="t_string2" select="substring-before($t_string1, '|')"/>
                  <xsl:call-template name="add-type">
                     <xsl:with-param name="t" select="$t_string2"/>
                  </xsl:call-template>
               </xsl:if>

               <titleInfo>
                  <title>
                     <xsl:choose>
                        <xsl:when test="contains(text(), '|')">
                           <xsl:value-of select="substring-before(text(), '|')"/>
                        </xsl:when>
                        <xsl:otherwise>
                           <xsl:value-of select="text()"/>
                        </xsl:otherwise>
                     </xsl:choose>
                  </title>
               </titleInfo>
            </relatedItem>
         </xsl:for-each>
      </xsl:if>

      <!-- Testing for a serial title used in a serial issue record -->
      <!-- obsoleted 2017-01-18
      <xsl:if test="relatedItem-title">
         <xsl:for-each select="relatedItem-title">

            <xsl:if test="contains(text(), '|')">
               <xsl:value-of select="."/>
               <xsl:message terminate="yes">Oops! This field does not take any attributes.</xsl:message>
            </xsl:if>

            <relatedItem type="host">
               <titleInfo>
                  <title>
                     <xsl:value-of select="text()"/>
                  </title>
               </titleInfo>
            </relatedItem>
         </xsl:for-each>
      </xsl:if>
-->

      <!-- PETER : The XSLT may throw an error that the ns is invalid, but since t's already in the 
         MODS file's header, you don't really need the xmlns declaration  in the <extension> element?
      Even though MODS instructions want the declaration in the <extension> element.-->

      <xsl:if test="extension">
         <extension xmlns:dhiapw="http://www.dhinitiative.org/dhiapw/">
            <dhiapw:dhiapw>
               <xsl:for-each select="extension">
                  <xsl:for-each select="child::node()">
                     <xsl:call-template name="tokenize-extension"/>
                  </xsl:for-each>
               </xsl:for-each>
            </dhiapw:dhiapw>
         </extension>
      </xsl:if>

   </xsl:template>

   <!-- ######## END OF modsMain TEMPLATE ########### -->

   <xsl:template name="subjectTopic">
      <xsl:param name="authority"/>
      <!--
            <xsl:if test="not(contains(text(), '|a='))">
               <xsl:value-of select="."/>
               <xsl:message terminate="yes">Oops! This field needs "|a=" added.</xsl:message>
            </xsl:if>
-->
      <xsl:choose>
         <xsl:when test="contains(text(), 'lcsh')">
            <topic>
               <xsl:choose>
                  <xsl:when test="contains(text(), '|')">
                     <xsl:value-of select="normalize-space(substring-before(text(), '|'))"/>
                  </xsl:when>
                  <xsl:otherwise>
                     <xsl:value-of select="text()"/>
                  </xsl:otherwise>
               </xsl:choose>
            </topic>
         </xsl:when>
         <xsl:when test="contains(text(), 'local')">
            <topic>
               <xsl:choose>
                  <xsl:when test="contains(text(), '|')">
                     <xsl:value-of select="normalize-space(substring-before(text(), '|'))"/>
                  </xsl:when>
                  <xsl:otherwise>
                     <xsl:value-of select="text()"/>
                  </xsl:otherwise>
               </xsl:choose>
            </topic>
         </xsl:when>
         <xsl:when test="contains(text(), 'none')">
            <topic>
               <xsl:choose>
                  <xsl:when test="contains(text(), '|')">
                     <xsl:value-of select="normalize-space(substring-before(text(), '|'))"/>
                  </xsl:when>
                  <xsl:otherwise>
                     <xsl:value-of select="text()"/>
                  </xsl:otherwise>
               </xsl:choose>
            </topic>
         </xsl:when>
      </xsl:choose>
   </xsl:template>

   <xsl:template name="typeOfResource">
      <xsl:param name="string" select="concat(normalize-space(.), ';')"/>

      <xsl:choose>
         <xsl:when test="contains($string, 'still image') or contains($string, 'Still Image') or contains($string, 'Still image')">
            <typeOfResource>
               <xsl:text>still image</xsl:text>
            </typeOfResource>
         </xsl:when>

         <xsl:when test="contains($string, 'moving image')">
            <typeOfResource>
               <xsl:text>moving image</xsl:text>
            </typeOfResource>
         </xsl:when>

         <xsl:when test="contains($string, 'three dimensional object')">
            <typeOfResource>
               <xsl:text>three dimensional object</xsl:text>
            </typeOfResource>
         </xsl:when>

         <xsl:when test="contains($string, 'software, multimedia')">
            <typeOfResource>
               <xsl:text>software, multimedia</xsl:text>
            </typeOfResource>
         </xsl:when>

         <xsl:when test="contains($string, 'cartographic')">
            <typeOfResource>
               <xsl:text>cartographic</xsl:text>
            </typeOfResource>
         </xsl:when>

         <xsl:when test="contains($string, 'text') or contains($string, 'Text')">
            <typeOfResource>
               <xsl:text>text</xsl:text>
            </typeOfResource>
         </xsl:when>

         <xsl:otherwise>
            <typeOfResource>
               <xsl:value-of select="node()"/>
               <xsl:message terminate="yes">Oops! Term is not valid. If a new typeOfResource, add it to the XSLT above.</xsl:message>
            </typeOfResource>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>

   <xsl:template name="name">
      <xsl:param name="type"/>
      <!-- add a semicolon at the end of the text content -->
      <!-- NOTE: type="first line" is not valid MODS -->

      <xsl:if test="contains(text(), 't=')">
         <xsl:variable name="t_string1" select="substring-after(text(), 't=')"/>
         <xsl:variable name="t_string2" select="substring-before($t_string1, '|')"/>
         <xsl:call-template name="add-type">
            <xsl:with-param name="t" select="$t_string2"/>
         </xsl:call-template>
      </xsl:if>

      <xsl:if test="contains(text(), 'a=')">
         <xsl:variable name="a_string1" select="substring-after(text(), 'a=')"/>
         <xsl:variable name="a_string2" select="substring-before($a_string1, '|')"/>
         <xsl:call-template name="add-authority">
            <xsl:with-param name="a" select="$a_string2"/>
         </xsl:call-template>
      </xsl:if>

      <namePart>
         <!-- all displayLabels disabled, 2015-10-01, pjm
                <xsl:if test="contains(text(), 'd=')">
                <xsl:variable name="d_string1" select="substring-after(text(), 'd=')"/>
                <xsl:variable name="d_string2" select="substring-before($d_string1, '|')"/>
                <xsl:call-template name="add-displayLabel">
                    <xsl:with-param name="d" select="$d_string2"/>
                </xsl:call-template>
            </xsl:if>
-->

         <xsl:choose>
            <xsl:when test="contains(text(), '|')">
               <!-- xsl:value-of select="substring-before(text(), '|')"/ -->
               <xsl:value-of select="normalize-space(substring-before(text(), '|'))"/>
            </xsl:when>
            <xsl:otherwise>
               <xsl:value-of select="text()"/>
            </xsl:otherwise>
         </xsl:choose>

      </namePart>
      <!--
        <role>
            <roleTerm authority="marcrelator" type="text">Author</roleTerm>
            <roleTerm authority="marcrelator" type="code">aut</roleTerm>
        </role>
        -->

   </xsl:template>

   <!-- Add more languages as needed from CV : http://www.loc.gov/marc/languages/language_name.html -->

   <xsl:template name="language">

      <xsl:element name="{name()}">
         <xsl:choose>
            <xsl:when test="contains(text(), 'English')">
               <languageTerm type="text">
                  <xsl:choose>
                     <xsl:when test="contains(text(), '|')">
                        <xsl:value-of select="substring-before(text(), '|')"/>
                     </xsl:when>
                     <xsl:otherwise>
                        <xsl:value-of select="text()"/>
                     </xsl:otherwise>
                  </xsl:choose>
               </languageTerm>
               <languageTerm>
                  <xsl:attribute name="type">
                     <xsl:text>code</xsl:text>
                  </xsl:attribute>
                  <xsl:attribute name="authority">
                     <xsl:text>iso639-2b</xsl:text>
                  </xsl:attribute>
                  <xsl:text>eng</xsl:text>
               </languageTerm>
            </xsl:when>
            <xsl:when test="contains(text(), 'Spanish')">
               <languageTerm type="text">
                  <xsl:choose>
                     <xsl:when test="contains(text(), '|')">
                        <xsl:value-of select="substring-before(text(), '|')"/>
                     </xsl:when>
                     <xsl:otherwise>
                        <xsl:value-of select="text()"/>
                     </xsl:otherwise>
                  </xsl:choose>
               </languageTerm>
               <languageTerm>
                  <xsl:attribute name="type">
                     <xsl:text>code</xsl:text>
                  </xsl:attribute>
                  <xsl:attribute name="authority">
                     <xsl:text>iso639-2b</xsl:text>
                  </xsl:attribute>
                  <xsl:text>spa</xsl:text>
               </languageTerm>
            </xsl:when>
            <xsl:when test="contains(text(), 'French')">
               <languageTerm type="text">
                  <xsl:choose>
                     <xsl:when test="contains(text(), '|')">
                        <xsl:value-of select="substring-before(text(), '|')"/>
                     </xsl:when>
                     <xsl:otherwise>
                        <xsl:value-of select="text()"/>
                     </xsl:otherwise>
                  </xsl:choose>
               </languageTerm>
               <languageTerm>
                  <xsl:attribute name="type">
                     <xsl:text>code</xsl:text>
                  </xsl:attribute>
                  <xsl:attribute name="authority">
                     <xsl:text>iso639-2b</xsl:text>
                  </xsl:attribute>
                  <xsl:text>fre</xsl:text>
               </languageTerm>
            </xsl:when>
            <xsl:when test="contains(text(), 'Japanese')">
               <languageTerm type="text">
                  <xsl:choose>
                     <xsl:when test="contains(text(), '|')">
                        <xsl:value-of select="substring-before(text(), '|')"/>
                     </xsl:when>
                     <xsl:otherwise>
                        <xsl:value-of select="text()"/>
                     </xsl:otherwise>
                  </xsl:choose>
               </languageTerm>
               <languageTerm>
                  <xsl:attribute name="type">
                     <xsl:text>code</xsl:text>
                  </xsl:attribute>
                  <xsl:attribute name="authority">
                     <xsl:text>iso639-2b</xsl:text>
                  </xsl:attribute>
                  <xsl:text>jpn</xsl:text>
               </languageTerm>
            </xsl:when>
            <xsl:when test="contains(text(), 'Dutch')">
               <languageTerm type="text">
                  <xsl:choose>
                     <xsl:when test="contains(text(), '|')">
                        <xsl:value-of select="substring-before(text(), '|')"/>
                     </xsl:when>
                     <xsl:otherwise>
                        <xsl:value-of select="text()"/>
                     </xsl:otherwise>
                  </xsl:choose>
               </languageTerm>
               <languageTerm>
                  <xsl:attribute name="type">
                     <xsl:text>code</xsl:text>
                  </xsl:attribute>
                  <xsl:attribute name="authority">
                     <xsl:text>iso639-2b</xsl:text>
                  </xsl:attribute>
                  <xsl:text>dut</xsl:text>
               </languageTerm>
            </xsl:when>
            <xsl:when test="contains(text(), 'Swedish')">
               <languageTerm type="text">
                  <xsl:choose>
                     <xsl:when test="contains(text(), '|')">
                        <xsl:value-of select="substring-before(text(), '|')"/>
                     </xsl:when>
                     <xsl:otherwise>
                        <xsl:value-of select="text()"/>
                     </xsl:otherwise>
                  </xsl:choose>
               </languageTerm>
               <languageTerm>
                  <xsl:attribute name="type">
                     <xsl:text>code</xsl:text>
                  </xsl:attribute>
                  <xsl:attribute name="authority">
                     <xsl:text>iso639-2b</xsl:text>
                  </xsl:attribute>
                  <xsl:text>swe</xsl:text>
               </languageTerm>
            </xsl:when>
            <xsl:when test="contains(text(), 'German')">
               <languageTerm type="text">
                  <xsl:choose>
                     <xsl:when test="contains(text(), '|')">
                        <xsl:value-of select="substring-before(text(), '|')"/>
                     </xsl:when>
                     <xsl:otherwise>
                        <xsl:value-of select="text()"/>
                     </xsl:otherwise>
                  </xsl:choose>
               </languageTerm>
               <languageTerm>
                  <xsl:attribute name="type">
                     <xsl:text>code</xsl:text>
                  </xsl:attribute>
                  <xsl:attribute name="authority">
                     <xsl:text>iso639-2b</xsl:text>
                  </xsl:attribute>
                  <xsl:text>ger</xsl:text>
               </languageTerm>
            </xsl:when>
            <xsl:when test="contains(text(), 'Latin')">
               <languageTerm type="text">
                  <xsl:choose>
                     <xsl:when test="contains(text(), '|')">
                        <xsl:value-of select="substring-before(text(), '|')"/>
                     </xsl:when>
                     <xsl:otherwise>
                        <xsl:value-of select="text()"/>
                     </xsl:otherwise>
                  </xsl:choose>
               </languageTerm>
               <languageTerm>
                  <xsl:attribute name="type">
                     <xsl:text>code</xsl:text>
                  </xsl:attribute>
                  <xsl:attribute name="authority">
                     <xsl:text>iso639-2b</xsl:text>
                  </xsl:attribute>
                  <xsl:text>ltn</xsl:text>
               </languageTerm>
            </xsl:when>
            <xsl:when test="contains(text(), 'zxx')">
               <languageTerm type="code">
                  <xsl:value-of select="."/>
               </languageTerm>
            </xsl:when>
            <xsl:otherwise>
               <languageTerm type="text">
                  <xsl:value-of select="."/>
                  <xsl:message terminate="yes">Oops! No valid language specified. If a new language, add it to the XSLT above.</xsl:message>
               </languageTerm>
            </xsl:otherwise>
         </xsl:choose>
      </xsl:element>
   </xsl:template>

   <!-- ######### Add Attributes Templages ######### -->
   <!-- Add more as needed from CV : https://www.loc.gov/marc/relators/relaterm.html -->

   <xsl:template name="add-role">
      <xsl:param name="r"/>
      <role>
         <!--
            <roleTerm>
                <xsl:attribute name="type">
                    <xsl:text>text</xsl:text>
                </xsl:attribute>
                <xsl:attribute name="authority">
                    <xsl:text>marcrelator</xsl:text>
                </xsl:attribute>
                <xsl:value-of select="$r"/>
            </roleTerm>
-->
         <xsl:choose>
            <xsl:when test="$r = 'author'">
               <roleTerm>
                  <xsl:attribute name="type">
                     <xsl:text>text</xsl:text>
                  </xsl:attribute>
                  <xsl:attribute name="authority">
                     <xsl:text>marcrelator</xsl:text>
                  </xsl:attribute>
                  <xsl:text>Author</xsl:text>
               </roleTerm>
               <roleTerm>
                  <xsl:attribute name="type">
                     <xsl:text>code</xsl:text>
                  </xsl:attribute>
                  <xsl:attribute name="authority">
                     <xsl:text>marcrelator</xsl:text>
                  </xsl:attribute>
                  <xsl:text>aut</xsl:text>
               </roleTerm>
            </xsl:when>
            <xsl:when test="$r = 'editor'">
               <roleTerm>
                  <xsl:attribute name="type">
                     <xsl:text>text</xsl:text>
                  </xsl:attribute>
                  <xsl:attribute name="authority">
                     <xsl:text>marcrelator</xsl:text>
                  </xsl:attribute>
                  <xsl:text>Editor</xsl:text>
               </roleTerm>
               <roleTerm>
                  <xsl:attribute name="type">
                     <xsl:text>code</xsl:text>
                  </xsl:attribute>
                  <xsl:attribute name="authority">
                     <xsl:text>marcrelator</xsl:text>
                  </xsl:attribute>
                  <xsl:text>edt</xsl:text>
               </roleTerm>
            </xsl:when>

            <xsl:when test="$r = 'translator'">
               <roleTerm>
                  <xsl:attribute name="type">
                     <xsl:text>text</xsl:text>
                  </xsl:attribute>
                  <xsl:attribute name="authority">
                     <xsl:text>marcrelator</xsl:text>
                  </xsl:attribute>
                  <xsl:text>Translator</xsl:text>
               </roleTerm>
               <roleTerm>
                  <xsl:attribute name="type">
                     <xsl:text>code</xsl:text>
                  </xsl:attribute>
                  <xsl:attribute name="authority">
                     <xsl:text>marcrelator</xsl:text>
                  </xsl:attribute>
                  <xsl:text>trl</xsl:text>
               </roleTerm>
            </xsl:when>

            <xsl:when test="$r = 'addressee'">
               <roleTerm>
                  <xsl:attribute name="type">
                     <xsl:text>text</xsl:text>
                  </xsl:attribute>
                  <xsl:attribute name="authority">
                     <xsl:text>marcrelator</xsl:text>
                  </xsl:attribute>
                  <xsl:text>Addressee</xsl:text>
               </roleTerm>
               <roleTerm>
                  <xsl:attribute name="type">
                     <xsl:text>code</xsl:text>
                  </xsl:attribute>
                  <xsl:attribute name="authority">
                     <xsl:text>marcrelator</xsl:text>
                  </xsl:attribute>
                  <xsl:text>rcp</xsl:text>
               </roleTerm>
            </xsl:when>
            <xsl:when test="$r = 'photographer'">
               <roleTerm>
                  <xsl:attribute name="type">
                     <xsl:text>text</xsl:text>
                  </xsl:attribute>
                  <xsl:attribute name="authority">
                     <xsl:text>marcrelator</xsl:text>
                  </xsl:attribute>
                  <xsl:text>Photographer</xsl:text>
               </roleTerm>
               <roleTerm>
                  <xsl:attribute name="type">
                     <xsl:text>code</xsl:text>
                  </xsl:attribute>
                  <xsl:attribute name="authority">
                     <xsl:text>marcrelator</xsl:text>
                  </xsl:attribute>
                  <xsl:text>pht</xsl:text>
               </roleTerm>
            </xsl:when>
            <xsl:when test="$r = 'publishing director'">
               <roleTerm>
                  <xsl:attribute name="type">
                     <xsl:text>text</xsl:text>
                  </xsl:attribute>
                  <xsl:attribute name="authority">
                     <xsl:text>marcrelator</xsl:text>
                  </xsl:attribute>
                  <xsl:text>Publishing director</xsl:text>
               </roleTerm>
               <roleTerm>
                  <xsl:attribute name="type">
                     <xsl:text>code</xsl:text>
                  </xsl:attribute>
                  <xsl:attribute name="authority">
                     <xsl:text>marcrelator</xsl:text>
                  </xsl:attribute>
                  <xsl:text>pbd</xsl:text>
               </roleTerm>
            </xsl:when>
            <xsl:when test="$r = 'publisher'">
               <roleTerm>
                  <xsl:attribute name="type">
                     <xsl:text>text</xsl:text>
                  </xsl:attribute>
                  <xsl:attribute name="authority">
                     <xsl:text>marcrelator</xsl:text>
                  </xsl:attribute>
                  <xsl:text>Publisher</xsl:text>
               </roleTerm>
               <roleTerm>
                  <xsl:attribute name="type">
                     <xsl:text>code</xsl:text>
                  </xsl:attribute>
                  <xsl:attribute name="authority">
                     <xsl:text>marcrelator</xsl:text>
                  </xsl:attribute>
                  <xsl:text>pbl</xsl:text>
               </roleTerm>
            </xsl:when>

            <xsl:when test="$r = 'printer'">
               <roleTerm>
                  <xsl:attribute name="type">
                     <xsl:text>text</xsl:text>
                  </xsl:attribute>
                  <xsl:attribute name="authority">
                     <xsl:text>marcrelator</xsl:text>
                  </xsl:attribute>
                  <xsl:text>Printer</xsl:text>
               </roleTerm>
               <roleTerm>
                  <xsl:attribute name="type">
                     <xsl:text>code</xsl:text>
                  </xsl:attribute>
                  <xsl:attribute name="authority">
                     <xsl:text>marcrelator</xsl:text>
                  </xsl:attribute>
                  <xsl:text>prt</xsl:text>
               </roleTerm>
            </xsl:when>

            <xsl:when test="$r = 'dedicatee'">
               <roleTerm>
                  <xsl:attribute name="type">
                     <xsl:text>text</xsl:text>
                  </xsl:attribute>
                  <xsl:attribute name="authority">
                     <xsl:text>marcrelator</xsl:text>
                  </xsl:attribute>
                  <xsl:text>Dedicatee</xsl:text>
               </roleTerm>
               <roleTerm>
                  <xsl:attribute name="type">
                     <xsl:text>code</xsl:text>
                  </xsl:attribute>
                  <xsl:attribute name="authority">
                     <xsl:text>marcrelator</xsl:text>
                  </xsl:attribute>
                  <xsl:text>dte</xsl:text>
               </roleTerm>
            </xsl:when>
            <xsl:otherwise>
               <xsl:value-of select="."/>
               <xsl:message terminate="yes">Oops! The role value specified is not valid. Add it to the XSLT.</xsl:message>
            </xsl:otherwise>
         </xsl:choose>
      </role>
   </xsl:template>

   <xsl:template name="add-type">
      <xsl:param name="t"/>
      <xsl:attribute name="type">
         <xsl:value-of select="$t"/>
      </xsl:attribute>
   </xsl:template>

   <xsl:template name="add-authority">
      <xsl:param name="a"/>
      <xsl:attribute name="authority">
         <xsl:choose>
            <xsl:when test="$a = ''">
               <xsl:text>ERROR: Empty attribute value. Check source syntax. --</xsl:text>
            </xsl:when>
            <xsl:otherwise>
               <xsl:value-of select="$a"/>
            </xsl:otherwise>
         </xsl:choose>
      </xsl:attribute>
   </xsl:template>

   <xsl:template name="add-encoding">
      <xsl:param name="e"/>
      <xsl:attribute name="encoding">
         <xsl:choose>
            <xsl:when test="$e = ''">
               <xsl:text>ERROR: Empty attribute value. Check source syntax. --</xsl:text>
            </xsl:when>
            <xsl:otherwise>
               <xsl:value-of select="$e"/>
            </xsl:otherwise>
         </xsl:choose>
      </xsl:attribute>
   </xsl:template>

   <xsl:template name="add-language">
      <xsl:param name="l"/>

      <xsl:attribute name="authority">
         <xsl:text>iso639-2b</xsl:text>
      </xsl:attribute>

      <xsl:attribute name="lang">
         <xsl:value-of select="$l"/>
      </xsl:attribute>
   </xsl:template>

   <xsl:template name="add-point">
      <xsl:param name="p"/>
      <xsl:attribute name="point">
         <xsl:choose>
            <xsl:when test="$p = ''">
               <xsl:text>ERROR: Empty attribute value. Check source syntax. --</xsl:text>
            </xsl:when>
            <xsl:otherwise>
               <xsl:value-of select="$p"/>
            </xsl:otherwise>
         </xsl:choose>
      </xsl:attribute>
   </xsl:template>

   <xsl:template name="add-end">
      <xsl:param name="e"/>
      <xsl:attribute name="end">
         <xsl:choose>
            <xsl:when test="$e = ''">
               <xsl:text>ERROR: Empty attribute value. Check source syntax. --</xsl:text>
            </xsl:when>
            <xsl:otherwise>
               <xsl:value-of select="$e"/>
            </xsl:otherwise>
         </xsl:choose>
      </xsl:attribute>
   </xsl:template>

   <xsl:template name="add-unit">
      <xsl:param name="u"/>
      <xsl:attribute name="unit">
         <xsl:choose>
            <xsl:when test="$u = ''">
               <xsl:text>ERROR: Empty attribute value. Check source syntax. --</xsl:text>
            </xsl:when>
            <xsl:otherwise>
               <xsl:value-of select="$u"/>
            </xsl:otherwise>
         </xsl:choose>
      </xsl:attribute>
   </xsl:template>

   <xsl:template name="add-displayLabel">
      <xsl:param name="d"/>
      <xsl:attribute name="displayLabel">
         <xsl:choose>
            <xsl:when test="$d = ''">
               <xsl:text>ERROR: Empty attribute value. Check source syntax. --</xsl:text>
            </xsl:when>
            <xsl:otherwise>
               <xsl:value-of select="$d"/>
            </xsl:otherwise>
         </xsl:choose>
      </xsl:attribute>
   </xsl:template>

   <!-- ######## EXTENSION ########### -->

   <xsl:template name="tokenize-extension">
      <xsl:param name="string" select="concat(normalize-space(.), ';')"/>
      <xsl:param name="delimiter" select="concat(normalize-space(.), ';')"/>
      <xsl:if test="contains($string, '|')">
         <xsl:value-of select="."/>
         <xsl:message terminate="yes">Oops! This field does not allow any attributes.</xsl:message>
      </xsl:if>


      <xsl:variable name="lowercaseElementName" select="translate($string, 'ABCDEFGHIJKLMNOPQRSTUVWXYZ', 'abcdefghijklmnopqrstuvwxyz')"/>

      <xsl:variable name="newElementName">
         <xsl:value-of select="substring-after(name(), 'ext-')"/>
      </xsl:variable>
      <xsl:if test="not($newElementName = '')">
         <xsl:element name="{concat('dhiapw:', $newElementName)}">

            <!-- all displayLabels disabled, 2015-10-01, pjm
            <xsl:attribute name="displayLabel">
                <xsl:value-of select="translate($newElementName, '_', ' ')"/>
            </xsl:attribute>
            -->

            <xsl:value-of select="substring-before($string, ';')"/>
         </xsl:element>
      </xsl:if>

      <xsl:if test="string-length(normalize-space(substring-after($string, $delimiter))) > 2">
         <xsl:call-template name="tokenize-extension">
            <xsl:with-param name="string" select="substring-after($string, $delimiter)"/>
            <xsl:with-param name="delimiter" select="$delimiter"/>
         </xsl:call-template>
      </xsl:if>

   </xsl:template>
   <xsl:template match="node() | @*">
      <xsl:copy>
         <xsl:apply-templates select="node() | @*"/>
      </xsl:copy>
   </xsl:template>
   <xsl:template match="*[not(*) and not(text()[normalize-space()]) and not(@*)]"/>

</xsl:stylesheet>
