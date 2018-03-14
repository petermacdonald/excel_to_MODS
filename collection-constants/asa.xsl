<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
   xmlns:dc="http://purl.org/dc/elements/1.1/"
   xmlns:oai_dc="http://www.openarchives.org/OAI/2.0/oai_dc/"
   xmlns:xlink="http://www.w3.org/1999/xlink" xmlns="http://www.loc.gov/mods/v3"
   xmlns:dhi="http://www.dhinitiative.org/dhi/" xmlns:dhiapw="http://www.dhinitiative.org/dhiapw/"
   xsi:schemaLocation="http://www.bepress.com/OAI/2.0/qualified-dublin-core/ 
   http://www.bepress.com/assets/xsd/oai_qualified_dc.xsd"
   xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" exclude-result-prefixes="oai_dc dc dhi"
   version="2.0">

   <xsl:template name="collectionConstants">
      <note>This digital resource is provided by The Beloved Witness, a project sponsored by the Digital Humanities Initiative, Hamilton College, Clinton, New York, United States. </note>
      <relatedItem type="host">
         <titleInfo>
            <title>The Beloved Witness</title>
         </titleInfo>
         <name type="personal">
            <namePart>Patricia O'Neill</namePart>
            <description>Director of the Beloved Witness: The Agha Shahid Ali Archive</description>
            <affiliation>Leonard C. Ferguson Professor of Literature and Creative Writing Emerita</affiliation>
            <affiliation>Hamilton College, Clinton, New York, United States</affiliation>
            <role>
               <roleTerm type="text">Project director</roleTerm>
               <roleTerm authority="marcrelator" type="code">pdr</roleTerm>
            </role>
         </name>
         <location>
            <physicalLocation>Digital Humanities Initiative Repository</physicalLocation>
         </location>
      </relatedItem>
      <accessCondition type="restriction on access">There are no restrictions on access to this resource.</accessCondition>
      <accessCondition type="use and reproduction">This resource is made available for educational purposes.</accessCondition>
   </xsl:template>

</xsl:stylesheet>
