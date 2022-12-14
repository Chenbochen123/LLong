<%@ Page Language="C#" AutoEventWireup="true" CodeFile="SemisDayPlan.aspx.cs" Inherits="Plugins_Semis_SemisPlan_SemisDayPlan" %>

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

        var commandcolumn_direct_edit = function (record) {
            var planDate = App.PlanDate.getValue();
            if (planDate.length == 0) {
                Ext.Msg.alert('提示', "请选择日期");
                return;
            }
          
            var equipID = record.data.jitaiid;
            var materialID = record.data.wuliaoid;
            var materialCode = record.data.wuliao;
            materialCode = materialCode.replace('#', 'jinghao')
            var greenTyreCode = record.data.materialcode;
            var bomID = record.data.bomid;
            var techID = record.data.gongyiid;
            var zao = record.data.zao;
            var zhong = record.data.zhong;
            var ye = record.data.ye;
            var planMonthID = record.data.yuedujihuaid;
            var myDate = new Date(planDate);
            var ymd = myDate.getFullYear().toString() + pad(myDate.getMonth() + 1, 2) + pad(myDate.getDate(), 2);
            var procedure = App.cobProcedure.getValue();
            var procedurename = App.cobProcedure.displayTplData[0].field2;
            var window = App.McUI_SearchBox_SearchEditMonthDayPlan_Window;
            var html = "<iframe src='" + thisDirUrl + "EditSemisDayPlan.aspx?PlanDate=" + ymd + "&ProcedureID=" + procedure + "&ProcedureName=" + procedurename + "&EquipID=" + equipID + "&MaterialID=" + materialID + "&BomID=" + bomID + "&TechID=" + techID + "&Zao=" + zao + "&Zhong=" + zhong + "&Ye=" + ye + "&MaterialCode=" + materialCode + "&PlanMonthID=" + planMonthID + "&greenTyreCode=" + greenTyreCode + "' width=100% height=100% scrolling=no  frameborder=0></iframe>";
            if (window.getBody()) {
                window.getBody().update(html);
            } else {
                window.html = html;
            }
            window.show();
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
            var value = App.cobProcedure.value;
            var values = App.cbxVersion.value;
            App.hidden_Procedure.setValue(value);
            App.hidden_Version.setValue(values);
            App.pnlList.store.reload();
            return false;
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
        var InsertSemisPlanWindowShow = function () {
            var planDate = App.PlanDate.getValue();
            if (planDate.length == 0) {
                Ext.Msg.alert('提示', "请选择日期");
                return;
            }
            var myDate = new Date(planDate);
            var ymd = myDate.getFullYear().toString() + pad(myDate.getMonth() + 1, 2) + pad(myDate.getDate(), 2);
            var procedure = App.cobProcedure.getValue();
            var procedurename = App.cobProcedure.displayTplData[0].field2;
            var window = App.McUI_SearchBox_SearchMonthDayPlanDetail_Window;
            var html = "<iframe src='" + thisDirUrl + "SemisDayPlanDetail.aspx?PlanDate=" + ymd + "&ProcedureID=" + procedure + "&ProcedureName=" + procedurename + "' width=100% height=100% scrolling=no  frameborder=0></iframe>";
            if (window.getBody()) {
                window.getBody().update(html);
            } else {
                window.html = html;
            }
            window.show();
        }
        var EditSemisPlanWindowShow = function () {
            
        }
        Ext.create("Ext.window.Window", {//物料查询带回窗体
            id: "McUI_SearchBox_SearchMonthDayPlanDetail_Window",
            hidden: true,
            maximized: true,
            html: "<iframe src='" + thisRootUrl + "SemisDayPlanDetail.aspx' width=100% height=100% scrolling=no  frameborder=0></iframe>",
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
        Ext.create("Ext.window.Window", {//物料查询带回窗体
            id: "McUI_SearchBox_SearchEditMonthDayPlan_Window",
            hidden: true,
            maximized: true,
            html: "<iframe src='" + thisRootUrl + "EditSemisDayPlan.aspx' width=100% height=100% scrolling=no  frameborder=0></iframe>",
            bodyStyle: "background-color: #fff;",
            closable: true,
            title: "修改明细计划",
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
            //if (record.get("zhuangtai") == "已审核") {
            //    toolbar.items.getAt(0).hide();
            //    toolbar.items.getAt(1).hide();

            //}
            //if (record.get("zhuangtai") == "已接收") {
            //    toolbar.items.getAt(0).hide();
            //    toolbar.items.getAt(1).hide();
            //}
            if (record.get("zhuangtai") != "新建") {
                toolbar.items.getAt(0).hide();
                toolbar.items.getAt(1).hide();
            }
        };
    </script>

    <script type="text/javascript">
        //区分删除操作，并进行二次确认操作
        var copy_plan = function (isall) {
            App.winCopyPlan.show();
        };

        var delete_all_plan = function () {
            Ext.Msg.confirm("提示", '您确定需要删除所有计划吗？', function (btn) {
                if (btn != "yes") {
                    return;
                }
                App.direct.deleteAllPlan();
                pnlListFresh();
            });
          
        };
    </script>
</head>
<body>
    <form id="form1" runat="server">
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
                                <ext:ComboBox ID="cobProcedure" runat="server" FieldLabel="工序" LabelAlign="Left" Editable="false"
                                    ValueField="Value" DisplayField="Text" LabelWidth="35" Width="120" ForceSelection="true">
                                   
                                    <Listeners>
                                        <Change Fn="pnlListFresh" />
                                    </Listeners>
                                </ext:ComboBox>
                                <ext:Hidden ID="hidden_Procedure" runat="server" Text="0" />
                                <ext:ToolbarSeparator />
                                <ext:ComboBox ID="cbxVersion" runat="server" FieldLabel="是否有工艺版本" LabelAlign="Left" Editable="false"
                                    ValueField="Value" DisplayField="Text" LabelWidth="100" Width="200" ForceSelection="true">
                                    <Listeners>
                                        <Change Fn="pnlListFresh" />
                                    </Listeners>
                                </ext:ComboBox>
                                <ext:Hidden ID="hidden_Version" runat="server" Text="0" />
                                <ext:ToolbarSeparator />
                                <ext:Button runat="server" Icon="Add" Text="添加计划" ID="btnAdd">
                                    <ToolTips>
                                        <ext:ToolTip ID="ttAdd" runat="server" Html="点击添加计划" />
                                    </ToolTips>
                                    <Listeners>
                                        <Click Fn="InsertSemisPlanWindowShow" />
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
                                <ext:Button runat="server" Icon="ShapesMany" Text="下发全部计划" ID="btnAllPlanState" Hidden="true">
                                    <ToolTips>
                                        <ext:ToolTip ID="ToolTip1" runat="server" Html="下发全部计划" />
                                    </ToolTips>
                                    <Listeners>
                                        <Click Handler="update_plan_state_confirm(1);" />
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
                                <ext:Button runat="server" Icon="ShapesMany" Text="复制选择计划" ID="btnCopy">
                                    <ToolTips>
                                        <ext:ToolTip ID="ToolTip3" runat="server" Html="复制选择计划" />
                                    </ToolTips>
                                    <Listeners>
                                        <Click Handler="copy_plan();" />
                                    </Listeners>
                                </ext:Button>
                                  <ext:ToolbarSeparator />
                                <ext:Button runat="server" Icon="Delete" Text="删除全部计划" ID="Button1" >
                                    <ToolTips>
                                        <ext:ToolTip ID="ToolTip5" runat="server" Html="删除全部计划" />
                                    </ToolTips>
                                    <Listeners>
                                        <Click Handler="delete_all_plan();" />
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
                                        <ext:ModelField Name="unit" />
                                        <ext:ModelField Name="procedure" />
                                        <ext:ModelField Name="zao" />
                                        <ext:ModelField Name="zhong" />
                                        <ext:ModelField Name="ye" />
                                        <ext:ModelField Name="bom" />
                                        <ext:ModelField Name="gongyi" />
                                        <ext:ModelField Name="bomid" />
                                        <ext:ModelField Name="gongyiid" />
                                        <ext:ModelField Name="jitaiid" />
                                        <ext:ModelField Name="yuedujihuaid" />
                                        <ext:ModelField Name="materialcode" />
                                        <ext:ModelField Name="wuliaosap" />
                                        <ext:ModelField Name="caozuoren" />
                                        <ext:ModelField Name="shijian" />
                                        <ext:ModelField Name="newver" />
                                        
                                    </Fields>
                                </ext:Model>
                            </Model>
                        </ext:Store>
                    </Store>
                    <ColumnModel ID="colModel" runat="server">
                        <Columns>
                            <ext:Column runat="server" Text="状态" DataIndex="zhuangtai" Width="60" />
                            <ext:Column runat="server" Text="机台" DataIndex="jitai" Width="60" />
                            <ext:Column runat="server" Text="工序" DataIndex="procedure" Width="60" Hidden="false" />
                             <ext:Column runat="server" Text="生产工艺" Hidden="false">
                                <Columns>
                                    <ext:Column runat="server" Text="BOM版本" DataIndex="bom" Width="110" Hidden="false" />
                                    <ext:Column runat="server" Text="工艺版本" DataIndex="gongyi" Width="240" Hidden="false" />
                                    <ext:Column runat="server" Text="版本" DataIndex="newver" Width="80" Hidden="false" />
                                </Columns>
                            </ext:Column>
                            <ext:Column runat="server" Text="月度计划" DataIndex="yuedujihua" Width="60" Hidden="true" />
                            <ext:Column runat="server" Text="物料" DataIndex="wuliao" Width="240" />
                            <ext:Column runat="server" Text="物料SAP号" DataIndex="wuliaosap" Width="100" />
                            <ext:Column runat="server" Text="单位" DataIndex="unit" Width="60" Hidden="false" />
                            <ext:Column runat="server" Text="胎胚规格" DataIndex="materialcode" Width="120" Hidden="true" />
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
                                    <ext:GridCommand Icon="Delete" CommandName="Delete" Text="删除">
                                    </ext:GridCommand>

                                     <ext:GridCommand Icon="TableEdit" CommandName="Edit" Text="修改">
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
            </Items>
        </ext:Viewport>
    </form>
</body>
</html>
