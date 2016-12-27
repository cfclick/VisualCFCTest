<!---<cfdump var="#URL#" label="URL">--->

<cfset data = URL />

<cfset meta = getcomponentMetadata(data.cfcmap) />
<!---<cfdump var="#meta#" label="meta" expand="false">--->
<cfoutput>
	
	<cfscript>

		functionArgs = arrayFilter(meta.functions, function(n) {
			return n.name == data.name;
		});
		//writeDump(functionArgs[1]);
	</cfscript>
<div class="fluid-container">	
	<blockquote>
	  <p>#data.access# #data.returnType# #data.name#()</p>
	  <footer>
	  	
	  </footer>
	</blockquote>
	<form class="form-horizontal">
	<cfloop array="#functionArgs[1].Parameters#" index="arg">
		<div class="form-group">
			<cfif arg.required >
				<cfset required=true/>
				<cfset requiredText="*"/>
			<cfelse>
				<cfset required=false/>
				<cfset requiredText=""/>
			</cfif>
			<label for="#arg.name#" class="col-sm-3 control-label">(#requiredText# #arg.type# #arg.name#) </label>
  				<div class="col-sm-5">
				<input type="text" name="#arg.name#" class="form-control" required="required" placeholder="#UCASE(arg.name)#" /><br>
			</div>	  		
  		</div>
	 </cfloop>
	 <div class="form-group">
     	<div class="col-sm-offset-2 col-sm-10">
      	<button type="button" id="submit_btn" name="submit_btn" class="btn btn-default">Invoke</button>
     </div>
     <div class="row">
     	<div class="col-sm-12">
     		<div id="result_content">
     		Results
     		</div>
     	</div>
     </div>
  </div>
	 </form>
</div>
</cfoutput>
<script src="assets/js/function.controller.js" ></script>
<script>
	$(document).ready(function(){
		var funcCtrl = new FunctionController();
	})
	
	
</script>