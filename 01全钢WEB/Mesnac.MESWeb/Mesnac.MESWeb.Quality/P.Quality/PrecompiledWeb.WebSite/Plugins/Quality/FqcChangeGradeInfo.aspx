<%@ page language="C#" autoeventwireup="true" inherits="Plugins_Quality_FqcChangeGradeInfo, Mesnac.Quality.WebSite" %>
<%@ Register Assembly="Ext.Net" Namespace="Ext.Net" TagPrefix="ext" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link rel="Stylesheet" type="text/css" href="<%= Page.ResolveUrl("~/") %>resources/css/ext-chinese-font.css" />
    <link rel="Stylesheet" type="text/css" href="<%= Page.ResolveUrl("~/") %>resources/css/main.css" />
    <style type="text/css">
        .x-grid-row-collapsed .x-grid-cell
        {
        	background-color: #B0FFBA !important;
        }
    </style>
    <script type="text/javascript">
        var SetRowClass = function (record, rowIndex, rowParams, store) {
            if (record.get("GRADEID") == "3") {
                return "x-grid-row-collapsed";
            }
        }
        //点击修改按钮
        var commandcolumn_direct_edit = function (record) {
            var ObjID = record.data.OBJID;
            App.direct.commandcolumndetail_direct_edit(ObjID, {
                success: function (result) {
                    //App.store.remove(record);
                },

                failure: function (errorMsg) {
                    Ext.Msg.alert('操作', errorMsg);
                }
            });
        }

        //点击删除按钮
        var commandcolumn_direct_delete = function (btn, record) {
            if (btn != "yes") {
                return;
            }
            var BillNo = record.data.BillNo;
            App.direct.commandcolumn_direct_delete(BillNo, {
                success: function (result) {
                    Ext.Msg.alert('操作', result);
                },

                failure: function (errorMsg) {
                    Ext.Msg.alert('操作', errorMsg);
                }
            });
        }

        //根据按钮类别进行删除和编辑操作
        var commandcolumn_click = function (command, record) {
            commandcolumn_click_confirm(command, record);
            return false;
        };

        //区分删除操作，并进行二次确认操作
        var commandcolumn_click_confirm = function (command, record) {
            if (command.toLowerCase() == "edit") {
                commandcolumn_direct_edit(record);
            }
            if (command.toLowerCase() == "delete") {
                Ext.Msg.confirm("提示", '您确定要删除此条信息吗？', function (btn) { commandcolumn_direct_delete(btn, record) });
            }
            return false;
        };

        var commandcolumndetail_click_confirm = function (command, record) {
            if (command.toLowerCase() == "edit") {
                commandcolumndetail_direct_edit(record);
            }
            if (command.toLowerCase() == "delete") {
                Ext.Msg.confirm("提示", '您确定要删除此条信息吗？', function (btn) { commandcolumndetail_direct_delete(btn, record) });
            }
        }

        Ext.apply(Ext.form.VTypes, {
            integer: function (val, field) {
                if (!val) {
                    return true;
                }
                try {
                    if (/^[\d]+$/.test(val)) {
                        return true;
                    }
                    else {
                        return false;
                    }
                }
                catch (e) {
                    return false;
                }
            },
            integerText: "此填入项格式为正整数"
        });

        var pnlListFresh = function () {
            if (App.txtBeginTime.getValue() > App.txtEndTime.getValue()) {
                Ext.Msg.alert('操作', '开始时间不能大于结束时间！');
                return false;
            }
            App.store.currentPage = 1;
            App.pageToolBar.doRefresh();
            return false;
        }

        var prepareToolbar = function (grid, toolbar, rowIndex, record) {
            if (record.get("FiledFlag") == "1") {
                toolbar.items.getAt(0).hide();
                toolbar.items.getAt(1).hide();
            }
            else if (record.get("LockedFlag") == "1") {
                toolbar.items.getAt(0).hide();
                toolbar.items.getAt(1).hide();
            }
        };

        var startTrack = function () {
            this.checkboxes = [];
            var cb;

            Ext.select(".x-form-item", false).each(function (checkEl) {
                cb = Ext.getCmp(checkEl.dom.id.selected);
                cb.setValue(false);
                this.rowselect.push(cb);
            }, this);
        };
        
        var McUI_SearchBox_SearchBoxSsbUser_Request = function (record) {//用户返回值处理
            if (!App.winModify.hidden) {
                App.txtRecordUser1.setValue(record.data.USER_NAME);
                App.hiddenEditUserID.setValue(record.data.OBJID);
            }
            else {
                App.txtRecordUser.getTrigger(0).show();
                App.txtRecordUser.setValue(record.data.USER_NAME);
                App.hiddenMakerPerson.setValue(record.data.OBJID);
            }
        }

        var QueryUser = function (field, trigger, index) {//人员查询
            switch (index) {
                case 0:
                    field.getTrigger(0).hide();
                    field.setValue('');
                    App.hiddenMakerPerson.setValue("");
                    field.getEl().down('input.x-form-text').setStyle('background', "white");
                    break;
                case 1:
                    App.McUI_SearchBox_SearchBoxSsbUser_Window.show();
                    break;
            }
        }

        Ext.create("Ext.window.Window", {//病疵带窗体
            id: "McUI_SearchBox_CrudFqdDefectInfo_Window",
            height: 460,
            hidden: true,
            width: 360,
            html: "<iframe src='../../../McUI/SearchBox/CrudFqdDefectInfo.aspx' width=100% height=100% scrolling=no  frameborder=0></iframe>",
            bodyStyle: "background-color: #fff;",
            closable: true,
            title: "请选择病疵",
            modal: true
        })

        Ext.create("Ext.window.Window", {//厂家带窗体
            id: "",
            height: 460,
            hidden: true,
            width: 360,
            html: "<iframe src='../../../McUI/SearchBox/SearchBoxCbeCuringEquip.aspx' width=100% height=100% scrolling=no  frameborder=0></iframe>",
            bodyStyle: "background-color: #fff;",
            closable: true,
            title: "请选择厂家名称",
            modal: true
        })
        
        Ext.create("Ext.window.Window", {//人员信息带回查询信息
            id: "McUI_SearchBox_SearchBoxSsbUser_Window",
            height: 460,
            hidden: true,
            width: 360,
            html: "<iframe src='../../../McUI/SearchBox/SearchBoxSsbUser.aspx' width=100% height=100% scrolling=no frameborder=0></iframe>",
            bodyStyle: "background-color: #fff;",
            closable: true,
            title: "请选择人员",
            modal: true
        })

        //点击取消作废按钮
        var commandcolumn_direct_usedflag = function (btn) {
            if (btn != "yes") {
                return;
            }
            App.direct.btnBatchUsing_Click({
                success: function (result) {
                    Ext.Msg.alert('操作', result);
                },

                failure: function (errorMsg) {
                    Ext.Msg.alert('操作', errorMsg);
                }
            });
        }

        var IsNewChange = function (value) {
            return Ext.String.format(value == "1" ? "是" : "否");
        };

    </script>
</head>
<body>
    <form id="form1" runat="server">
    <ext:ResourceManager ID="rmXcheckInfo" runat="server" />
    <ext:Viewport ID="vpXcheckInfo" runat="server" Layout="border">
        <Items>
            <ext:Panel ID="pnXcheckInfo" runat="server" Region="North" Height="90">
                <TopBar>
                    <ext:Toolbar runat="server" ID="tbXcheckInfo">
                        <Items>
                            <ext:Button runat="server" Icon="Find" Text="查询" ID="btnSearch">
                                <Listeners>
                                    <Click Fn="pnlListFresh" />
                                </Listeners>
                            </ext:Button>
                            <ext:ToolbarSeparator ID="tsEnd" />
                            <ext:ToolbarSpacer runat="server" ID="tspacerEnd" />
                            <ext:ToolbarFill ID="tfEnd" />
                        </Items>
                    </ext:Toolbar>
                </TopBar>
                <Items>
                    <ext:FormPanel ID="container_top" runat="server" Layout="ColumnLayout" AutoHeight="true">
                        <Items>
                            <ext:Container ID="container1" runat="server" Layout="FormLayout" ColumnWidth=".33"
                                Padding="5">
                                <Items>
                                     <ext:FieldContainer runat="server" FieldLabel="开始时间" Layout="HBoxLayout" LabelAlign="Right">
                                            <Items>
                                                <ext:DateField ID="txtBeginDate" runat="server" Flex="1" Editable="false" />
                                                <ext:TimeField ID="txtBeginTime" runat="server" width="80" Editable="true" />
                                            </Items>
                                      </ext:FieldContainer>
                                    <ext:TextField ID="txtTyreNo" runat="server" FieldLabel="硫化号" LabelAlign="Right" />
                                </Items>
                            </ext:Container>
                            <ext:Container ID="container2" runat="server" Layout="FormLayout" ColumnWidth=".33"
                                Padding="5">
                                <Items>
                                    <ext:FieldContainer runat="server" FieldLabel="结束时间" Layout="HBoxLayout" LabelAlign="Right">
                                            <Items>
                                                <ext:DateField ID="txtEndDate" runat="server" Flex="1" Editable="false" />
                                                <ext:TimeField ID="txtEndTime" runat="server" width="80" Editable="true" />
                                            </Items>
                                        </ext:FieldContainer>
                                   <ext:TextField ID="txtGreenTyreNo" runat="server" FieldLabel="胎胚号" LabelAlign="Right" />
                                </Items>
                            </ext:Container>
                            <ext:Container ID="container3" runat="server" Layout="FormLayout" ColumnWidth=".34"
                                Padding="5">
                                <Items>
                                    <ext:ComboBox ID="cbxGrade" runat="server" FieldLabel="等级" LabelAlign="Right" Editable="false"></ext:ComboBox>
                                    <ext:ComboBox ID="cbxEquip" runat="server" FieldLabel="质检机台" LabelAlign="Right" Editable="false"></ext:ComboBox>
                                  <%--  <ext:TriggerField ID="txtRecordUser" runat="server" FieldLabel="质检人员" LabelAlign="Right" Editable="false">
                                        <Triggers>
                                            <ext:FieldTrigger Icon="Clear" HideTrigger="true" />
                                            <ext:FieldTrigger Icon="Search" />
                                        </Triggers>
                                        <Listeners>
                                            <TriggerClick Fn="QueryUser" />
                                        </Listeners>
                                    </ext:TriggerField>--%>
                                </Items>
                            </ext:Container>
                        </Items>
                        <Listeners>
                            <ValidityChange Handler="#{btnSearch}.setDisabled(!valid);" />
                        </Listeners>
                    </ext:FormPanel>
                </Items>
            </ext:Panel>

                <ext:Panel ID="Panel2" runat="server" Region="Center" Frame="true" Layout="Fit" MarginsSummary="0 5 0 5">
                    <Items>
                        <ext:GridPanel ID="pnlList" runat="server">
                            <Store>
                                <ext:Store ID="store" runat="server" PageSize="10">
                                    <Proxy>
                                        <ext:PageProxy DirectFn="App.direct.GridPanelBindData" />
                                    </Proxy>
                                    <Model>
                                        <ext:Model ID="model" runat="server" IDProperty="OBJID">
                                            <Fields>
                                                <ext:ModelField Name="OBJID" />
                                                <ext:ModelField Name="TYRDID" />
                                                <ext:ModelField Name="GRADEID" />
                                                <ext:ModelField Name="GRADENAME" />
                                                <ext:ModelField Name="USER_NAME" />
                                                <ext:ModelField Name="RECORD_TIME" Type="Date" />
                                                <ext:ModelField Name="MATERIAL_NAME" />
                                                <ext:ModelField Name="SHIFT_ID" />
                                                <ext:ModelField Name="SHIFT_NAME" />
                                                <ext:ModelField Name="DEFECTID" />
                                                <ext:ModelField Name="DEFECTNAME" />
                                                <ext:ModelField Name="DEFECT_PART" />
                                                <ext:ModelField Name="UP_OR_DOWM" />
                                                <ext:ModelField Name="PROCEDURE_NAME" />
                                                <ext:ModelField Name="EQUIPCODE" />
                                                <ext:ModelField Name="EQUIP_NAME" />
                                                <ext:ModelField Name="TYRE_NO" />
                                                <ext:ModelField Name="REMARK" />
                                            </Fields>
                                        </ext:Model>
                                    </Model>
                                </ext:Store>
                            </Store>
                            <ColumnModel ID="colModel" runat="server">
                                <Columns>
                                    <ext:RowNumbererColumn ID="rowNumCol" runat="server" Width="35" />
                                    <ext:Column ID="TYRDID" runat="server" Text="硫化号" DataIndex="TYRE_NO" Flex="1" />
                                    <ext:Column ID="TYRE_NO" runat="server" Text="胎胚号" DataIndex="TYRDID" Flex="1" />
                                    <ext:Column ID="MATERIAL_NAME" runat="server" Text="物料名称" DataIndex="MATERIAL_NAME" Width="260" />
                                    <ext:Column ID="EQUIP_NAME" runat="server" Text="质检机台"  DataIndex="EQUIP_NAME" Width="60" />
                                    <ext:Column ID="GRADENAME" runat="server" Text="等级" DataIndex="GRADENAME" Flex="1" />
                                    <ext:Column ID="DEFECTNAME" runat="server" Text="病疵" DataIndex="DEFECTNAME" Width="160" />
                                    <ext:Column ID="DEFECT_PART" runat="server" Text="病疵位置" Hidden="true" DataIndex="DEFECT_PART" Flex="1" />
                                    <ext:Column ID="PROCEDURE_NAME" runat="server" Text="病疵工序" DataIndex="PROCEDURE_NAME" Flex="1" />
                                    <ext:Column ID="UP_OR_DOWM" runat="server" Text="上下模" DataIndex="UP_OR_DOWM" Flex="1" />
                                    <ext:Column ID="USER_NAME" runat="server" Text="质检人员" DataIndex="USER_NAME" Width="100" />
                                    <ext:DateColumn ID="RECORD_TIME" runat="server" Text="质检日期" DataIndex="RECORD_TIME"
                                        Width="180" Format="yyyy-MM-dd HH:mm:ss" />
                                    <ext:Column ID="SHIFT_NAME" runat="server" Text="质检班次" Hidden="true" DataIndex="SHIFT_NAME" Flex="1" />
                                    <ext:Column ID="REMARK" runat="server" Text="改判原因" DataIndex="REMARK" Flex="1" />
                                    <ext:CommandColumn ID="commandCol" runat="server" Width="120" Text="操作" Align="Center">
                                        <Commands>
                                            <ext:GridCommand Icon="TableEdit" CommandName="Edit" Text="修改" />
                                            
                                        </Commands>
                                        <PrepareToolbar Fn="prepareToolbar" />
                                        <Listeners>
                                            <Command Handler="return commandcolumn_click(command, record);" />
                                        </Listeners>
                                    </ext:CommandColumn>
                                </Columns>
                            </ColumnModel>
                            <SelectionModel>
                                <ext:RowSelectionModel ID="rowSelectMuti" runat="server" Mode="Single">
                                    <Listeners>
                                        <Select Handler="#{storeDetail}.reload();" Buffer="250" />
                                    </Listeners>
                                </ext:RowSelectionModel>
                            </SelectionModel>
                            <View>
                                <ext:GridView ID="gvRows" runat="server">
                                    <GetRowClass Fn="SetRowClass" />
                                </ext:GridView>
                            </View>
                            <BottomBar>
                                <ext:PagingToolbar ID="pageToolBar" runat="server">
                                    <Items>
                                        <ext:Label ID="Label2" runat="server" Text="每页条数:" Hidden="true"/>
                                        <ext:ToolbarSpacer ID="ToolbarSpacer2" runat="server" Width="10" />
                                        <ext:ComboBox ID="ComboBox2" runat="server" Width="80" Hidden="true">
                                            <Items>
                                                <ext:ListItem Text="10" />
                                                <ext:ListItem Text="50" />
                                                <ext:ListItem Text="100" />
                                                <ext:ListItem Text="200" />
                                            </Items>
                                            <SelectedItems>
                                                <ext:ListItem Value="10" />
                                            </SelectedItems>
                                            <Listeners>
                                                <Select Handler="#{pnlList}.store.pageSize = parseInt(this.getValue(), 10); #{pageToolBar}.doRefresh(); return false;" />
                                            </Listeners>
                                        </ext:ComboBox>
                                    </Items>
                                    <Plugins>
                                        <ext:ProgressBarPager ID="ProgressBarPager" runat="server" />
                                    </Plugins>
                                </ext:PagingToolbar>
                            </BottomBar>
                        </ext:GridPanel>
                    </Items>
                </ext:Panel>
            <ext:Window ID="winModify" runat="server" Icon="MonitorEdit" Closable="false" Title="修改质检信息"
                Width="320" Height="380" Resizable="false" Hidden="true" Modal="false" BodyStyle="background-color:#fff;"
                BodyPadding="5" Layout="Form">
                <Items>
                    <ext:FormPanel ID="pnlEdit" runat="server" Flex="1" BodyPadding="5">
                        <FieldDefaults>
                            <CustomConfig>
                                <ext:ConfigItem Name="LabelWidth" Value="80" Mode="Raw" />
                                <ext:ConfigItem Name="PreserveIndicatorIcon" Value="true" Mode="Raw" />
                            </CustomConfig>
                        </FieldDefaults>
                        <Items>
                            <ext:TextField ID="txtObjID1" runat="server" FieldLabel="OBJID" LabelAlign="Right" Hidden="true" />
                            <ext:TextField ID="txtTyreID1" runat="server" FieldLabel="胎胚号" LabelAlign="Right" ReadOnly="true" />
                            <ext:TextField ID="txtTyreID2" runat="server" FieldLabel="硫化号" LabelAlign="Right" ReadOnly="true" />
                            <ext:ComboBox ID="cbxGradeID" runat="server" FieldLabel="等级" LabelAlign="Right" Editable="true">
                                <DirectEvents>
                                    <Select OnEvent="SelectedChange_Event"></Select>
                                </DirectEvents>
                            </ext:ComboBox>
                            <ext:ComboBox ID="cbxReason" runat="server" FieldLabel="改判原因" LabelAlign="Right" Editable="false"></ext:ComboBox>
                            <ext:ComboBox ID="cbxDefect" runat="server" FieldLabel="病疵" LabelAlign="Right" Editable="false"></ext:ComboBox>
                        </Items>
                        <Listeners>
                            <ValidityChange Handler="#{btnModify}.setDisabled(!valid);" />
                        </Listeners>
                    </ext:FormPanel>
                </Items>
                <Buttons>
                    <ext:Button ID="btnModify" runat="server" Text="确定" Icon="Accept">
                        <DirectEvents>
                            <Click OnEvent="btnModify_Click" />
                        </DirectEvents>
                    </ext:Button>
                    <ext:Button ID="btnModifyCancel" runat="server" Text="取消" Icon="Cancel">
                        <DirectEvents>
                            <Click OnEvent="btnCancel_Click" />
                        </DirectEvents>
                    </ext:Button>
                </Buttons>
                <Listeners>
                    <Show Handler="for(var i=0;i<#{vpXcheckInfo}.items.length;i++){#{vpXcheckInfo}.getComponent(i).disable(true);}" />
                    <Hide Handler="for(var i=0;i<#{vpXcheckInfo}.items.length;i++){#{vpXcheckInfo}.getComponent(i).enable(true);}" />
                </Listeners>
            </ext:Window>

            <ext:Hidden ID="hiddenEditUserID" runat="server"></ext:Hidden>
            <ext:Hidden ID="hiddenFactoryID" runat="server"></ext:Hidden>
            <ext:Hidden ID="hiddenMakerPerson" runat="server"></ext:Hidden>
        </Items>
    </ext:Viewport>
    </form>
</body>
</html>
