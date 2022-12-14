<%@ page language="C#" autoeventwireup="true" inherits="Plugins_Curing_ProductPlan_EquipDayPlan, Mesnac.CuringPlanLL.WebSite" %>

<%@ Register Assembly="Ext.Net" Namespace="Ext.Net" TagPrefix="ext" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>每日计划</title>
    <link rel="Stylesheet" type="text/css" href="<%= Page.ResolveUrl("~/") %>resources/css/ext-chinese-font.css" />
    <link rel="Stylesheet" type="text/css" href="<%= Page.ResolveUrl("~/") %>resources/css/main.css" />
    <style type="text/css">
        .redcs {
            color: #ff0000;
        }
    </style>
    <script type="text/javascript">
        var thisDirUrl = "<%= Page.ResolveUrl("./") %>";
        var thisRootUrl = "<%= Page.ResolveUrl("~/") %>";
    </script>
    <script type="text/javascript" src="<%= Page.ResolveUrl("~/") %>resources/js/jquery-1.7.1.js"></script>
    <script type="text/javascript">
        //-------物料-----查询带回弹出框--BEGIN
        var McUI_SearchBox_SearchBoxSbmMaterialCuring_Request = function (record) {//物料返回值处理
            if (!App.winAdd.hidden) {
                App.add_MATERIAL.setValue(record.data.MATERIAL_NAME);
                App.hidden_add_MATERIAL.setValue(record.data.OBJID);
            }
            else if (!App.winModify.hidden) {
                App.modify_MATERIAL.setValue(record.data.MATERIAL_NAME);
                App.hidden_modify_MATERIAL.setValue(record.data.OBJID);
            }
            else {
                App.txt_material.getTrigger(0).show();
                App.txt_material.setValue(record.data.MATERIAL_NAME);
                App.hidden_txt_material.setValue(record.data.OBJID);
            }
        }

        var SelectMaterial = function (field, trigger, index) {//物料查询
            switch (index) {
                case 0:
                    field.getTrigger(0).hide();
                    field.setValue('');
                    App.hidden_txt_material.setValue("");
                    field.getEl().down('input.x-form-text').setStyle('background', "white");
                    break;
                case 1:
                    App.McUI_SearchBox_SearchBoxSbmMaterialCuring_Window.show();
                    break;
            }
        }

        var UpdateDepartment = function (field, trigger, index) {//物料查询
            App.McUI_SearchBox_SearchBoxSbmMaterialCuring_Window.show();
        }
        Ext.create("Ext.window.Window", {//物料查询带回窗体
            id: "McUI_SearchBox_SearchBoxSbmMaterialCuring_Window",
            height: 430,
            hidden: true,
            width: 360,
            html: "<iframe src='" + thisRootUrl + "McUI/SearchBox/SearchBoxSbmMaterialCuring.aspx' width=100% height=100% scrolling=no  frameborder=0></iframe>",
            bodyStyle: "background-color: #fff;",
            closable: true,
            title: "请选择物料",
            modal: true
        })
        //------------查询带回弹出框--END 
    </script>
    <script type="text/javascript">
        //点击删除按钮
        var commandcolumn_direct_delete = function (btn, record) {
            if (btn != "yes") {
                return;
            }
            var ObjId = record.data.OBJID;
            App.direct.commandcolumn_direct_delete(ObjId, {
                success: function (result) {
                    Ext.Msg.alert('操作', result);
                    pnlListFresh();
                },

                failure: function (errorMsg) {
                    Ext.Msg.alert('操作', errorMsg);
                }
            });
        }

        //区分删除操作，并进行二次确认操作
        var commandcolumn_click_confirm = function (command, record) {
            if (command.toLowerCase() == "edit") {
                commandcolumn_direct_edit(record);
            }
            if (command.toLowerCase() == "delete") {
                Ext.Msg.confirm("提示", '您确定需要删除未下发的计划吗？', function (btn) { commandcolumn_direct_delete(btn, record) });
            }
            return false;
        };

        //根据按钮类别进行删除和编辑操作
        var commandcolumn_click = function (command, record) {
            commandcolumn_click_confirm(command, record);
            return false;
        };

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


        //列表刷新数据重载方法
        var pnlListFresh = function () {
            App.CheckboxSelectionModel1.deselectAll();
            App.pnlList.store.reload();
            return false;
        }

        var pnlListFreshAndClear = function () {
            App.CheckboxSelectionModel1.deselectAll();
            App.pnlList.store.reload();
            return false;
        }
        var YN = function () {
            Ext.Msg.confirm("提示", '您确定需要下发计划吗？', function (btn) {
                if (btn != "yes") {
                    
                    return false;
                }
                Ext.Msg.wait('计划下达中...', '下达中');
                App.direct.btnAllPlanState_Click();
            });
        }
    </script>

    <script type="text/javascript">
        var pad = function (num, n) {
            var len = num.toString().length;
            while (len < n) {
                num = "0" + num;
                len++;
            }
            return num;
        }
        //-------月度计划-----查询带回弹出框--BEGIN
        var McUI_SearchBox_SearchCuringMonthPlan_Request = function (record) {//物料返回值处理
            App.hidden_CuringMonthPlanId.setValue(record.data.OBJID);
            App.txt_month_date.setValue(record.data.PLAN_MONTH);
            App.txt_month_material.setValue(record.data.MATERIAL_NAME);
        }

        var SearchCuringMonthPlanWindowShow = function () {
            var planDate = App.PlanDate.getValue();
            if (planDate.length == 0) {
                Ext.Msg.alert('提示', "请选择日期");
                return;
            }
            var myDate = new Date(planDate);
            var ymd = myDate.getFullYear().toString() + pad(myDate.getMonth() + 1, 2) + pad(myDate.getDate(), 2);
            var window = App.McUI_SearchBox_SearchMonthDayPlanDetail_Window;
            var html = "<iframe src='" + thisDirUrl + "EquipDayPlanDetail.aspx?PlanDate=" + ymd + "' width=100% height=100% scrolling=no  frameborder=0></iframe>";
            if (window.getBody()) {
                window.getBody().update(html);
            } else {
                window.html = html;
            }
            window.show();
        }
        var SearchCuringMonthPlan = function (field, trigger, index) {//物料查询
            switch (index) {
                case 0:
                    field.getTrigger(0).hide();
                    field.setValue('');
                    App.hidden_txt_material.setValue("");
                    field.getEl().down('input.x-form-text').setStyle('background', "white");
                    break;
                case 1:
                    SearchCuringMonthPlanWindowShow();
                    break;
            }
        }
        Ext.create("Ext.window.Window", {//物料查询带回窗体
            id: "McUI_SearchBox_SearchMonthDayPlanDetail_Window",
            hidden: true,
            maximized: true,
            html: "<iframe src='" + thisRootUrl + "EquipDayPlanDetail.aspx' width=100% height=100% scrolling=no  frameborder=0></iframe>",
            bodyStyle: "background-color: #fff;",
            closable: true,
            title: "制定明细计划",
            modal: true,
            listeners: {
                beforeclose: function (panel, eOpts) {
                    pnlListFresh();
                }
            }
        })
        //------------查询带回弹出框--END 
    </script>

    <script type="text/javascript">
        //区分删除操作，并进行二次确认操作
        var update_plan_state_confirm = function (isall) {
            Ext.Msg.confirm("提示", '您确定需要下发计划吗？', function (btn) {
                if (btn != "yes") {
                    return;
                }
                App.direct.update_plan_state(isall);
            });
        };


        //区分删除操作，并进行二次确认操作
        var reset_plan_state_confirm = function () {
            Ext.Msg.confirm("提示", '您确定需要反审核选中的计划吗？', function (btn) {
                if (btn != "yes") {
                    return;
                }
                App.direct.reset_plan_state();
            });
        };

        var prepareToolbar = function (grid, toolbar, rowIndex, record) {
            if (record.get("zhuangtai") == "已下达") {
                toolbar.items.getAt(0).hide();
            }
            if (record.get("zhuangtai") == "已接收") {
                toolbar.items.getAt(0).hide();
            }
        };
    </script>

    <script type="text/javascript">
        //区分删除操作，并进行二次确认操作
        var copy_plan = function (isall) {
            App.winCopyPlan.show();
        };
    </script>
</head>
<body>
    <form id="fmUser" runat="server">
        <asp:Button ID="btnExportSubmit" Style="display: none" runat="server" Text="Button"
            OnClick="btnExportSubmit_Click" />
        <ext:ResourceManager ID="ResourceManager1" runat="server" />
        <ext:Viewport ID="Viewport1" runat="server" Layout="border">
            <Items>
                <ext:Panel ID="pnlQueryTitle" runat="server" Region="North" AutoHeight="true">
                    <TopBar>
                        <ext:Toolbar runat="server" ID="barUser">
                            <Items>
                                <ext:ToolbarSeparator ID="toolbarSeparator_begin" />
                                <ext:DateField runat="server" ID="PlanDate" Text="计划日期">
                                    <Listeners>
                                        <Change Fn="pnlListFreshAndClear" />
                                    </Listeners>
                                </ext:DateField>
                                <ext:ToolbarSeparator />
                                <ext:Button runat="server" Icon="Add" Text="添加计划" ID="btnAdd">
                                    <ToolTips>
                                        <ext:ToolTip ID="ttAdd" runat="server" Html="点击选择计划" />
                                    </ToolTips>
                                    <Listeners>
                                        <Click Fn="SearchCuringMonthPlanWindowShow" />
                                    </Listeners>
                                </ext:Button>
                                <ext:Hidden ID="hidden_CuringMonthPlanId" runat="server" />
                                <ext:ToolbarSeparator />
                                <ext:Button runat="server" Icon="ShapesManySelect" Text="下发选中计划" ID="btnCheckPlanState">
                                    <ToolTips>
                                        <ext:ToolTip ID="ttSearch" runat="server" Html="下发选中计划" />
                                    </ToolTips>
                                    <Listeners>
                                        <Click Handler="update_plan_state_confirm(0);" />
                                    </Listeners>
                                </ext:Button>
                                <ext:Button runat="server" Icon="ShapeSquareDelete" Text="反审核选中计划" ID="Button3">
                                    <ToolTips>
                                        <ext:ToolTip ID="ToolTip4" runat="server" Html="反审核选中计划" />
                                    </ToolTips>
                                    <Listeners>
                                        <Click Handler="reset_plan_state_confirm();" />
                                    </Listeners>
                                </ext:Button>
                                <ext:ToolbarSeparator ID="toolbarSeparator_middle" />
                                <ext:Button runat="server" Icon="ShapesMany" Text="下发全部计划" ID="btnAllPlanState">
                                    <ToolTips>
                                        <ext:ToolTip ID="ToolTip1" runat="server" Html="下发全部计划" />
                                    </ToolTips>
                                  <%--  <Listeners>
                                        <Click Handler="update_plan_state_confirm(1);"/>
                                    </Listeners>--%>
                                    <Listeners>
                                        <Click Fn="YN"></Click>
                                    </Listeners>
                                </ext:Button>
                                <ext:Hidden runat="server" ID="HiddenYN"></ext:Hidden>
                                <ext:ToolbarSeparator ID="toolbarSeparator_middle_2" />
                                <ext:Button runat="server" Icon="PageWhiteExcel" Text="导出计划" ID="btnExport">
                                    <ToolTips>
                                        <ext:ToolTip ID="ToolTip2" runat="server" Html="点击将查询结果导出到Excel中" />
                                    </ToolTips>
                                    <Listeners>
                                        <Click Handler="$('#btnExportSubmit').click();">
                                        </Click>
                                    </Listeners>
                                </ext:Button>
                                <ext:ToolbarSeparator />
                                <ext:Button runat="server" Icon="ShapesMany" Text="复制选择计划" ID="Button1">
                                    <ToolTips>
                                        <ext:ToolTip ID="ToolTip3" runat="server" Html="复制选择计划" />
                                    </ToolTips>
                                    <Listeners>
                                        <Click Handler="copy_plan();" />
                                    </Listeners>
                                </ext:Button>
                                <ext:ToolbarSeparator ID="toolbarSeparator_end" />
                                <ext:ToolbarSpacer runat="server" ID="toolbarSpacer_end" />
                                <ext:ToolbarFill ID="toolbarFill_end" />
                            </Items>
                        </ext:Toolbar>
                    </TopBar>
                </ext:Panel>
                <ext:GridPanel ID="pnlList" runat="server" Region="Center" MaskOnDisable="true">
                    <View>
                        <ext:GridView EnableTextSelection="true" PreserveScrollOnRefresh="true">
                        </ext:GridView>
                    </View>
                    <Store>
                        <ext:Store ID="store" runat="server" PageSize="10">
                            <Proxy>
                                <ext:PageProxy DirectFn="App.direct.GridPanelBindData" />
                            </Proxy>
                            <Model>
                                <ext:Model ID="model" runat="server" IDProperty="PlanInfo">
                                    <Fields>
                                        <ext:ModelField Name="OBJID" />
                                        <ext:ModelField Name="PlanInfo" />
                                        <ext:ModelField Name="zhuangtai" />
                                        <ext:ModelField Name="yuedujihua" />
                                        <ext:ModelField Name="jitai" />
                                        <ext:ModelField Name="wuliaoid" />
                                        <ext:ModelField Name="wuliao" />
                                        <ext:ModelField Name="bom" />
                                        <ext:ModelField Name="gongyi" />
                                        <ext:ModelField Name="zuomozao" />
                                        <ext:ModelField Name="zuomozhong" />
                                        <ext:ModelField Name="zuomoye" />
                                        <ext:ModelField Name="youmozao" />
                                        <ext:ModelField Name="youmozhong" />
                                        <ext:ModelField Name="yongmoye" />
                                    </Fields>
                                </ext:Model>
                            </Model>
                        </ext:Store>
                    </Store>
                    <ColumnModel ID="colModel" runat="server">
                        <Columns>
                            <ext:Column runat="server" Text="状态" DataIndex="zhuangtai" Width="60" />
                            <ext:Column runat="server" Text="机台" DataIndex="jitai" Width="60" />
                            <ext:Column runat="server" Text="月度计划" DataIndex="yuedujihua" Width="60" />
                            <ext:Column runat="server" Text="物料" DataIndex="wuliao" Width="200" />
                            <ext:Column runat="server" Text="生产工艺">
                                <Columns>
                                    <ext:Column runat="server" Text="BOM版本" DataIndex="bom" Width="160" />
                                    <ext:Column runat="server" Text="工艺版本" DataIndex="gongyi" Width="240" />
                                </Columns>
                            </ext:Column>
                            <ext:Column runat="server" Text="左模计划">
                                <Columns>
                                    <ext:Column runat="server" Text="早" DataIndex="zuomozao" Width="40" />
                                    <ext:Column runat="server" Text="中" DataIndex="zuomozhong" Width="40" />
                                    <ext:Column runat="server" Text="夜" DataIndex="zuomoye" Width="40" />
                                </Columns>
                            </ext:Column>
                            <ext:Column runat="server" Text="右模计划">
                                <Columns>
                                    <ext:Column runat="server" Text="早" DataIndex="youmozao" Width="40" />
                                    <ext:Column runat="server" Text="中" DataIndex="youmozhong" Width="40" />
                                    <ext:Column runat="server" Text="夜" DataIndex="yongmoye" Width="40" />
                                </Columns>
                            </ext:Column>
                            <ext:CommandColumn ID="commandCol" runat="server" Width="60" Text="操作" Align="Center">
                                <Commands>
                                    <ext:GridCommand Icon="Delete" CommandName="Delete" Text="删除">
                                    </ext:GridCommand>
                                </Commands>
                                <PrepareToolbar Fn="prepareToolbar" />
                                <Listeners>
                                    <Command Handler="return commandcolumn_click(command, record);" />
                                </Listeners>
                            </ext:CommandColumn>
                        </Columns>
                    </ColumnModel>
                    <SelectionModel>
                        <ext:CheckboxSelectionModel ID="CheckboxSelectionModel1" runat="server" Mode="Multi" />
                    </SelectionModel>
                </ext:GridPanel>
                <ext:Window ID="winPlanImport" runat="server" Icon="MonitorEdit" Closable="true"
                    Title="选择导入文件" Width="360" Height="160" Resizable="false" Hidden="true" Modal="true"
                    BodyStyle="background-color:#fff;" BodyPadding="5" Layout="FitLayout">
                    <Items>
                        <ext:FormPanel ID="panelImport" runat="server" Flex="1" BodyPadding="5">
                            <Defaults>
                                <ext:Parameter Name="allowBlank" Value="false" Mode="Raw" />
                            </Defaults>
                            <FieldDefaults>
                                <CustomConfig>
                                    <ext:ConfigItem Name="LabelWidth" Value="80" Mode="Raw" />
                                    <ext:ConfigItem Name="PreserveIndicatorIcon" Value="true" Mode="Raw" />
                                </CustomConfig>
                            </FieldDefaults>
                            <Items>
                                <ext:FileUploadField runat="server" ID="fileUploadFieldExcel" EmptyText="选择导入的Excel文件"
                                    FieldLabel="导入计划文件" ButtonText="" Icon="PageExcel" AllowBlank="false" Width="320"
                                    LabelAlign="Right" />
                            </Items>
                        </ext:FormPanel>
                    </Items>
                    <Buttons>
                        <ext:Button ID="btnImportUpload" runat="server" Text="上传" Disabled="false">
                            <DirectEvents>
                                <Click OnEvent="btnImportUpload_Click" Before="Ext.Msg.wait('正在上传文件...', '上传中');"
                                    Failure="Ext.Msg.show({ 
                                                title   : '错误', 
                                                msg     : '上传文件处理失败', 
                                                minWidth: 200, 
                                                modal   : true, 
                                                icon    : Ext.Msg.ERROR, 
                                                buttons : Ext.Msg.OK 
                                        });">
                                </Click>
                            </DirectEvents>
                        </ext:Button>
                        <ext:Button ID="btnImportReset" runat="server" Text="重置">
                            <Listeners>
                                <Click Handler="#{panelImport}.getForm().reset();" />
                            </Listeners>
                        </ext:Button>
                    </Buttons>
                </ext:Window>


                <ext:Window ID="winCopyPlan" runat="server" Icon="MonitorEdit" Closable="true"
                    Title="复制计划" Width="360" Height="160" Resizable="false" Hidden="true" Modal="true"
                    BodyStyle="background-color:#fff;" BodyPadding="5" Layout="FitLayout">
                    <Items>
                        <ext:FormPanel ID="FormPanel1" runat="server" Flex="1" BodyPadding="5">
                            <Defaults>
                                <ext:Parameter Name="allowBlank" Value="false" Mode="Raw" />
                            </Defaults>
                            <FieldDefaults>
                                <CustomConfig>
                                    <ext:ConfigItem Name="LabelWidth" Value="80" Mode="Raw" />
                                    <ext:ConfigItem Name="PreserveIndicatorIcon" Value="true" Mode="Raw" />
                                </CustomConfig>
                            </FieldDefaults>
                            <Items>
                                <ext:DateField runat="server" ID="copyPlanDate" FieldLabel="计划日期" LabelAlign="Right" />
                                <ext:MenuSeparator runat="server"></ext:MenuSeparator>
                                <ext:MenuSeparator runat="server"></ext:MenuSeparator>
                                <ext:Label runat="server" Text="复制选中的计划到目标日期中！" Cls="redcs" />
                            </Items>
                        </ext:FormPanel>
                    </Items>
                    <Buttons>
                        <ext:Button ID="Button2" runat="server" Text="确定" Disabled="false">
                            <DirectEvents>
                                <Click OnEvent="btnCapyPlan_Click"></Click>
                            </DirectEvents>
                        </ext:Button>
                    </Buttons>
                </ext:Window>
            </Items>
        </ext:Viewport>
    </form>
</body>
</html>
