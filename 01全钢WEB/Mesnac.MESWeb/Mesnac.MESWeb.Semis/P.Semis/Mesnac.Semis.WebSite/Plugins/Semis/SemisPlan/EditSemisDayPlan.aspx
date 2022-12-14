<%@ Page Language="C#" AutoEventWireup="true" CodeFile="EditSemisDayPlan.aspx.cs" Inherits="Plugins_Semis_SemisPlan_EditSemisDayPlan" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>修改每日计划</title>
    <link rel="Stylesheet" type="text/css" href="<%= Page.ResolveUrl("~/") %>resources/css/ext-chinese-font.css" />
    <link rel="Stylesheet" type="text/css" href="<%= Page.ResolveUrl("~/") %>resources/css/main.css" />
    <style type="text/css"  >  
       #label2{font-size: 12px; color: #868600;background-color:#808000}   
       .classDiv1{font-size: 13px; color: #808000;font-weight:600; }   
       .classDiv2{font-size: 12px; color: #EEE000; }   
   </style>   

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
        };
        //-------物料-----查询带回弹出框--BEGIN
        var McUI_SearchBox_SearchSemisMonthPlan_Request = function (record) {//物料返回值处理
            App.hidden_month_material_id.setValue(record.data.MATERIAL_ID);
            App.txt_month_material.setValue(record.data.MATERIAL_NAME);
            App.hidden_month_id.setValue(record.data.OBJID);
        };

        var SearchSemisPlanMaterialWindowShow = function () {//物料查询
            App.McUI_SearchBox_SearchSemisMonthPlan_Window.show();
        };

        var on_tech_version_change = function (sender) {//工艺选择处理
            App.direct.on_tech_version_change(sender.getValue());
        }

        Ext.create("Ext.window.Window", {//物料查询带回窗体
            id: "McUI_SearchBox_SearchSemisMonthPlan_Window",
            height: 430,
            hidden: true,
            width: 360,
            html: "<iframe src='" + thisRootUrl + "McUI/SearchBox/SearchSemisMonthPlan.aspx' width=100% height=100% scrolling=no  frameborder=0></iframe>",
            bodyStyle: "background-color: #fff;",
            closable: true,
            title: "请选择物料",
            modal: true
        });
        //------------查询带回弹出框--END 
    </script>
    <script type="text/javascript">
        var onPlanQuyChange = function (sender, value) {
            App.txt_plan_qty_s1.setValue(value);
            App.txt_plan_qty_s2.setValue(value);
            App.txt_plan_qty_s3.setValue(value);
        }
        var on_bom_version_change = function (sender) {//物料返回值处理
            App.direct.on_bom_version_change(sender.getValue());
        }
        var SelectEquip = function () {
            debugger;
            App.CheckboxSelectionModel1.selectAll();
            var e = new Array();
            for (var i = 0 ; i < App.CheckboxSelectionModel1.selected.items.length; i++) {
                if (App.CheckboxSelectionModel1.selected.items[i].data.OBJID.toString() != App.hidEquipID.getValue())
                {
                    e.push(i);
                }
            }
            for (var j = 0; j < e.length; j++)
            {
                App.CheckboxSelectionModel1.deselect(e[j])
            }
        }
    </script>
</head>
<body>
    <form id="form1" runat="server">
        <ext:ResourceManager ID="ResourceManager1" runat="server" />
        <ext:Viewport ID="Viewport1" runat="server" Layout="border">
            <Items>
                <ext:GridPanel ID="GridPanel1" runat="server" Flex="1" Region="Center" Collapsible="false" MultiSelect="true" FolderSort="true"
                    Title="机台信息" TitleAlign="Center">
                    <Store>
                        <ext:Store ID="store" runat="server">
                            <Proxy>
                                <ext:PageProxy DirectFn="App.direct.GridPanelBindData" />
                            </Proxy>
                            <Listeners>
                                <Load Fn="SelectEquip">
                                    
                                </Load>
                            </Listeners>
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
                                        <ext:ModelField Name="SELECT_FLAG" />
                                    </Fields>
                                </ext:Model>
                            </Model>
                        </ext:Store>
                    </Store>
                    <ColumnModel ID="columnModel" runat="server">
                        <Columns>
                          <%--  <ext:CheckColumn ID ="SELECT_FLAG" runat="server" AutoRender="true" Editable="true" Width="30" DataIndex="SELECT_FLAG"></ext:CheckColumn>--%>
                            <ext:Column ID="OBJID" DataIndex="OBJID" runat="server" Text="编码" Width="80" Hidden="true" />
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
                                <ext:Label runat="server" ID="labProcedureName" Cls="classDiv1"></ext:Label>
                                <ext:DateField runat="server" ID="PlanDate" Text="计划日期" ReadOnly="true"></ext:DateField>
                                <ext:Hidden ID="hidProcedureId" runat="server" />
                                <ext:Hidden ID="hidBomID" runat="server" />
                                <ext:Hidden ID="hidTechID" runat="server" />
                                <ext:Hidden ID="hidZao" runat="server" />
                                <ext:Hidden ID="hidZhong" runat="server" />
                                <ext:Hidden ID="hidYe" runat="server" />
                                <ext:Hidden ID="hidDate" runat="server" />
                                <ext:Hidden ID="hidGreenTyreCode" runat="server" />
                                <ext:Hidden ID ="hidEquipID" runat="server"></ext:Hidden>
                                <ext:ToolbarSeparator />
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
                                        <ext:Hidden ID="hidden_month_material_id" runat="server" />
                                        <ext:Hidden ID="hidden_month_id" runat="server" />
                                        <ext:TextField ID="txt_month_date" runat="server" FieldLabel="月度计划" ReadOnly="true" LabelAlign="Right" Hidden="true" />
                                        <ext:TextField ID="txt_month_material" runat="server" FieldLabel="计划物料" ReadOnly="true" LabelAlign="Right">
                                        </ext:TextField>
                                        <ext:TextField ID="txt_month_PlanQty" runat="server" FieldLabel="计划数量" ReadOnly="true" LabelAlign="Right" Hidden="true" />
                                        <ext:TextField ID="txt_month_AdjustQty" runat="server" FieldLabel="调整数据" ReadOnly="true" LabelAlign="Right" Hidden="true" />
                                        <ext:TextField ID="txt_month_Qty" runat="server" FieldLabel="已生产数量" ReadOnly="true" LabelAlign="Right" Hidden="true" />
                                        <ext:MenuSeparator />
                                        <ext:Label runat="server" Text="工艺信息" Hidden="false"></ext:Label>
                                        <ext:MenuSeparator Hidden="true" />
                                       <ext:Hidden ID="hidden_GreenTyre" runat="server" />
                                        <ext:ComboBox ID="cmbGreenTyre" runat="server" FieldLabel="胎胚规格" LabelAlign="Right" Editable="false"
                                            ValueField="value" DisplayField="text" Hidden="true">
                                            <Store>
                                                <ext:Store ID="stoGreenTyre" runat="server">
                                                    <Model>
                                                        <ext:Model ID="Model4" runat="server">
                                                            <Fields>
                                                                <ext:ModelField Name="value" Mapping="MATERIAL_CODE" />
                                                                <ext:ModelField Name="text" Mapping="MATERIAL_CODE" />
                                                            </Fields>
                                                        </ext:Model>
                                                    </Model>
                                                </ext:Store>
                                            </Store>
                                        </ext:ComboBox>
                                        <ext:Hidden ID="hidden_bom_version" runat="server" />
                                        <ext:ComboBox ID="txt_bom_version" runat="server" FieldLabel="BOM版本" LabelAlign="Right" Editable="false"
                                            ValueField="value" DisplayField="text" Hidden="false">
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
                                                <Change Fn="on_bom_version_change" />
                                            </Listeners>
                                        </ext:ComboBox>
                                        <ext:Hidden ID="hidden_tech_version" runat="server" />
                                        <ext:ComboBox ID="txt_tech_version" runat="server" FieldLabel="工艺版本" LabelAlign="Right" Editable="false"
                                            ValueField="value" DisplayField="text" Hidden="false">
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
                                            <Listeners>
                                                <Select Fn="on_tech_version_change"></Select>
                                            </Listeners>
                                        </ext:ComboBox>
                                        <ext:MenuSeparator />
                                        <ext:Label runat="server" Text="计划数量"></ext:Label>
                                        <ext:TextField ID="txt_plan_qty" runat="server" FieldLabel="所有班次" LabelAlign="Right">
                                            <Listeners>
                                                <Change Fn="onPlanQuyChange" />
                                            </Listeners>
                                        </ext:TextField>
                                        <ext:MenuSeparator />
                                        <ext:TextField ID="txt_plan_qty_s1" runat="server" FieldLabel="早班" LabelAlign="Right" />
                                        <ext:TextField ID="txt_plan_qty_s2" runat="server" FieldLabel="中班" LabelAlign="Right" />
                                        <ext:TextField ID="txt_plan_qty_s3" runat="server" FieldLabel="夜班" LabelAlign="Right" />
                                        <ext:MenuSeparator />
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
