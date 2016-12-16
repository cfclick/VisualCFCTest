
<cfcomponent name="Util" output="false">

	<cfset this.javaString = createObject("java", "java.lang.String")>

	<cffunction name="getArrayCount" returntype="numeric" output="false">
		<cfargument name="arrayVar" type="Any"/>

		<cfif isArray(arguments.arrayVar)>
			<cfreturn ArrayLen(arguments.arrayVar)>
		<cfelse>
			<cfreturn 0>
		</cfif>
	</cffunction>

	<cffunction name="generateURL" output="false">
		<cfargument name="templateName" required="true" type="string"/>

		<cfreturn getURLBasePath() & "/" & templateName>
	</cffunction>

	<cffunction name="getURLBasePath" output="false">
		<cfset scriptPath = CGI.script_name>
		<cfset javaStrObj = createJavaString(scriptPath)>
		<cfset index = javaStrObj.lastIndexOf("/")>
		<cfset scriptPath = javaStrObj.subString(0, index)>

		<cfreturn "http://" & #CGI.SERVER_NAME# & ":" & #CGI.SERVER_PORT# & scriptPath>
	</cffunction>

	<cffunction name="createJavaString" returntype="any" output="false">
		<cfargument name="arg" required="true"/>

		<cfreturn this.javaString.init(arg)>
	</cffunction>

	<cffunction name="createRefreshFileCommand" returntype="String" output="false">
		<cfargument name="filePath" required="true" type="string"/>
		<cfargument name="projectName" required="false" type="string"/>

		<cfoutput>
			<cfsavecontent variable="result">
				<command type="refreshFile">
					<params>
						<param key="filename" value="#arguments.filePath#" />
						<cfif isDefined("arguments.projectName")>
						<param key="projectname" value="#arguments.projectName#" />
						</cfif>
					</params>
				</command>
			</cfsavecontent>
		</cfoutput>

		<cfreturn result>
	</cffunction>

	<cffunction name="createRefreshFolderCommand" returntype="String" output="false">
		<cfargument name="folderPath" required="true" type="string"/>
		<cfargument name="projectName" required="false" type="string"/>

		<cfoutput>
			<cfsavecontent variable="result">
				<command type="refreshFolder">
					<params>
						<param key="foldername" value="#arguments.folderPath#" />
						<cfif isDefined("arguments.projectName")>
						<param key="projectname" value="#arguments.projectName#" />
						</cfif>
					</params>
				</command>
			</cfsavecontent>
		</cfoutput>

		<cfreturn result>
	</cffunction>

	<cffunction name="createRefreshProjectCommand" returntype="String" output="false">
		<cfargument name="projectName" required="true" type="string"/>

		<cfoutput>
			<cfsavecontent variable="result">
				<command type="refreshProject">
					<params>
						<param key="projectname" value="#arguments.projectName#" />
					</params>
				</command>
			</cfsavecontent>
		</cfoutput>

		<cfreturn result>
	</cffunction>

	<cffunction name="createOpenFileCommand" returntype="String" output="false">
		<cfargument name="filePath" required="true" type="string"/>
		<cfargument name="projectName" required="false" type="string"/>

		<cfoutput>
			<cfsavecontent variable="result">
				<command type="openFile">
					<params>
						<param key="filename" value="#arguments.filePath#" />
						<cfif isDefined("arguments.projectName")>
						<param key="projectname" value="#arguments.projectName#" />
						</cfif>
					</params>
				</command>
			</cfsavecontent>
		</cfoutput>

		<cfreturn result>
	</cffunction>

	<cffunction name="createInsertTextCommand" returntype="String" output="false">
		<cfargument name="text" required="true" type="string"/>
		<cfargument name="insertMode" required="false" type="string" default="replace"/>

		<cfoutput>
			<cfsavecontent variable="result">
				<command type="inserttext">
					<params>
						<param key="text">
							<![CDATA[ #arguments.text# ]]>
						</param>
						<param key="insertmode" value="#arguments.insertMode#" />
					</params>
				</command>
			</cfsavecontent>
		</cfoutput>

		<cfreturn result>
	</cffunction>

	<cffunction name="createWrapTextCommand" returntype="String" output="false">
		<cfargument name="startText" required="true" type="string"/>
		<cfargument name="endText" required="true" type="string"/>

		<cfoutput>
			<cfsavecontent variable="result">
				<command type="inserttext">
					<params>
						<param key="starttext">
							<![CDATA[ #arguments.startText# ]]>
						</param>
						<param key="endtext">
							<![CDATA[ #arguments.endText# ]]>
						</param>
						<param key="insertmode" value="wrap" />
					</params>
				</command>
			</cfsavecontent>
		</cfoutput>

		<cfreturn result>
	</cffunction>

	<cffunction name="createFormByType" access="public" returntype="struct">
		<cfargument name="arg" type="struct" required="true"/>
		<cfargument name="isInit" type="boolean" required="false" default="false"/>

		<cftry>
			<cfset var input = {}/>
			<cfset var required = false/>
			<cfset var prefix = "" />

			<cfif isinit>
				<cfset prefix = "init" />
			</cfif>

			<cfif structkeyexists(arg, 'required')>
				<cfset required = arg.required/>
			<cfelseif structkeyexists(arg,"NOTNULL") >
				<cfset required = arg.NOTNULL/>
			</cfif>

			<cfif !structKeyExists(arg, "Type")>
				<cfthrow detail="Argument Type is not defined. Unable to continue processing you test. Please make sure you define type for your method arguments."
				         message="Argument Type is not defined">
				<cfabort>
			</cfif>

			<cfswitch expression="#arg.Type#">
				<cfcase value="string,numeric">
					<cfif compareNocase(arg.Name, "password") eq 0>
						<cfset input.type = "password"/>
					<cfelse>
						<cfset input.type = "Text"/>
					</cfif>
					<cfset input.value = ""/>
					<cfset input.name = prefix & arg.Name/>
					<cfset input.required = required/>

				</cfcase>
				<cfcase value="Boolean">
					<cfset input.type = "checkbox"/>
					<cfset input.value = "#arg.required#"/>
					<cfset input.name = prefix & arg.Name/>
					<cfset input.required = required/>
				</cfcase>
				<cfcase value="Date">
					<cfset input.type = "datefield"/>
					<cfset input.value = ""/>
					<cfset input.name = prefix & arg.Name/>
					<cfset input.required = required/>
				</cfcase>

				<cfcase value="array">
					<cfset input.type = "array"/>
					<cfset input.value = ""/>
					<cfset input.name = prefix & arg.Name/>
					<cfset input.required = arg.required/>
				</cfcase>

				<cfcase value="struct">
					<cfset input.type = "struct"/>
					<cfset input.value = ""/>
					<cfset input.name = prefix & arg.Name/>
					<cfset input.required = required/>
				</cfcase>
				<cfdefaultcase>
					<cfif len(arg.Type) gt 0>
						<cfset input.type = arg.Type/>
						<cfset input.isComplexObject = true/>

					<cfelse>
						<cfset input.type = "String"/>
						<cfset input.required = required/>
					</cfif>
					<cfset input.value = ""/>
					<cfset input.name = UCASE(prefix & arg.Name)/>
					<cfset input.required = required/>
				</cfdefaultcase>
			</cfswitch>

			<cfreturn input/>
		<cfcatch type="any">
			<cfthrow detail="#cfcatch.Detail#" message="#cfcatch.Message#">
		</cfcatch>
		</cftry>
	</cffunction>

	<cffunction name="InvokeTheMethod" access="public" returntype="any">
		<cfargument name="ComponentName" type="string" required="true"/>
		<cfargument name="MethodName" type="string" required="true"/>
		<cfargument name="MethodArguments" type="array" required="true"/>
		<cfargument name="formScope" type="struct" required="true"/>

		<cftry>
			<cfset var methodResult = ""/>
			<cfset var argName = ""/>
			<cfset var argValue = ""/>
			<cfset var mystr = {}/>
			<cfset var tempArray = arraynew(2)/>

			<cfinvoke method="#Arguments.MethodName#" component="#arguments.ComponentName#"
			          returnvariable="MethodResult">
				<cfloop from="1" to="#arraylen(MethodArguments)#" index="i">

					<cfswitch expression="#MethodArguments[i].Type#">
						<cfcase value="string,numeric,Boolean,Date">
							<cfset argName = MethodArguments[i].Name/>
							<cfset argValue = formScope[MethodArguments[i].Name]/>
						</cfcase>

						<cfcase value="array">
							<cfset argName = MethodArguments[i].Name/>
							<cfset argValue = formScope["myarrayGrid." & MethodArguments[i].Name]/>
						</cfcase>

						<cfcase value="struct">
							<cfset var keyName = "myStructGrid." & MethodArguments[i].Name & "_Key"/>
							<cfset var valName = "myStructGrid." & MethodArguments[i].Name & "_Value"/>
							<cfloop from="1" to="#arraylen(formScope[keyName])#" index="j">
								<cfset var tempStr = {"#formScope[keyName][j]#"="#formScope[valName][j]#"}/>
								<cfset structAppend(mystr, tempStr)/>
							</cfloop>
							<cfset argName = MethodArguments[i].Name/>
							<cfset argValue = mystr/>
						</cfcase>
						<cfdefaultcase>

						</cfdefaultcase>
					</cfswitch>

					<cfinvokeargument name="#argName#" value="#argValue#">

				</cfloop>
			</cfinvoke>

			<cfif isDefined("methodResult")>
				<cfreturn methodResult/>
			<cfelse>
				<cfreturn ""/>
			</cfif>
		<cfcatch type="any">
			<cfset methodResult = {}/>
			<cfset methodResult["Status"] = "failed"/>
			<cfset methodResult["catch"] = cfcatch/>
			<cfreturn methodResult/>
			<cfthrow detail="#cfcatch.Detail#" message="#cfcatch.message#">
		</cfcatch>
		</cftry>
	</cffunction>

	<cffunction name="InvokeTheMethodByInitObject" access="public" returntype="any">
		<cfargument name="initObject" type="any" required="true"/>
		<cfargument name="MethodName" type="string" required="true"/>
		<cfargument name="MethodArguments" type="array" required="true"/>
		<cfargument name="formScope" type="struct" required="true"/>


		<cftry>
			<cfset var methodResult = ""/>

			<cfset var collection = CreateArgumentCollection(MethodArguments, formScope)/>

			<cfif StructIsEmpty(collection)>
				<cfset var stringToEvaluate = "initObject.#MethodName#()"/>
			<cfelse>
				<cfset var stringToEvaluate = "initObject.#MethodName#(argumentcollection=collection)"/>
			</cfif>
			
			<cfset methodResult = evaluate(stringToEvaluate)/>

			<cfif isDefined("methodResult")>
				<cfreturn methodResult/>
			<cfelse>
				<cfreturn ""/>
			</cfif>
		<cfcatch type="any">
			<cfdump var="#cfcatch#"/>
			<!---<cfif findnocase("ORM is not configured for the current application.",cfcatch.message) gt 0>
				<cfif structKeyExists(session, "wsProxy")>
					<cfset var WsStringToEvaluate = replace(stringToEvaluate, "initObject", "session.wsProxy")/>
					<cfset methodResult = evaluate(WsStringToEvaluate)/>
				<cfelse>
					<cfset methodResult = {}/>
					<cfset methodResult["Status"] = "failed"/>
					<cfset methodResult["catch"] = cfcatch/>
					<cfreturn methodResult/>
				</cfif>

				<cfif isDefined("methodResult")>
					<cfreturn methodResult/>
				<cfelse>
					<cfreturn ""/>
				</cfif>
			<cfelse>
				<cfset methodResult = {}/>
				<cfset methodResult["Status"] = "failed"/>
				<cfset methodResult["catch"] = cfcatch/>
				<cfreturn methodResult/>
			</cfif>--->
		</cfcatch>
		</cftry>
	</cffunction>

	<cffunction name="CreateArgumentCollection" access="public" returntype="struct">
		<cfargument name="MethodArguments" type="array" required="true"/>
		<cfargument name="formScope" type="struct" required="true"/>
		<cfargument name="isInit" type="boolean" required="true" default="false"/>
		<cfargument name="obj" type="any" required="false" default=""/>

		<cftry>
			<cfset var collection = {}/>
			<cfset var argValue = ""/>
			<cfset var mystr = {}/>
			<cfset var tempArray = arraynew(2)/>

			<cfloop from="1" to="#arraylen(MethodArguments)#" index="i">

				<cfif !StructKeyExists(MethodArguments[i], "Type")>
					<cfthrow detail="Argument Type is not defined. Unable to continue processing you test. Please make sure you define type for your method arguments."
					         message="Argument Type is not defined">
					<cfreturn input/>
				</cfif>

				<cfswitch expression="#MethodArguments[i].Type#">
					<cfcase value="string,numeric,Boolean,Date">
						<cfset collection["#MethodArguments[i].Name#"] = formScope[MethodArguments[i].Name]/>
					</cfcase>

					<cfcase value="array">
							<cfset collection["#MethodArguments[i].Name#"] = formScope[MethodArguments[i].Name & "." & MethodArguments[i].Name]/>
					</cfcase>

					<cfcase value="struct">
						<cfset var keyName = ""/>
						<cfset var valName = ""/>
						<cfset keyName = MethodArguments[i].Name & "." & MethodArguments[i].Name & "_Key"/>
						<cfset valName = MethodArguments[i].Name & "." & MethodArguments[i].Name & "_Value"/>

						<cfloop from="1" to="#arraylen(formScope[keyName])#" index="j">
							<cfset var tempStr = {"#formScope[keyName][j]#"="#formScope[valName][j]#"}/>
							<cfset structAppend(mystr, tempStr)/>
						</cfloop>
						<cfset collection["#MethodArguments[i].Name#"] = mystr/>
					</cfcase>
					<cfdefaultcase>
						<cftry>
							<cfset obj = createobject(MethodArguments[i].Type) />
							<cfset mta = getComponentMetadata(MethodArguments[i].Type) />

							<cfloop list="#formScope.FIELDNAMES#" index="fo" >

								<cfloop array="#mta.PROPERTIES#" index="prop" >

									<cfif CompareNoCase(fo, prop.Name) eq 0>

										<!---<cfset var accessorstring = "obj.set" & prop.Name & "(formScope[fo])" />
										<cfdump var="#accessorstring#" />--->
										<cfset obj[prop.Name] = formScope[fo] />
										<cfbreak>
									</cfif>
								</cfloop>
							</cfloop>
						<cfcatch type="any" >
						</cfcatch>
						</cftry>
						<cfset collection["#MethodArguments[i].Name#"] = obj/>

					</cfdefaultcase>
				</cfswitch>

			</cfloop>

			<cfreturn collection/>
		<cfcatch type="any">
			<cfthrow detail="#cfcatch.Detail#" message="#cfcatch.message#">
		</cfcatch>
		</cftry>
	</cffunction>



	<cffunction name="renderHTML" access="public" returntype="Any">
		<cfargument name="initFuncArg" type="array" required="true"/>
		<cfargument name="funcArg" type="array" required="false"/>
		<cfargument name="functionName" type="string" required="true" />

		<cfset var showInit = true />
		<cfset var htmlString = ""/>
		<cfsavecontent variable="htmlString" >
			<cfoutput >
				<table width="100%" border="1">
				<cfform>
					<cfinput name="funcName" id="funcName" type="hidden" value="#functionName#" >

					<cfif arraylen(funcArg) gt 0 >
						<cfloop array="#funcArg#" index="arg">
							<cfset var inputForm = {} />
							<!---<cfdump var="#arg#">--->
							<cfset inputForm = createFormByType(arg,false)/>
							<tr>
								<td align="left" valign="top" width="150" nowrap="true">
										#inputForm.Name# <cfif inputForm.required><font color="red">*</font></cfif>
								</td>
								<td align="left" valign="top" width="100%">
									<cfif comparenocase(inputForm.type, 'checkbox') eq 0>
										<cfinput name="#inputForm.Name#" id="#inputForm.Name#" type="#inputForm.type#"
										         required="#inputForm.required#" value="#inputForm.value#"
										         checked="#inputForm.required#" class="input"/> (Boolean)
									<cfelseif comparenocase(inputForm.type, "array") eq 0>
										<cfgrid format="html" name="#inputForm.Name#" autowidth="true" insert="true"
										        selectmode="edit">
											<cfgridcolumn name="#inputForm.Name#" header="Array Value" width=300>

										</cfgrid> (Array)
									<cfelseif comparenocase(inputForm.type, "struct") eq 0>
										<cfgrid format="html" name="#inputForm.Name#" autowidth="true" insert="true"
											    selectmode="edit">
											<cfgridcolumn name="#inputForm.Name#_Key" header="Struct Key" width=300>
											<cfgridcolumn name="#inputForm.Name#_Value" header="Struct Value" width=300>
										</cfgrid> (Struct)

									<cfelseif comparenocase(inputForm.type, 'Text') eq 0 or comparenocase(inputForm.type, 'password') eq 0>
											<cfinput name="#inputForm.Name#" id="#inputForm.Name#" type="#inputForm.type#"
											         required="#inputForm.required#" class="input" value="#inputForm.value#"/> (#inputForm.type#)
									<cfelseif comparenocase(inputForm.type, 'datefield') eq 0>
											<cfinput name="#inputForm.Name#" id="#inputForm.Name#" type="#inputForm.type#"
											         required="#inputForm.required#" class="input" value="#inputForm.value#"/> (#inputForm.type#)
									<cfelseif structkeyexists(inputForm,"isComplexObject") and inputForm.isComplexObject>
										<cfinclude template="..\complexObject.cfm" > (ComplexType)
									<cfelse>

									</cfif>
								</td>
							</tr>

						</cfloop>
					</cfif>

				<tr>
					<td>
					</td>
					<td style="padding-left:15;padding-right:15;padding-top:15;padding-bottom:15">
						<cfinput type="submit" name="submit" value="Invoke #URL.FunctionName#()" class="inputbtn">
					</td>
				</tr>
				</cfform>
				</table>

			</cfoutput>
		</cfsavecontent>
		<cfreturn htmlstring>
	</cffunction>


</cfcomponent>