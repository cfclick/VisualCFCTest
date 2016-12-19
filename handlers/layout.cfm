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
<link rel="stylesheet" href="assets/css/bootstrap.min.css" />
<link rel="stylesheet" href="assets/css/zTreeStyle/zTreeStyle.css" />


<script src="assets/js/jquery.js"></script>
<script src="assets/js/bootstrap.min.js"></script>
<script src="assets/js/zTree/jquery.ztree.core-3.5.js"></script>
<script src="assets/js/tree.controller.js"></script>

<cfinclude template="createStructure.cfm" >

<cfinclude template="initCFC.cfm" >

<cfoutput>
	<input id="input_cfcmap" value="#res.cfcmap#" type="hidden"  />
	<div class="container-fluid">

		<div class="row">
			<div class="col-sm-11">
				<div class="col-sm-4">
					<dl>
					  <dt>Project Name</dt>
					  <dd>#project.name#</dd>
					
					  <dt>File Name</dt>
					  <dd>#res.file#</dd>
					</dl>
					    		
			       	<div class="zTreeDemoBackground left">   		
			       		<!---<div id="loading" class="ico_loading"><span style="position: relative;left: 40px;top: 50px" >loading.. </span></div>--->
						<ul id="cfcTree" class="ztree"></ul>
					</div>
					
					<div id="help">
							<img src="assets/func-icon-private.png"/> Private<br>
							<img src="assets/func-icon-package.png"/> Package<br>
							<img src="assets/func-icon-public.png"/> Public<br>
							<img src="assets/func-icon-remote.png"/> Remote<br>
							<img src="assets/func-icon-undefined.png"/> Undefined<br>
						</div>
				</div>
				
				<div class="col-sm-7">
					<div id="cfc_pageContent"><cfdump var="#ide#"></div>
				</div>
			</div>
		</div>
	</div>
	
</cfoutput>
<script>
	
	$(document).ready( function(){
		var treeManagement = new TreeManagement();
	});
</script>