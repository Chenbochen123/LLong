<%@ Page Language="C#" AutoEventWireup="true" CodeFile="BatchForwardGo.aspx.cs" Inherits="Tracing_Forward_BatchForwardGo" ViewStateMode="Enabled" EnableViewStateMac="true" EnableViewState="true" %>

<%@ Register Assembly="Ext.Net" Namespace="Ext.Net" TagPrefix="ext" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="head" runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>批量正向追溯</title>
    <!--通用-->
    <link rel="Stylesheet" type="text/css" href="<%= Page.ResolveUrl("~/") %>resources/css/ext-chinese-font.css" />
    <link rel="Stylesheet" type="text/css" href="<%= Page.ResolveUrl("~/") %>resources/css/main.css" />
    <script src="<%= Page.ResolveUrl("./")  %>Search_forward.js?_dc=<%= DateTime.Now.ToString("yyyyMMddHHmmss") %>"></script>
    <script type="text/javascript">
    </script>
    <script type="text/javascript">
        //var basicInfoLoad = function (barcode) {
        //    App.direct.BasicInfoLoad(barcode, {
        //        success: function (result) {
        //        },
        //        failure: function (errorMsg) {
        //            Ext.Msg.alert('提示', errorMsg);
        //        }
        //    });
        //}
        semisCheckChange = function (node, checked, record) {
            //  debugger;
            var barcode = record.data.Barcode;
            var selected = record.data.done;
            if (selected) {
                App.direct.SetSemisTrackBarcode(cardNo, 0);
            }
            else {
                App.direct.SetSemisTrackBarcode(cardNo, 1);
            }
        }
        var setGroupStyle = function (view) {
            // get an instance of the Groups
            var groups = view.el.query(App.GroupingMaster.eventSelector);

            for (var i = 0; i < groups.length; i++) {
                //                var groupId = Ext.fly(groups[i]).next().id.substr((view.id + '-gp-').length),
                //                    records = view.panel.store.getGroups(groupId).children,
                //                    color = "#" + records[0].data.ColorCode;
                //                color = "Gray";
                // Set the "background-color" of the original Group node.
                Ext.get(groups[i]).select('.x-grid-cell-inner').setStyle("background-color", "WhiteSmoke");
            }
            var firsts = view.el.query('.x-grid-cell-first');
            for (var i = 0; i < firsts.length; i++) {
                var first = Ext.get(firsts[i]);
                first.setStyle("background-color", "WhiteSmoke");
            }
        };
        var onGroupCommand = function (column, command, group) {
            if (command === 'SelectGroup') {

                column.grid.getSelectionModel().select(group.children, true);
                return;
            }

            Ext.Msg.alert(command, 'Group name: ' + group.name + '<br/>Count - ' + group.children.length);
        };
        var showDetailWindow = function (barcodes) {
            var url = "../Tracing/Tracing_forward/BatchForwardGo.aspx?Barcode=" + barcodes;
            var tabid = "BatchForwardGo" + barcodes;
            var tabp = parent.App.mainTabPanel;
            var tab = tabp.getComponent("id=" + tabid);
            if (tab) {
                tab.close();
            }

            parent.addTab(tabid, "批量追溯信息（" + barcodes + ")", url, true);

        }
    </script>
</head>
<body>
    <form id="form" runat="server">
        <ext:ResourceManager ID="resourceManager" runat="server" />
        <ext:Viewport ID="viewport" runat="server" Layout="BorderLayout">
            <Items>
                <ext:Panel ID="northPanel" runat="server" Region="North" AutoHeight="true">
                    <TopBar>
                        <ext:Toolbar runat="server" ID="northToolbar">
                            <Items>
                      <%--          <ext:ComboBox ID="cbxBarcodeType" runat="server" FieldLabel="条码类型(工序)" LabelAlign="Right">
                                    <Items>
                                        <ext:ListItem Text="原材料条码" Value="1" />
                                        <ext:ListItem Text="车条码" Value="2" />
                                        <ext:ListItem Text="半制品条码" Value="3" />
                                        <ext:ListItem Text="成型条码" Value="4" />
                                        <ext:ListItem Text="硫化条码" Value="5" />
                                    </Items>
                                    <Listeners>
                                        <Change Fn="cbxBarcodeType_Change" />
                                    </Listeners>
                                </ext:ComboBox>
                                <ext:TextField ID="txtBarcode" runat="server" FieldLabel="条码号" />
                                <ext:Button runat="server" Icon="Find" Text="查询" ID="btnSearch">
                                    <ToolTips>
                                        <ext:ToolTip ID="ttSearch" runat="server" Html="点击进行查询" />
                                    </ToolTips>
                                    <DirectEvents>
                                        <Click OnEvent="btnSearch_Click"></Click>
                                    </DirectEvents>
                                </ext:Button>
                                <ext:ToolbarSeparator ID="toolbarSeparator_end" /> --%>
                                 <ext:Button runat="server" Icon="LightningGo" Text="追溯" ID="btnTrace">
                                    <ToolTips>
                                        <ext:ToolTip ID="ToolTip1" runat="server" Html="点击进行正向追溯" />
                                    </ToolTips>
                                    <DirectEvents>
                                        <Click OnEvent="btnTrace_Click"></Click>
                                    </DirectEvents>
                                </ext:Button>
                                <ext:ToolbarSpacer runat="server" ID="toolbarSpacer_end" />
                                <ext:ToolbarFill ID="toolbarFill_end" />
                            </Items>
                        </ext:Toolbar>
                    </TopBar>
                </ext:Panel>
                <ext:Panel ID="Panel1" runat="server" Region="Center" AutoHeight="true" Layout="BorderLayout">
                    <Items>
                        <ext:Panel runat="server" ID="Panel2" Title="汇总信息" AutoHeight="true" Region="Center" AutoScroll="true">
                            <Items>
                                <ext:GridPanel runat="server" ID="GridPanel1" Region="Center" >
                                    <Store>
                                        <ext:Store runat="server" ID="Store1" GroupField="G">
                                            <Model>
                                                <ext:Model runat="server" IDProperty="ID">
                                                    <Fields>
                                                        <ext:ModelField Name="ID" />
                                                        <ext:ModelField Name="SHIFT_DATE" />
                                                        <ext:ModelField Name="BARCODE" />
                                                        <ext:ModelField Name="SHELF_BARCODE" />
                                                        <ext:ModelField Name="EQUIP_NAME" />
                                                        <ext:ModelField Name="SHIFT_NAME" />
                                                        <ext:ModelField Name="CLASS_NAME" />
                                                        <ext:ModelField Name="MATERIALNAME" />
                                                        <ext:ModelField Name="SET_WEIGHT" />
                                                        <ext:ModelField Name="REAL_WEIGHT" />
                                                        <ext:ModelField Name="MATERIALNAME" />
                                                        <ext:ModelField Name="G" />
                                                        <%--  <ext:ModelField Name="QTY" />--%>
                                                    </Fields>
                                                </ext:Model>
                                            </Model>
                                        </ext:Store>
                                    </Store>
                                    <ColumnModel ID="columnModel3" runat="server">
                                        <Columns>
                                            <%--    <ext:RowNumbererColumn runat="server" />--%>
                                            <%--   <ext:CheckColumn runat="server" Text="" DataIndex="done" Width="40" Editable="true" StopSelection="false">
                                                <Listeners>
                                                    <CheckChange Fn="CheckChange" />
                                                </Listeners>
                                            </ext:CheckColumn>--%>
                                            <ext:Column ID="BARCODE" runat="server" Text="条码号" Width="200" DataIndex="BARCODE" />
                                            <ext:Column ID="colShelf" runat="server" Hidden="false" Text="架子号" Width="200" DataIndex="SHELF_BARCODE" />
                                            <%--   <ext:DateColumn ID="Column2" runat="server" Text="计划日期" Width="100" DataIndex="SHIFT_DATE" Format="yyyy-MM-dd" />
                                            <ext:Column ID="Column15" runat="server" Text="机台" Flex="1" DataIndex="EQUIP_NAME" />
                                            <ext:Column ID="Column16" runat="server" Text="班次" Width="100" DataIndex="SHIFT_NAME" />
                                            <ext:Column ID="Column17" runat="server" Text="班组" Width="100" DataIndex="CLASS_NAME" />--%>
                                            <ext:Column ID="Column18" runat="server" Text="规格" Width="200" Flex="1" DataIndex="MATERIALNAME" />
                                            <ext:Column ID="colSetWeight" runat="server" Text="设定重量" Width="200" DataIndex="SET_WEIGHT" />
                                            <ext:Column ID="colRealWeight" runat="server" Text="实际重量" Width="200" DataIndex="REAL_WEIGHT" />
                                            <%--  <ext:Column ID="Column19" runat="server" Text="数量" Width="50" DataIndex="QTY" />--%>
                                            <ext:CommandColumn runat="server" Hidden="true">
                                                <GroupCommands>
                                                    <ext:GridCommand Icon="TableRow" CommandName="SelectGroup">
                                                        <ToolTip Title="全选" Text="分组内记录全选" />
                                                    </ext:GridCommand>
                                                </GroupCommands>
                                            <%--    <PrepareGroupToolbar Fn="prepareGroupToolbar" />--%>
                                                <Listeners>
                                                    <GroupCommand Fn="onGroupCommand" />
                                                </Listeners>
                                            </ext:CommandColumn>
                                        </Columns>
                                    </ColumnModel>
                                    <SelectionModel>
                                        <ext:CheckboxSelectionModel ID="SelectionModel" runat="server" Mode="Multi" RowSpan="1" />
                                    </SelectionModel>
                                    <View>
                                        <ext:GridView ID="GridViewMaster" runat="server">
                                            <Listeners>
                                                <Refresh Fn="setGroupStyle" />
                                            </Listeners>
                                        </ext:GridView>
                                    </View>
                                    <Features>
                                        <ext:Grouping ID="GroupingMaster" runat="server" GroupHeaderTplString='{name} ({[values.rows.length]} {["条记录"]})' />
                                    </Features>
                                </ext:GridPanel>
                            </Items>
                        </ext:Panel>
                    </Items>
                </ext:Panel>
                <ext:Hidden runat="server" ID="hiddenMaterialMajorType"></ext:Hidden>
                <ext:Hidden runat="server" ID="hiddenBarcodes"></ext:Hidden>
            </Items>
        </ext:Viewport>
    </form>
</body>
</html>
