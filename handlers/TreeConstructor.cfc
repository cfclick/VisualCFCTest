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
component  output="false"
{
	
	remote array function loadTree( required string cfcmap) returnformat="JSON"{
		
		var proxy = createobject(cfcmap);
		var meta = getComponentMetaData(cfcmap);
		
			var arrayOfFolder = [];
			for( var func in meta.Functions ){
				var f = {};				
				f.name = func.Name;
				f.access = func.access; //& folder.Name;
				f.parameters = func.parameters;
				f.returntype = func.returntype;
				f["id"] = func.Name;
				if( len(f.name) <= 23 ){
					f["name"]= left(f.name, 23);
				} else {
					f["name"]= left(f.name, 23) & ' ...';
				}
				f["noR"] = false;
				f["isDynamic"] = false;
				f["isParent"] = false;	
				f["drop"] = false;
				f["drag"] = false;			
				
				f['icon'] = "assets/func-icon-public.png";
				arrayOfFolder.append( f );
			}
			
			return arrayOfFolder;
		}   	    
}