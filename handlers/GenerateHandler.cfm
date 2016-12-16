<!---
********************************************************************************
Author      	:	Shirak Avakian
Email       	:	Shirak.Avakian@Qbillc.com
Company  	: 	QBI LLC
Date        	:	@{Date}
Component Name  : 	index.cfc
Description :
	A description about this page
********************************************************************************
--->
<cfsetting showdebugoutput="no" enablecfoutputonly="true" >

<cfparam name="ideeventinfo">

<cflock scope="Application" timeout="10">
	<cfset application.appId = (isdefined("application.appId") ? application.appId : 0) + 1>
</cflock>

<cfset application[application.appId] = ideeventinfo>
<cfset nextUrl = new Framework.Util().generateURL("layout.cfm")>
<cfset nextUrl &= "?genId=" & application.appId>

<cfheader name="Content-Type" value="text/xml">
<cfoutput>
	<response showresponse="true">
		<ide url="#nextUrl#">
			<dialog title="Visual ColdFusion Component Test" image="handlers/assets/vcfc-logo.png" width="1200" height="100%"/>
		</ide>
	</response>
</cfoutput>
