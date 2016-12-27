function FunctionController(){
	functionController = this;
	this.submit_btn = $('#submit_btn');
	this.result_content = $('#result_content');
	
	this.setListeners();
}

FunctionController.prototype.setListeners = function(){
	
	functionController.submit_btn.on('click', function(){
		alert('clicked');
		$.ajax({
		  url: "http://localhost/VisualCFCTest/handlers/testResult.cfm",
		  cache: false,
		  data: {},
		  beforeSend: function( xhr ) {
		    functionController.result_content.html( "<h4>Loading... Please wait.</h4>" );
		  }
		}).done(function( html ) {
		  	 functionController.result_content.html( html );
	  	}).error(function (messsage,obj){
	  		console.log(message);
	  		console.log(obj);
	  	});
	})
	
}