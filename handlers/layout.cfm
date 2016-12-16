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

<div class="container">
	
	<div class="row">
		<div class="col-lg-3">		    		
	       	<div class="zTreeDemoBackground left">   		
	       		<!---<div id="loading" class="ico_loading"><span style="position: relative;left: 40px;top: 50px" >loading.. </span></div>--->
				<ul id="cfcTree" class="ztree"></ul>
			</div>
		</div>
		
		<div class="col-lg-9">
			<div id="cfc_pageContent">RIGHT</div>
		</div>
	</div>
	
</div>

<script>
	
	$(document).ready( function(){
		var treeManagement = new TreeManagement();
	});
</script>