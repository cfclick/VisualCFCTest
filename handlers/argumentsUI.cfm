<!--- 
  ***************************************************************************
  LAST MODIFIED ON: $Modtime: 04/02/11 8:05p $ BY USER: $Author: Shirak $
  LAST CHECKIN ON: $Date: 6/30/11 2:18p $
  AUTHOR: Shirak 
  E-MAIL: ShirakAvakian@gmail.com
  COMPANY: CFFlex Technology, INC. 
  ***************************************************************************
--->
<cfsetting showdebugoutput="no" >
<cfajaximport tags="cfinput-datefield,cflayout-accordion,cfgrid,cfform,cfwindow,cfdiv,cftooltip">
<cftry>

	<cfset util = createobject("framework.Util")/>

	<cfparam name="form.funcName" default="">
	<cfparam name="URL.functionName" default="#iif(isdefined('form.funcName') and len(form.funcName),de(form.funcName),de(''))#">

	<cfset initFuncArg = []/>
	<cfset funcArg = []/>
	<cfset functions = session.meta.Functions/>
	<cfset funcparam = {}/>
	<cfset input = {}/>
	
	<cfloop array="#functions#" index="func">
		<cfset funcparam[func.Name] = func.parameters/>
	</cfloop>

	<cfif isdefined("URL.functionName") and structkeyexists(funcparam, URL.functionName)>
		<cfset funcArg = structFind(funcparam, URL.functionName)/>
	</cfif>
	
	<cfif structkeyexists(funcparam, "init")>
		<cfset initFuncArg = structFind(funcparam, "init")/>
	</cfif>

	<cfoutput>
		<div>
			<h3>
				#URL.FunctionName#()
			</h3>
		</div>
		<cfset HtmlVar = util.renderHTML( initFuncArg,funcArg,URL.FunctionName ) />

		<cfcontent  type="text/html" >
			#HtmlVar#
		</cfcontent>

		<cfif isdefined("form.submit")>
			<cfdump var="#form#"><cfabort>
			<cfset comp = "" />
			<cfif isDefined("form.ComponentName")>

				<cfset comp = createobject("#form.ComponentName#")/>
				<cfset compmt = getComponentMetadata("#form.ComponentName#")/>
				<cfset compProp = compmt.PROPERTIES/>
				<cfif arraylen(compProp) gt 0>
					<cfloop array="#compProp#" index="co">
						<cfset comp[co.Name] = form[co.Name] />
					</cfloop>
				</cfif>

			</cfif>

			<cfset result = ""/>
			<cfset componentPath = session.meta.FullName/>
			<cfset collection = util.CreateArgumentCollection(funcArg, form,false,comp)/>

			<cfif not(isdefined("Session.initCollection"))>
				<cfset Session.initCollection = util.CreateArgumentCollection(InitFuncArg, form)/>
			</cfif>

			<cfif structkeyexists(funcparam, "init")>
				<cfset proxy = createobject(componentPath)/>
				<cfif !StructIsEmpty(Session.initCollection)>
					<cflock timeout="2" type="exclusive" >
						<cfset session.init = proxy.init(argumentCollection=Session.initCollection)/>
					</cflock>
				<cfelse>
					<cflock timeout="2" type="exclusive" >
						<cfset session.init = proxy.init()/>
					</cflock>
				</cfif>
			<cfelse>
				<cfset proxy = createobject(componentPath)/>
			</cfif>

			<cfif CompareNocase(form.funcName,"init") neq 0 >
				<cfif structkeyexists(session,'init') and not (isSimpleValue(session.init)) and isObject(session.init)>
					<cfset result = util.InvokeTheMethodByInitObject(session.init, form.funcName, funcArg, form)/>
				<cfelse>
					<cfset result = util.InvokeTheMethodByInitObject(proxy, form.funcName, funcArg, form)/>
				</cfif>
			</cfif>
			<table width="100%" border="2" style="margin-top:20px">
				<tr>
					<td colspan="2" align="left" valign="top">
						<table width="100%" border="1">
							<tr>
								<th colspan="2" valign="middle">
									Server Response
								</th>
							</tr>
							<cfif isStruct(result) and structkeyexists(result,'status') and result.status is "failed">
							<tr bgcolor="##ff0000">
								<td align="left" valign="top" style="padding-left:5px;padding-top:5px;padding-right:5px;padding-bottom:5px">
									<font color="##ffffff">Results</font>
								</td>
								<td align="left" valign="top" style="padding-left:5px;padding-top:5px;padding-right:5px;padding-bottom:5px"/>
									<font color="##ffffff" >Failed</font>
								</td>
							</tr>
							<cfelse>
								<tr bgcolor="##6fdd00">
									<td align="left" valign="top" style="padding-left:5px;padding-top:5px;padding-right:5px;padding-bottom:5px">
										<font color="##ffffff">Results</font>
									</td>
									<td align="left" valign="top" style="padding-left:5px;padding-top:5px;padding-right:5px;padding-bottom:5px"/>
										<font color="##ffffff" >Success</font>
									</td>
								</tr>
							</cfif>
							<tr>
								<td align="left" valign="top">
									Method Name
								</td>
								<td align="left" valign="top">
									#form.funcName#
								</td>
							</tr>
							<tr>
								<td align="left" valign="top" colspan="2">
									<cfif isdefined("result") and not (isSimpleValue(result))>
										<cfdump var="#result#"/>
									<cfelseif isdefined("result") and isSimpleValue(result) and len(result)>
										#result#
									<cfelse>
										<div class="input-validation-error">
											If the return type is void below is the proxy object for
											#session.meta.fullname#
											component.
										</div>
										<cfdump var="#proxy#"/>
									</cfif>
								</td>
							</tr>
						</table>
					</td>
				</tr>
			</table>

			<cfif structkeyexists(session,"init")>
				<cflock timeout="2" type="exclusive" >
					<cfset session.init = "" />
				</cflock>
			</cfif>
		</cfif>
	</cfoutput>
<cfcatch type="any">
	<cfdump var="#cfcatch#"/>
</cfcatch>
</cftry>
