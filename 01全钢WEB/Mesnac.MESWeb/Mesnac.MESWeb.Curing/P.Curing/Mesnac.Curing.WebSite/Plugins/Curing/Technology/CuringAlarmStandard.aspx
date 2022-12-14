<%@ Page Language="C#" AutoEventWireup="true" CodeFile="CuringAlarmStandard.aspx.cs" Inherits="Plugins_Curing_Technology_CuringAlarmStandard" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>硫化报警标准</title>
    <style>
        .dirty-row .x-grid-cell, .dirty-row .x-grid-rowwrap-div {
            background-color: #FFFDD8 !important;
        }

        .new-row .x-grid-cell, .new-row .x-grid-rowwrap-div {
            background: #c8ffc8 !important;
        }

        .row_0 .x-grid-cell, .row_0 .x-grid-rowwrap-div {
        }

        .row_1 .x-grid-cell, .row_1 .x-grid-rowwrap-div {
            background: yellow !important;
        }

        .row_2 .x-grid-cell, .row_2 .x-grid-rowwrap-div {
            background: green !important;
            color: white !important;
        }

        .row_3 .x-grid-cell, .row_3 .x-grid-rowwrap-div {
            background: red !important;
            color: white !important;
        }

        .row_4 .x-grid-cell, .row_4 .x-grid-rowwrap-div {
            background: blue !important;
            color: white !important;
        }

        .row_5 .x-grid-cell, .row_5 .x-grid-rowwrap-div {
            background: gray !important;
            color: white !important;
        }
    </style>
    <script type="text/javascript" src="CuringAlarmStandard.js?<%=DateTime.Now.ToString("HHmmss") %>"></script>
</head>
<body>
    <form id="form1" runat="server">
        <ext:ResourceManager runat="server" ID="ResourceManager1" />
        <ext:Viewport runat="server" ID="Viewport1" Layout="BorderLayout">
            <Items>
                <ext:Panel runat="server" Region="North">
                    <Items>
                        <%--操作按钮--%>
                        <ext:Toolbar runat="server">
                            <Items>
                                <ext:Button runat="server" ID="btnSearch" Text="查询" Icon="PageFind">
                                    <Listeners>
                                        <Click Handler="return btnSearch_Click();" />
                                    </Listeners>
                                </ext:Button>
                                <ext:Button runat="server" ID="btnView" Text="查看" Icon="PageWord">
                                    <Listeners>
                                        <Click Handler="return btnView_Click();" />
                                    </Listeners>
                                </ext:Button>
                                <ext:Button runat="server" ID="btnCopy" Text="复制" Icon="PageCopy">
                                    <Listeners>
                                        <Click Handler="return btnCopy_Click();" />
                                    </Listeners>
                                </ext:Button>
                                <ext:Button runat="server" ID="btnAdd" Text="添加" Icon="PageAdd">
                                    <Listeners>
                                        <Click Handler="return btnAdd_Click();" />
                                    </Listeners>
                                </ext:Button>
                                <ext:Button runat="server" ID="btnEdit" Text="修改" Icon="PageEdit">
                                    <Listeners>
                                        <Click Handler="return btnEdit_Click();" />
                                    </Listeners>
                                </ext:Button>
                                <ext:Button runat="server" ID="btnDelete" Text="删除" Icon="PageDelete">
                                    <Listeners>
                                        <Click Handler="return btnDelete_Click();" />
                                    </Listeners>
                                </ext:Button>
                                <ext:Button runat="server" ID="btnSubmit" Text="提交" Icon="PageGo">
                                    <Listeners>
                                        <Click Handler="return btnSubmit_Click();" />
                                    </Listeners>
                                </ext:Button>
                                <ext:Button runat="server" ID="btnAudit" Text="审核" Icon="PageKey">
                                    <Listeners>
                                        <Click Handler="return btnAudit_Click();" />
                                    </Listeners>
                                </ext:Button>
                                <ext:Button runat="server" ID="btnSend" Text="下发" Icon="PageForward">
                                    <Listeners>
                                        <Click Handler="return btnSend_Click();" />
                                    </Listeners>
                                </ext:Button>
                                <ext:ToolbarSeparator runat="server"></ext:ToolbarSeparator>
                                <ext:TextField ID="txtAlarmCount" runat="server" Width ="200" LabelAlign="Right" FieldLabel="累计报警次数设置"></ext:TextField>
                                <ext:Button ID="btnSaveAlarmCount" runat="server" Text="保存设置" Icon="DatabaseSave">
                                      <DirectEvents>
                                          <Click OnEvent="btnSaveAlarmCount_Click">
                                          </Click>
                                      </DirectEvents>
                                </ext:Button>
                            </Items>
                        </ext:Toolbar>
                        <%--查询条件--%>
                        <ext:Panel runat="server" Layout="ColumnLayout">
                            <Items>
                                <ext:ComboBox runat="server" ID="cboSearchAlarmStandardType" FieldLabel="标准类型" LabelAlign="Right" ForceSelection="true">
                                    <Triggers>
                                        <ext:FieldTrigger Icon="Clear" Qtip="清空" />
                                    </Triggers>
                                    <Listeners>
                                        <TriggerClick Handler="this.setValue('');" />
                                    </Listeners>
                                </ext:ComboBox>
                                <ext:ComboBox runat="server" ID="cboSearchMinorTypeId" FieldLabel="硫化机类型" LabelAlign="Right" ForceSelection="true">
                                    <Triggers>
                                        <ext:FieldTrigger Icon="Clear" Qtip="清空" />
                                    </Triggers>
                                    <Listeners>
                                        <TriggerClick Handler="this.setValue('');" />
                                    </Listeners>
                                </ext:ComboBox>
                                <ext:ComboBox runat="server" ID="cboSearchAlarmSubmitState" LabelAlign="Right" FieldLabel="提交状态" Editable="false">
                                    <Triggers>
                                        <ext:FieldTrigger Icon="Clear" Qtip="清空" />
                                    </Triggers>
                                    <Listeners>
                                        <TriggerClick Handler="this.setValue('');" />
                                    </Listeners>
                                </ext:ComboBox>
                                <ext:ComboBox runat="server" ID="cboSearchAlarmAuditState" LabelAlign="Right" FieldLabel="审核状态" Editable="false">
                                    <Triggers>
                                        <ext:FieldTrigger Icon="Clear" Qtip="清空" />
                                    </Triggers>
                                    <Listeners>
                                        <TriggerClick Handler="this.setValue('');" />
                                    </Listeners>
                                </ext:ComboBox>
                                <ext:ComboBox runat="server" ID="cboSearchAlarmSendState" LabelAlign="Right" FieldLabel="下发状态" Editable="false">
                                    <Triggers>
                                        <ext:FieldTrigger Icon="Clear" Qtip="清空" />
                                    </Triggers>
                                    <Listeners>
                                        <TriggerClick Handler="this.setValue('');" />
                                    </Listeners>
                                </ext:ComboBox>
                                <ext:ComboBox runat="server" ID="cboSearchUsedFlag" LabelAlign="Right" FieldLabel="使用状态" Editable="false">
                                    <Items>
                                        <ext:ListItem Value="1" Text="使用" />
                                        <ext:ListItem Value="2" Text="停用" />
                                    </Items>
                                    <Triggers>
                                        <ext:FieldTrigger Icon="Clear" Qtip="清空" />
                                    </Triggers>
                                    <Listeners>
                                        <TriggerClick Handler="this.setValue('');" />
                                    </Listeners>
                                </ext:ComboBox>
                                <ext:ComboBox runat="server" ID="cboSearchAlarmState" LabelAlign="Right" FieldLabel="状态" Editable="false">
                                    <Triggers>
                                        <ext:FieldTrigger Icon="Clear" Qtip="清空" />
                                    </Triggers>
                                    <Listeners>
                                        <TriggerClick Handler="this.setValue('');" />
                                    </Listeners>
                                </ext:ComboBox>
                            </Items>
                        </ext:Panel>
                    </Items>
                </ext:Panel>
                <%--硫化工艺列表--%>
                <ext:Panel runat="server" Region="Center" Layout="FitLayout">
                    <Items>
                        <ext:GridPanel runat="server" ID="gridPanelMain">
                            <Store>
                                <ext:Store runat="server" ID="gridPanelMainStore" AutoLoad="false">
                                    <Proxy>
                                        <ext:PageProxy DirectFn="App.direct.GridPanelBindData" />
                                    </Proxy>
                                    <Model>
                                        <ext:Model runat="server" ID="gridPanelMainModel">
                                            <Fields>
                                                <ext:ModelField Name="OBJID" />
                                                <ext:ModelField Name="ALARM_STANDARD_TYPE_CAPTION" />
                                                <ext:ModelField Name="MAJOR_TYPE_ID" />
                                                <ext:ModelField Name="MAJOR_TYPE_NAME" />
                                                <ext:ModelField Name="MINOR_TYPE_ID" />
                                                <ext:ModelField Name="MINOR_TYPE_NAME" />
                                                <ext:ModelField Name="STATE" />
                                                <ext:ModelField Name="STATE_CAPTION" />
                                                <ext:ModelField Name="SUBMIT_STATE" />
                                                <ext:ModelField Name="SUBMIT_STATE_CAPTION" />
                                                <ext:ModelField Name="AUDIT_FLAG" />
                                                <ext:ModelField Name="AUDIT_STATE_CAPTION" />
                                                <ext:ModelField Name="SEND_FLAG" />
                                                <ext:ModelField Name="SEND_STATE_CAPTION" />
                                                <ext:ModelField Name="VERSION" />
                                                <ext:ModelField Name="RECORD_USER_NAME" />
                                                <ext:ModelField Name="RECORD_TIME" Type="Date" />
                                                <ext:ModelField Name="USED_FLAG" />
                                                <ext:ModelField Name="SELECT_AUDIT_USER_NAME" />
                                                <ext:ModelField Name="REMARK" />
                                            </Fields>
                                        </ext:Model>
                                    </Model>
                                </ext:Store>
                            </Store>
                            <ColumnModel>
                                <Columns>
                                    <ext:CommandColumn runat="server" Width="380" Text="操作" Align="Center" Hidden="true">
                                        <Commands>
                                            <ext:GridCommand Icon="TableCell" CommandName="View" Text="查看">
                                                <ToolTip Text="查看本条数据" />
                                            </ext:GridCommand>
                                            <ext:CommandSeparator />
                                            <ext:GridCommand Icon="TableGo" CommandName="Submit" Text="提交">
                                                <ToolTip Text="提交本条数据" />
                                            </ext:GridCommand>
                                            <ext:CommandSeparator />
                                            <ext:GridCommand Icon="TableEdit" CommandName="Edit" Text="修改">
                                                <ToolTip Text="修改本条数据" />
                                            </ext:GridCommand>
                                            <ext:CommandSeparator />
                                            <ext:GridCommand Icon="Delete" CommandName="Delete" Text="删除">
                                                <ToolTip Text="删除本条数据" />
                                            </ext:GridCommand>
                                            <ext:CommandSeparator />
                                            <ext:GridCommand Icon="PageAttach" CommandName="Audit" Text="审核">
                                                <ToolTip Text="审核本条数据" />
                                            </ext:GridCommand>
                                            <ext:CommandSeparator />
                                            <ext:GridCommand Icon="PageCopy" CommandName="Send" Text="下发">
                                                <ToolTip Text="下发本条数据" />
                                            </ext:GridCommand>
                                            <ext:CommandSeparator />
                                        </Commands>
                                        <Listeners>
                                            <Command Handler="return commandcolumn_click(command, record);" />
                                        </Listeners>
                                    </ext:CommandColumn>
                                    <ext:RowNumbererColumn />
                                    <ext:Column DataIndex="STATE_CAPTION" Text="状态" Width="60" />
                                    <ext:Column DataIndex="SUBMIT_STATE_CAPTION" Text="提交状态" Width="60" />
                                    <ext:Column DataIndex="AUDIT_STATE_CAPTION" Text="审核状态" Width="60" />
                                    <ext:Column DataIndex="SEND_STATE_CAPTION" Text="下发状态" Width="60" />
                                    <ext:Column DataIndex="USED_FLAG" Text="使用状态" Width="60">
                                        <Renderer Handler="if (value == null || value == '' || value == '0') { return ''; } else if (value == 1) { return '使用'; } else if (value == 2) { return '停用'; }" />
                                    </ext:Column>
                                    <ext:Column DataIndex="ALARM_STANDARD_TYPE_CAPTION" Text="标准类型" Width="60" />
                                    <ext:Column DataIndex="MINOR_TYPE_NAME" Text="硫化机类型" Width="80" />
                                    <ext:Column DataIndex="VERSION" Text="版本号" Width="60" />
                                    <ext:Column DataIndex="REMARK" Text="备注" Width="120" />
                                    <ext:Column DataIndex="SELECT_AUDIT_USER_NAME" Text="选择的审核人" />
                                    <ext:Column DataIndex="RECORD_USER_NAME" Text="录入人" Width="60" />
                                    <ext:DateColumn DataIndex="RECORD_TIME" Text="录入时间" Format="yyyy-MM-dd HH:mm:ss" Width="120" />
                                </Columns>
                            </ColumnModel>
                            <SelectionModel>
                                <ext:CheckboxSelectionModel runat="server" ID="gridPanelMainCheckboxSelectionModel" Mode="Single" AllowDeselect="true" ShowHeaderCheckbox="false" />
                            </SelectionModel>
                            <View>
                                <ext:GridView runat="server" ID="gridPanelMainView">
                                    <GetRowClass Handler="return gridPanelMainView_GetRowClass(record,index,rowParams,store);" />
                                </ext:GridView>
                            </View>
                            <BottomBar>
                                <ext:PagingToolbar ID="gridPanelMainPagingToolbar" runat="server">
                                    <Items>
                                    </Items>
                                </ext:PagingToolbar>
                            </BottomBar>
                        </ext:GridPanel>
                    </Items>
                </ext:Panel>
                <%--添加/修改报警标准--%>
                <ext:Window runat="server" ID="winMain" Height="450" Width="700" Layout="FitLayout" Hidden="true" Modal="true">
                    <Buttons>
                        <ext:Button ID="btnMainSave" runat="server" Icon="Accept" Text="确定">
                            <DirectEvents>
                                <Click OnEvent="btnMainSave_Click" />
                            </DirectEvents>
                        </ext:Button>
                        <ext:Button ID="btnMainAuditAcept" runat="server" Icon="Accept" Text="审核通过">
                            <DirectEvents>
                                <Click OnEvent="btnMainAuditAcept_Click">
                                    <Confirmation ConfirmRequest="true" Title="提示" Message="确定要将该条数据审核通过吗" />
                                </Click>
                            </DirectEvents>
                        </ext:Button>
                        <ext:Button ID="btnMainAuditReject" runat="server" Icon="Accept" Text="退回修改">
                            <DirectEvents>
                                <Click OnEvent="btnMainAuditReject_Click">
                                    <Confirmation ConfirmRequest="true" Title="提示" Message="确定要将该条数据退回修改吗" />

                                </Click>
                            </DirectEvents>
                        </ext:Button>
                        <ext:Button runat="server" Icon="Cancel" Text="取消">
                            <%--<Listeners>
                                <Click Handler="#{winMain}.close();" />
                            </Listeners>--%>
                            <DirectEvents>
                                <Click OnEvent="btnMainCancel_Click" />
                            </DirectEvents>
                        </ext:Button>
                    </Buttons>
                    <Items>
                        <ext:TabPanel runat="server" ID="tabPanelMain">
                            <Items>
                                <%--基本信息--%>
                                <ext:Panel runat="server" Title="基本信息" ActiveIndex="1" TabIndex="1" Layout="FitLayout">
                                    <Items>
                                        <ext:Panel runat="server" Layout="ColumnLayout">
                                            <Items>
                                                <ext:Hidden runat="server" ID="hdnMainObjId" />
                                                <ext:Hidden runat="server" ID="hdnMainGuid" />
                                                <ext:Hidden runat="server" ID="hdnMainRefreshDetailFlag" />
                                                <ext:Hidden runat="server" ID="hdnMainRefreshDegradeFlag" />
                                                <ext:Hidden runat="server" ID="hdnMainCopyFlag" />
                                                <ext:ComboBox runat="server" ID="cboMainAlarmStandardType" LabelAlign="Right" FieldLabel="标准类型" ColumnWidth="0.5" Padding="2" Editable="false">
                                                </ext:ComboBox>
                                                <ext:ComboBox runat="server" ID="cboMainMajorTypeId" LabelAlign="Right" FieldLabel="设备大类" ColumnWidth="0.5" Padding="2" Editable="false" Hidden="true">
                                                </ext:ComboBox>
                                                <ext:ComboBox runat="server" ID="cboMainMinorTypeId" LabelAlign="Right" FieldLabel="硫化机类型" ColumnWidth="0.5" Padding="2" Editable="false">
                                                    <Listeners>
                                                        <Change Fn="cboMainMinorTypeId_Change" />
                                                    </Listeners>
                                                </ext:ComboBox>
                                                <ext:ComboBox runat="server" ID="cboMainFactoryId" LabelAlign="Right" FieldLabel="所属工厂" Editable="false" ColumnWidth="0.5">
                                                </ext:ComboBox>
                                                <ext:TextField runat="server" ID="txtMainRemark" LabelAlign="Right" FieldLabel="备注" ColumnWidth="1" MaxLength="100">
                                                </ext:TextField>
                                            </Items>
                                        </ext:Panel>
                                    </Items>
                                </ext:Panel>
                                <%--硫化报警时间--%>
                                <ext:Panel runat="server" Title="硫化报警时间" ActiveIndex="2" TabIndex="2" Layout="FitLayout">
                                    <Items>
                                        <ext:GridPanel runat="server" ID="gridPanelDetail" AutoScroll="true">
                                            <TopBar>
                                                <ext:Toolbar runat="server">
                                                    <Items>
                                                        <ext:Button runat="server" ID="btnDetailAdd" Text="添加明细" Icon="TableAdd">
                                                            <DirectEvents>
                                                                <Click OnEvent="btnDetailAdd_Click" />
                                                            </DirectEvents>
                                                        </ext:Button>
                                                        <ext:Button runat="server" ID="btnDetailEdit" Text="修改明细" Icon="TableEdit">
                                                            <Listeners>
                                                                <Click Handler="return btnDetailEdit_Click();" />
                                                            </Listeners>
                                                        </ext:Button>
                                                        <ext:Button runat="server" ID="btnDetailDelete" Text="删除明细" Icon="TableDelete">
                                                            <Listeners>
                                                                <Click Handler="return btnDetailDelete_Click();" />
                                                            </Listeners>
                                                        </ext:Button>
                                                    </Items>
                                                </ext:Toolbar>
                                            </TopBar>
                                            <Store>
                                                <ext:Store runat="server" ID="gridPanelDetailStore" PageSize="0" AutoLoad="false">
                                                    <Proxy>
                                                        <ext:PageProxy DirectFn="App.direct.GridPanelDetailBindData" AutoDataBind="true" />

                                                    </Proxy>
                                                    <Model>
                                                        <ext:Model runat="server" ID="gridPanelDetailModel" IDProperty="OBJID">
                                                            <Fields>
                                                                <ext:ModelField Name="OBJID" />
                                                                <ext:ModelField Name="STANDARD_ID" />
                                                                <ext:ModelField Name="ALARM_ITEM_NO" />
                                                                <ext:ModelField Name="ALARM_ITEM_NAME" />
                                                                <ext:ModelField Name="ALARM_STEP" />
                                                                <ext:ModelField Name="ALARM_DELAY" />
                                                                <ext:ModelField Name="ALARM_REMAIN" />
                                                                <ext:ModelField Name="ALARM_MAX" />
                                                                <ext:ModelField Name="ALARM_MIN" />
                                                                <ext:ModelField Name="ALARM_SET" />
                                                            </Fields>
                                                        </ext:Model>
                                                    </Model>
                                                </ext:Store>
                                            </Store>
                                            <SelectionModel>
                                                <ext:CheckboxSelectionModel runat="server" ID="gridPanelDetailCheckboxSelectionModel" Mode="Single" ShowHeaderCheckbox="false" AllowDeselect="true">
                                                </ext:CheckboxSelectionModel>
                                            </SelectionModel>
                                            <ColumnModel>
                                                <Columns>
                                                    <ext:CommandColumn ID="commandColumnDetail" runat="server" Width="120" Text="操作" Align="Center" Hidden="true">
                                                        <Commands>
                                                            <ext:GridCommand Icon="TableEdit" CommandName="Edit" Text="修改">
                                                                <ToolTip Text="修改本条数据" />
                                                            </ext:GridCommand>
                                                            <ext:CommandSeparator />
                                                            <ext:GridCommand Icon="Delete" CommandName="Delete" Text="删除">
                                                                <ToolTip Text="删除本条数据" />
                                                            </ext:GridCommand>
                                                            <ext:CommandSeparator />
                                                        </Commands>
                                                        <Listeners>
                                                            <Command Handler="return detailcommandcolumn_click(command, record);" />
                                                        </Listeners>
                                                    </ext:CommandColumn>
                                                    <ext:Column DataIndex="ALARM_ITEM_NAME" Text="报警项" Align="Center"></ext:Column>
                                                    <ext:Column DataIndex="ALARM_STEP" Text="步序" Align="Center" Width="40">
                                                    </ext:Column>
                                                    <ext:Column DataIndex="ALARM_DELAY" Text="开始时间" Align="Center" ></ext:Column>
                                                    <ext:Column DataIndex="ALARM_REMAIN" Text="持续时间" Align="Center"></ext:Column>
                                                    <ext:Column DataIndex="ALARM_MAX" Text="最大值" Align="Center"></ext:Column>
                                                    <ext:Column DataIndex="ALARM_MIN" Text="最小值" Align="Center"></ext:Column>
                                                    <ext:Column DataIndex="ALARM_SET" Text="设定值" Align="Center"></ext:Column>
                                                </Columns>
                                            </ColumnModel>
                                            <BottomBar>
                                                <ext:PagingToolbar ID="gridPanelDetailPagingToolbar" runat="server">
                                                    <Items>
                                                    </Items>
                                                </ext:PagingToolbar>
                                            </BottomBar>
                                        </ext:GridPanel>
                                    </Items>
                                </ext:Panel>
                                <%--硫化判级标准--%>
                                <ext:Panel runat="server" Title="硫化判级标准" ActiveIndex="3" TabIndex="3" Layout="FitLayout">
                                    <Items>
                                        <ext:GridPanel runat="server" ID="gridPanel1" AutoScroll="true">
                                            <TopBar>
                                                  <ext:Toolbar runat="server">
                                                    <Items>
                                                        <ext:Button runat="server" ID="btnDegradeAdd" Text="添加明细" Icon="TableAdd">
                                                            <DirectEvents>
                                                                <Click OnEvent="btnDagradeAdd_Click" />
                                                            </DirectEvents>
                                                        </ext:Button>
                                                         <ext:Button runat="server" ID="btnDegradeEdit" Text="修改明细" Icon="TableEdit">
                                                            <Listeners>
                                                                <Click Handler="return btnDegradeEdit_Click();" />
                                                            </Listeners>
                                                        </ext:Button>
                                                        <ext:Button runat="server" ID="btnDegradeDel" Text="删除明细" Icon="TableDelete">
                                                            <Listeners>
                                                                <Click Handler="return btnDegradeDelete_Click();" />
                                                            </Listeners>
                                                        </ext:Button>
                                                    </Items>
                                                </ext:Toolbar>
                                            </TopBar>
                                             <Store>
                                                <ext:Store runat="server" ID="gridPanelDegradeStore" PageSize="0" AutoLoad="false">
                                                    <Proxy>
                                                        <ext:PageProxy DirectFn="App.direct.GridPanelDegradeBindData" AutoDataBind="true" />
                                                    </Proxy>
                                                    <Model>
                                                        <ext:Model runat="server" ID="gridPanelDegradeModel" IDProperty="OBJID">
                                                            <Fields>
                                                                <ext:ModelField Name="OBJID" />
                                                                <ext:ModelField Name="ALARM_STANDARD_ID" />
                                                                <ext:ModelField Name="ALARM_ITEM_NO" />
                                                                <ext:ModelField Name="ALARM_ITEM_NAME" />
                                                                <ext:ModelField Name="ALARM_STEP" />
                                                                <ext:ModelField Name="SET_MIN_VALUE" />
                                                                <ext:ModelField Name="SET_MAX_VALUE" />
                                                                <ext:ModelField Name="INCLUDE_MAX_VALUE" />
                                                                <ext:ModelField Name="INCLUDE_MIN_VALUE" />
                                                                <ext:ModelField Name="SET_GRADE_REMAIN" />
                                                                <ext:ModelField Name="SET_GRADE_VALUE" />
                                                                <ext:ModelField Name="GRADENAME" />
                                                            </Fields>
                                                        </ext:Model>
                                                    </Model>
                                                </ext:Store>
                                            </Store>
                                             <SelectionModel>
                                                <ext:CheckboxSelectionModel runat="server" ID="gridPanelDegradeCheckboxSelectionModel" Mode="Single" ShowHeaderCheckbox="false" AllowDeselect="true">
                                                </ext:CheckboxSelectionModel>
                                            </SelectionModel>
                                             <ColumnModel>
                                                <Columns>
                                                    <ext:CommandColumn ID="commandColumnDegrade" runat="server" Width="120" Text="操作" Align="Center" Hidden="true">
                                                        <Commands>
                                                            <ext:GridCommand Icon="TableEdit" CommandName="Edit" Text="修改">
                                                                <ToolTip Text="修改本条数据" />
                                                            </ext:GridCommand>
                                                            <ext:CommandSeparator />
                                                            <ext:GridCommand Icon="Delete" CommandName="Delete" Text="删除">
                                                                <ToolTip Text="删除本条数据" />
                                                            </ext:GridCommand>
                                                            <ext:CommandSeparator />
                                                        </Commands>
                                                        <Listeners>
                                                            <Command Handler="return degradecommandcolumn_click(command, record);" />
                                                        </Listeners>
                                                    </ext:CommandColumn>
                                                    <ext:Column DataIndex="ALARM_ITEM_NAME" Text="报警项" Align="Center"></ext:Column>
                                                    <ext:Column DataIndex="ALARM_STEP" Text="步序" Align="Center" Width="40">
                                                    </ext:Column>
                                                    <ext:Column DataIndex="SET_GRADE_REMAIN" Text="持续时间" Align="Center"></ext:Column>
                                                    <ext:Column DataIndex="SET_MAX_VALUE" Text="最大值" Align="Center" Width="50"></ext:Column>
                                                    <ext:Column DataIndex="SET_MIN_VALUE" Text="最小值" Align="Center" Width="50"></ext:Column>
                                                    <ext:Column DataIndex="INCLUDE_MAX_VALUE" Text="包含最大值" Align="Center" Width="90"></ext:Column>
                                                    <ext:Column DataIndex="INCLUDE_MIN_VALUE" Text="包含最小值" Align="Center" Width="90"></ext:Column>
                                                    <ext:Column DataIndex="GRADENAME" Text="判级" Align="Center"></ext:Column>
                                                </Columns>
                                            </ColumnModel>
                                            <BottomBar>
                                                <ext:PagingToolbar ID="gridPanelDegradePagingToolbar" runat="server">
                                                    <Items>
                                                    </Items>
                                                </ext:PagingToolbar>
                                            </BottomBar>
                                        </ext:GridPanel>
                                    </Items>
                                </ext:Panel>
                                <%--审核信息--%>
                                <ext:Panel runat="server" Title="审核信息" ActiveIndex="99" TabIndex="99" Layout="FitLayout">
                                    <Items>
                                        <ext:Panel runat="server" Layout="FormLayout">
                                            <Items>
                                                <ext:Hidden runat="server" ID="hdnMainAuditSelects" />
                                                <ext:Hidden runat="server" ID="hdnMainAuditSelectNames" />
                                                <ext:CheckboxGroup runat="server" ID="cbgMainAuditUser" LabelAlign="Right" FieldLabel="选择审核人员" Layout="ColumnLayout">
                                                    <Listeners>
                                                        <Change Handler="return cbgMainAuditUser_Change(item);" />
                                                    </Listeners>
                                                </ext:CheckboxGroup>
                                                <ext:TextField runat="server" ID="txtMainLastAuditUserName" LabelAlign="Right" FieldLabel="上次审核人">
                                                </ext:TextField>
                                                <ext:TextField runat="server" ID="txtMainLastAuditTime" LabelAlign="Right" FieldLabel="上次审核时间">
                                                </ext:TextField>
                                                <ext:TextArea runat="server" ID="txtMainLastAuditRemark" LabelAlign="Right" FieldLabel="上次审核意见">
                                                </ext:TextArea>
                                                <ext:TextArea runat="server" ID="txtMainAuditRemark" LabelAlign="Right" FieldLabel="本次审核意见">
                                                </ext:TextArea>
                                            </Items>
                                        </ext:Panel>
                                    </Items>
                                </ext:Panel>
                            </Items>
                            <Listeners>
                                <TabChange Handler="return tabPanelMain_Click(newTab);" />
                            </Listeners>
                        </ext:TabPanel>
                    </Items>
                </ext:Window>
                <%--添加/修改报警设置--%>
                <ext:Window runat="server" ID="winDetail" Height="300" Width="350" Layout="FormLayout" Hidden="true" Modal="true">
                    <Items>
                        <ext:Panel runat="server" Layout="FormLayout">
                            <Items>
                                <ext:Hidden runat="server" ID="hdnDetailObjId" />
                                <ext:Hidden runat="server" ID="hdnDetailGuid" />
                                <ext:Hidden runat="server" ID="hdnDetailStandardId" />
                                <ext:ComboBox runat="server" ID="cboDetailAlarmItemNo" FieldLabel="硫化报警项" LabelAlign="Right" Editable="false"></ext:ComboBox>
                                <ext:NumberField runat="server" ID="numDetailAlarmStep" FieldLabel="硫化步序" LabelAlign="Right"></ext:NumberField>
                                <ext:NumberField runat="server" ID="numDetailAlarmDelay" FieldLabel="开始时间" LabelAlign="Right"></ext:NumberField>
                                <ext:NumberField runat="server" ID="numDetailAlarmRemain" FieldLabel="持续时间" LabelAlign="Right"></ext:NumberField>
                                <ext:NumberField runat="server" ID="numDetailAlarmMax" FieldLabel="最大值" LabelAlign="Right"></ext:NumberField>
                                <ext:NumberField runat="server" ID="numDetailAlarmMin" FieldLabel="最小值" LabelAlign="Right"></ext:NumberField>
                                <ext:NumberField runat="server" ID="numDetailAlarmSet" FieldLabel="设定值" LabelAlign="Right"></ext:NumberField>
                            </Items>
                        </ext:Panel>
                    </Items>
                    <Buttons>
                        <ext:Button runat="server" ID="btnDetailSave" Icon="Accept" Text="确定">
                            <DirectEvents>
                                <Click OnEvent="btnDetailSave_Click" />
                            </DirectEvents>
                        </ext:Button>
                        <ext:Button runat="server" ID="btnDetailCancel" Icon="Cancel" Text="取消">
                            <Listeners>
                                <Click Handler="#{winDetail}.close();" />
                            </Listeners>
                        </ext:Button>
                    </Buttons>
                </ext:Window>
                 <%--添加/修改判级--%>
                <ext:Window runat="server" ID="winDegrade" Height="300" Width="350" Layout="FormLayout" Hidden="true" Modal="true">
                      <Items>
                        <ext:Panel runat="server" Layout="FormLayout">
                            <Items>
                                <ext:Hidden runat="server" ID="hdnDegradeObjId" />
                                <ext:Hidden runat="server" ID="hdnDegradeGuid" />
                                <ext:Hidden runat="server" ID="hdnDegradeStandardId" />
                                <ext:ComboBox runat="server" ID="cboDegradeAlarmItemNo" FieldLabel="硫化报警项" LabelAlign="Right" Editable="false"></ext:ComboBox>
                                <ext:NumberField runat="server" ID="numDegradeAlarmStep" FieldLabel="硫化步序" LabelAlign="Right"></ext:NumberField>
                                <ext:NumberField runat="server" ID="numDegradeAlarmRemain" FieldLabel="持续时间" LabelAlign="Right"></ext:NumberField>
                                <ext:NumberField runat="server" ID="numDegradeAlarmMax" FieldLabel="最大值" LabelAlign="Right"></ext:NumberField>
                                <ext:NumberField runat="server" ID="numDegradeAlarmMin" FieldLabel="最小值" LabelAlign="Right"></ext:NumberField>
                                <ext:Checkbox runat="server" ID="cheIncludeMax" FieldLabel="包含最大值" LabelAlign="Right"></ext:Checkbox>
                                <ext:Checkbox runat="server" ID="cheIncludeMin" FieldLabel="包含最小值" LabelAlign="Right"></ext:Checkbox>
                                <ext:ComboBox runat="server" ID="cboDegradeItem" FieldLabel="判级" LabelAlign="Right" Editable="false"></ext:ComboBox>
                            </Items>
                        </ext:Panel>
                    </Items>
                    <Buttons>
                        <ext:Button runat="server" ID="btnDegradeSave" Icon="Accept" Text="确定">
                            <DirectEvents>
                                <Click OnEvent="btnDegradeSave_Click" />
                            </DirectEvents>
                        </ext:Button>
                        <ext:Button runat="server" ID="btnDegradeCancel" Icon="Cancel" Text="取消">
                            <Listeners>
                                <Click Handler="#{winDegrade}.close();" />
                            </Listeners>
                        </ext:Button>
                    </Buttons>
                </ext:Window>
            </Items>
        </ext:Viewport>
    </form>
</body>
</html>
