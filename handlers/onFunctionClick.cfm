<!---<cfdump var="#URL#" label="URL">--->

<cfset data = URL />

<cfset meta = getcomponentMetadata(data.cfcmap) />
<cfdump var="#meta#" label="meta" expand="false">
<cfoutput>
	
	<cfscript>

		functionArgs = arrayFilter(meta.functions, function(n) {
			return n.name == data.name;
		});
		//writeDump(functionArgs[1]);
	</cfscript>
	
	<blockquote>
	  <p>#data.access# #data.returnType# #data.name#()</p>
	  <footer>
	  	<cfloop array="#functionArgs[1].Parameters#" index="arg">
	  		<cfif arg.required >
	  		(required #arg.type# #arg.name#) 
	  		<cfelse>
	  		(#arg.type# #arg.name#) 
	  		</cfif>
	  	</cfloop>
	  </footer>
	</blockquote>
	
</cfoutput>