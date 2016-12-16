<cfset myApp = createObject('java','coldfusion.runtime.ApplicationScopeTracker').init() />

<cffunction name="listActiveApps" returntype="any" >

	<cfset var appTracker = createObject("java","coldfusion.runtime.ApplicationScopeTracker")/>
    <cfset var apps = appTracker.getApplicationKeys() />
    <cfset var appsList = ""/>
    <cfloop condition="#apps.hasMoreElements()#">
        <cfset var appName = apps.nextElement().toString()/>
        <cfset var appsList = listAppend(appsList, appName)/>

    </cfloop>
    <cfset appsList = listSort(appsList, 'textNoCase', 'asc')/>
	<cfreturn appsList />
</cffunction>
<cfset myapps = listActiveApps() />
<cfset CAPosition = listFindNoCase(myapps,"VisualCFCTest")/>
	<cfif CAPosition gt 0 >
		<cfset caappname = listGetAt(myapps,CAPosition)/>
		
		<cfdump var="#myApp.getApplicationScope( trim(caappname) )#">
	</cfif>
<cfdump var="#myapps#">

<cfform>
<cfinput name="resetApps" type="submit" value="reset VisualCFCUnitTest Application scope">
</cfform>
<cfif isdefined("form.resetApps") >
	
	<cfset CAPosition = listFindNoCase(myapps,"VisualCFCUnitTest")/>
	<cfif CAPosition gt 0 >
		<cfset appname = listGetAt(myapps,CAPosition)/>
		<!---<cfset structclear(application["VisualCFCUnitTest"])/>--->
		
		<cfset myApp.getApplicationScope( "VisualCFCUnitTest" ).cleanUp() />
		<!---<cfset appscope = myApp.getApplicationScope( trim(appname) ) />--->
		<cfset myApp.stopApplication( trim( appname ) ) />
<!---<cfdump var="#appscope#"/>
<cfdump var="#myApp.stopApplication('HomeownersRating')#"/>
<cfdump var="#application["HomeownersRating"]#" expand="false" >--->
		<br><br>
		<cfset myapps = listActiveApps() />
	</cfif>
<cfdump var="#myapps#">
</cfif>
<!---<cfset po = listFindNoCase(appsList,"HomeownersRating") >
<cfset appname = listGetAt(appsList,po ) />
<cfdump var="#appname#">--->
<!---<cfset myApp = createObject('java','coldfusion.runtime.ApplicationScopeTracker').init() />
    <cfset myApp.getApplicationScope( "HomeownersRating" ).cleanup() />
<cfdump var="#application#">--->