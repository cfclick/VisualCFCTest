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
	<input id="input_cfcmap" value="#res.cfcmap#" />
	<div class="container">
		<!---<cfdump var="#loadTree()#">--->
		<div class="row">
			<div class="col-lg-3">
				Project Name: #project.name#<br>
				File Name:#res.file#<br>		    		
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
			
			<div class="col-lg-9">
				<div id="cfc_pageContent"><cfdump var="#ide#"></div>
			</div>
		</div>
		
	</div>
	
</cfoutput>
<script>
	
	$(document).ready( function(){
		var treeManagement = new TreeManagement();
	});
</script>