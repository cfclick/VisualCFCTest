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

	<cfset proxy = createobject(res.cfcmap)/>
<!---<cfdump var="#proxy#">--->
	<cfset meta = getComponentMetaData(res.cfcmap)/>
<!---<cfdump var="#meta#">--->
	<cfif CompareNocase(res.file,"Application.cfc") eq 0>
		<cfoutput><H3>Sorry you can not test Application.cfc</H3></cfoutput>
		<cfabort>
	</cfif>

	<cfif not structkeyexists(meta,"Functions")>
		<cfoutput><H3>Sorry There are no methods in #res.path#</H3></cfoutput>
		<cfabort>
	<!---<cfelseif structkeyexists(meta,"Functions") and isArray(meta.Functions)>
		<cfif arraylen(meta.Functions)>
			<cfloop array="#meta.Functions#" index="item" >
				<cfif structkeyExists(item,"access") and compareNocase(item.access,"remote") eq 0 >
					<cfset hasRemoteMethod = true />
					<cfbreak>
				<cfelse>

				</cfif>
			</cfloop>
		</cfif>--->
	
	</cfif>
	
	

