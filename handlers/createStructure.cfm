	<cfset util = createobject("framework.Util")/>

	<cfset proxy = "" />
	<cfset meta = "" />
	<cfset wsProxy = "" />
	<cfset hasRemoteMethod = false />
	<cfset system = createObject("java", "java.lang.System")>
	<cfset fileSeparator = system.getProperty("file.separator")>

	<cfset xmldoc = xmlParse(application[application.appId])>
	<cfset projectview = xmlSearch(xmldoc, "//projectview")>
	<cfset serverdetail = xmlSearch(xmldoc, "//server")>
	<cfset resourcedetail = xmlSearch(xmldoc, "//resource")>

	<!--- project details --->
	<cfset project = structNew()>
	<cfset project.name = projectview[1].xmlAttributes["projectname"]>
	<cfset project.location = projectview[1].xmlAttributes["projectlocation"]>

	<cfset ser = structNew()>
	
	<cfset ser.wwwroot = server.coldfusion.rootDir & "/wwwroot/">
	<cfset ser.hostname = cgi.server_NAME />
	<cfset ser.port = cgi.serVER_PORT />

	<!--- resource details --->
	<cfset res = structNew()>
	<cfset res.path = resourcedetail[1].xmlAttributes["path"]>
	<cfset res.type = resourcedetail[1].xmlAttributes["type"]>
	
	<cfif not find(res.path, fileSeparator )>
		<cfset fileSeparator = '/' />
	</cfif>
	
	<cfset res.file = listlast(res.path, fileSeparator)/>
	<cfset project.projectFolder = listlast(project.location,fileSeparator) />

	<cfset c = len(res.path)/>

	<cfset f = findnocase(project.projectFolder, res.path)/>
	<cfset r = c - f/>
	<cfset re = right(res.path, r + 1)/>

	<cfset res.cfc = replace(re, fileSeparator, ".", "all")/>
	
	<cfset res.cfcmap = left(res.cfc,len(res.cfc)-4)/>