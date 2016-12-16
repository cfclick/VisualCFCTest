<!--- 
  ***************************************************************************
  LAST MODIFIED ON: $Modtime: 04/02/11 8:05p $ BY USER: $Author: Shirak $
  LAST CHECKIN ON: $Date: 6/30/11 2:18p $
  AUTHOR: Shirak 
  E-MAIL: ShirakAvakian@gmail.com
  COMPANY: CFFlex Technology, INC. 
  ***************************************************************************
--->
<cfsetting showdebugoutput="no">
<cfajaximport tags="cfinput-datefield,cflayout-accordion,cfgrid,cfform,cfwindow,cfdiv,cftooltip">
<cfinclude template="style.css.cfm" >

<cftry>
	<cfinclude template="createStructure.cfm" >

	<cfset proxy = createobject(res.cfcmap)/>

	<cfset meta = getComponentMetaData(res.cfcmap)/>

	<cfif CompareNocase(res.file,"Application.cfc") eq 0>
		<cfoutput><H3>Sorry you can not test Application.cfc</H3></cfoutput>
		<cfabort>
	</cfif>

	<cfif not structkeyexists(meta,"Functions")>
		<cfoutput><H3>Sorry There are no methods in #res.path#</H3></cfoutput>
		<cfabort>
	<cfelseif structkeyexists(meta,"Functions") and isArray(meta.Functions)>
		<cfif arraylen(meta.Functions)>
			<cfloop array="#meta.Functions#" index="item" >
				<cfif structkeyExists(item,"access") and compareNocase(item.access,"remote") eq 0 >
					<cfset hasRemoteMethod = true />
					<cfbreak>
				<cfelse>

				</cfif>
			</cfloop>
		</cfif>
	</cfif>

	<cflock timeout="2" type="exclusive">
		<cfset structclear(session) />
		<cfset session.meta = meta/>
		<cfset session.proxy = proxy/>
	</cflock>

	<cfoutput>

		<cflayout name="bor01" type="border" fittowindow=true>
			<cflayoutarea position="left" collapsible="false" splitter="false" title=""
			              size="310" style="padding-top:5;padding-left:5">
				Project Name:
				#project.name#
				<br>
				File Name:
				#res.file#
				<br>
				<cftry>

				<cfform name="tablesGridForm">
					<cftree name="functionsTree" format="html">
						<cftreeitem  display="#res.file#" value="Functions" img="assets/ws-icon.png" >
						<cfloop array="#meta.Functions#" index="ele" >
							<cfif structKeyExists(ele,"RETURNTYPE")>
								<cfset reType = ele.RETURNTYPE />
							<cfelse>
								<cfset reType = "" />
							</cfif>
							<cfif structkeyexists(ele,"access")>
								<cftreeitem display="#ele.Name#():#reType#" value="#ele.Name#" parent="Functions" expand="false" img="assets/func-icon-#ele.access#.png"  >
							<cfelse>
								<cftreeitem display="#ele.Name#():#reType#" value="#ele.Name#" parent="Functions" expand="false" img="assets/func-icon-undefined.png"  >
							</cfif>

							<cfloop array="#ele.PARAMETERS#" index="pro" >
								<cfif structkeyExists(pro,"Type")>
									<cftreeitem display="#pro.Name#-[#pro.Type#]" value="#pro.Name#" parent="#ele.Name#" img="element"  >
								<cfelse>
									<cftreeitem display="#pro.Name#" value="#pro.Name#" parent="#ele.Name#" img="element">
								</cfif>

							</cfloop>
						</cfloop>
					</cftree>
					<div id="help">
						<img src="assets/func-icon-private.png"/> Private<br>
						<img src="assets/func-icon-package.png"/> Package<br>
						<img src="assets/func-icon-public.png"/> Public<br>
						<img src="assets/func-icon-remote.png"/> Remote<br>
						<img src="assets/func-icon-undefined.png"/> Undefined<br>
					</div>
				</cfform>
				<cfcatch type="any" >
					<cfdump var="#cfcatch#" />
				</cfcatch>
				</cftry>
			</cflayoutarea>

			<cflayoutarea position="center" name="centerPane" style="padding-left:5; spacing:0;">
				<cfpod source="argumentsUI.cfm?functionName={functionsTree.node}" name='ipod' height="650"
				       width="850" title="Function Arguments" headerstyle="color:black;"/>
			</cflayoutarea>
		</cflayout>

	</cfoutput>
<cfcatch type="any">
	<cfdump var="#cfcatch#"/>
</cfcatch>
</cftry>
