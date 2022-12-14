<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ProductionScanStat.aspx.cs" Inherits="Plugins_Curing_ProductPlan_ProductionScanStat" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>未扫描统计率</title>
     <script type="text/javascript">
         var gridPanelMainRefresh = function () {
             App.gridPanelMainStore.currentPage = 1;
             App.gridPanelMainPagingToolbar.doRefresh();
             //App.tabPanelMain.setActiveTab(1);
         };
         var btnSearch_Click = function () {
             return gridPanelMainRefresh();
         };
         var cboSearchShiftId_Change = function (newValue) {
             if (newValue == null || newValue == "") {
                 return false;
             }
             App.direct.setSearchTime(newValue, {
                 success: function (result) {
                     if (result != "") {
                         Ext.Msg.alert("提示", result);
                         return false;
                     }
                 },
                 failure: function (errorMsg) {
                     Ext.Msg.alert("提示", errorMsg);
                     return false;
                 },
                 eventMask: {
                     showMask: true
                 }
             });
             return true;
         };

         var cgpSearchPressTempLine_Change = function (item) {
             var selectValues = "";
             var chks = item.getChecked();
             for (var i = 0; i < chks.length; i++) {
                 var auditUserId = chks[i].inputValue;
                 if (selectValues == "") {
                     selectValues = auditUserId;
                 }
                 else {
                     selectValues = selectValues + "," + auditUserId;
                 }
             }
             App.hdnSearchPressTempLine.setValue(selectValues);
         };

    </script>
</head>
<body>
    <form id="form1" runat="server">
        <ext:ResourceManager runat="server" ID="ResourceManager1" />
        <ext:Viewport runat="server" ID="Viewport1" Layout="BorderLayout">
            <Items>
               <ext:Panel runat="server" Region="North" AutoScroll="true">
                    <TopBar>
                        <ext:Toolbar runat="server">
                            <Items>
                                <ext:Button runat="server" ID="btnSearch" Icon="Find" Text="查询">
                                    <Listeners>
                                        <Click Handler="return btnSearch_Click();" />
                                    </Listeners>
                                </ext:Button>
                            </Items>
                        </ext:Toolbar>
                    </TopBar>
                    <Items>
                        <ext:Panel runat="server" Width="700" Border="false">
                            <Items>
                                <ext:FieldContainer runat="server" Layout="ColumnLayout" ColumnWidth="1">
                                    <Items>
                                        <ext:ComboBox runat="server" ID="cboSearchEquipId" LabelAlign="Right" FieldLabel="硫化机台"
                                            QueryMode="Local" ForceSelection="true" LabelWidth="80" InputWidth="70">
                                            <Triggers>
                                                <ext:FieldTrigger Icon="Clear" Qtip="清空" HideTrigger="true" />
                                            </Triggers>
                                            <Listeners>
                                                <TriggerClick Handler="this.setValue('');" />
                                            </Listeners>
                                        </ext:ComboBox>
                                        <ext:ComboBox runat="server" ID="cboSearchShiftId" LabelAlign="Right" FieldLabel="班次" Editable="false"
                                            LabelWidth="80" InputWidth="70">
                                            <Triggers>
                                                <ext:FieldTrigger Icon="Clear" Qtip="清空" HideTrigger="true" />
                                            </Triggers>
                                            <Listeners>
                                                <TriggerClick Handler="this.setValue('');" />
                                                <Change Handler="return cboSearchShiftId_Change(newValue);" />
                                            </Listeners>
                                        </ext:ComboBox>
                                        <ext:DateField runat="server" ID="datSearchBeginDate" LabelAlign="Right" FieldLabel="时间" Format="yyyy-MM-dd" Editable="false"
                                            LabelWidth="80" InputWidth="90" />
                                        <ext:TimeField runat="server" ID="timSearchBeginTime" HideLabel="true" Format="HH:mm:ss"
                                            InputWidth="90" />
                                        <ext:Label runat="server" Text="~" />
                                        <ext:TimeField runat="server" ID="timSearchEndTime" HideLabel="true" Format="HH:mm:ss" InputWidth="90" />

                                    </Items>
                                </ext:FieldContainer>
                            </Items>
                        </ext:Panel>
                    </Items>
                </ext:Panel>
                <ext:Panel runat="server" Region="Center">
                    <Items>
                         <ext:GridPanel runat="server" ID="gridPanelMain">
                                    <Store>
                                        <ext:Store runat="server" ID="gridPanelMainStore" AutoLoad="True" PageSize="20">
                                            <Proxy>
                                                <ext:PageProxy DirectFn="App.direct.GridPanelBindData" />
                                            </Proxy>
                                            <Model>
                                                <ext:Model runat="server" ID="gridPanelMainModel">
                                                    <Fields>
                                                        <ext:ModelField Name="EQUIP_CODE" />
                                                        <ext:ModelField Name="EQUIP_ID" />
                                                        <ext:ModelField Name="COUNTTYRENO" />
                                                        <ext:ModelField Name="HASTYRENO" />
                                                        <ext:ModelField Name="NULLTYRENO" />
                                                        <ext:ModelField Name="RATE" />
                                                    </Fields>
                                                </ext:Model>
                                            </Model>
                                        </ext:Store>
                                    </Store>
                                    <ColumnModel runat="server" ID="gridPanelMainColumnModel">
                                        <Columns>
                                            <ext:Column DataIndex="EQUIP_CODE" Text="设备编码" />
                                            <ext:Column DataIndex="COUNTTYRENO" Text="总生产数" />
                                            <ext:Column DataIndex="HASTYRENO" Text="扫描数量" />
                                            <ext:Column DataIndex="NULLTYRENO" Text="未扫描数量" />
                                            <ext:Column DataIndex="RATE" Text="扫描率" />
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
        </ext:Viewport>
    </form>
</body>
</html>
