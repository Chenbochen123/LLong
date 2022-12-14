<%@ Page Language="C#" AutoEventWireup="true" CodeFile="PlanCompleteContrast.aspx.cs" Inherits="Plugins_Curing_ProductPlan_PlanCompleteContrast" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>计划完成率对比</title>
    <script type="text/javascript">
        var gridPanelMainRefresh = function () {
            App.gridPanelMainStore.currentPage = 1;
            App.gridPanelMainPagingToolbar.doRefresh();
            App.tabPanelMain.setActiveTab(1);
        };
        var btnSearch_Click = function () {
            return gridPanelMainRefresh();
        };

        //-------硫化机-----查询带回弹出框--BEGIN
        var McUI_SearchBox_SearchBoxCbeCuringEquip_Window_Creat = function (minorTypeId) {
            Ext.create("Ext.window.Window", {//硫化机查询带回窗体
                id: "McUI_SearchBox_SearchBoxCbeCuringEquip_Window",
                height: 460,
                hidden: true,
                width: 560,
                html: "<iframe src='../../../McUI/SearchBox/SearchBoxCbeCuringEquip.aspx?MINOR_TYPE_ID=" + minorTypeId + "' width=100% height=100% scrolling=no  frameborder=0></iframe>",
                bodyStyle: "background-color: #fff;",
                closable: true,
                title: "请选择硫化机",
                closeAction: "destroy",
                modal: true
            });

        };

        var tgrSearchEquipName_Click = function (item, trigger, index) {//硫化机查询
            if (index == 0) {
                item.setValue('');
                App.hdnSearchEquipId.setValue('');
            }
            else if (index == 1) {
                var minorTypeId = App.cboSearchEquipMinorTypeId.getValue();
                minorTypeId = minorTypeId == null ? "" : minorTypeId;
                McUI_SearchBox_SearchBoxCbeCuringEquip_Window_Creat(minorTypeId);
                App.McUI_SearchBox_SearchBoxCbeCuringEquip_Window.show();
            }
        }

        var McUI_SearchBox_SearchBoxCbeCuringEquip_Request = function (record) {
            App.tgrSearchEquipName.setValue(record.data.EQUIP_NAME);
            App.hdnSearchEquipId.setValue(record.data.OBJID);
        }
        //------------查询带回弹出框--END 

        //-------成品胎规格-----查询带回弹出框--BEGIN
        var McUI_SearchBox_SearchBoxVCbmMaterial_Window_Creat = function () {
            Ext.create("Ext.window.Window", {//硫化机查询带回窗体
                id: "McUI_SearchBox_SearchBoxVCbmMaterial_Window",
                height: 460,
                hidden: true,
                width: 560,
                html: "<iframe src='../../../McUI/SearchBox/SearchBoxVCbmMaterial.aspx' width=100% height=100% scrolling=no  frameborder=0></iframe>",
                bodyStyle: "background-color: #fff;",
                closable: true,
                title: "请选择成品胎规格",
                closeAction: "hide",
                modal: true
            });

        };

        var tgrSearchMaterialName_Click = function (item, trigger, index) {//硫化机查询
            if (index == 0) {
                item.setValue('');
                App.hdnSearchMaterialId.setValue('');
            }
            else if (index == 1) {
                McUI_SearchBox_SearchBoxVCbmMaterial_Window_Creat();
                App.McUI_SearchBox_SearchBoxVCbmMaterial_Window.show();
            }
        }

        var McUI_SearchBox_SearchBoxVCbmMaterial_Request = function (record) {
            App.tgrSearchMaterialName.setValue(record.data.MATERIAL_NAME);
            App.hdnSearchMaterialId.setValue(record.data.OBJID);
        }
        //------------查询带回弹出框--END 
    </script>
</head>
<body>
    <form id="form1" runat="server">
        <ext:ResourceManager runat="server" ID="ResourceManager1" />
        <ext:Viewport runat="server" ID="Viewport1" Layout="FitLayout">
            <Items>
                <ext:TabPanel runat="server" ID="tabPanelMain">
                    <Items>
                        <ext:Panel runat="server" ID="pnlSearch" Layout="BorderLayout" ActiveIndex="1" ActiveItem="1" Title="查询条件">
                            <Items>
                                <ext:Panel runat="server" Region="North">
                                    <Items>
                                        <ext:Toolbar runat="server">
                                            <Items>
                                                <ext:Button runat="server" ID="btnSearch" Text="查询" Icon="PageFind">
                                                    <Listeners>
                                                        <Click Handler="return btnSearch_Click();" />
                                                    </Listeners>
                                                </ext:Button>
                                            </Items>
                                        </ext:Toolbar>
                                        <ext:Panel runat="server" Layout="FormLayout" MaxWidth="620">
                                            <Items>
                                                <ext:FieldSet runat="server" Title="查询条件" Layout="ColumnLayout">
                                                    <Items>
                                                        <ext:Container runat="server" Layout="ColumnLayout" ColumnWidth="1">
                                                            <Items>
                                                                <ext:DateField runat="server" ID="dtSearchPlanDate" FieldLabel="计划日期" LabelAlign="Right" Format="yyyy-MM-dd" LabelWidth="100" InputWidth="150" ColumnWidth="0.5">
                                                                </ext:DateField>
                                                            </Items>
                                                        </ext:Container>
                                                        <ext:Container runat="server" Layout="ColumnLayout" ColumnWidth="1">
                                                            <Items>
                                                                <ext:ComboBox runat="server" ID="cboSearchShiftId" FieldLabel="班次" LabelAlign="Right" Width="300" LabelWidth="100" InputWidth="150" ColumnWidth="0.5">
                                                                    <Triggers>
                                                                        <ext:FieldTrigger Icon="Clear" Qtip="清空" />
                                                                    </Triggers>
                                                                    <Listeners>
                                                                        <TriggerClick Handler="this.setValue('');" />
                                                                    </Listeners>
                                                                </ext:ComboBox>
                                                                <ext:ComboBox runat="server" ID="cboSearchClassId" FieldLabel="班组" LabelAlign="Right" Width="300" LabelWidth="100" InputWidth="150" ColumnWidth="0.5" Hidden="true">
                                                                    <Triggers>
                                                                        <ext:FieldTrigger Icon="Clear" Qtip="清空" />
                                                                    </Triggers>
                                                                    <Listeners>
                                                                        <TriggerClick Handler="this.setValue('');" />
                                                                    </Listeners>
                                                                </ext:ComboBox>
                                                            </Items>
                                                        </ext:Container>
                                                        <ext:Container runat="server" Layout="ColumnLayout" ColumnWidth="1">
                                                            <Items>
                                                                <ext:ComboBox runat="server" ID="cboSearchEquipMajorTypeId" FieldLabel="设备类型" LabelAlign="Right" Hidden="true">
                                                                </ext:ComboBox>
                                                                <ext:ComboBox runat="server" ID="cboSearchEquipMinorTypeId" FieldLabel="机台类型" LabelAlign="Right" LabelWidth="100" InputWidth="150" ColumnWidth="0.5">
                                                                    <Triggers>
                                                                        <ext:FieldTrigger Icon="Clear" Qtip="清空" />
                                                                    </Triggers>
                                                                    <Listeners>
                                                                        <TriggerClick Handler="this.setValue('');" />
                                                                    </Listeners>
                                                                </ext:ComboBox>
                                                                <ext:TriggerField runat="server" ID="tgrSearchEquipName" FieldLabel="机台" LabelAlign="Right" LabelWidth="100" InputWidth="150" ColumnWidth="0.5">
                                                                    <Triggers>
                                                                        <ext:FieldTrigger Icon="Clear" Qtip="清空" />
                                                                        <ext:FieldTrigger Icon="Search" Qtip="查找" />
                                                                    </Triggers>
                                                                    <Listeners>
                                                                        <TriggerClick Handler="return tgrSearchEquipName_Click(item,trigger,index);" />
                                                                    </Listeners>
                                                                </ext:TriggerField>
                                                                <ext:Hidden runat="server" ID="hdnSearchEquipId" />
                                                            </Items>
                                                        </ext:Container>
                                                        <ext:Container runat="server" Layout="ColumnLayout" ColumnWidth="1">
                                                            <Items>
                                                                <ext:ComboBox runat="server" ID="cboSearchSizeId" FieldLabel="规格" LabelAlign="Right" LabelWidth="100" InputWidth="150" ColumnWidth="0.5">
                                                                    <Triggers>
                                                                        <ext:FieldTrigger Icon="Clear" Qtip="清空" />
                                                                    </Triggers>
                                                                    <Listeners>
                                                                        <TriggerClick Handler="this.setValue('');" />
                                                                    </Listeners>
                                                                </ext:ComboBox>
                                                                <ext:ComboBox runat="server" ID="cboSearchPlyratingId" FieldLabel="层级" LabelAlign="Right" LabelWidth="100" InputWidth="150" ColumnWidth="0.5">
                                                                    <Triggers>
                                                                        <ext:FieldTrigger Icon="Clear" Qtip="清空" />
                                                                    </Triggers>
                                                                    <Listeners>
                                                                        <TriggerClick Handler="this.setValue('');" />
                                                                    </Listeners>
                                                                </ext:ComboBox>
                                                                <ext:ComboBox runat="server" ID="cboSearchPatternId" FieldLabel="花纹" LabelAlign="Right" LabelWidth="100" InputWidth="150" ColumnWidth="0.5">
                                                                    <Triggers>
                                                                        <ext:FieldTrigger Icon="Clear" Qtip="清空" />
                                                                    </Triggers>
                                                                    <Listeners>
                                                                        <TriggerClick Handler="this.setValue('');" />
                                                                    </Listeners>
                                                                </ext:ComboBox>
                                                                <ext:ComboBox runat="server" ID="cboSearchBrandId" FieldLabel="品牌" LabelAlign="Right" LabelWidth="100" InputWidth="150" ColumnWidth="0.5">
                                                                    <Triggers>
                                                                        <ext:FieldTrigger Icon="Clear" Qtip="清空" />
                                                                    </Triggers>
                                                                    <Listeners>
                                                                        <TriggerClick Handler="this.setValue('');" />
                                                                    </Listeners>
                                                                </ext:ComboBox>
                                                                <ext:TriggerField runat="server" ID="tgrSearchMaterialName" FieldLabel="成品胎规格" LabelAlign="Right" LabelWidth="100" InputWidth="450" ColumnWidth="1">
                                                                    <Triggers>
                                                                        <ext:FieldTrigger Icon="Clear" Qtip="清空" />
                                                                        <ext:FieldTrigger Icon="Search" Qtip="查找" />
                                                                    </Triggers>
                                                                    <Listeners>
                                                                        <TriggerClick Handler="return tgrSearchMaterialName_Click(item,trigger,index);" />
                                                                    </Listeners>
                                                                </ext:TriggerField>
                                                                <ext:Hidden runat="server" ID="hdnSearchMaterialId" />
                                                            </Items>
                                                        </ext:Container>
                                                    </Items>
                                                </ext:FieldSet>
                                            </Items>
                                        </ext:Panel>
                                    </Items>
                                </ext:Panel>

                            </Items>
                        </ext:Panel>
                        <ext:Panel runat="server" ID="pnlResult" ActiveIndex="2" ActiveItem="2" Title="统计结果" Layout="FitLayout">
                            <Items>
                                <ext:GridPanel runat="server" ID="gridPanelMain">
                                    <Store>
                                        <ext:Store runat="server" ID="gridPanelMainStore" AutoLoad="false" PageSize="0">
                                            <Proxy>
                                                <ext:PageProxy DirectFn="App.direct.GridPanelBindData" />
                                            </Proxy>
                                            <Model>
                                                <ext:Model runat="server" ID="gridPanelMainModel">
                                                    <Fields>
                                                        <ext:ModelField Name="物料" />
                                                        <ext:ModelField Name="当日计划" />
                                                        <ext:ModelField Name="当日实际" />
                                                        <ext:ModelField Name="当日差异" />
                                                        <ext:ModelField Name="日完成率" />
                                                        <ext:ModelField Name="当月计划" />
                                                        <ext:ModelField Name="当月实际" />
                                                        <ext:ModelField Name="当月差异" />
                                                        <ext:ModelField Name="月完成率" />
                                                        <ext:ModelField Name="当年计划" />
                                                        <ext:ModelField Name="当年实际" />
                                                        <ext:ModelField Name="当年差异" />
                                                        <ext:ModelField Name="年完成率" />
                                                    </Fields>
                                                </ext:Model>
                                            </Model>
                                        </ext:Store>
                                    </Store>
                                    <ColumnModel runat="server" ID="gridPanelMainColumnModel">
                                        <Columns>
                                            <ext:Column DataIndex="物料" Text="物料" />
                                            <ext:Column DataIndex="当日计划" Text="当日计划" />
                                            <ext:Column DataIndex="当日实际" Text="当日实际" />
                                            <ext:Column DataIndex="当日差异" Text="当日差异" />
                                            <ext:ComponentColumn DataIndex="日完成率" Text="日完成率">
                                                <Component>
                                                    <ext:ProgressBar></ext:ProgressBar>
                                                </Component>
                                                <Listeners>
                                                    <Bind Handler="cmp.updateProgress(record.get('日完成率'), Ext.util.Format.number(record.get('日完成率') * 100, '0.00') + '%');" />
                                                </Listeners>
                                            </ext:ComponentColumn>
                                            <ext:Column DataIndex="当月计划" Text="当月计划" />
                                            <ext:Column DataIndex="当月实际" Text="当月实际" />
                                            <ext:Column DataIndex="当月差异" Text="当月差异" />
                                            <ext:ComponentColumn DataIndex="月完成率" Text="月完成率">
                                                <Component>
                                                    <ext:ProgressBar></ext:ProgressBar>
                                                </Component>
                                                <Listeners>
                                                    <Bind Handler="cmp.updateProgress(record.get('月完成率'), Ext.util.Format.number(record.get('月完成率') * 100, '0.00') + '%');" />
                                                </Listeners>
                                            </ext:ComponentColumn>
                                            <ext:Column DataIndex="当年计划" Text="当年计划" />
                                            <ext:Column DataIndex="当年实际" Text="当年实际" />
                                            <ext:Column DataIndex="当年差异" Text="当年差异" />
                                            <ext:ComponentColumn DataIndex="年完成率" Text="年完成率">
                                                <Component>
                                                    <ext:ProgressBar></ext:ProgressBar>
                                                </Component>
                                                <Listeners>
                                                    <Bind Handler="cmp.updateProgress(record.get('年完成率'), Ext.util.Format.number(record.get('年完成率') * 100, '0.00') + '%');" />
                                                </Listeners>
                                            </ext:ComponentColumn>
                                        </Columns>
                                    </ColumnModel>
                                    <SelectionModel>
                                        <ext:RowSelectionModel runat="server" ID="gridPanelMainRowSelectionModel" Mode="Single" AllowDeselect="true" />
                                    </SelectionModel>
                                    <BottomBar>
                                        <ext:PagingToolbar ID="gridPanelMainPagingToolbar" runat="server">
                                        </ext:PagingToolbar>
                                    </BottomBar>
                                </ext:GridPanel>
                            </Items>
                        </ext:Panel>
                    </Items>
                </ext:TabPanel>
            </Items>
        </ext:Viewport>
    </form>
</body>
</html>
