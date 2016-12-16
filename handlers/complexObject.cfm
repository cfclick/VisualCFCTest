<!--- 
  ***************************************************************************
  LAST MODIFIED ON: $Modtime: 04/02/11 8:05p $ BY USER: $Author: Shirak $
  LAST CHECKIN ON: $Date: 6/30/11 2:18p $
  AUTHOR: Shirak 
  E-MAIL: ShirakAvakian@gmail.com
  COMPANY: CFFlex Technology, INC. 
  ***************************************************************************
--->
<cfoutput>
<cfset obj = createobject("#inputForm.Type#")/>
<cfset mt = getComponentMetadata("#inputForm.Type#")/>
<cfset objArg = mt.PROPERTIES/>

<cfinput name="componentName" id="componentName" type="hidden"
								     value="#inputForm.Type#" />
	<table width="100%" border="1">
		<cfif arraylen(objArg) gt 0>
		
			<cfloop array="#objArg#" index="item">
				<cfset objectinputForm = createFormByType(item)/>		
				<tr>
					<td align="left" valign="top" nowrap="true">				
						#objectinputForm.Name#
						<cfif objectinputForm.required>
							<font color="red">
								*
							</font>
						</cfif>
					</td>
					<td align="left" valign="top" width="100%">
						<cfif comparenocase(objectinputForm.type, 'boolean') eq 0>
							<cfinput name="#objectinputForm.Name#" id="#objectinputForm.Name#" 
							         type="#objectinputForm.type#" required="#objectinputForm.required#" 
							         value="#objectinputForm.value#" checked="#objectinputForm.required#" class="input"/>
							(Boolean)
						<cfelseif comparenocase(objectinputForm.type, "array") eq 0>
							<cfset arr = []/>
							<cfgrid format="html" name="myarrayGrid" autowidth="true" insert="true" selectmode="edit">
								<cfgridcolumn name="#objectinputForm.Name#" header="Array Value" width=300>
							
							</cfgrid>
							(Array)
						<cfelseif comparenocase(objectinputForm.type, "struct") eq 0>
						
							<cfgrid format="html" name="myStructGrid" autowidth="true" insert="true" selectmode="edit">
								<cfgridcolumn name="#objectinputForm.Name#_Key" header="Struct Key" width=300>
								<cfgridcolumn name="#objectinputForm.Name#_Value" header="Struct Value" width=300>
							</cfgrid>
							(Struct)
						<cfelseif comparenocase(objectinputForm.type, "Text") eq 0>
							<cfinput name="#objectinputForm.Name#" id="#objectinputForm.Name#" 
							         type="#objectinputForm.type#" required="#objectinputForm.required#" class="input" 
							         value="#objectinputForm.value#"/>
							(
							#objectinputForm.type#
							)
						<cfelseif comparenocase(objectinputForm.type, 'Text') eq 0 or comparenocase(objectinputForm.type, 
						                                                                            'password') eq 0>
							<cfinput name="#objectinputForm.Name#" id="#objectinputForm.Name#" 
							         type="#objectinputForm.type#" required="#objectinputForm.required#" class="input"/>
							(
							#objectinputForm.type#
							)
						<cfelseif comparenocase(objectinputForm.type, "datefield") eq 0>
							<cfinput name="#objectinputForm.Name#" id="#objectinputForm.Name#" 
							         type="#objectinputForm.type#" required="#objectinputForm.required#" class="input" 
							         value="#objectinputForm.value#"/>
							(
							#objectinputForm.type#
							)
						<cfelse>					
							<cfinput type="hidden" name="path" id="path" width="250" class="input"
							         value="#objectinputForm.Type#">
						
							<input type="button" name="win" onclick="javascript:ShowComponentWindow();" value="show win" 
							       class="input">
						</cfif>
					</td>
				</tr>				
			</cfloop>
		</cfif>
		</table>
</cfoutput>