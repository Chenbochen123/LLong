<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Search_Detail_forward.aspx.cs" Inherits="Tracing_Forward_Search_Detail_forward" %>

<%@ Register Assembly="Ext.Net" Namespace="Ext.Net" TagPrefix="ext" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="head" runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>条码正向追溯</title>
    <!--通用-->
    <link rel="Stylesheet" type="text/css" href="<%= Page.ResolveUrl("~/") %>resources/css/ext-chinese-font.css" />
    <link rel="Stylesheet" type="text/css" href="<%= Page.ResolveUrl("~/") %>resources/css/main.css" />
    <script src="<%= Page.ResolveUrl("~/") %>resources/js/waitwindow.js"></script>
    <%--<script src="<%= Page.ResolveUrl("./") %>Search.js?_dc=<%= DateTime.Now.ToString("yyyyMMddHHmmss") %>"></script>--%>

    <script type="text/javascript">
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
        var RefleshChart = function (barcode) {
            App.tab4.getBody().update("<iframe src='../Tracing_Back/CuringPressTemp2.aspx?Barcode=" + barcode + "' width=100% height=100% scrolling=no  frameborder=0></iframe>");
        }
        var nodeJson;
        var nodeAllJson;
        var UnionNodeTree = function (node) {
            nodeJson = { nodeId: node.getId(), nodeText: node.data.text, nodeLevel: node.getDepth() }
            if (App.treeJson.getValue() != null && App.treeJson.getValue() != "") {
                nodeAllJson = App.treeJson.getValue() + "," + JSON.stringify(nodeJson);
            } else {
                nodeAllJson = JSON.stringify(nodeJson);
            }
            App.treeJson.setValue(nodeAllJson.toString());
            //alert(App.treeJson.getValue());
        }
        //var task = new Ext.util.DelayedTask(refresh_panel);
        //task.delay(500);

        function refresh_panel() {
            before();
            App.direct.Lazy_Delay_Load({
                success: function (result) {
                    after();
                },
                failure: function (errorMsg) {
                    after();
                    Ext.Msg.alert('提示', "追溯数据加载异常!");
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
    <form id="form" runat="server">
        <ext:ResourceManager ID="resourceManager" runat="server" />
        <ext:Viewport ID="viewport" runat="server" Layout="BorderLayout">
            <Items>
                <ext:Panel ID="PanelInfo" runat="server" Region="Center" AutoHeight="true" Layout="BorderLayout" Flex="1">
                    <Items>
                        <ext:TabPanel ID="TabPanel1" runat="server" ActiveTabIndex="0" Width="600" Height="250" Plain="true" Region="Center">
                            <Items>
                                <ext:Panel ID="Tab1" runat="server" Title="生产信息" Flex="1" BodyPadding="6" AutoScroll="true" Region="Center">
                                    <Items>
                                        <ext:GridPanel ID="gridPanel_pro" runat="server" Region="Center">
                                            <Store>
                                                <ext:Store ID="pro_store" runat="server" PageSize="30">
                                                    <Model>
                                                        <ext:Model ID="model" runat="server">
                                                            <Fields>
                                                                <ext:ModelField Name="ITEMS" />
                                                                <ext:ModelField Name="VALUES" />
                                                            </Fields>
                                                        </ext:Model>
                                                    </Model>
                                                </ext:Store>
                                            </Store>
                                            <ColumnModel ID="columnModel2" runat="server">
                                                <Columns>
                                                    <ext:RowNumbererColumn runat="server" />
                                                    <ext:Column ID="ITEMS" runat="server" HideTitleEl="true" Width="300" DataIndex="ITEMS"></ext:Column>
                                                    <ext:Column ID="VALUES" runat="server" Text="" HideTitleEl="true" Width="300" DataIndex="VALUES" />
                                                </Columns>
                                            </ColumnModel>
                                        </ext:GridPanel>
                                    </Items>
                                    <Listeners>
                                        <Activate Fn="LoadProduction"></Activate>
                                    </Listeners>
                                </ext:Panel>
                                <ext:Panel ID="Tab2" runat="server" Title="工艺参数" Flex="1" BodyPadding="6" AutoScroll="true">
                                    <Items>
                                        <ext:GridPanel ID="gridPanel_tech" runat="server" Region="Center">
                                            <Store>
                                                <ext:Store ID="tech_store" runat="server" PageSize="30">
                                                    <Model>
                                                        <ext:Model ID="model1" runat="server">
                                                            <Fields>
                                                                <ext:ModelField Name="ITEMS" />
                                                                <ext:ModelField Name="VALUES" />
                                                            </Fields>
                                                        </ext:Model>
                                                    </Model>
                                                </ext:Store>
                                            </Store>
                                            <ColumnModel ID="columnModel1" runat="server">
                                                <Columns>
                                                    <ext:RowNumbererColumn runat="server" />
                                                    <ext:Column ID="TECH_ITEMS" runat="server" HideTitleEl="true" Width="300" DataIndex="ITEMS"></ext:Column>
                                                    <ext:Column ID="TECH_VALUES" runat="server" Text="状态" HideTitleEl="true" Width="300" DataIndex="VALUES" />
                                                </Columns>
                                            </ColumnModel>
                                        </ext:GridPanel>
                                    </Items>
                                    <Listeners>
                                        <Activate Fn="LoadTech"></Activate>
                                    </Listeners>
                                </ext:Panel>
                                <ext:Panel ID="tab3" runat="server" Title="质量信息" Flex="1" BodyPadding="6" AutoScroll="true">
                                    <Items>
                                        <ext:GridPanel ID="gridPanel_q" runat="server" Region="North">
                                            <Store>
                                                <ext:Store ID="quality_store" runat="server" PageSize="30">
                                                    <Model>
                                                        <ext:Model ID="model2" runat="server">
                                                            <Fields>
                                                                <ext:ModelField Name="ITEMS" />
                                                                <ext:ModelField Name="VALUES" />
                                                            </Fields>
                                                        </ext:Model>
                                                    </Model>
                                                </ext:Store>
                                            </Store>
                                            <ColumnModel ID="columnModel" runat="server">
                                                <Columns>
                                                    <ext:RowNumbererColumn runat="server" />
                                                    <ext:Column ID="Q_ITEMS" runat="server" HideTitleEl="true" Width="300" DataIndex="ITEMS"></ext:Column>
                                                    <ext:Column ID="Q_VALUES" runat="server" Text="状态" Width="300" HideTitleEl="true" DataIndex="VALUES" />
                                                </Columns>
                                            </ColumnModel>
                                        </ext:GridPanel>
                                    </Items>
                                    <Listeners>
                                        <Activate Fn="LoadQuality"></Activate>
                                    </Listeners>
                                </ext:Panel>
                                <ext:Panel ID="tab6" runat="server" Title="库存信息" Flex="1" BodyPadding="6" AutoScroll="true">
                                    <Items>
                                        <ext:GridPanel ID="gridPanel_stock" runat="server" Region="North">
                                            <Store>
                                                <ext:Store ID="stock_store" runat="server" PageSize="30">
                                                    <Model>
                                                        <ext:Model ID="model3" runat="server">
                                                            <Fields>
                                                                <ext:ModelField Name="ITEMS" />
                                                                <ext:ModelField Name="VALUES" />
                                                            </Fields>
                                                        </ext:Model>
                                                    </Model>
                                                </ext:Store>
                                            </Store>
                                            <ColumnModel ID="columnModel3" runat="server">
                                                <Columns>
                                                    <ext:RowNumbererColumn runat="server" />
                                                    <ext:Column ID="S_ITEMS" runat="server" HideTitleEl="true" Width="300" DataIndex="ITEMS"></ext:Column>
                                                    <ext:Column ID="S_VALUES" runat="server" Text="状态" Width="300" HideTitleEl="true" DataIndex="VALUES" />
                                                </Columns>
                                            </ColumnModel>
                                        </ext:GridPanel>
                                    </Items>
                                    <Listeners>
                                        <Activate Fn="LoadStock"></Activate>
                                    </Listeners>
                                </ext:Panel>
                                <ext:Panel ID="tab4" runat="server" Title="曲线图" Flex="1" BodyPadding="6" AutoScroll="true">
                                    <Listeners>
                                        <Activate Fn="LoadCurve"></Activate>
                                    </Listeners>
                                </ext:Panel>
                                <ext:Panel ID="tab5" runat="server" Title="报警日志" Flex="1" BodyPadding="6" AutoScroll="true">
                                    <Items>
                                        <ext:GridPanel ID="gridPanel_alarm" runat="server" Region="Center">
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
                            </Items>
                        </ext:TabPanel>
                    </Items>
                </ext:Panel>
                <ext:Hidden runat="server" ID="refreshHidden" />
                <ext:Hidden runat="server" ID="treeJson" />
                <ext:Hidden runat="server" ID="treeJsonTarget" />
                <ext:Hidden runat="server" ID="HiddCurrentProcess" />
                <ext:Hidden runat="server" ID="HiddBarcode" />
            </Items>
        </ext:Viewport>
    </form>
</body>
</html>
