<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Compare.aspx.cs" Inherits="Tracing_Compare_Compare" %>

<%@ Register Assembly="Ext.Net" Namespace="Ext.Net" TagPrefix="ext" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="head" runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>条码追溯</title>
    <!--通用-->
    <link rel="Stylesheet" type="text/css" href="<%= Page.ResolveUrl("~/") %>resources/css/ext-chinese-font.css" />
    <link rel="Stylesheet" type="text/css" href="<%= Page.ResolveUrl("~/") %>resources/css/main.css" />
    <%-- <script src="<%= Page.ResolveUrl("./") %>Search.js?_dc=<%= DateTime.Now.ToString("yyyyMMddHHmmss") %>"></script>--%>
    <script type="text/javascript">
        var gridPanelRefresh = function () {
            App.store.currentPage = 1;
            App.refreshHidden.setValue("1");
            App.store.reload();
            return false;
        };

        var Compare = function () {
            App.direct.StartCompare({
                failure: function (errorMsg) {
                    Ext.Msg.alert('Failure', errorMsg);
                }
            });
            return false;
        };
        var Test = function () {
            App.direct.Test({
                failure: function (errorMsg) {
                    Ext.Msg.alert('Failure', errorMsg);
                }
            });
            return false;
        };
        var nodeLoad = function (store, operation, options) {
            var node = operation.node;
            App.direct.NodeLoad(node.getId(), {
                success: function (result) {
                    node.set('loading', false);
                    node.set('loaded', true);
                    var data = Ext.decode(result);
                    node.appendChild(data, undefined, true);
                    node.expand();
                },

                failure: function (errorMsg) {
                    Ext.Msg.alert('Failure', errorMsg);
                }
            });

            return false;
        };
        var nodeCollapse = function (store, operation, options) {
            var node = operation.node;
            App.direct.nodeCollapse(node.getId(), {
                success: function (result) {
                    node.set('loading', false);
                    node.set('loaded', true);
                    var data = Ext.decode(result);
                    node.appendChild(data, undefined, true);
                    node.expand();
                },

                failure: function (errorMsg) {
                    Ext.Msg.alert('Failure', errorMsg);
                }
            });

            return false;
        };
        var nodeExpand = function (store, operation, options) {
            var node = operation.node;
            debugger;
            App.direct.nodeExpand(node.getId(), {
                success: function (result) {
                    node.set('loading', false);
                    node.set('loaded', true);
                    var data = Ext.decode(result);
                    node.appendChild(data, undefined, true);
                    node.expand();
                },

                failure: function (errorMsg) {
                    Ext.Msg.alert('Failure', errorMsg);
                }
            });

            return false;
        };
        var LoadProduction = function () {
            App.direct.LoadProduction({
                failure: function (errorMsg) {
                    Ext.Msg.alert('Failure', errorMsg);
                }
            });

            return false;
        };
        var LoadTech = function () {
            App.direct.LoadTech({
                failure: function (errorMsg) {
                    Ext.Msg.alert('Failure', errorMsg);
                }
            });

            return false;
        };
        var LoadQuality = function () {
            App.direct.LoadQuality({
                failure: function (errorMsg) {
                    Ext.Msg.alert('Failure', errorMsg);
                }
            });

            return false;
        };

        var LoadAlarm = function () {
            App.direct.LoadAlarm({
                failure: function (errorMsg) {
                    Ext.Msg.alert('Failure', errorMsg);
                }
            });

            return false;
        };
        var LoadCurve = function () {
            App.direct.LoadCurve({
                failure: function (errorMsg) {
                    Ext.Msg.alert('Failure', errorMsg);
                }
            });

            return false;
        };
        var LoadStock = function () {
            App.direct.LoadStock({
                failure: function (errorMsg) {
                    Ext.Msg.alert('Failure', errorMsg);
                }
            });

            return false;
        };
        var LoadWeight = function () {
            App.direct.LoadWeight({
                failure: function (errorMsg) {
                    Ext.Msg.alert('Failure', errorMsg);
                }
            });

            return false;
        };
        var LoadMix = function () {
            App.direct.LoadMix({
                failure: function (errorMsg) {
                    Ext.Msg.alert('Failure', errorMsg);
                }
            });

            return false;
        };
        var LoadBatch = function () {
            App.direct.LoadBatch({
                failure: function (errorMsg) {
                    Ext.Msg.alert('Failure', errorMsg);
                }
            });

            return false;
        };
        var RefleshChart = function (barcode, item) {
            App.curvePanel.getBody().update("<iframe src='CuringPressTemp3.aspx?Item=" + item + "&Barcode=" + barcode + "' width=100% height=100% scrolling=no  frameborder=0></iframe>");
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
                                <ext:ToolbarSeparator ID="toolbarSeparator_begin" />
                                <ext:Button runat="server" Icon="Zoom" Text="开始对比" ID="btnSearch">
                                    <ToolTips>
                                        <ext:ToolTip ID="ttSearch" runat="server" Html="点击进行对比" />
                                    </ToolTips>
                                    <Listeners>
                                        <Click Fn="Compare"></Click>
                                    </Listeners>
                                </ext:Button>
                                <ext:Button runat="server" Icon="Zoom" Text="测试SQLServer" Hidden="true" ID="Button1">
                                    <Listeners>
                                        <Click Fn="Test"></Click>
                                    </Listeners>
                                </ext:Button>
                                <ext:ToolbarSeparator ID="toolbarSeparator_end" />
                                <ext:ToolbarSpacer runat="server" ID="toolbarSpacer_end" />
                                <ext:ToolbarFill ID="toolbarFill_end" />
                            </Items>
                        </ext:Toolbar>
                    </TopBar>
                </ext:Panel>
                <ext:Panel ID="Panel1" runat="server" Region="Center" Flex="1" AutoHeight="true" Layout="BorderLayout">
                    <Items>
                        <ext:Panel ID="PanelLeft" Title="编辑胎号" runat="server" Icon="TextColumns" Collapsible="true" Width="255" Split="true" MinWidth="175" Region="West" AutoHeight="true">
                            <Items>
                                <ext:Container ID="container4" runat="server" Layout="VBoxLayout" Padding="5">
                                    <Items>
                                        <ext:FieldSet ID="fs1" runat="server" Title="对比胎号" Width="245" Layout="VBoxLayout" DefaultAnchor="100%">
                                            <LayoutConfig>
                                                <ext:VBoxLayoutConfig Align="Stretch" Pack="Center" DefaultMargins="5" />
                                            </LayoutConfig>
                                            <Items>
                                                <ext:TextField ID="txtBarcode1" runat="server" FieldLabel="胎号1" LabelWidth="60" Width="255" LabelAlign="Left">
                                                </ext:TextField>
                                                <ext:TextField ID="txtBarcode2" runat="server" FieldLabel="胎号2" LabelWidth="60" Width="255" LabelAlign="Left">
                                                </ext:TextField>
                                                <ext:TextField ID="txtBarcode3" runat="server" FieldLabel="胎号3" LabelWidth="60" Width="255" LabelAlign="Left">
                                                </ext:TextField>
                                                <ext:TextField ID="txtBarcode4" runat="server" FieldLabel="胎号4" LabelWidth="60" Width="255" LabelAlign="Left">
                                                </ext:TextField>
                                                <ext:TextField ID="txtBarcode5" runat="server" FieldLabel="胎号5" LabelWidth="60" Width="255" LabelAlign="Left">
                                                </ext:TextField>
                                                <ext:TextField ID="txtBarcode6" runat="server" FieldLabel="胎号6" LabelWidth="60" Width="255" LabelAlign="Left">
                                                </ext:TextField>
                                                <ext:TextField ID="txtBarcode7" runat="server" FieldLabel="胎号7" LabelWidth="60" Width="255" LabelAlign="Left">
                                                </ext:TextField>
                                                <ext:TextField ID="txtBarcode8" runat="server" FieldLabel="胎号8" LabelWidth="60" Width="255" LabelAlign="Left">
                                                </ext:TextField>
                                                <ext:TextField ID="txtBarcode9" runat="server" FieldLabel="胎号9" LabelWidth="60" Width="255" LabelAlign="Left">
                                                </ext:TextField>
                                                <ext:TextField ID="txtBarcode10" runat="server" FieldLabel="胎号10" LabelWidth="60" Width="255" LabelAlign="Left">
                                                </ext:TextField>
                                            </Items>
                                        </ext:FieldSet>
                                    </Items>
                                </ext:Container>
                            </Items>
                        </ext:Panel>
                        <ext:Panel ID="PanelRight" runat="server" Region="Center" AutoHeight="true" Layout="BorderLayout">
                            <Items>
                                <ext:Panel ID="PanelTree" runat="server" Region="Center" Split="true" AutoHeight="true" Layout="BorderLayout">
                                    <Items>
                                        <%--          <ext:TreePanel ID="TreePanel1" runat="server" Region="West" Width="330" Hidden="true">
                                            <Store>
                                                <ext:TreeStore ID="TreeStore1" runat="server">
                                                    <Root>
                                                        <ext:Node NodeID="Root">
                                                        </ext:Node>
                                                    </Root>
                                                    <Listeners>
                                                        <BeforeLoad Fn="nodeLoad" />
                                                        <BeforeCollapse Fn="nodeCollapse"/>
                                                       <BeforeExpand Fn="nodeExpand"/>
                                                    </Listeners>
                                                </ext:TreeStore>
                                            </Store>
                                            <DirectEvents>
                                                <ItemClick OnEvent="treeNodeClick">
                                                    <EventMask ShowMask="true">
                                                    </EventMask>
                                                    <ExtraParams>
                                                        <ext:Parameter Name="value" Value="record.getId()" Mode="Raw" Encode="true" />
                                                    </ExtraParams>
                                                </ItemClick>
                                            </DirectEvents>
                                        </ext:TreePanel>--%>
                                        <ext:GridPanel runat="server" ID="GridTrace" Split="true" Frame="true" Title="追溯对比信息" Icon="CameraGo" Region="Center">
                                            <Store>
                                                <ext:Store runat="server" ID="GridStore" GroupField="MINOR_TYPE_NAME">
                                                    <Model>
                                                        <ext:Model ID="ModelMaster" runat="server">
                                                            <Fields>
                                                                <ext:ModelField Name="MINOR_TYPE_NAME" />
                                                                <ext:ModelField Name="MINOR_TYPE_ID" />
                                                                <ext:ModelField Name="BARCODE1" />
                                                                <ext:ModelField Name="BARCODE2" />
                                                                <ext:ModelField Name="BARCODE3" />
                                                                <ext:ModelField Name="BARCODE4" />
                                                                <ext:ModelField Name="BARCODE5" />
                                                                <ext:ModelField Name="BARCODE6" />
                                                                <ext:ModelField Name="BARCODE7" />
                                                                <ext:ModelField Name="BARCODE8" />
                                                                <ext:ModelField Name="BARCODE9" />
                                                                <ext:ModelField Name="BARCODE10" />
                                                            </Fields>
                                                        </ext:Model>
                                                    </Model>
                                                </ext:Store>
                                            </Store>
                                            <ColumnModel ID="ColumnModelMaster" runat="server">
                                                <Columns>
                                                    <ext:Column ID="ColumnMasterSpace" runat="server" Width="15" Draggable="false" MenuDisabled="true"
                                                        Resizable="false" Sortable="false" Selectable="false" />
                                                    <ext:Column ID="barcode1" runat="server" Text="胎号1" DataIndex="BARCODE1"
                                                        Width="150" MenuDisabled="true" Hidden="false" />
                                                    <ext:Column ID="barcode2" runat="server" Text="胎号2" DataIndex="BARCODE2"
                                                        Width="150" MenuDisabled="true" Hidden="true" />
                                                    <ext:Column ID="barcode3" runat="server" Text="胎号3" DataIndex="BARCODE3"
                                                        Width="150" MenuDisabled="true" Hidden="true" />
                                                    <ext:Column ID="barcode4" runat="server" Text="胎号4" DataIndex="BARCODE4"
                                                        Width="150" MenuDisabled="true" Hidden="true" />
                                                    <ext:Column ID="barcode5" runat="server" Text="胎号5" DataIndex="BARCODE5"
                                                        Width="150" MenuDisabled="true" Hidden="true" />
                                                    <ext:Column ID="barcode6" runat="server" Text="胎号6" DataIndex="BARCODE6"
                                                        Width="150" MenuDisabled="true" Hidden="true" />
                                                    <ext:Column ID="barcode7" runat="server" Text="胎号7" DataIndex="BARCODE7"
                                                        Width="150" MenuDisabled="true" Hidden="true" />
                                                    <ext:Column ID="barcode8" runat="server" Text="胎号8" DataIndex="BARCODE8"
                                                        Width="150" MenuDisabled="true" Hidden="true" />
                                                    <ext:Column ID="barcode9" runat="server" Text="胎号9" DataIndex="BARCODE9"
                                                        Width="150" MenuDisabled="true" Hidden="true" />
                                                    <ext:Column ID="barcode10" runat="server" Text="胎号10" DataIndex="BARCODE10"
                                                        Width="150" MenuDisabled="true" Hidden="true" />
                                                </Columns>
                                            </ColumnModel>
                                            <SelectionModel>
                                                <ext:RowSelectionModel runat="server" ID="RowSelectionModelMaster" Mode="Single">
                                                    <DirectEvents>
                                                        <SelectionChange OnEvent="RowSelectionModelMaster_SelectionChange">
                                                            <%--  <EventMask ShowMask="true" Target="CustomTarget" CustomTarget="PanelDetail" />--%>
                                                            <ExtraParams>
                                                                <ext:Parameter Name="Id" Value="Ext.encode(#{GridTrace}.getRowsValues({selectedOnly:true}))" Mode="Raw" />
                                                            </ExtraParams>
                                                        </SelectionChange>
                                                    </DirectEvents>

                                                </ext:RowSelectionModel>
                                            </SelectionModel>
                                            <View>
                                                <ext:GridView ID="GridViewMaster" runat="server">
                                                    <Listeners>
                                                        <Refresh Fn="setGroupStyle" />
                                                    </Listeners>
                                                </ext:GridView>
                                            </View>
                                            <Features>
                                                <ext:Grouping ID="GroupingMaster" runat="server" GroupHeaderTplString='{name}' />
                                            </Features>
                                        </ext:GridPanel>
                                    </Items>
                                </ext:Panel>

                                <ext:TabPanel ID="TabPanel1" runat="server" ActiveTabIndex="0" Split="true" Width="600" Plain="true" Region="South">
                                    <Items>
                                        <ext:Panel ID="Tab1" runat="server" Title="生产信息" MaxHeight="300" BodyPadding="6" Region="Center">
                                            <Items>
                                                <ext:GridPanel ID="gridPanel_pro" runat="server" Region="Center" Height="300">
                                                    <Store>
                                                        <ext:Store ID="pro_store" runat="server" PageSize="30">
                                                            <Model>
                                                                <ext:Model ID="model" runat="server">
                                                                    <Fields>
                                                                        <ext:ModelField Name="ITEMS" />
                                                                        <ext:ModelField Name="VALUES1" />
                                                                        <ext:ModelField Name="VALUES2" />
                                                                        <ext:ModelField Name="VALUES3" />
                                                                        <ext:ModelField Name="VALUES4" />
                                                                        <ext:ModelField Name="VALUES5" />
                                                                        <ext:ModelField Name="VALUES6" />
                                                                        <ext:ModelField Name="VALUES7" />
                                                                        <ext:ModelField Name="VALUES8" />
                                                                        <ext:ModelField Name="VALUES9" />
                                                                        <ext:ModelField Name="VALUES10" />
                                                                    </Fields>
                                                                </ext:Model>
                                                            </Model>
                                                        </ext:Store>
                                                    </Store>
                                                    <ColumnModel ID="columnModel2" runat="server">
                                                        <Columns>
                                                            <ext:RowNumbererColumn runat="server" />
                                                            <ext:Column ID="ITEMS" runat="server" HideTitleEl="true" Width="120" DataIndex="ITEMS"></ext:Column>
                                                            <ext:Column ID="VALUES1" runat="server" HideTitleEl="true" Width="300" DataIndex="VALUES1" />
                                                            <ext:Column ID="VALUES2" runat="server" HideTitleEl="true" Width="300" DataIndex="VALUES2" />
                                                            <ext:Column ID="VALUES3" runat="server" HideTitleEl="true" Width="300" DataIndex="VALUES3" />
                                                            <ext:Column ID="VALUES4" runat="server" HideTitleEl="true" Width="300" DataIndex="VALUES4" />
                                                            <ext:Column ID="VALUES5" runat="server" HideTitleEl="true" Width="300" DataIndex="VALUES5" />
                                                            <ext:Column ID="VALUES6" runat="server" HideTitleEl="true" Width="300" DataIndex="VALUES6" />
                                                            <ext:Column ID="VALUES7" runat="server" HideTitleEl="true" Width="300" DataIndex="VALUES7" />
                                                            <ext:Column ID="VALUES8" runat="server" HideTitleEl="true" Width="300" DataIndex="VALUES8" />
                                                            <ext:Column ID="VALUES9" runat="server" HideTitleEl="true" Width="300" DataIndex="VALUES9" />
                                                            <ext:Column ID="VALUES10" runat="server" HideTitleEl="true" Width="300" DataIndex="VALUES10" />
                                                        </Columns>
                                                    </ColumnModel>
                                                </ext:GridPanel>
                                            </Items>
                                            <Listeners>
                                                <Activate Fn="LoadProduction"></Activate>
                                            </Listeners>
                                        </ext:Panel>
                                        <ext:Panel ID="Tab2" runat="server" Title="工艺参数" MaxHeight="300" BodyPadding="6" Region="Center">
                                            <Items>
                                                <ext:GridPanel ID="gridPanel_tech" runat="server" Region="Center" Height="300">
                                                    <Store>
                                                        <ext:Store ID="tech_store" runat="server" PageSize="30">
                                                            <Model>
                                                                <ext:Model ID="model1" runat="server">
                                                                    <Fields>
                                                                        <ext:ModelField Name="ITEMS" />
                                                                        <ext:ModelField Name="VALUES1" />
                                                                        <ext:ModelField Name="VALUES2" />
                                                                        <ext:ModelField Name="VALUES3" />
                                                                        <ext:ModelField Name="VALUES4" />
                                                                        <ext:ModelField Name="VALUES5" />
                                                                        <ext:ModelField Name="VALUES6" />
                                                                        <ext:ModelField Name="VALUES7" />
                                                                        <ext:ModelField Name="VALUES8" />
                                                                        <ext:ModelField Name="VALUES9" />
                                                                        <ext:ModelField Name="VALUES10" />
                                                                    </Fields>
                                                                </ext:Model>
                                                            </Model>
                                                        </ext:Store>
                                                    </Store>
                                                    <ColumnModel ID="columnModel1" runat="server">
                                                        <Columns>
                                                            <ext:RowNumbererColumn runat="server" />
                                                            <ext:Column ID="Column11" runat="server" HideTitleEl="true" Width="200" DataIndex="ITEMS"></ext:Column>
                                                            <ext:Column ID="Column12" runat="server" HideTitleEl="true" Width="300" DataIndex="VALUES1" />
                                                            <ext:Column ID="Column13" runat="server" HideTitleEl="true" Width="300" DataIndex="VALUES2" />
                                                            <ext:Column ID="Column14" runat="server" HideTitleEl="true" Width="300" DataIndex="VALUES3" />
                                                            <ext:Column ID="Column15" runat="server" HideTitleEl="true" Width="300" DataIndex="VALUES4" />
                                                            <ext:Column ID="Column16" runat="server" HideTitleEl="true" Width="300" DataIndex="VALUES5" />
                                                            <ext:Column ID="Column17" runat="server" HideTitleEl="true" Width="300" DataIndex="VALUES6" />
                                                            <ext:Column ID="Column18" runat="server" HideTitleEl="true" Width="300" DataIndex="VALUES7" />
                                                            <ext:Column ID="Column19" runat="server" HideTitleEl="true" Width="300" DataIndex="VALUES8" />
                                                            <ext:Column ID="Column20" runat="server" HideTitleEl="true" Width="300" DataIndex="VALUES9" />
                                                            <ext:Column ID="Column21" runat="server" HideTitleEl="true" Width="300" DataIndex="VALUES10" />
                                                        </Columns>
                                                    </ColumnModel>
                                                </ext:GridPanel>
                                            </Items>
                                            <Listeners>
                                                <Activate Fn="LoadTech"></Activate>
                                            </Listeners>
                                        </ext:Panel>
                                        <ext:Panel ID="tab3" runat="server" Title="质量信息" MaxHeight="300" BodyPadding="6">
                                            <Items>
                                                <ext:GridPanel ID="gridPanel_q" runat="server" Region="Center" Height="300">
                                                    <Store>
                                                        <ext:Store ID="quality_store" runat="server" PageSize="30">
                                                            <Model>
                                                                <ext:Model ID="model2" runat="server">
                                                                    <Fields>
                                                                        <ext:ModelField Name="ITEMS" />
                                                                        <ext:ModelField Name="VALUES1" />
                                                                        <ext:ModelField Name="VALUES2" />
                                                                        <ext:ModelField Name="VALUES3" />
                                                                        <ext:ModelField Name="VALUES4" />
                                                                        <ext:ModelField Name="VALUES5" />
                                                                        <ext:ModelField Name="VALUES6" />
                                                                        <ext:ModelField Name="VALUES7" />
                                                                        <ext:ModelField Name="VALUES8" />
                                                                        <ext:ModelField Name="VALUES9" />
                                                                        <ext:ModelField Name="VALUES10" />
                                                                    </Fields>
                                                                </ext:Model>
                                                            </Model>
                                                        </ext:Store>
                                                    </Store>
                                                    <ColumnModel ID="columnModel" runat="server">
                                                        <Columns>
                                                            <ext:RowNumbererColumn runat="server" />
                                                            <ext:Column ID="Column22" runat="server" HideTitleEl="true" Width="300" DataIndex="ITEMS"></ext:Column>
                                                            <ext:Column ID="Column23" runat="server" HideTitleEl="true" Width="300" DataIndex="VALUES1" />
                                                            <ext:Column ID="Column24" runat="server" HideTitleEl="true" Width="300" DataIndex="VALUES2" />
                                                            <ext:Column ID="Column25" runat="server" HideTitleEl="true" Width="300" DataIndex="VALUES3" />
                                                            <ext:Column ID="Column26" runat="server" HideTitleEl="true" Width="300" DataIndex="VALUES4" />
                                                            <ext:Column ID="Column27" runat="server" HideTitleEl="true" Width="300" DataIndex="VALUES5" />
                                                            <ext:Column ID="Column28" runat="server" HideTitleEl="true" Width="300" DataIndex="VALUES6" />
                                                            <ext:Column ID="Column29" runat="server" HideTitleEl="true" Width="300" DataIndex="VALUES7" />
                                                            <ext:Column ID="Column30" runat="server" HideTitleEl="true" Width="300" DataIndex="VALUES8" />
                                                            <ext:Column ID="Column31" runat="server" HideTitleEl="true" Width="300" DataIndex="VALUES9" />
                                                            <ext:Column ID="Column32" runat="server" HideTitleEl="true" Width="300" DataIndex="VALUES10" />
                                                        </Columns>
                                                    </ColumnModel>
                                                </ext:GridPanel>
                                            </Items>
                                            <Listeners>
                                                <Activate Fn="LoadQuality"></Activate>
                                            </Listeners>
                                        </ext:Panel>
                                        <ext:Panel ID="tab6" runat="server" Title="库存信息" MaxHeight="300" BodyPadding="6">
                                            <Items>
                                                <ext:GridPanel ID="gridPanel_stock" runat="server" Region="Center" Height="300">
                                                    <Store>
                                                        <ext:Store ID="stock_store" runat="server" PageSize="30">
                                                            <Model>
                                                                <ext:Model ID="model3" runat="server">
                                                                    <Fields>
                                                                        <ext:ModelField Name="ITEMS" />
                                                                        <ext:ModelField Name="VALUES1" />
                                                                        <ext:ModelField Name="VALUES2" />
                                                                        <ext:ModelField Name="VALUES3" />
                                                                        <ext:ModelField Name="VALUES4" />
                                                                        <ext:ModelField Name="VALUES5" />
                                                                        <ext:ModelField Name="VALUES6" />
                                                                        <ext:ModelField Name="VALUES7" />
                                                                        <ext:ModelField Name="VALUES8" />
                                                                        <ext:ModelField Name="VALUES9" />
                                                                        <ext:ModelField Name="VALUES10" />
                                                                    </Fields>
                                                                </ext:Model>
                                                            </Model>
                                                        </ext:Store>
                                                    </Store>
                                                    <ColumnModel ID="columnModel3" runat="server">
                                                        <Columns>
                                                            <ext:RowNumbererColumn runat="server" />
                                                            <ext:Column ID="Column33" runat="server" HideTitleEl="true" Width="300" DataIndex="ITEMS"></ext:Column>
                                                            <ext:Column ID="Column34" runat="server" HideTitleEl="true" Width="300" DataIndex="VALUES1" />
                                                            <ext:Column ID="Column35" runat="server" HideTitleEl="true" Width="300" DataIndex="VALUES2" />
                                                            <ext:Column ID="Column36" runat="server" HideTitleEl="true" Width="300" DataIndex="VALUES3" />
                                                            <ext:Column ID="Column37" runat="server" HideTitleEl="true" Width="300" DataIndex="VALUES4" />
                                                            <ext:Column ID="Column38" runat="server" HideTitleEl="true" Width="300" DataIndex="VALUES5" />
                                                            <ext:Column ID="Column39" runat="server" HideTitleEl="true" Width="300" DataIndex="VALUES6" />
                                                            <ext:Column ID="Column40" runat="server" HideTitleEl="true" Width="300" DataIndex="VALUES7" />
                                                            <ext:Column ID="Column41" runat="server" HideTitleEl="true" Width="300" DataIndex="VALUES8" />
                                                            <ext:Column ID="Column42" runat="server" HideTitleEl="true" Width="300" DataIndex="VALUES9" />
                                                            <ext:Column ID="Column43" runat="server" HideTitleEl="true" Width="300" DataIndex="VALUES10" />
                                                        </Columns>
                                                    </ColumnModel>
                                                </ext:GridPanel>
                                            </Items>
                                            <Listeners>
                                                <Activate Fn="LoadStock"></Activate>
                                            </Listeners>
                                        </ext:Panel>
                                        <ext:Panel ID="tab4" runat="server" Title="曲线图" Height="500" BodyPadding="6" Region="Center">
                                            <Items>
                                               <ext:Toolbar runat="server">
                                                    <Items>
                                                        <ext:ComboBox runat="server" ID="curveCbx" FieldLabel="曲线类型">
                                                            <Items>
                                                                <ext:ListItem Text="内温" Value="1"/>
                                                                <ext:ListItem Text="内压" Value="2" />
                                                                <ext:ListItem Text="热板温度" Value="3" />
                                                                <ext:ListItem Text="热环温度" Value="4" />
                                                            </Items>
                                                        </ext:ComboBox>
                                                        <ext:ToolbarSeparator/>
                                                        <ext:Button runat="server" ID="BtnCurveSearch" Text="对比" Icon="ChartCurve" >
                                                            <Listeners>
                                                                <Click Fn="LoadCurve"></Click>
                                                            </Listeners>
                                                        </ext:Button>
                                                    </Items>
                                               </ext:Toolbar>
                                                <ext:Panel runat="server" ID="curvePanel" Region="Center" Height="500">
                                                </ext:Panel>
                                            </Items>
                                            <%-- <Listeners>
                                                <Activate Fn="LoadCurve"></Activate>
                                            </Listeners>--%>
                                        </ext:Panel>
                                        <ext:Panel ID="tab5" runat="server" Title="报警日志" MaxHeight="300" BodyPadding="6">
                                            <Items>
                                                <ext:GridPanel ID="gridPanel_alarm" runat="server" Region="Center" Height="300">
                                                    <Store>
                                                        <ext:Store ID="alarm_store" runat="server" PageSize="30">
                                                            <Model>
                                                                <ext:Model ID="model4" runat="server">
                                                                    <Fields>
                                                                        <ext:ModelField Name="TYRE_NO" />
                                                                        <ext:ModelField Name="EQUIP_NAME" />
                                                                        <ext:ModelField Name="ALARM_BEGIN_TIME" />
                                                                        <ext:ModelField Name="ALARM_END_TIME" />
                                                                        <ext:ModelField Name="ITEM_NAME" />
                                                                        <ext:ModelField Name="MAX_VALUE" />
                                                                        <ext:ModelField Name="MIN_VALUE" />
                                                                        <ext:ModelField Name="SET_VALUE" />
                                                                        <ext:ModelField Name="CURING_STEP" />
                                                                        <ext:ModelField Name="USER_NAME" />
                                                                    </Fields>
                                                                </ext:Model>
                                                            </Model>
                                                        </ext:Store>
                                                    </Store>
                                                    <ColumnModel ID="columnModel4" runat="server">
                                                        <Columns>
                                                            <ext:RowNumbererColumn runat="server" />
                                                            <ext:Column ID="Column1" runat="server" Text="胎号" Width="100" DataIndex="TYRE_NO"></ext:Column>
                                                            <ext:Column ID="Column2" runat="server" Text="机台" Width="50" DataIndex="EQUIP_NAME" />
                                                            <ext:Column ID="Column9" runat="server" Text="步序" Width="50" DataIndex="CURING_STEP" />
                                                            <ext:Column ID="Column3" runat="server" Text="报警开始时间" Width="150" DataIndex="ALARM_BEGIN_TIME"></ext:Column>
                                                            <ext:Column ID="Column4" runat="server" Text="报警结束时间" Width="150" DataIndex="ALARM_END_TIME" />
                                                            <ext:Column ID="Column5" runat="server" Text="报警原因" Width="100" DataIndex="ITEM_NAME"></ext:Column>
                                                            <ext:Column ID="Column6" runat="server" Text="最大值" Width="50" DataIndex="MAX_VALUE" />
                                                            <ext:Column ID="Column7" runat="server" Text="最小值" Width="50" DataIndex="MIN_VALUE"></ext:Column>
                                                            <ext:Column ID="Column8" runat="server" Text="设定值" Width="50" DataIndex="SET_VALUE" />
                                                            <ext:Column ID="Column10" runat="server" Text="硫化工" Width="50" Flex="1" DataIndex="USER_NAME" />
                                                        </Columns>
                                                    </ColumnModel>
                                                </ext:GridPanel>
                                            </Items>
                                            <Listeners>
                                                <Activate Fn="LoadAlarm"></Activate>
                                            </Listeners>
                                        </ext:Panel>
                                        <ext:Panel ID="tab7" runat="server" Title="称量信息" MaxHeight="300" BodyPadding="6">
                                            <Items>
                                                <ext:GridPanel ID="gridPanel1" runat="server" Region="Center" Height="300">
                                                    <Store>
                                                        <ext:Store ID="weight_store" runat="server" PageSize="30">
                                                            <Model>
                                                                <ext:Model ID="model5" runat="server">
                                                                    <Fields>
                                                                        <ext:ModelField Name="车条码" />
                                                                        <ext:ModelField Name="物料名称" />
                                                                        <ext:ModelField Name="设重" />
                                                                        <ext:ModelField Name="实重" />
                                                                        <ext:ModelField Name="超差" />
                                                                        <ext:ModelField Name="公差" />
                                                                        <ext:ModelField Name="是否超差" />
                                                                        <ext:ModelField Name="物料类型" />
                                                                    </Fields>
                                                                </ext:Model>
                                                            </Model>
                                                        </ext:Store>
                                                    </Store>
                                                    <ColumnModel ID="columnModel5" runat="server">
                                                        <Columns>
                                                            <ext:RowNumbererColumn runat="server" />
                                                            <ext:Column ID="Column44" runat="server" Text="车条码" Width="100" DataIndex="车条码"></ext:Column>
                                                            <ext:Column ID="Column45" runat="server" Text="物料名称" Width="100" DataIndex="物料名称" />
                                                            <ext:Column ID="Column46" runat="server" Text="设重" Width="50" DataIndex="设重" />
                                                            <ext:Column ID="Column47" runat="server" Text="实重" Width="50" DataIndex="实重" />
                                                            <ext:Column ID="Column48" runat="server" Text="公差" Width="50" DataIndex="公差" />
                                                            <ext:Column ID="Column49" runat="server" Text="超差" Width="50" DataIndex="超差" />
                                                            <ext:Column ID="Column50" runat="server" Text="是否超差" Width="50" DataIndex="是否超差" />
                                                            <ext:Column ID="Column51" runat="server" Text="物料类型" Width="50" DataIndex="物料类型" />
                                                        </Columns>
                                                    </ColumnModel>
                                                </ext:GridPanel>
                                            </Items>
                                            <Listeners>
                                                <Activate Fn="LoadWeight"></Activate>
                                            </Listeners>
                                        </ext:Panel>
                                        <ext:Panel ID="tab8" runat="server" Title="混炼信息" MaxHeight="300" BodyPadding="6">
                                            <Items>
                                                <ext:GridPanel ID="gridPanel2" runat="server" Region="Center" Height="300">
                                                    <Store>
                                                        <ext:Store ID="mix_store" runat="server" PageSize="30">
                                                            <Model>
                                                                <ext:Model ID="model6" runat="server">
                                                                    <Fields>
                                                                        <ext:ModelField Name="BARCODE" />
                                                                        <ext:ModelField Name="MIXID" />
                                                                        <ext:ModelField Name="TERMCODE" />
                                                                        <ext:ModelField Name="SETTIME" />
                                                                        <ext:ModelField Name="SETEMP" />
                                                                        <ext:ModelField Name="SETENER" />
                                                                        <ext:ModelField Name="SETPOWER" />
                                                                        <ext:ModelField Name="SETPRES" />
                                                                        <ext:ModelField Name="SETROTA" />
                                                                        <ext:ModelField Name="ACTCODE" />
                                                                        <ext:ModelField Name="SAVETIME" />
                                                                        <ext:ModelField Name="PFTIME" />
                                                                        <ext:ModelField Name="PFTEMP" />
                                                                        <ext:ModelField Name="PFENER" />
                                                                        <ext:ModelField Name="PFPOWER" />
                                                                        <ext:ModelField Name="PFPRES" />
                                                                        <ext:ModelField Name="PFROTA" />
                                                                    </Fields>
                                                                </ext:Model>
                                                            </Model>
                                                        </ext:Store>
                                                    </Store>
                                                    <ColumnModel ID="columnModel6" runat="server">
                                                        <Columns>
                                                            <ext:Column ID="Column52" runat="server" Text="车条码" Width="100" DataIndex="BARCODE"></ext:Column>
                                                            <ext:Column ID="Column53" runat="server" Text="步骤" Width="50" DataIndex="MIXID" />
                                                            <ext:Column ID="Column54" runat="server" Text="条件名称" Width="50" DataIndex="TERMCODE" />
                                                            <ext:Column ID="Column55" runat="server" Text="时间" Width="50" DataIndex="SETTIME" />
                                                            <ext:Column ID="Column56" runat="server" Text="温度" Width="50" DataIndex="SETEMP" />
                                                            <ext:Column ID="Column57" runat="server" Text="能量" Width="50" DataIndex="SETENER" />
                                                            <ext:Column ID="Column58" runat="server" Text="功率" Width="50" DataIndex="SETPOWER" />
                                                            <ext:Column ID="Column61" runat="server" Text="动作名称" Width="100" DataIndex="ACTCODE" />
                                                            <ext:Column ID="Column60" runat="server" Text="压力" Width="50" DataIndex="SETPRES" />
                                                            <ext:Column ID="Column59" runat="server" Text="转速" Width="50" DataIndex="SETROTA" />
                                                        </Columns>
                                                    </ColumnModel>
                                                </ext:GridPanel>
                                            </Items>
                                            <Listeners>
                                                <Activate Fn="LoadMix"></Activate>
                                            </Listeners>
                                        </ext:Panel>
                                        <ext:Panel ID="tab9" runat="server" Title="批次信息" MaxHeight="300" BodyPadding="6">
                                            <Items>
                                                <ext:GridPanel ID="gridPanel3" runat="server" Region="Center" Height="300">
                                                    <Store>
                                                        <ext:Store ID="batch_store" runat="server" PageSize="30">
                                                            <Model>
                                                                <ext:Model ID="model7" runat="server">
                                                                    <Fields>
                                                                        <ext:ModelField Name="BARCODE" />
                                                                        <ext:ModelField Name="MATERIALNAME" />
                                                                        <ext:ModelField Name="BILLNO" />
                                                                        <ext:ModelField Name="PRODUCTNO" />
                                                                        <ext:ModelField Name="PROCDATE" />
                                                                        <ext:ModelField Name="RECORDDATE" />
                                                                        <ext:ModelField Name="FACNAME" />
                                                                        <ext:ModelField Name="LLBARCODE" />
                                                                    </Fields>
                                                                </ext:Model>
                                                            </Model>
                                                        </ext:Store>
                                                    </Store>
                                                    <ColumnModel ID="columnModel7" runat="server">
                                                        <Columns>
                                                            <ext:Column ID="Column62" runat="server" Text="批次条码" Width="150" DataIndex="BARCODE"></ext:Column>
                                                            <ext:Column ID="Column63" runat="server" Text="物料名称" Width="50" DataIndex="MATERIALNAME" />
                                                            <ext:Column ID="Column64" runat="server" Text="入库单号" Width="50" DataIndex="BILLNO" />
                                                            <ext:Column ID="Column69" runat="server" Text="玲珑批次号" Width="100" DataIndex="LLBARCODE" />
                                                            <ext:Column ID="Column65" runat="server" Text="批次号" Width="50" DataIndex="PRODUCTNO" />
                                                            <ext:Column ID="Column66" runat="server" Text="生产日期" Width="50" DataIndex="PROCDATE" />
                                                            <ext:Column ID="Column67" runat="server" Text="入库日期" Width="50" DataIndex="RECORDDATE" />
                                                            <ext:Column ID="Column68" runat="server" Text="生产厂家" Width="50" DataIndex="FACNAME" />
                                                        </Columns>
                                                    </ColumnModel>
                                                </ext:GridPanel>
                                            </Items>
                                            <Listeners>
                                                <Activate Fn="LoadBatch"></Activate>
                                            </Listeners>
                                        </ext:Panel>
                                    </Items>
                                </ext:TabPanel>
                            </Items>
                        </ext:Panel>
                    </Items>
                </ext:Panel>
                <ext:Hidden runat="server" ID="HiddenRegex" />
                <ext:Hidden runat="server" ID="HiddenTyreCount" />
                <ext:Hidden runat="server" ID="HiddenBarcodes" />
                <ext:Hidden runat="server" ID="HiddenProcess" />
            </Items>
        </ext:Viewport>
    </form>
</body>
</html>
