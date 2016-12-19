<cfcomponent displayname="Application" output="false" hint="Handle the application.">

	<!--- Set up the application. --->
	<cfset THIS.Name = "VisualCFCTest" />
	<cfset THIS.ApplicationTimeout = createTimeSpan( 0, 0, 30, 0 ) />
	<cfset THIS.SessionManagement = true />
	<cfset THIS.SetClientCookies = true />

	<!--- Define the page request properties. --->
	<cfsetting	requesttimeout="30"	showdebugoutput="true" enablecfoutputonly="false"/>

	<cffunction	name="OnApplicationStart" access="public" returntype="boolean" output="false" hint="Fires when the application is first created.">
		<!--- Return out. --->
		<cfreturn true />
	</cffunction>

	<cffunction name="OnSessionStart" access="public" returntype="void"	output="false" hint="Fires when the session is first created.">
		<!--- Return out. --->
		<cfreturn />
	</cffunction>

	<cffunction name="OnRequestStart" access="public" returntype="boolean" output="false" hint="Fires at first part of page processing.">
		<cfargument name="TargetPage" type="string" required="true" />
		
		<!--- Return out. --->
		<cfscript>
			var headers = getHttpRequestData().headers;
			var origin = '';
			var PC = getpagecontext().getresponse();
			
			// Find the Origin of the request
			if( structKeyExists( headers, 'Origin' ) ) {
				origin = headers['Origin']; 
			}
			
			// If the Origin is okay, then echo it back, otherwise leave out the header key
			if( listFindNoCase( 'http://localhost,http://localhost:8500', origin ) ) {
				PC.setHeader( 'Access-Control-Allow-Origin', origin );
			}
			// Only allow GET requests
			PC.setHeader( 'Access-Control-Allow-Methods', 'GET' );

			return true;
	   	        
        </cfscript>

	
	</cffunction>


	<cffunction name="OnRequest" access="public" returntype="void" output="true">
		<cfargument name="TargetPage" type="string" required="true"/>
		<!--- Include the requested page. --->
		<cftry>
			<cfinclude template="#ARGUMENTS.TargetPage#" />
			<cfcatch type="any">
				<cflog file="VCFCTest" type="error" text="#CFCATCH.message#" />
				<cflog file="VCFCTest" type="error" text="#CFCATCH.detail#" />
			</cfcatch>
		</cftry>
		<!--- Return out. --->
		<cfreturn />
	</cffunction>


	<cffunction name="OnRequestEnd" access="public" returntype="void" output="true">
		<!--- Return out. --->
		<cfreturn />
	</cffunction>


	<cffunction name="OnSessionEnd" access="public" returntype="void" output="false">
		<cfargument name="SessionScope" type="struct" required="true"/>
		<cfargument name="ApplicationScope" type="struct" required="false" default="#StructNew()#"/>
		<!--- Return out. --->
		<cfreturn />
	</cffunction>


	<cffunction name="OnApplicationEnd" access="public" returntype="void" output="false">
		<cfargument name="ApplicationScope" type="struct" required="false" default="#StructNew()#"/>
		<!--- Return out. --->
		<cfreturn />
	</cffunction>


	<cffunction name="OnError" access="public" returntype="void" output="true">
		<cfargument name="Exception" type="any" required="true"/>
		<cfargument name="EventName" type="string" required="false" default=""/>

		<cflog file="VCFCTest" type="error" text="#ARGUMENTS.Exception#" />
		<!--- Return out. --->
		<cfreturn />
	</cffunction>

</cfcomponent>