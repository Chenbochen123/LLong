<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ProductionStat.aspx.cs" Inherits="Plugins_Curing_ProductPlan_ProductionInfoStat" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <script type="text/javascript" src="<%= Page.ResolveUrl("~/") %>resources/js/jquery-1.7.1.js"></script>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>产量信息统计</title>
    <script type="text/javascript">
        var gridPanelMainRefresh = function () {
            App.gridPanelMainStore.currentPage = 1;
            App.gridPanelMainPagingToolbar.doRefresh();
            App.tabPanelMain.setActiveTab(1);                     
        };
        var thisRootUrl = "<%= Page.ResolveUrl("~/") %>";
        var btnSearch_Click = function () {
            return gridPanelMainRefresh();
        };

        var rdgSearchStatType_Change = function (item, oldValue, newValue) {
            var statType = item.getChecked()[0].inputValue; // newValue["rdgSearchStatType_Group"]
            App.hdnSearchStatType.setValue(statType);
            return true;
        };

        var rdgSearchDateType_Change = function (item, oldValue, newValue) {
            var dateType = item.getChecked()[0].inputValue; // newValue["rdgSearchDateType_Group"]
            App.hdnSearchDateType.setValue(dateType);
            if (dateType == "1") {
                // 按接班日期
                App.tmSearchBeginTime.hide();
                App.tmSearchEndTime.hide();
            }
            else if (dateType == "2") {
                // 按接班日期
                App.tmSearchBeginTime.show();
                App.tmSearchEndTime.show();
            }
            return true;
        };

        //-------成型机-----查询带回弹出框--BEGIN
        var McUI_SearchBox_SearchBoxCbeMoldingEquip_Window_Creat = function (minorTypeId) {
            Ext.create("Ext.window.Window", {//成型机查询带回窗体
                id: "McUI_SearchBox_SearchBoxCbeMoldingEquip_Window",
                height: 460,
                hidden: true,
                width: 560,
                html: "<iframe src='" + thisRootUrl + "McUI/SearchBox/SearchBoxCbeMoldingEquip.aspx?MINOR_TYPE_ID=" + minorTypeId + "' width=100% height=100% scrolling=no  frameborder=0></iframe>",
                bodyStyle: "background-color: #fff;",
                closable: true,
                title: "请选择成型机",
                closeAction: "destroy",
                modal: true
            });

        };

        var tgrSearchEquipName_Click = function (item, trigger, index) {//成型机查询
            if (index == 0) {
                item.setValue('');
                App.hdnSearchEquipId.setValue('');
            }
            else if (index == 1) {
                var minorTypeId = App.cboSearchEquipMinorTypeId.getValue();
                minorTypeId = minorTypeId == null ? "" : minorTypeId;
                McUI_SearchBox_SearchBoxCbeMoldingEquip_Window_Creat(minorTypeId);
                App.McUI_SearchBox_SearchBoxCbeMoldingEquip_Window.show();
            }
        }

        var McUI_SearchBox_SearchBoxCbeMoldingEquip_Request = function (record) {
            App.tgrSearchEquipName.setValue(record.data.EQUIP_NAME);
            App.hdnSearchEquipId.setValue(record.data.OBJID);
        }
        //------------查询带回弹出框--END 

        //-------胎胚规格-----查询带回弹出框--BEGIN
        Ext.create("Ext.window.Window", {//物料查询带回窗体
            id: "McUI_SearchBox_SearchBoxSbmMaterialMolding_Window",
            height: 430,
            hidden: true,
            width: 360,
            html: "<iframe src='" + thisRootUrl + "McUI/SearchBox/SearchBoxSbmMaterialMolding.aspx' width=100% height=100% scrolling=no  frameborder=0></iframe>",
            bodyStyle: "background-color: #fff;",
            closable: true,
            title: "请选择物料",
            modal: true
        });

        var tgrSearchMaterialName_Click = function (item, trigger, index) {//胎胚规格查询
            if (index == 0) {
                item.setValue('');
                App.hdnSearchMaterialId.setValue('');
            }
            else if (index == 1) {
                App.McUI_SearchBox_SearchBoxSbmMaterialMolding_Window.show();
            }
        }

        var McUI_SearchBox_SearchBoxSbmMaterialMolding_Request = function (record) {
            App.tgrSearchMaterialName.setValue(record.data.MATERIAL_NAME);
            App.hdnSearchMaterialId.setValue(record.data.OBJID);
        }
        //------------查询带回弹出框--END 
    </script>
</head>
<body>
    <form id="form1" runat="server">
        <asp:Button ID="btnExportSubmit" Style="display: none" runat="server" Text="Button"
            OnClick="btnExportSubmit_Click" />
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
                                                <ext:Button runat="server" Icon="PageExcel" Text="导出Excel" ID="btnExport">
                                                    <ToolTips>
                                                        <ext:ToolTip ID="ToolTip2" runat="server" Html="点击将查询结果导出到Excel中" />
                                                    </ToolTips>
                                                    <Listeners>
                                                        <Click Handler="$('#btnExportSubmit').click();">
                                                        </Click>
                                                    </Listeners>
                                                </ext:Button>
                                                <ext:Hidden ID="hiddenState" runat="server"></ext:Hidden>
                                            </Items>
                                        </ext:Toolbar>
                                        <ext:Panel runat="server" Layout="FormLayout" MaxWidth="620">
                                            <Items>
                                                <ext:FieldSet runat="server" Title="统计方式">
                                                    <Items>
                                                        <ext:Hidden runat="server" ID="hdnSearchStatType" />
                                                        <ext:RadioGroup runat="server" ID="rdgSearchStatType" Layout="ColumnLayout">
                                                            <Listeners>
                                                                <Change Handler="return rdgSearchStatType_Change(item, oldValue, newValue);" />
                                                            </Listeners>
                                                        </ext:RadioGroup>
                                                    </Items>
                                                </ext:FieldSet>
                                                <ext:FieldSet runat="server" Title="日期方式">
                                                    <Items>
                                                        <ext:Hidden runat="server" ID="hdnSearchDateType" />
                                                        <ext:RadioGroup runat="server" ID="rdgSearchDateType" Layout="ColumnLayout">
                                                            <Items>
                                                                <ext:Radio runat="server" InputValue="1" BoxLabelAlign="After" BoxLabel="按接班日期统计" ColumnWidth="0.3" Checked="true" />
                                                                <ext:Radio runat="server" InputValue="2" BoxLabelAlign="After" BoxLabel="按生产时间统计" ColumnWidth="0.3" />
                                                            </Items>
                                                            <Listeners>
                                                                <Change Handler="return rdgSearchDateType_Change(item, oldValue, newValue);" />
                                                            </Listeners>
                                                        </ext:RadioGroup>
                                                    </Items>
                                                </ext:FieldSet>
                                                <ext:FieldSet runat="server" Title="查询条件" Layout="ColumnLayout">
                                                    <Items>
                                                        <ext:Container runat="server" Layout="ColumnLayout" ColumnWidth="1">
                                                            <Items>
                                                                <ext:Container runat="server" ColumnWidth="0.5" Layout="ColumnLayout" Padding="2">
                                                                    <Items>
                                                                        <ext:DateField runat="server" ID="dtSearchBeginDate" FieldLabel="开始日期" LabelAlign="Right" LabelWidth="100" Format="yyyy-MM-dd" Width="220">
                                                                        </ext:DateField>
                                                                        <ext:TimeField runat="server" ID="tmSearchBeginTime" Format="HH:mm:ss" Hidden="true" Width="75" HideMode="Visibility">
                                                                        </ext:TimeField>
                                                                    </Items>
                                                                </ext:Container>
                                                                <ext:Container runat="server" ColumnWidth="0.5" Layout="ColumnLayout" Padding="2">
                                                                    <Items>
                                                                        <ext:DateField runat="server" ID="dtSearchEndDate" FieldLabel="结束日期" LabelAlign="Right" Format="yyyy-MM-dd" Width="220">
                                                                        </ext:DateField>
                                                                        <ext:TimeField runat="server" ID="tmSearchEndTime" Format="HH:mm:ss" Hidden="true" Width="75">
                                                                        </ext:TimeField>
                                                                    </Items>
                                                                </ext:Container>
                                                            </Items>
                                                        </ext:Container>
                                                        <ext:Container runat="server" Layout="ColumnLayout" ColumnWidth="1">
                                                            <Items>
                                                                <ext:ComboBox runat="server" ID="cboSearchShiftId" FieldLabel="班次" LabelAlign="Right" Width="300" LabelWidth="100" InputWidth="120" ColumnWidth="0.5" Padding="2">
                                                                    <Triggers>
                                                                        <ext:FieldTrigger Icon="Clear" Qtip="清空" />
                                                                    </Triggers>
                                                                    <Listeners>
                                                                        <TriggerClick Handler="this.setValue('');" />
                                                                    </Listeners>
                                                                </ext:ComboBox>
                                                                <ext:ComboBox runat="server" ID="cboSearchClassId" FieldLabel="班组" LabelAlign="Right" Width="300" LabelWidth="100" InputWidth="120" ColumnWidth="0.5" Padding="2">
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
                                                                <ext:ComboBox runat="server" ID="cboSearchEquipMinorTypeId" FieldLabel="机台类型" LabelAlign="Right" Width="300" LabelWidth="100" InputWidth="120" ColumnWidth="0.5" Padding="2">
                                                                    <Triggers>
                                                                        <ext:FieldTrigger Icon="Clear" Qtip="清空" />
                                                                    </Triggers>
                                                                    <Listeners>
                                                                        <TriggerClick Handler="this.setValue('');" />
                                                                    </Listeners>
                                                                </ext:ComboBox>
                                                                <ext:TriggerField runat="server" ID="tgrSearchEquipName" FieldLabel="机台" LabelAlign="Right" Width="300" LabelWidth="100" InputWidth="120" ColumnWidth="0.5" Padding="2">
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
                                                                <ext:TriggerField runat="server" ID="tgrSearchMaterialName" FieldLabel="胎胚规格" LabelAlign="Right" LabelWidth="100" InputWidth="420" ColumnWidth="1" Padding="2">
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
                                        <ext:Store runat="server" ID="gridPanelMainStore" AutoLoad="false" PageSize="1000">
                                            <Proxy>
                                                <ext:PageProxy DirectFn="App.direct.GridPanelBindData" />
                                            </Proxy>
                                            <Model>
                                                <ext:Model runat="server" ID="gridPanelMainModel">
                                                    <Fields>
                                                        <ext:ModelField Name="EQUIP_NAME" />
                                                        <ext:ModelField Name="MATERIAL_CODE" />
                                                        <ext:ModelField Name="MATERIAL_NAME" />
                                                        <ext:ModelField Name="EMP_NAME1" />
                                                        <ext:ModelField Name="EMP_NAME2" />
                                                        <ext:ModelField Name="EMP_NAME3" />
                                                        <ext:ModelField Name="TOTAL_1" />
                                                        <ext:ModelField Name="TOTAL_2" />
                                                        <ext:ModelField Name="TOTAL_3" />
                                                        <ext:ModelField Name="TOTAL_N" />
                                                        <ext:ModelField Name="TOTAL" />
                                                        <ext:ModelField Name="TOTAL_BL" />
                                                    </Fields>
                                                </ext:Model>
                                            </Model>
                                        </ext:Store>
                                    </Store>
                                    <ColumnModel runat="server" ID="gridPanelMainColumnModel">
                                        <Columns>
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
