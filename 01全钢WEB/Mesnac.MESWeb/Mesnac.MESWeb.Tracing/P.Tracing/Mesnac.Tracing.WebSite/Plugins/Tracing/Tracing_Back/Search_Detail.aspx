<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Search_Detail.aspx.cs" Inherits="Tracing_Back_Search_Detail" %>

<%@ Register Assembly="Ext.Net" Namespace="Ext.Net" TagPrefix="ext" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="head" runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>条码追溯</title>
    <!--通用-->
    <link rel="Stylesheet" type="text/css" href="<%= Page.ResolveUrl("~/") %>resources/css/ext-chinese-font.css" />
    <link rel="Stylesheet" type="text/css" href="<%= Page.ResolveUrl("~/") %>resources/css/main.css" />
    <script type="text/javascript" src="<%= Page.ResolveUrl("~/") %>resources/js/jquery-1.7.1.js"></script>
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
            App.tab4.getBody().update("<iframe src='CuringPressTemp2.aspx?Barcode=" + barcode + "' width=100% height=100% scrolling=no  frameborder=0></iframe>");
        }

        var RefleshChart2 = function (equipid, Typeid, begintime, endtime) {
            App.tab4.getBody().update("<iframe src='SemisTechFhx.aspx?Typeid=" + Typeid + "&Equipid=" + equipid + "&BeginTime= " + begintime + "&EndTime= " + endtime + "' width=100% height=100% scrolling=no  frameborder=0></iframe>");
        }
        var RefleshChart3 = function (equipid, Typeid, begintime, endtime) {
            App.tab4.getBody().update("<iframe src='SemisTechNcc.aspx?Typeid=" + Typeid + "&Equipid=" + equipid + "&BeginTime= " + begintime + "&EndTime= " + endtime + "' width=100% height=100% scrolling=no  frameborder=0></iframe>");
        }
        var RefleshChart4 = function (equipid, Typeid, begintime, endtime) {
            App.tab4.getBody().update("<iframe src='SemisTechXc15.aspx?Typeid=" + Typeid + "&Equipid=" + equipid + "&BeginTime= " + begintime + "&EndTime= " + endtime + "' width=100% height=100% scrolling=no  frameborder=0></iframe>");
        }
        var RefleshChart5 = function (equipid, Typeid, begintime, endtime) {
            App.tab4.getBody().update("<iframe src='SemisTechZc90.aspx?Typeid=" + Typeid + "&Equipid=" + equipid + "&BeginTime= " + begintime + "&EndTime= " + endtime + "' width=100% height=100% scrolling=no  frameborder=0></iframe>");
        }
        var RefleshChart6 = function (equipid, Typeid, begintime, endtime) {
            App.tab4.getBody().update("<iframe src='SemisTechBjp.aspx?Typeid=" + Typeid + "&Equipid=" + equipid + "&BeginTime= " + begintime + "&EndTime= " + endtime + "' width=100% height=100% scrolling=no  frameborder=0></iframe>");
        }
        var RefleshChart7 = function (equipid, Typeid, begintime, endtime, Typeid2) {
            App.tab4.getBody().update("<iframe src='SemisTechGsyy.aspx?Typeid=" + Typeid + "&Equipid=" + equipid + "&BeginTime=" + begintime + "&EndTime=" + endtime + "&Typeid2=" + Typeid2 + "' width=100% height=100% scrolling=no  frameborder=0></iframe>");
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
        showDetailWindow = function (shelf, path) {
            var url = path + "?Shelf=" + shelf;
            var tabid = "DETAILFORORACLE" + shelf;
            var tabp = parent.App.mainTabPanel;
            var tab = tabp.getComponent("id=" + tabid);
            if (tab) {
                tab.close();
            }
            debugger;
            parent.addTab(tabid, "每车明细信息（" + shelf + ")", url, true);
        }
    </script>
</head>
<body>
    <form id="form" runat="server">
        <asp:Button ID="btnExportSubmit" Style="display: none" runat="server" Text="Button"
            OnClick="btnExportSubmit_Click" />
        <ext:ResourceManager ID="resourceManager" runat="server" />
        <ext:Viewport ID="viewport" runat="server" Layout="BorderLayout">
            <Items>
                <ext:Panel ID="Panel1" runat="server" Region="Center" AutoHeight="true" Layout="BorderLayout">
                    <Items>
                        <ext:Panel ID="pnlUnitTitle" runat="server" Region="North" AutoHeight="true">
                            <TopBar>
                                <ext:Toolbar runat="server" ID="barUnit">
                                    <Items>
                                        <ext:Button runat="server" Icon="PageExcel" Text="导出" ID="btnExport">
                                            <ToolTips>
                                                <ext:ToolTip ID="ttbtnExport" runat="server" Html="导出条码相关追溯信息" />
                                            </ToolTips>
                                            <Listeners>
                                                <Click Handler="$('#btnExportSubmit').click();">
                                                </Click>
                                            </Listeners>
                                        </ext:Button>
                                        <ext:ComboBox runat="server" ID="ComboBox1"
                                            Editable="false"
                                            QueryMode="Local"
                                            TriggerAction="All"
                                            EmptyText="选择复合曲线类型">
                                            <Triggers>
                                                <ext:FieldTrigger Icon="Clear" Qtip="清空" />
                                            </Triggers>
                                            <Listeners>
                                                <TriggerClick Handler="this.setValue('');" />
                                            </Listeners>
                                            <Items>
                                                <ext:ListItem Text="温度" Value="Temp" />
                                                <ext:ListItem Text="温控温度" Value="WKTemp" />
                                                <ext:ListItem Text="机筒温控" Value="JTTemp" />
                                                <ext:ListItem Text="销钉温控" Value="XDTemp" />
                                                <ext:ListItem Text="螺杆温控" Value="LGTemp" />
                                                <ext:ListItem Text="压力" Value="Press" />
                                                <ext:ListItem Text="速度" Value="BG" />
                                                <ext:ListItem Text="电流" Value="CA" />
                                                <ext:ListItem Text="转速" Value="CL" />
                                                <ext:ListItem Text="米重" Value="MZ" />
                                                <ext:ListItem Text="口型盒" Value="KXH" />
                                                <ext:ListItem Text="宽度" Value="KD" />
                                                <ext:ListItem Text="收缩比" Value="SSB" />
                                            </Items>
                                        </ext:ComboBox>
                                        <ext:ComboBox runat="server" ID="ComboBox2"
                                            Editable="false"
                                            QueryMode="Local"
                                            TriggerAction="All"
                                            EmptyText="选择内衬曲线类型">
                                            <Triggers>
                                                <ext:FieldTrigger Icon="Clear" Qtip="清空" />
                                            </Triggers>
                                            <Listeners>
                                                <TriggerClick Handler="this.setValue('');" />
                                            </Listeners>
                                            <Items>
                                                <ext:ListItem Text="挤出温度" Value="NccJCTemp" />
                                                <ext:ListItem Text="压延温度" Value="NccYYTemp" />
                                                <ext:ListItem Text="冷却温度" Value="NccLQTEMP" />
                                                <ext:ListItem Text="厚度" Value="NccHD" />
                                                <ext:ListItem Text="宽度" Value="NccKD" />
                                                <ext:ListItem Text="侧轴" Value="NccCZ" />
                                                <ext:ListItem Text="速度" Value="NccSpeed" />
                                                <ext:ListItem Text="压力" Value="NccPress" />
                                            </Items>
                                        </ext:ComboBox>
                                        <ext:ComboBox runat="server" ID="ComboBox3"
                                            Editable="false"
                                            QueryMode="Local"
                                            TriggerAction="All"
                                            EmptyText="选择裁断曲线类型" Hidden="true">
                                            <Triggers>
                                                <ext:FieldTrigger Icon="Clear" Qtip="清空" />
                                            </Triggers>
                                            <Listeners>
                                                <TriggerClick Handler="this.setValue('');" />
                                            </Listeners>
                                            <Items>
                                                <ext:ListItem Text="宽度" Value="0" />
                                                <ext:ListItem Text="宽度CPK" Value="1" />
                                            </Items>
                                        </ext:ComboBox>
                                        <ext:ComboBox runat="server" ID="ComboBox4"
                                            Editable="false"
                                            QueryMode="Local"
                                            TriggerAction="All"
                                            EmptyText="选择薄胶片曲线类型">
                                            <Triggers>
                                                <ext:FieldTrigger Icon="Clear" Qtip="清空" />
                                            </Triggers>
                                            <Listeners>
                                                <TriggerClick Handler="this.setValue('');" />
                                            </Listeners>
                                            <Items>
                                                <ext:ListItem Text="温度" Value="Temp3"  />
                                                <ext:ListItem Text="速度" Value="Speed" />
                                                <ext:ListItem Text="厚度宽度" Value="HDKD" />
                                                <ext:ListItem Text="侧轴" Value="CZ" />
                                            </Items>
                                        </ext:ComboBox>
                                        <ext:ComboBox runat="server" ID="ComboBox5"
                                            Editable="false"
                                            QueryMode="Local"
                                            TriggerAction="All"
                                            EmptyText="选择纲压曲线类型" MultiSelect="true">
                                            <Triggers>
                                                <ext:FieldTrigger Icon="Clear" Qtip="清空" />
                                            </Triggers>
                                            <Listeners>
                                                <TriggerClick Handler="this.setValue('');" />
                                            </Listeners>
                                            <Items>
                                                <ext:ListItem Text="东北温度" Value="NORTHEASTTEMP"  />
                                                <ext:ListItem Text="东南温度" Value="SOUTHEASTTEMP" />
                                                <ext:ListItem Text="西北温度" Value="NORTHWESTTEMP" />
                                                <ext:ListItem Text="西南温度" Value="SOUTHWESTTEMP" />
                                                <ext:ListItem Text="中部温度" Value="MIDDLETEMP" />
                                                <ext:ListItem Text="室外温度" Value="OUTSIDETEMP" />
                                                <ext:ListItem Text="东北湿度" Value="NORTHEASTHUMI" />
                                                <ext:ListItem Text="东南湿度" Value="SOUTHEASTHUMI" />
                                                <ext:ListItem Text="西北湿度" Value="NORTHWESTHUMI" />
                                                <ext:ListItem Text="西南湿度" Value="SOUTHWESTHUMI" />
                                                <ext:ListItem Text="中部湿度" Value="MIDDLEHUMI" />
                                                <ext:ListItem Text="供胶温度1" Value="RUBBERTEMP1" />
                                                <ext:ListItem Text="供胶温度2" Value="RUBBERTEMP2" />
                                                <ext:ListItem Text="辊1温度" Value="G1TEMP" />
                                                <ext:ListItem Text="辊2温度" Value="G2TEMP" />
                                                <ext:ListItem Text="辊3温度" Value="G3TEMP" />
                                                <ext:ListItem Text="辊4温度" Value="G4TEMP" />
                                                <ext:ListItem Text="上胶片厚度" Value="TOPRUBBERTHICKNESS" />
                                                <ext:ListItem Text="下胶片厚度" Value="BOTTOMRUBBERTHICKNESS" />
                                                <ext:ListItem Text="总厚度" Value="TOTALTHICKNESS" />
                                                <ext:ListItem Text="总厚度CPK" Value="TOTALTHICKNESSCPK" />
                                                <ext:ListItem Text="冷却水温度1" Value="LQSTEMP1" />
                                                <ext:ListItem Text="冷却水温度2" Value="LQSTEMP2" />
                                                <ext:ListItem Text="进水压力" Value="LQSJSPRE" />
                                                <ext:ListItem Text="出水压力" Value="LQSCSPRE" />
                                                <ext:ListItem Text="压力差" Value="LQSPREDIF" />
                                                <ext:ListItem Text="卷曲温度" Value="JQTEMP" />
                                                <ext:ListItem Text="风压" Value="WINDPRESSURE" />
                                                <ext:ListItem Text="生产线速度" Value="SCXSPEED" />
                                                <ext:ListItem Text="1辊速比" Value="GSB1" />
                                                <ext:ListItem Text="2辊速比" Value="GSB2" />
                                                <ext:ListItem Text="4辊速比" Value="GSB4" />
                                                <ext:ListItem Text="1辊间距加热端" Value="JJJRD1HEAT" />
                                                <ext:ListItem Text="2辊间距加热端" Value="JJJRD2HEAT" />
                                                <ext:ListItem Text="4辊间距加热端" Value="JJJRD4HEAT" />
                                                <ext:ListItem Text="1辊间距传动端" Value="JJCDD1DRIVE" />
                                                <ext:ListItem Text="2辊间距传动端" Value="JJCDD2DRIVE" />
                                                <ext:ListItem Text="4辊间距传动端" Value="JJCDD4DRIVE" />
                                                <ext:ListItem Text="1辊交叉加热端" Value="JXJRD1HEAT" />
                                                <ext:ListItem Text="4辊交叉加热端" Value="JCJRD4HEAT" />
                                                <ext:ListItem Text="1辊交叉传动端" Value="JCCDD1DRIVE" />
                                                <ext:ListItem Text="4辊交叉传动端" Value="JXCDD4DRIVE" />
                                                <ext:ListItem Text="储布张力" Value="CBZTENSION" />
                                                <ext:ListItem Text="冷却张力" Value="LQTENSION" />
                                                <ext:ListItem Text="卷曲张力" Value="JQTENSION" />
                                            </Items>
                                        </ext:ComboBox>
                                        <ext:ToolbarFill ID="toolbarFill2" />
                                    </Items>
                                </ext:Toolbar>
                            </TopBar>
                        </ext:Panel>
                        <ext:Panel ID="Panel2" runat="server" Region="West" Width="330" AutoHeight="true" Layout="BorderLayout">
                            <Items>
                                <ext:TreePanel ID="PanelTree" runat="server" Region="Center" Title="追溯结构">
                                    <Store>
                                        <ext:TreeStore ID="TreeStore1" runat="server">
                                            <Root>
                                                <ext:Node NodeID="Root">
                                                </ext:Node>
                                            </Root>
                                            <Listeners>
                                                <BeforeLoad Fn="nodeLoad" />
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
                                </ext:TreePanel>
                            </Items>
                        </ext:Panel>
                        <ext:Panel ID="PanelInfo" runat="server" Region="Center" Title="生产明细信息" Layout="BorderLayout">
                            <Items>
                                <ext:Panel ID="Tab1" runat="server" Flex="11" BodyPadding="6" AutoScroll="true" Region="North">
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
                                                    <ext:Column ID="VALUES" runat="server" Text="状态" HideTitleEl="true" Width="300" DataIndex="VALUES" />
                                                </Columns>
                                            </ColumnModel>
                                        </ext:GridPanel>
                                    </Items>
                                    <Listeners>
                                        <Activate Fn="LoadProduction"></Activate>
                                    </Listeners>
                                </ext:Panel>
                                <ext:Panel ID="Panel3" runat="server" Region="Center" AutoHeight="true" Layout="BorderLayout" Flex="25">
                                    <Items>
                                        <ext:TabPanel ID="TabPanel1" runat="server" Region="Center" ActiveIndex="0" DefaultBorder="false"
                                            AutoScroll="false" MinTabWidth="160">
                                            <Items>
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
                                                <%--<ext:Panel ID="tab6" runat="server" Title="库存信息" Flex="1" BodyPadding="6" AutoScroll="true">
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
                                                </ext:Panel>--%>
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
                            </Items>
                        </ext:Panel>
                    </Items>
                </ext:Panel>
                <ext:Hidden runat="server" ID="refreshHidden" />
                <ext:Hidden runat="server" ID="treeJson" />
                <ext:Hidden runat="server" ID="treeJsonTarget" />
                <ext:Hidden runat="server" ID="HiddCurrentProcess" />
                <ext:Hidden runat="server" ID="HiddBarcode" />
                <ext:Hidden runat="server" ID="HiddenEquip" />
                <ext:Hidden runat="server" ID="HiddenBeginTime" />
                <ext:Hidden runat="server" ID="HiddenEndTime" />
                <ext:Hidden runat="server" ID="HiddenType" />
            </Items>
        </ext:Viewport>
    </form>
</body>
</html>
