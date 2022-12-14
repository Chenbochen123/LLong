<%@ Page Language="C#" AutoEventWireup="true" CodeFile="EquipDayPlanDetail.aspx.cs" Inherits="Plugins_Curing_ProductPlan_EquipDayPlanDetail" %>

<%@ Register Assembly="Ext.Net" Namespace="Ext.Net" TagPrefix="ext" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>添加每日计划</title>
    <link rel="Stylesheet" type="text/css" href="<%= Page.ResolveUrl("~/") %>resources/css/ext-chinese-font.css" />
    <link rel="Stylesheet" type="text/css" href="<%= Page.ResolveUrl("~/") %>resources/css/main.css" />
    <script type="text/javascript">
        var thisDirUrl = "<%= Page.ResolveUrl("./") %>";
        var thisRootUrl = "<%= Page.ResolveUrl("~/") %>";
    </script>
    <script type="text/javascript" src="<%= Page.ResolveUrl("~/") %>resources/js/jquery-1.7.1.js"></script>
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
            App.direct.IniCuringMonthPlanInfo(record.data.OBJID);
        }

        var SearchCuringMonthPlanWindowShow = function () {
            var planDate = App.PlanDate.getValue();
            if (planDate.length == 0) {
                Ext.Msg.alert('提示', "请选择日期");
                return;
            }
            var myDate = new Date(planDate);
            var ym = myDate.getFullYear().toString() + pad(myDate.getMonth() + 1, 2);
            var window = App.McUI_SearchBox_SearchCuringMonthPlan_Window;
            var html = "<iframe src='" + thisRootUrl + "McUI/SearchBox/SearchCuringMonthPlan.aspx?PlanMonth=" + ym + "' width=100% height=100% scrolling=no  frameborder=0></iframe>";
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
            id: "McUI_SearchBox_SearchCuringMonthPlan_Window",
            height: 430,
            hidden: true,
            width: 360,
            html: "<iframe src='" + thisRootUrl + "McUI/SearchBox/SearchCuringMonthPlan.aspx' width=100% height=100% scrolling=no  frameborder=0></iframe>",
            bodyStyle: "background-color: #fff;",
            closable: true,
            title: "制定项目明细计划",
            modal: true
        })
        //------------查询带回弹出框--END 
    </script>
    <script type="text/javascript">
        var onPlanQuyZChange = function (sender, value) {
            App.txt_plan_qty_z1.setValue(value);
            App.txt_plan_qty_z2.setValue(value);
            App.txt_plan_qty_z3.setValue(value);
        }
        var onPlanQuyYChange = function (sender, value) {
            App.txt_plan_qty_y1.setValue(value);
            App.txt_plan_qty_y2.setValue(value);
            App.txt_plan_qty_y3.setValue(value);
        }
        var on_bom_version_change = function (sender) {//物料返回值处理
            App.direct.on_bom_version_change(sender.getValue());
        }
    </script>
    
</head>
<body>
    <form id="fmUser" runat="server">
        <ext:ResourceManager ID="ResourceManager1" runat="server" />
        <ext:Viewport ID="Viewport1" runat="server" Layout="border">
            <Items>
                <ext:GridPanel ID="GridPanel1" runat="server" Flex="1" Region="Center" Collapsible="false" MultiSelect="true" FolderSort="true"
                    Title="硫化机台信息" TitleAlign="Center">
                    <Store>
                        <ext:Store ID="store" runat="server">
                            <Proxy>
                                <ext:PageProxy DirectFn="App.direct.GridPanelBindData" />
                            </Proxy>
                            <Model>
                                <ext:Model ID="model3" runat="server" IDProperty="OBJID">
                                    <Fields>
                                        <ext:ModelField Name="OBJID" />
                                        <ext:ModelField Name="RECORD_USER_ID" />
                                        <ext:ModelField Name="RECORD_TIME" />
                                        <ext:ModelField Name="BACKUP_FLAG" />
                                        <ext:ModelField Name="BACKUP_TIME" />
                                        <ext:ModelField Name="DELETE_FLAG" />
                                        <ext:ModelField Name="MAJOR_TYPE_ID" />
                                        <ext:ModelField Name="MINOR_TYPE_ID" />
                                        <ext:ModelField Name="EQUIP_NAME" />
                                        <ext:ModelField Name="EQUIP_CODE" />
                                        <ext:ModelField Name="USED_FLAG" />
                                        <ext:ModelField Name="PRODUCE_FACTORY" />
                                        <ext:ModelField Name="USED_DATE" />
                                        <ext:ModelField Name="IP_ADDRESS" />
                                        <ext:ModelField Name="EQUIP_UUID" />
                                        <ext:ModelField Name="REGISTER_CODE" />
                                        <ext:ModelField Name="REMARK" />
                                    </Fields>
                                </ext:Model>
                            </Model>
                        </ext:Store>
                    </Store>
                    <ColumnModel ID="columnModel" runat="server">
                        <Columns>
                            <ext:Column ID="OBJID" DataIndex="OBJID" runat="server" Text="编码" Width="80" />
                            <ext:Column ID="EQUIP_NAME" DataIndex="EQUIP_NAME" runat="server" Text="设备名称" Flex="1" />
                            <ext:Column ID="EQUIP_CODE" DataIndex="EQUIP_CODE" runat="server" Text="设备代号" Flex="1" />
                        </Columns>
                    </ColumnModel>
                    <SelectionModel>
                        <ext:CheckboxSelectionModel ID="CheckboxSelectionModel1" runat="server" Mode="Multi" />
                    </SelectionModel>
                </ext:GridPanel>
                <ext:Panel ID="pnlQueryTitle" runat="server" Region="East" Flex="1" AutoScroll="true">
                    <TopBar>
                        <ext:Toolbar runat="server" ID="barUser">
                            <Items>
                                <ext:ToolbarSeparator ID="toolbarSeparator_begin" />
                                <ext:DateField runat="server" ID="PlanDate" Text="计划日期" ReadOnly="true"></ext:DateField>
                                <ext:ToolbarSeparator />
                                <ext:Button runat="server" Icon="Add" Text="选择月度计划" ID="btnAdd">
                                    <ToolTips>
                                        <ext:ToolTip ID="ttAdd" runat="server" Html="点击选择月度计划" />
                                    </ToolTips>
                                    <Listeners>
                                        <Click Fn="SearchCuringMonthPlanWindowShow" />
                                    </Listeners>
                                </ext:Button>
                                <ext:ToolbarSeparator ID="toolbarSeparator_middle1" />
                                <ext:Button runat="server" Icon="TableSave" Text="保存计划信息" ID="btnSavePlan">
                                    <ToolTips>
                                        <ext:ToolTip ID="ToolTip4" runat="server" Html="点击保存计划信息" />
                                    </ToolTips>
                                    <Listeners>
                                        <Click Handler="App.hidden_bom_version.setValue(App.txt_bom_version.getValue());
                                            App.hidden_tech_version.setValue(App.txt_tech_version.getValue());" />
                                    </Listeners>
                                    <DirectEvents>
                                        <Click OnEvent="btnSavePlan_Click" />
                                    </DirectEvents>
                                </ext:Button>
                                <ext:ToolbarSeparator ID="toolbarSeparator_end" />
                                <ext:ToolbarSpacer runat="server" ID="toolbarSpacer_end" />
                                <ext:ToolbarFill ID="toolbarFill_end" />
                            </Items>
                        </ext:Toolbar>
                    </TopBar>
                    <Items>
                        <ext:FormPanel ID="container_top" runat="server" Layout="ColumnLayout" AutoScroll="true">
                            <Items>
                                <ext:Container ID="container15" runat="server" Layout="FormLayout" ColumnWidth=".8">
                                    <Items>
                                        <ext:MenuSeparator />
                                        <ext:Hidden ID="hidden_CuringMonthPlanId" runat="server" />
                                        <ext:Hidden ID="hidden_month_material_id" runat="server" />
                                        <ext:TextField ID="txt_month_date" runat="server" FieldLabel="月度计划" ReadOnly="true" LabelAlign="Right" />
                                        <ext:TextField ID="txt_month_material" runat="server" FieldLabel="计划物料" ReadOnly="true" LabelAlign="Right" />
                                        <ext:TextField ID="txt_month_PlanQty" runat="server" FieldLabel="计划数量" ReadOnly="true" LabelAlign="Right" />
                                        <ext:TextField ID="txt_month_AdjustQty" runat="server" FieldLabel="调整数据" ReadOnly="true" LabelAlign="Right" />
                                        <ext:TextField ID="txt_month_Qty" runat="server" FieldLabel="已生产数量" ReadOnly="true" LabelAlign="Right" />
                                        <ext:MenuSeparator />
                                        <ext:Label runat="server" Text="工艺信息"></ext:Label>
                                        <ext:MenuSeparator />
                                        <ext:Hidden ID="hidden_bom_version" runat="server" />
                                        <ext:ComboBox ID="txt_bom_version" runat="server" FieldLabel="BOM版本" LabelAlign="Right" Editable="false"
                                            ValueField="value" DisplayField="text" >
                                            <Store>
                                                <ext:Store ID="bom_version_store" runat="server">
                                                    <Model>
                                                        <ext:Model ID="Model1" runat="server">
                                                            <Fields>
                                                                <ext:ModelField Name="value" Mapping="OBJID" />
                                                                <ext:ModelField Name="text" Mapping="V" />
                                                            </Fields>
                                                        </ext:Model>
                                                    </Model>
                                                </ext:Store>
                                            </Store>
                                            <Listeners>
                                                <Change Fn ="on_bom_version_change" />
                                            </Listeners>
                                        </ext:ComboBox>
                                        <ext:Hidden ID="hidden_tech_version" runat="server" />
                                        <ext:ComboBox ID="txt_tech_version" runat="server" FieldLabel="工艺版本" LabelAlign="Right" Editable="false"
                                            ValueField="value" DisplayField="text">
                                            <Store>
                                                <ext:Store ID="tech_version_store" runat="server">
                                                    <Model>
                                                        <ext:Model ID="Model2" runat="server">
                                                            <Fields>
                                                                <ext:ModelField Name="value" Mapping="OBJID" />
                                                                <ext:ModelField Name="text" Mapping="V" />
                                                            </Fields>
                                                        </ext:Model>
                                                    </Model>
                                                </ext:Store>
                                            </Store>
                                        </ext:ComboBox>
                                        <ext:MenuSeparator />
                                        <ext:Label runat="server" Text="左模计划"></ext:Label>
                                        <ext:TextField ID="txt_plan_qty_z" runat="server" FieldLabel="所有班次" LabelAlign="Right">
                                            <Listeners>
                                                <Change Fn="onPlanQuyZChange" />
                                            </Listeners>
                                        </ext:TextField>
                                        <ext:MenuSeparator />
                                        <ext:TextField ID="txt_plan_qty_z1" runat="server" FieldLabel="早班" LabelAlign="Right" />
                                        <ext:TextField ID="txt_plan_qty_z2" runat="server" FieldLabel="中班" LabelAlign="Right" />
                                        <ext:TextField ID="txt_plan_qty_z3" runat="server" FieldLabel="夜班" LabelAlign="Right" />
                                        <ext:MenuSeparator />
                                        <ext:Label runat="server" Text="右模计划"></ext:Label>
                                        <ext:TextField ID="TextField2" runat="server" FieldLabel="所有班次" LabelAlign="Right">
                                            <Listeners>
                                                <Change Fn="onPlanQuyYChange" />
                                            </Listeners>
                                        </ext:TextField>
                                        <ext:MenuSeparator />
                                        <ext:TextField ID="txt_plan_qty_y1" runat="server" FieldLabel="早班" LabelAlign="Right" />
                                        <ext:TextField ID="txt_plan_qty_y2" runat="server" FieldLabel="中班" LabelAlign="Right" />
                                        <ext:TextField ID="txt_plan_qty_y3" runat="server" FieldLabel="夜班" LabelAlign="Right" />
                                    </Items>
                                </ext:Container>
                            </Items>
                        </ext:FormPanel>
                    </Items>
                </ext:Panel>
            </Items>
        </ext:Viewport>
    </form>
</body>
</html>
