/*
********************************************************************************
Author      	:	Shirak Avakian
Email       	:	Shirak.Avakian@Qbillc.com
Company  	: 	QBI LLC
Date        	:	@{Date}
Component Name  : 	service.cfc
Description :
	A description about this page
********************************************************************************
*/
component  output="true"
{
	public string function getName(){
		return "Shirak";
	}
	
	public numeric function getAgeByNameAndGender( required string Name, required numeric age){
		return 40;
	}
	
	private string function getNameByID( required string id ){
		return id;
	}
	
	package string function getNameByEmail( required string email ){
		return getName();
	}
	
	remote string function setName( required string yourName ){
		return yourName;
	}
}