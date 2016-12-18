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
			enable: true,
			showRemoveBtn: false,
			showRenameBtn: false
		},
		async: {
			enable: true,
			url: this.getUrl,
			autoParam:["id", "name=n", "level=lv"],
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
	
	this.zNodes =[
			{ name:"pNode 01", open:true,
				children: [
					{ name:"pNode 11",
						children: [
							{ name:"leaf node 111"},
							{ name:"leaf node 112"},
							{ name:"leaf node 113"},
							{ name:"leaf node 114"}
						]},
					{ name:"pNode 12",
						children: [
							{ name:"leaf node 121"},
							{ name:"leaf node 122"},
							{ name:"leaf node 123"},
							{ name:"leaf node 124"}
						]},
					{ name:"pNode 13 - no child", isParent:true}
				]},
			{ name:"pNode 02",
				children: [
					{ name:"pNode 21", open:true,
						children: [
							{ name:"leaf node 211"},
							{ name:"leaf node 212"},
							{ name:"leaf node 213"},
							{ name:"leaf node 214"}
						]},
					{ name:"pNode 22",
						children: [
							{ name:"leaf node 221"},
							{ name:"leaf node 222"},
							{ name:"leaf node 223"},
							{ name:"leaf node 224"}
						]},
					{ name:"pNode 23",
						children: [
							{ name:"leaf node 231"},
							{ name:"leaf node 232"},
							{ name:"leaf node 233"},
							{ name:"leaf node 234"}
						]}
				]},
			{ name:"pNode 3 - no child", isParent:true}

		];
//	alert(this.zNodes);
	//init the tree	
	//setTimeout(this.initTree, 1500);
	$.fn.zTree.init(this.cfcTree, this.setting );
	this.zTreeObj = $.fn.zTree.getZTreeObj("cfcTree");
//	alert(this.zTreeObj);
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
	//console.log(treeId);
	//console.log(treeNode);
	//console.log(main.config.urls.documentViewer.renderFile);
	
	/*if( !treeNode.isParent ){
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
  	}*/
}

/* right click */
function OnRightClick(event, treeId, treeNode) {
 	if (treeNode && !treeNode.noR) {
		treeManagement.zTreeObj.selectNode(treeNode);
		treeManagement.showRMenu("node", event.clientX, event.clientY);
		treeManagement.positionMenu(event);
	}
}
