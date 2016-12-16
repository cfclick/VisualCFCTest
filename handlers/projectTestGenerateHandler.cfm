<!--- 
  ***************************************************************************
  LAST MODIFIED ON: $Modtime: 04/02/11 8:05p $ BY USER: $Author: Shirak $
  LAST CHECKIN ON: $Date: 6/30/11 2:18p $
  AUTHOR: Shirak 
  E-MAIL: ShirakAvakian@gmail.com
  COMPANY: CFFlex Technology, INC. 
  ***************************************************************************
--->
<cfsetting showdebugoutput="no" enablecfoutputonly="true" >

<cfparam name="ideeventinfo">

<cflock scope="Application" timeout="10">
	<cfset application.appId = (isdefined("application.appId") ? application.appId : 0) + 1>
</cflock>

<cfset application[#application.appId#] = ideeventinfo>
<cfset nextUrl = new Framework.Util().generateURL("layoutpage.cfm")>
<cfset nextUrl &= "?genId=" & #application.appId#>

<cfheader name="Content-Type" value="text/xml">
<cfoutput>
	<response showresponse="true">
		<ide url="#nextUrl#">
			<dialog title="Visual ColdFusion Component Test" image="handlers/assets/vcfc-logo.png" width="1200" height="100%"/>
		</ide>
	</response>
</cfoutput>