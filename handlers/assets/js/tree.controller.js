function TreeManagement( ){
	treeManagement = this;
	
	this.cfcTree = $('#cfcTree');
	this.input_cfcmap = $('#input_cfcmap');

	
	//container
	this.cfc_pageContent = $('#cfc_pageContent');
	
	//tree settings
	this.setting = {
		view: {
			dblClickExpand: false,
			selectedMulti: false
		},
		check: {
			enable: false
		},
		edit: {
			enable: false,
			showRemoveBtn: false,
			showRenameBtn: false
		},
		async: {
			enable: true,
			url: this.getUrl,
			autoParam:["id","pId", "name=n", "level=lv"],
			otherParam:{"otherParam":"zTreeAsyncTest"}//,
			//dataFilter: filter
		},
		/*data: {
			simpleData: {
				enable:true,
				idKey: "id",
				pIdKey: "pId",
				rootPId: ""
			}
		},*/
		callback: {
			//beforeClick: beforeClick,
			onClick: onClick,
			/*onDblClick: onDblClick,
			onRightClick: OnRightClick
			beforeCheck: beforeCheck,
			onCheck: onCheck,
			beforeDrag: beforeDrag,
			beforeDrop: beforeDrop*/
		}
	};
	
	this.zNodes = [];

	//init the tree	
	//setTimeout(this.initTree, 1500);
	
//	alert(this.zTreeObj);
	$.fn.zTree.init(treeManagement.cfcTree, treeManagement.setting, this.zNodes );
	treeManagement.zTreeObj = $.fn.zTree.getZTreeObj("cfcTree");
	this.setListeners();	
}


TreeManagement.prototype.setListeners = function (){

}
// tree callback functions

TreeManagement.prototype.getUrl = function( treeId, treeNode ) {
	var param = '';
	
	if( treeNode=='undefined' || treeNode == null || treeNode=='' )
		return "http://localhost/VisualCFCTest/handlers/TreeConstructor.cfc?method=loadTree&cfcmap=" + treeManagement.input_cfcmap.val();
	
}

/* get data for tree parent & children */


/* On tree item click */
function onDblClick(event, treeId, treeNode, clickFlag) {
	//console.log(treeId);
	//console.log(treeNode);
	//console.log(main.config.urls.documentViewer.renderFile);
	
	if( !treeNode.isParent ){
		$.ajax({
		  url: main.config.urls.documentViewer.renderFile,
		  cache: false,
		  data: treeNode,
		  beforeSend: function( xhr ) {
		    treeManagement.documentViewer_pageContent.html( "<h4>Loading... Please wait.</h4>" );
		  }
		}).done(function( html ) {
		  	 treeManagement.documentViewer_pageContent.html( html );
	  	}).error(function (messsage,obj){
	  		console.log(message);
	  		console.log(obj);
	  	});
  	}
}

function onClick(event, treeId, treeNode, clickFlag) {
	console.log(treeId);
	console.log(treeNode);
	var nodes = {access:treeNode.access,
				 returnType:treeNode.returntype,
				 argumentsCount:treeNode.argumentsCount,
				 id:treeNode.id,
				 name:treeNode.name,
				 cfcmap:treeNode.cfcmap	}
	$.ajax({
		  url: "http://localhost/VisualCFCTest/handlers/onFunctionClick.cfm",
		  cache: false,
		  data: nodes,
		  beforeSend: function( xhr ) {
		    treeManagement.cfc_pageContent.html( "<h4>Loading... Please wait.</h4>" );
		  }
		}).done(function( html ) {
		  	 treeManagement.cfc_pageContent.html( html );
	  	}).error(function (messsage,obj){
	  		console.log(message);
	  		console.log(obj);
	  	});
	
}

/* right click */
function OnRightClick(event, treeId, treeNode) {
 	if (treeNode && !treeNode.noR) {
		treeManagement.zTreeObj.selectNode(treeNode);
		treeManagement.showRMenu("node", event.clientX, event.clientY);
		treeManagement.positionMenu(event);
	}
}
