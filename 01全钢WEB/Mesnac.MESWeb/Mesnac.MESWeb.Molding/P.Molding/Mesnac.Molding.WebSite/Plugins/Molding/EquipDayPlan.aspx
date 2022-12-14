<%@ Page Language="C#" AutoEventWireup="true" CodeFile="EquipDayPlan.aspx.cs" Inherits="Plugins_Molding_ProductPlan_EquipDayPlan" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
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
      <script src="<%= Page.ResolveUrl("~/") %>resources/js/waitwindow.js"></script>
    <script type="text/javascript">
        //点击删除按钮
        var commandcolumn_direct_delete = function (btn, record) {
            if (btn != "yes") {
                return;
            }
            var ObjId = record.data.OBJID;
            debugger;
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

        var semis_confirm = function () {
            Ext.Msg.confirm("提示", '选定的日期班次已存在计划，是否继续生成？', function (btn) { semis_plan_confirm(btn) });
        }
        var semis_plan_confirm = function (btn) {
            if (btn != "yes") {
                return;
            }
            App.direct.CreatePlan();
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

        //点击修改按钮
        var commandcolumn_direct_edit = function (record) {
            debugger;
            if (record.data.zhuangtai != "新建") {
                Ext.Msg.alert('提示', "计划已下发，无法修改！");
                return;
            }
            var ObjId = record.data.OBJID;
            var jitai = record.data.jitai;
            var wuliao = record.data.wuliao;
            var zuomozao = record.data.zao;
            var zuomozhong = record.data.zhong;
            var zuomoye = record.data.ye;
            debugger;
            App.direct.commandcolumn_direct_edit(ObjId, jitai, wuliao, zuomozao, zuomozhong, zuomoye, {
                success: function (result) {
                    // Ext.Msg.alert('操作', result);
                    pnlListFresh();
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
            App.MPlanDate.setValue(App.PlanDate.getValue());
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
        var InsertMoldingPlanWindowShow = function () {
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
            if (record.get("zhuangtai") == "已审核") {
                toolbar.items.getAt(0).hide();
                toolbar.items.getAt(1).hide();
                toolbar.items.getAt(2).hide();

            }
            if (record.get("zhuangtai") == "已接收") {
                toolbar.items.getAt(0).hide();
                toolbar.items.getAt(1).hide();
                toolbar.items.getAt(2).hide();

            }
        };
    </script>

    <script type="text/javascript">
        //区分删除操作，并进行二次确认操作
        var copy_plan = function (isall) {
            App.winCopyPlan.show();
        };
        var create_semiPlan = function (isall) {
            App.winCreateSemiPlan.show();
        };
        var CreatePlan = function () {
            before();
            App.direct.test({
                success: function (result) {
                    if (result.length == 0) {
                        Ext.Msg.alert('成功', "用户权限设置成功！");
                    }
                    else {
                        Ext.Msg.alert('提示', result);
                    }
                    after();
                },

                failure: function (errorMsg) {
                    Ext.Msg.alert('错误', errorMsg);
                    after();
                }
            });
        }
        var after = function () {
            App.waitProgressWindow.close();
        }
        var before = function () {
            App.waitProgressWindow.show();
        }
    </script>
</head>
<body>
    <form id="form1" runat="server">
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
                                        <Change Fn="pnlListFresh" />
                                    </Listeners>
                                </ext:DateField>
                                <ext:ToolbarSeparator />
                                <ext:Button runat="server" Icon="Add" Text="添加计划" ID="btnAdd">
                                    <ToolTips>
                                        <ext:ToolTip ID="ttAdd" runat="server" Html="点击添加计划" />
                                    </ToolTips>
                                    <Listeners>
                                        <Click Fn="InsertMoldingPlanWindowShow" />
                                    </Listeners>
                                </ext:Button>
                                <ext:ToolbarSeparator />
                                <ext:Button runat="server" Icon="ShapesManySelect" Text="下发选中计划" ID="btnCheckPlanState">
                                    <ToolTips>
                                        <ext:ToolTip ID="ttSearch" runat="server" Html="下发选中计划" />
                                    </ToolTips>
                                    <Listeners>
                                        <Click Handler="update_plan_state_confirm(0);" />
                                    </Listeners>
                                </ext:Button>
                                <ext:Button runat="server" Icon="ShapeSquareDelete" Text="反审核选中计划" ID="btnCancelPlanState">
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
                                   <%-- <Listeners>
                                        <Click Handler="update_plan_state_confirm(1);" />
                                    </Listeners>--%>
                                     <Listeners>
                                        <Click Fn="YN"></Click>
                                    </Listeners>
                                </ext:Button>
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
                                <ext:Button runat="server" Icon="ShapesMany"  Text="复制选择计划" ID="btnCopy">
                                    <ToolTips>
                                        <ext:ToolTip ID="ToolTip3" runat="server" Html="复制选择计划" />
                                    </ToolTips>
                                    <Listeners>
                                        <Click Handler="copy_plan();" />
                                    </Listeners>
                                </ext:Button>
                                <ext:ToolbarSeparator />
                                <ext:Button runat="server" Icon="ShapesMany" Hidden="false" Text="生成半制品计划" ID="Button1">
                                    <ToolTips>
                                        <ext:ToolTip ID="ToolTip5" runat="server" Html="生成半制品计划" />
                                    </ToolTips>
                                    <Listeners>
                                        <Click Handler="create_semiPlan();" />
                                    </Listeners>
                                </ext:Button>
                                <ext:ToolbarSeparator ID="toolbarSeparator_end" />
                                <ext:ToolbarSpacer runat="server" ID="toolbarSpacer_end" />
                                <ext:ToolbarFill ID="toolbarFill_end" />
                            </Items>
                        </ext:Toolbar>
                    </TopBar>
                </ext:Panel>
                <ext:GridPanel ID="pnlList" runat="server" Region="Center">
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
                                        <ext:ModelField Name="zao" />
                                        <ext:ModelField Name="zhong" />
                                        <ext:ModelField Name="ye" />
                                        <ext:ModelField Name="wuliaosap" />
                                        <ext:ModelField Name="caozuoren" />
                                        <ext:ModelField Name="shijian" />
                                    </Fields>
                                </ext:Model>
                            </Model>
                        </ext:Store>
                    </Store>
                    <ColumnModel ID="colModel" runat="server">
                        <Columns>
                            <ext:Column runat="server" Text="状态" DataIndex="zhuangtai" Width="60" />
                            <ext:Column runat="server" Text="机台" DataIndex="jitai" Width="60" />
                            <ext:Column runat="server" Text="月度计划" DataIndex="yuedujihua" Width="60" Hidden="true" />
                            <ext:Column runat="server" Text="物料" DataIndex="wuliao" Width="300" />
                            <ext:Column runat="server" Text="SAP物料号" DataIndex="wuliaosap" Width="100" />
                            <ext:Column runat="server" Text="生产工艺" Hidden="false">
                                <Columns>
                                    <ext:Column runat="server" Text="BOM版本" DataIndex="bom" Width="110" Hidden="false" />
                                    <ext:Column runat="server" Text="工艺版本" DataIndex="gongyi" Width="240" Hidden="false" />
                                </Columns>
                            </ext:Column>
                            <ext:Column runat="server" Text="计划数量">
                                <Columns>
                                    <ext:Column runat="server" Text="早" DataIndex="zao" Width="40" />
                                    <ext:Column runat="server" Text="中" DataIndex="zhong" Width="40" />
                                    <ext:Column runat="server" Text="夜" DataIndex="ye" Width="40" />
                                </Columns>
                            </ext:Column>
                            <ext:Column runat="server" Text="操作人" DataIndex="caozuoren" Width="80" />
                            <ext:Column runat="server" Text="操作时间" DataIndex="shijian" Width="120" />
                            <ext:CommandColumn ID="commandCol" runat="server" Width="120" Text="操作" Align="Center">
                                <Commands>
                                    <ext:GridCommand Icon="TableEdit" CommandName="Edit" Text="修改">
                                    </ext:GridCommand>
                                    <ext:CommandSeparator />
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
                <ext:Window ID="winCreateSemiPlan" runat="server" Icon="MonitorEdit" Closable="true"
                    Title="生成半制品计划" Width="360" Height="260" Resizable="false" Hidden="true" Modal="true"
                    BodyStyle="background-color:#fff;" BodyPadding="5" Layout="FitLayout">
                    <Items>
                        <ext:FormPanel ID="FormPanel2" runat="server" Flex="1" BodyPadding="5">
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
                                <ext:DateField runat="server" ID="MPlanDate" FieldLabel="成型日期" LabelAlign="Right" />
                                <ext:ComboBox runat="server" ID="createMShift" FieldLabel="成型班次" LabelAlign="Right" />
                                <ext:Label runat="server" Text="生成："></ext:Label>
                                <ext:DateField runat="server" ID="SPlanDate" FieldLabel="半制品日期" LabelAlign="Right" />
                                <ext:ComboBox runat="server" ID="createSShift" FieldLabel="半制品班次" LabelAlign="Right" />
                                <ext:MenuSeparator runat="server"></ext:MenuSeparator>
                                <ext:MenuSeparator runat="server"></ext:MenuSeparator>
                            </Items>
                        </ext:FormPanel>
                    </Items>
                    <Buttons>
                        <ext:Button ID="Button3" runat="server" Text="确定" Disabled="false">
                            <DirectEvents>
                                <Click OnEvent="btnCreatePlan_Click" Timeout="600000">
                                    <EventMask ShowMask="true" Msg="正在生成..."></EventMask>
                                </Click>
                            </DirectEvents>
                           <%-- <Listeners>
                                <Click Fn="CreatePlan"></Click>
                            </Listeners>--%>
                        </ext:Button>
                    </Buttons>
                </ext:Window>

                <ext:Window ID="winEditProduct" runat="server" Icon="MonitorEdit" Closable="true"
                    Title="修改计划数量" Width="360" Height="300" Resizable="false" Hidden="true" Modal="true"
                    BodyStyle="background-color:#fff;" BodyPadding="5" Layout="FitLayout">
                    <Items>
                        <ext:FormPanel ID="FormPanel3" runat="server" Flex="1" BodyPadding="5">
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
                                <ext:TextField runat="server" ID="EditObjId" Hidden="true"></ext:TextField>
                                <ext:TextField runat="server" ID="EditEquip" FieldLabel="机台" LabelAlign="Right" ReadOnly="true" />
                                <ext:TextField runat="server" ID="EditMaterial" FieldLabel="物料" LabelAlign="Right" ReadOnly="true" />
                                <ext:TextField runat="server" ID="EditQtyLeftZao" FieldLabel="早班数量" LabelAlign="Right" />
                                <ext:TextField runat="server" ID="EditQtyLeftZhong" FieldLabel="中班数量" LabelAlign="Right" />
                                <ext:TextField runat="server" ID="EditQtyLeftYe" FieldLabel="夜班数量" LabelAlign="Right" />
                                <ext:Hidden runat="server" ID="EditPlandate" />
                                <ext:Hidden runat="server" ID="EditEquipId" />
                                <ext:Hidden runat="server" ID="EditMaterialId" />
                                <ext:Hidden runat="server" ID="EditBomId" />
                                <ext:Hidden runat="server" ID="EditTechId" />
                            </Items>
                        </ext:FormPanel>
                    </Items>
                    <Buttons>
                        <ext:Button ID="Button4" runat="server" Text="确定" Disabled="false">
                            <DirectEvents>
                                <Click OnEvent="btnEditOK_Click"></Click>
                            </DirectEvents>
                        </ext:Button>
                    </Buttons>
                </ext:Window>

            </Items>
        </ext:Viewport>
    </form>
</body>
</html>
