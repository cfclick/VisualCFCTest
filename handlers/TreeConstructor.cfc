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
		
		var arrayOfNode = [];
		var comp = {};
		comp.name = "Functions(#arrayLen(meta.Functions)#)";
		comp.id = "Functions";
		comp.open = true;
		comp.isDynamic = false;
		comp.isParent = true;	
		comp.drop = false;
		comp.drag = false;			
		comp.icon = "assets/function.png";
		comp.children = [];
		var arrayOfFolder = [];
		for( var func in meta.Functions ){
			var f = {};		
			if( len(func.name) <= 23 ){
				f.name = left(func.name, 23);
			} else {
				f.name= left(func.name, 23) & ' ...';
			}	

			f.id = func.name;
			f.pId = comp.name;
			f.access = func.access; //& folder.Name;
			f.parameters = func.parameters;
			var paramLen = arrayLen( f.parameters );
			f.isParent = false;
			f.children = [];
			f.argumentsCount = paramLen;
			if( paramLen > 0 ){
				f.isParent = true;
				for( para in  f.parameters ){
					var nullible = iif( para.required , de('not null'), de('null') );
					var paraName = para.name & '(' & para.type & ')-' & nullible;
					f.children.append({name:paraName,id:para.name,pId:f.name,type:para.type,required:para.required}); 
				}			
			}
			
			f.returntype = func.returntype;									
			f.isDynamic = false;				
			f.drop = false;
			f.drag = false;			
			if( compareNocase(f.access,'private') == 0 )
				f['icon'] = "assets/func-icon-private.png";
			else if( compareNocase(f.access,'package') == 0 )	
				f['icon'] = "assets/func-icon-package.png";
			else if( compareNocase(f.access,'public') == 0 )	
				f['icon'] = "assets/func-icon-public.png";
			else if( compareNocase(f.access,'remote') == 0 )	
				f['icon'] = "assets/func-icon-remote.png";
			
			f.cfcmap = meta.name;
			arrayOfFolder.append( f );
		}
		comp.children = arrayOfFolder;
		arrayOfNode.append(comp);
		
		comp = {};
		comp.name = "Extends";
		comp.id = "Extends";
		comp.open = false;
		comp.isDynamic = false;
		comp.isParent = true;	
		comp.drop = false;
		comp.drag = false;			
		comp.icon = "assets/function.png";
		comp.children = [{
			name : meta.Extends.FullName,
			id : meta.Extends.FullName,
			pid = comp.id
		}];
		arrayOfNode.append(comp);
		
		return arrayOfNode;
	}   	    
}