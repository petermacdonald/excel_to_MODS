<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
   xmlns:dhi="http://www.dhinitiative.org/dhi/" 
   exclude-result-prefixes="dhi" version="2.0">

   <xsl:output omit-xml-declaration="yes" indent="yes"/>
<!-- NOTE: Select parser: Saxon EE xx because this XSLT uses the XSLT 2.0 replace() --> 
   <xsl:template match="/">
      <root>
         <xsl:for-each select="child::node()">
            <xsl:call-template name="row"/>
         </xsl:for-each>
      </root>
   </xsl:template>

   <xsl:template name="row">
      <xsl:for-each select="child::node()">
         <xsl:if test="child::node() != ''">
            <row>
               <xsl:attribute name="version">3.6</xsl:attribute>
               <xsl:call-template name="tokenizerMain"/>
            </row>
         </xsl:if>
      </xsl:for-each>
   </xsl:template>
   <xsl:template name="tokenizerMain">
      <xsl:for-each select="child::node()">
            <xsl:if
            test="not(name() = '')
            and not(contains(name(), 'identifier'))
            and not(contains(name(), 'contentdmID'))
            and not(contains(name(), 'title'))
            and not(contains(name(), 'title-alternative'))
            and not(contains(name(), 'subTitle'))
               and not(contains(name(), 'name'))
               and not(contains(name(), 'typeOfResource'))
               and not(contains(name(), 'genre'))
               and not(contains(name(), 'originInfoPublisher'))
               and not(contains(name(), 'originInfoPlace'))
               and not(contains(name(), 'dateIssued'))
               and not(contains(name(), 'dateOther'))
               and not(contains(name(), 'dateCopyrighted'))
               and not(contains(name(), 'issuance'))
               and not(contains(name(), 'frequency'))
               and not(contains(name(), 'edition'))
               and not(contains(name(), 'language'))
               and not(contains(name(), 'form'))
               and not(contains(name(), 'extent'))
               and not(contains(name(), 'physicalDescriptionNote'))
               and not(contains(name(), 'abstract'))
               and not(contains(name(), 'tableOfContents'))
               and not(contains(name(), 'subjectName'))
               and not(contains(name(), 'subjectTopic'))
               and not(contains(name(), 'subjectTemporal'))
               and not(contains(name(), 'subjectGeographic'))
               and not(contains(name(), 'coordinates'))
               and not(contains(name(), 'note'))
               and not(contains(name(), 'physicalLocation'))
               and not(contains(name(), 'shelfLocator'))
               and not(contains(name(), 'relatedItem'))
               and not(contains(name(), 'ext-age_conviction_start_employment'))
               and not(contains(name(), 'ext-birthdate'))
               and not(contains(name(), 'ext-category'))
               and not(contains(name(), 'ext-ethnicity_census'))
               and not(contains(name(), 'ext-ethnicity_other'))
               and not(contains(name(), 'ext-facility_type'))
               and not(contains(name(), 'ext-gender_identity'))
               and not(contains(name(), 'ext-gender_identity_other'))
               and not(contains(name(), 'ext-has_children'))
               and not(contains(name(), 'ext-incarceration_num'))
               and not(contains(name(), 'ext-management_type'))
               and not(contains(name(), 'ext-poetic_form'))
               and not(contains(name(), 'ext-prison_location'))
               and not(contains(name(), 'ext-prison_name'))
               and not(contains(name(), 'ext-prison_security'))
               and not(contains(name(), 'ext-prison_work'))
               and not(contains(name(), 'ext-pq_identifier'))
               and not(contains(name(), 'ext-relationship_to_prison'))
               and not(contains(name(), 'ext-relationship_to_prison_other'))
               and not(contains(name(), 'ext-relatives_incarcerated'))
               and not(contains(name(), 'ext-relatives_prison_employment'))
               and not(contains(name(), 'ext-religion'))
               and not(contains(name(), 'ext-religion_other'))
               and not(contains(name(), 'ext-sexual_orientation'))
               and not(contains(name(), 'ext-sexual_orientation_other'))
               and not(contains(name(), 'ext-veteran'))
               and not(contains(name(), 'Heading'))
               "
            >**** Oops: the field "<xsl:value-of select="name()"/>" is not valid. Please change it in the spreadsheet. *** <xsl:message terminate="yes">Processing terminated.</xsl:message>
         </xsl:if>
         <!-- deprecated "ext-transcriptions" and removed from the APWA online, 2017-11, pjm --> 
         <!-- deprecated "ext-num_chilren, but left in records online where already used, 2017-11, pjm -->
         <!-- renamed "ext-ethnicity" is now "ext-ethnicity_census" 2017-11, pjm --> 
         <!-- renamded "ext-prison_status" is now "ext-relationship_to_prison" 2017-11, pjm --> 
         <!-- renamed "ext-age_conviction" is now "ext-age_conviction_start_employment" 2017-11, pjm --> 
         
         <!-- Add field names below in which a semicolon indicates separate values.  -->

         <xsl:if test="text() != ''">
            <xsl:choose>
               <!--
                   <xsl:when test="contains(name(), 'ext-ethnicity')">
                      <xsl:call-template name="tokenizer"/>another
                   </xsl:when>
                   
                   <xsl:when test="contains(name(), 'ext-ethnicity_census')">
                      <xsl:call-template name="tokenizer"/>another
                   </xsl:when>
                   
                   <xsl:when test="contains(name(), 'ext-prison_work')">
                      <xsl:call-template name="tokenizer"/>another
                   </xsl:when>
-->
               <!--
               <xsl:when test="contains(name(), 'name_')">
                  <xsl:variable name="string2" select="translate(name(), '_', '|')"/>
                  <xsl:call-template name="tokenizer">
                     <xsl:with-param name="string" select="substring-after($string2,'|')"/>
                  </xsl:call-template>
               </xsl:when>
-->
               <!-- START of non-repeatable, with user-supplied attributes elements -->

               <xsl:when test="contains(name(), 'title')">
                  <xsl:call-template name="convertAttributes"/>
               </xsl:when>
               
               <xsl:when test="contains(name(), 'note_t')">
                  <xsl:call-template name="convertAttributes"/>
               </xsl:when>

               <xsl:when test="contains(name(), 'frequency')">
                  <xsl:call-template name="convertAttributes"/>
               </xsl:when>
               
               <xsl:when test="contains(name(), 'dateIssued')">
                  <xsl:call-template name="convertAttributes"/>
               </xsl:when>
               
               <!-- END of non-repeatable, with user-supplied attributes -->

               <!-- START of non-repeatable, no user-user attributes -->
               <!--
               <xsl:when test="contains(name(), 'title')">
                  <xsl:element name="{name()}">
                     <xsl:value-of select="text()"/>
                  </xsl:element>
               </xsl:when>
-->
               <xsl:when test="contains(name(), 'subTitle')">
                  <xsl:element name="{name()}">
                     <xsl:value-of select="text()"/>
                  </xsl:element>
               </xsl:when>

               <xsl:when test="contains(name(), 'originInfoPublisher')">
                  <xsl:element name="{name()}">
                     <xsl:value-of select="text()"/>
                  </xsl:element>
               </xsl:when>

               <xsl:when test="contains(name(), 'originInfoPlace')">
                  <xsl:element name="{name()}">
                     <xsl:value-of select="text()"/>
                  </xsl:element>
               </xsl:when>

               <xsl:when test="contains(name(), 'dateIssued')">
                  <xsl:element name="{name()}">
                     <xsl:value-of select="text()"/>
                  </xsl:element>
               </xsl:when>

               <xsl:when test="contains(name(), 'dateCopyrighted')">
                  <xsl:element name="{name()}">
                     <xsl:value-of select="text()"/>
                  </xsl:element>
               </xsl:when>

               <xsl:when test="contains(name(), 'issuance')">
                  <xsl:element name="{name()}">
                     <xsl:value-of select="text()"/>
                  </xsl:element>
               </xsl:when>

               <xsl:when test="contains(name(), 'edition')">
                  <xsl:element name="{name()}">
                     <xsl:value-of select="text()"/>
                  </xsl:element>
               </xsl:when>

               <xsl:when test="contains(name(), 'extent')">
                  <xsl:element name="{name()}">
                     <xsl:value-of select="text()"/>
                  </xsl:element>
               </xsl:when>

               <xsl:when test="contains(name(), 'physicalDescriptionNote')">
                  <xsl:element name="{name()}">
                     <xsl:value-of select="text()"/>
                  </xsl:element>
               </xsl:when>

               <xsl:when test="contains(name(), 'abstract')">
                  <xsl:element name="{name()}">
                     <xsl:value-of select="text()"/>
                  </xsl:element>
               </xsl:when>

               <xsl:when test="contains(name(), 'tableOfContents')">
                  <xsl:element name="{name()}">
                     <xsl:value-of select="text()"/>
                  </xsl:element>
               </xsl:when>

               <xsl:when test="contains(name(), 'physicalLocation')">
                  <xsl:element name="{name()}">
                     <xsl:value-of select="text()"/>
                  </xsl:element>
               </xsl:when>

               <xsl:when test="contains(name(), 'shelfLocator')">
                  <xsl:element name="{name()}">
                     <xsl:value-of select="text()"/>
                  </xsl:element>
               </xsl:when>

               <!-- END of non-repeatable, no user-user attributes -->

               <!-- START of repeatable elements, no user-supplied attributes allowed -->
               <!-- Send to tokenizer only if there is a semicolon in the value. -->

               <xsl:when test="identifier">
                  <xsl:choose>
                     <xsl:when test="contains(text(), ';')">
                        <xsl:call-template name="tokenizer-no-attributes"/>
                     </xsl:when>
                     <xsl:otherwise>
                        <xsl:element name="{name()}">
                           <xsl:value-of select="text()"/>
                        </xsl:element>
                     </xsl:otherwise>
                  </xsl:choose>
               </xsl:when>

<!-- original
               <xsl:when test="contains(name(), 'name') and not(contains(name(), '_'))">
                  <xsl:choose>
                     <xsl:when test="contains(text(), ';')">
                        <xsl:call-template name="tokenizer-no-attributes"/>
                     </xsl:when>
                     <xsl:otherwise>
                        <xsl:element name="{name()}">
                           <xsl:value-of select="text()"/>
                        </xsl:element>
                     </xsl:otherwise>
                  </xsl:choose>
               </xsl:when>$$
-->
               <xsl:when test="contains(name(), 'name') and not(contains(name(), '_'))">
                  <xsl:call-template name="tokenizer"/>
               </xsl:when>
               
               <xsl:when test="contains(name(), 'typeOfResource')">
                  <xsl:choose>
                     <xsl:when test="contains(text(), ';')">
                        <xsl:call-template name="tokenizer-no-attributes"/>
                     </xsl:when>
                     <xsl:otherwise>
                        <xsl:element name="{name()}">
                           <xsl:value-of select="text()"/>
                        </xsl:element>
                     </xsl:otherwise>
                  </xsl:choose>
               </xsl:when>

               <xsl:when test="contains(name(), 'language')">
                  <xsl:choose>
                     <xsl:when test="contains(text(), ';')">
                        <xsl:call-template name="tokenizer-no-attributes"/>
                     </xsl:when>
                     <xsl:otherwise>
                        <xsl:element name="{name()}">
                           <xsl:value-of select="text()"/>
                        </xsl:element>
                     </xsl:otherwise>
                  </xsl:choose>
               </xsl:when>

               <xsl:when test="contains(name(), 'coordinates')">
                  <xsl:choose>
                     <xsl:when test="contains(text(), ';')">
                        <xsl:call-template name="tokenizer-no-attributes"/>
                     </xsl:when>
                     <xsl:otherwise>
                        <xsl:element name="{name()}">
                           <xsl:value-of select="text()"/>
                        </xsl:element>
                     </xsl:otherwise>
                  </xsl:choose>
               </xsl:when>
               
               <xsl:when test="contains(name(), 'contentdmID')">
                  <xsl:choose>
                     <xsl:when test="contains(text(), ';')">
                        <xsl:call-template name="tokenizer-no-attributes"/>
                     </xsl:when>
                     <xsl:otherwise>
                        <xsl:element name="{name()}">
                           <xsl:value-of select="text()"/>
                        </xsl:element>
                     </xsl:otherwise>
                  </xsl:choose>
               </xsl:when>
               
               <!-- END of repeatable elements, no user-supplied attributes allowed -->

               <!-- START repeatable elements, with user-supplied attributes -->

               <xsl:when test="substring-before(name(), '_') = 'name'">
                  <xsl:call-template name="tokenizer"/>
               </xsl:when>
               <!--
               <xsl:when test="contains(name(), 'subgenre')">
                  <xsl:call-template name="tokenizer"/>
               </xsl:when>

               <xsl:when test="contains(name(), 'genre') and not(contains(name(), 'subgenre'))">
                  <xsl:call-template name="tokenizer"/>
               </xsl:when>
-->
               <xsl:when test="contains(name(), 'genre')">
                  <xsl:call-template name="tokenizer"/>
               </xsl:when>

               <!-- retired when type attribute allowed
               <xsl:when test="contains(name(), 'dateOther')">
                  <xsl:choose>
                     <xsl:when test="contains(text(), ';')">
                        <xsl:call-template name="tokenizer-no-attributes"/>
                     </xsl:when>
                     <xsl:otherwise>
                        <xsl:element name="{name()}">
                           <xsl:value-of select="text()"/>
                        </xsl:element>
                     </xsl:otherwise>
                  </xsl:choose>
               </xsl:when>
-->

               <xsl:when test="contains(name(), 'dateOther')">
                  <xsl:call-template name="tokenizer"/>
               </xsl:when>

               <xsl:when test="contains(name(), 'form')">
                  <xsl:call-template name="tokenizer"/>
               </xsl:when>
               <!-- 
               <xsl:when test="contains(name(), 'language')">
                  <xsl:choose>
                     <xsl:when test="contains(text(), ';')">
                        <xsl:call-template name="tokenizer-no-attributes"/>
                     </xsl:when>
                     <xsl:otherwise>
                        <xsl:element name="{name()}">
                           <xsl:value-of select="text()"/>
                        </xsl:element>
                     </xsl:otherwise>
                  </xsl:choose>
               </xsl:when>
 -->

               <xsl:when test="contains(name(), 'subjectName')">
                  <xsl:call-template name="tokenizer"/>
               </xsl:when>

               <xsl:when test="contains(name(), 'subjectTopic')">
                  <xsl:call-template name="tokenizer"/>
               </xsl:when>

               <xsl:when test="contains(name(), 'subjectTemporal')">
                  <xsl:call-template name="tokenizer"/>
               </xsl:when>

               <xsl:when test="contains(name(), 'subjectGeographic')">
                  <xsl:call-template name="tokenizer"/>
               </xsl:when>

               <xsl:when test="contains(name(), 'relatedItem')">
                  <xsl:call-template name="tokenizer"/>
               </xsl:when>

               <!-- END repeatable elements, with user-supplied attributes -->

               <!-- START of not categorized yet -->

               <!-- not implemented
               <xsl:when test="contains(name(), 'subjectHierarchicalGeographicTgn_')">
                  <xsl:call-template name="tokenizer"/>
               </xsl:when>
-->
               <xsl:when test="contains(name(), 'ext-')">
                  <extension>
                     <xsl:call-template name="tokenizer-no-attributes"/>
                  </extension>
               </xsl:when>

               <!-- END of not categorized yet -->

               <xsl:otherwise>
                  <xsl:element name="{normalize-space(name())}">
                     <xsl:value-of select="."/>
                  </xsl:element>
               </xsl:otherwise>
            </xsl:choose>
         </xsl:if>
      </xsl:for-each>
   </xsl:template>

   <!-- Format the Element name without the default attributes  -->
   <xsl:template name="convertAttributes">
      <xsl:param name="string" select="concat(text(), ';')"/>
      <xsl:variable name="stringx" select="translate(name(), '_r-', '|r=')"/>
      <xsl:variable name="stringy" select="translate($stringx, '_t-', '|t=')"/>
      <xsl:variable name="stringz" select="translate($stringy, '_a-', '|a=')"/>
      <xsl:choose>
         <xsl:when test="contains(name(), '_')">
            <xsl:element name="{normalize-space(substring-before(name(),'_'))}">
               <xsl:value-of select="normalize-space(substring-before($string, ';'))"/>
               <!-- SUPPRESSED 2018-01 was leaving ; in title-alterntive fields; 
                  restore it in metadata, as needed, if splitting values isn't working
                  xsl:value-of select="normalize-space($string)"/ -->
               <xsl:text>|</xsl:text>
               <xsl:value-of select="normalize-space(substring-after($stringz, '|'))"/>
            </xsl:element>
         </xsl:when>
         <xsl:otherwise>
            <xsl:element name="{name()}">
               <xsl:value-of select="normalize-space(substring-before($string, ';'))"/>
               <!-- SOMETIMES NEED ONLY THIS:  <xsl:value-of select="normalize-space($string)"/> -->
            </xsl:element>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>

   <xsl:template name="tokenizer">
      <!-- add a semicolon at the end of the text content -->
      <xsl:param name="string" select="concat(text(), ';')"/>
      <xsl:variable name="stringw" select="translate(name(), '_l-', '|l=')"/>
      <xsl:variable name="stringx" select="translate($stringw, '_r-', '|r=')"/>
      <xsl:variable name="stringy" select="translate($stringx, '_t-', '|t=')"/>
      <xsl:variable name="stringz" select="translate($stringy, '_a-', '|a=')"/>
      <!-- code replaced 2017-01-17
         <xsl:element name="{normalize-space(substring-before(name(),'_'))}">
         <xsl:value-of select="normalize-space(substring-before($string, ';'))"/>
         <xsl:text>|</xsl:text>
         <xsl:value-of select="normalize-space(substring-after($stringz, '|'))"/>
      </xsl:element>
      -->

      <xsl:choose>

         <xsl:when test="contains(name(), '_')">

            <xsl:element name="{normalize-space(substring-before(name(),'_'))}">
               <xsl:variable name="stringx" select="concat($string, ';')"/>
               <xsl:choose>
                  <!-- When attributes are declared in the cell value, prevent adding attributes to the cell from the Header -->
                  <!-- Look for a pipe in the cell value $$ -->
                  <xsl:when test="not(contains(substring-before($stringx, ';'), '|'))">
                     <xsl:value-of select="substring-before($stringx, ';')"/>
                     <xsl:text>|</xsl:text>
                     <xsl:value-of select="normalize-space(substring-after($stringz, '|'))"/>
                  </xsl:when>
                  <xsl:otherwise>
                     <!-- Convert Excel attribute cell attributes from dashes to equal signs -->
                     <xsl:variable name="string1" select="substring-before($stringx, ';')"/>
                     <xsl:variable name="string2" select="replace($string1, '\|a-', '|a=')"/>
                     <xsl:variable name="string3" select="replace($string2, '\|t-', '|t=')"/>
                     <xsl:variable name="string4" select="replace($string3, '\|r-', '|r=')"/>
                     <xsl:value-of select="$string4"/>
                  </xsl:otherwise>
               </xsl:choose>
            </xsl:element>

         </xsl:when>
         <xsl:otherwise>
            <xsl:element name="{name()}">
               <xsl:value-of select="normalize-space(substring-before($string, ';'))"/>
            </xsl:element>
         </xsl:otherwise>
      </xsl:choose>

      <xsl:variable name="string-remainder" select="normalize-space(substring-after($string, ';'))"/>
      <xsl:if test="string-length($string-remainder) > 2">
         <xsl:call-template name="tokenizer">
            <xsl:with-param name="string" select="$string-remainder"/>
         </xsl:call-template>
      </xsl:if>
   </xsl:template>

   <xsl:template name="tokenizer-no-attributes">
      <!-- add a semicolon at the end of the text content -->
      <xsl:param name="string" select="concat(text(), ';')"/>
      <xsl:element name="{name()}">
         <xsl:value-of select="normalize-space(substring-before($string, ';'))"/>
      </xsl:element>
      <xsl:variable name="string-remainder" select="normalize-space(substring-after($string, ';'))"/>
      <xsl:if test="string-length($string-remainder) > 2">
         <xsl:call-template name="tokenizer-no-attributes">
            <xsl:with-param name="string" select="$string-remainder"/>
         </xsl:call-template>
      </xsl:if>


   </xsl:template>
</xsl:stylesheet>
