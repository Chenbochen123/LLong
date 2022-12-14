<%@ Page Language="C#" AutoEventWireup="true" CodeFile="EquipStopAnalysis.aspx.cs" Inherits="Plugins_Curing_Equip_EquipStopAnalysis" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>维修分析</title>
    <script type="text/javascript" src="<%= Page.ResolveUrl("~/") %>resources/js/jquery-1.7.1.js"></script>
    <link rel="Stylesheet" type="text/css" href="<%= Page.ResolveUrl("~/") %>resources/css/ext-chinese-font.css" />
    <link rel="Stylesheet" type="text/css" href="<%= Page.ResolveUrl("~/") %>resources/css/main.css" />
    <script type="text/javascript">
        var tipsRenderer = function (si, item) {
            var storeItem = item.storeItem;
            this.setTitle(storeItem.get('TYPENAME') + ": " + storeItem.get('DURATIONPERCENT') + " of " + storeItem.get('TOTALDURATION') + "分钟");
            App.direct.refreshTips(storeItem.get('STOPTYPEID'), {
                success: function () { },
                failure: function () { }
            });
        };
    </script>
    <script type="text/javascript">        //树节点选中
        var setParentNode = function (node, checked) {
            var pNode = node;
            while (checked) {
                pNode = pNode.parentNode;
                if (!pNode) {
                    break;
                }
                pNode.set("checked", checked);
            }
        }
        var setChildNode = function (node, checked) {
            var nodes = node.childNodes;
            for (var i = 0; i < nodes.length; i++) {
                var node = nodes[i];
                node.set("checked", checked);
                if (node.data.leaf) {
                    continue;
                }
                setChildNode(node, node.data.checked);
            }
        }
        var onTreeCheckChange = function (node, checked, fn) {
            setParentNode(node, checked);
            setChildNode(node, checked);
            var actions = getTreeSelectionModel(App.equipTree.getRootNode().childNodes);
            App.treeStr.setValue(actions);
        }
        var getTreeSelectionData = function (node) {
            if (node.data.ObjID) {
                return node.data.ObjID;
            }
            return "";
        }
        var getTreeSelectionModel = function (nodes) {
            var Result = ",";
            for (var i = 0; i < nodes.length; i++) {
                var node = nodes[i];
                if (node.data.checked) {
                    Result = Result + getTreeSelectionData(node) + ",";
                    try {
                        if (node.childNodes) {
                            Result = Result + getTreeSelectionModel(node.childNodes) + ",";
                        }
                    } catch (e) { }
                }
            }
            return Result;
        }
    </script>
</head>
<body>
    <form id="form1" runat="server">
    <ext:ResourceManager ID="ResourceManager1" runat="server" />
    <asp:Button ID="btnExportSubmit" runat="server" Text="Button" OnClick="btnExportSubmit_Click" Style="display:none" />
        <ext:Viewport ID="vw1" runat="server" Layout="border">
            <Items>
                <ext:Panel ID="pnl1" runat="server" Region="North" AutoHeight="true">
                    <TopBar>
                        <ext:Toolbar runat="server" ID="bar1">
                            <Items>
                                <ext:Button runat="server" Icon="Find" Text="查询" ID="btnSearch">
                                    <ToolTips><ext:ToolTip ID="ttSearch" runat="server" Html="点击进行查询" /></ToolTips>
                                    <DirectEvents><Click OnEvent="btnSearch_Click"/></DirectEvents>
                                </ext:Button>
                                <ext:Button runat="server" Icon="PageWhiteExcel" Text="导出" ID="btnExcel"  Hidden="true">
                                    <ToolTips><ext:ToolTip ID="ToolTip1" runat="server" Html="点击进行结果导出" /></ToolTips>
                                    <Listeners>
                                        <Click Handler="$('#btnExportSubmit').click();"></Click>
                                    </Listeners>
                                </ext:Button>
                                <ext:ToolbarSeparator />
                            </Items>
                        </ext:Toolbar>
                    </TopBar>
                    <Items>
                        <ext:FormPanel ID="container_top" runat="server" Layout="ColumnLayout" Height="40" BodyPadding="5">
                            <FieldDefaults>
                                <CustomConfig>
                                    <ext:ConfigItem Name="PreserveIndicatorIcon" Value="true" Mode="Raw" />
                                </CustomConfig>
                            </FieldDefaults>
                            <Items>
                                <ext:Container ID="Container1"  runat="server" Layout="ColumnLayout">
                                    <Items>
                                        <ext:FieldContainer ID="FieldContainer9"  runat="server" Layout="HBoxLayout" FieldLabel="开始时间" LabelAlign="Right" LabelWidth="55" Width="250">
                                            <Items>
                                                <ext:DateField ID="dStartDate" runat="server" Editable="false" AllowBlank="false" Format="yyyy-MM-dd" Margins="0 3 0 0" Width="90" LabelWidth="0"/>
                                                <ext:TimeField ID="dStartTime" runat="server" Width="60"/>
                                            </Items>
                                        </ext:FieldContainer>
                                        <ext:FieldContainer ID="FieldContainer5"  runat="server" Layout="HBoxLayout" FieldLabel="结束时间" LabelAlign="Right" LabelWidth="55" Width="250">
                                            <Items>
                                                <ext:DateField ID="dEndDate" runat="server" Editable="false" AllowBlank="false" Format="yyyy-MM-dd" Margins="0 3 0 0" Width="90" LabelWidth="0"/>
                                                <ext:TimeField ID="dEndTime" runat="server" Width="60"/>
                                            </Items>
                                        </ext:FieldContainer>
                                         <ext:FieldContainer ID="FieldContainer1"  runat="server" Layout="HBoxLayout" FieldLabel="停机大类" LabelAlign="Right" LabelWidth="55" Width="250">
                                            <Items>
                                                <ext:ComboBox ID="cbStopMainType" runat="server" LabelAlign="Right"
                                                    Width="80" LabelWidth="0" DisplayField="EquipStopTypeName" ValueField="ObjId" Editable="false">
                                                    <Store>
                                                        <ext:Store runat="server" ID="storeStopMainType">
                                                            <Model>
                                                                <ext:Model runat="server" ID="Model3">
                                                                    <Fields>
                                                                        <ext:ModelField Name="EquipStopTypeName" />
                                                                        <ext:ModelField Name="ObjId" />
                                                                    </Fields>
                                                                </ext:Model>
                                                            </Model>
                                                        </ext:Store>
                                                    </Store>
                                                    <Triggers>
                                                        <ext:FieldTrigger Icon="Clear" HideTrigger="true" />
                                                    </Triggers>
                                                </ext:ComboBox>
                                            </Items>
                                        </ext:FieldContainer>
                                    </Items>
                                </ext:Container>
                            </Items>
                        </ext:FormPanel>
                    </Items>
                </ext:Panel>
                <ext:TreePanel ID="equipTree" runat="server" Region="West" Width="305" RootVisible="false" MultiSelect="false" TitleAlign="Center" Collapsible="true">
                    <Store>
                        <ext:TreeStore ID="equipTreeStore" runat="server">
                            <Model>
                                <ext:Model ID="model2" runat="server">
                                    <Fields>
                                        <ext:ModelField Name="ObjID" />
                                        <ext:ModelField Name="Equip_Name" />
                                        <ext:ModelField Name="Remark" />
                                    </Fields>
                                </ext:Model>
                            </Model>
                            <Root>
                                <ext:Node NodeID="Root" />
                            </Root>
                        </ext:TreeStore>
                    </Store>
                    <ColumnModel>
                        <Columns>
                            <ext:TreeColumn ID="Equip_Name" DataIndex="Equip_Name" runat="server" Sortable="false" Hideable="false" Text="设备信息树" Width="300" />
                            <ext:Column ID="ObjID" DataIndex="ObjID" runat="server" Sortable="false" Hideable="false" Text="设备编号" Width="100" Hidden="true" />
                        </Columns>
                    </ColumnModel>
                    <Listeners>
                        <CheckChange Fn="onTreeCheckChange" />
                    </Listeners>
                </ext:TreePanel>
                <ext:Chart  ID="Chart1" runat="server" Shadow="true" StyleSpec="background:#fff" Animate="true">
                    <Store>
                        <ext:Store runat="server" ID="store1">
                            <Model>
                                <ext:Model runat="server">
                                    <Fields>
                                        <ext:ModelField Name="STOPTYPEID" />
                                        <ext:ModelField Name="TYPENAME" />
                                        <ext:ModelField Name="DURATION" />
                                        <ext:ModelField Name="TOTALDURATION" />
                                        <ext:ModelField Name="DURATIONPERCENT" />
                                    </Fields>
                                </ext:Model>
                            </Model>
                        </ext:Store>
                    </Store>
                    <Axes>
                        <ext:NumericAxis Fields="DURATION" Grid="true" Title="持续时间（分钟）" Minimum="0">
                            <Label>
                                <Renderer Handler="return Ext.util.Format.number(value, '0');" />
                            </Label>
                        </ext:NumericAxis>
                        <ext:CategoryAxis Position="Bottom" Fields="TYPENAME" Title="设备维修分析"/>
                    </Axes>
                    <Series>
                        <ext:ColumnSeries Axis="Left" Highlight="true" XField="TYPENAME" YField="DURATION">
                            <Label Display="Outside" Field="DURATIONPERCENT" Orientation="Horizontal" TextAnchor="middle" />
                            <Tips ID="Tips1" runat="server" TrackMouse="true" Width="270" Height="270">
                                <Items>
                                    <ext:Container runat="server" Layout="VBoxLayout" Width="260" Height="260">
                                        <Items>
                                            <ext:Label runat="server" ID="lblTipTitle"></ext:Label>
                                            <ext:Chart ID="Chart2" runat="server" Shadow="true" StyleSpec="background:#fff" Animate="true" Width="255" Height="230">
                                                <Store>
                                                    <ext:Store runat="server" ID="store2">
                                                        <Model>
                                                            <ext:Model ID="Model1" runat="server">
                                                                <Fields>
                                                                    <ext:ModelField Name="FAULTNAME" />
                                                                    <ext:ModelField Name="DURATION" />
                                                                    <ext:ModelField Name="DURATIONPERCENT" />
                                                                </Fields>
                                                            </ext:Model>
                                                        </Model>
                                                    </ext:Store>
                                                </Store>
                                                <Series>
                                                    <ext:PieSeries AngleField="DURATION" ShowInLegend="false">
                                                        <Label Field="FAULTNAME" Display="Outside" Contrast="true" Font="10px Arial" />
                                                    </ext:PieSeries>
                                                </Series>
                                            </ext:Chart>
                                        </Items>
                                    </ext:Container>
                                </Items>
                                <Renderer Fn="tipsRenderer" />
                            </Tips>
                        </ext:ColumnSeries>
                    </Series>
                </ext:Chart>
                <ext:Hidden ID="treeStr" runat="server" />
            </Items>
        </ext:Viewport>
    </form>
</body>
</html>
