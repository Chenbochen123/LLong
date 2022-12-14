<%@ Page Language="C#" AutoEventWireup="true" CodeFile="CuringInStorage.aspx.cs" Inherits="Plugins_Curing_ReportCenter_CuringInStorage" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>成品胎入库日报</title>
    <script type="text/javascript" src="<%= Page.ResolveUrl("~/") %>resources/js/jquery-1.7.1.js"></script>
</head>
<body>
    <form id="form1" runat="server">
        <ext:ResourceManager runat="server" />
        <asp:Button ID="btnExportSubmit" Style="display: none" runat="server" Text="Button"
            OnClick="btnExportSubmit_Click" />
        <ext:Viewport runat="server" Layout="BorderLayout">
            <Items>
                <ext:Panel runat="server" Region="North" Layout="FitLayout">
                    <Items>
                        <ext:Toolbar runat="server">
                            <Items>
                                <ext:DateField runat="server" ID="txtDate" FieldLabel="日期" LabelAlign="Right" ForceSelection="true" LabelWidth="50">
                                </ext:DateField>
                                <ext:Button runat="server" ID="btnSearch" Text="查询" Icon="Find">
                                    <DirectEvents>
                                        <Click IsUpload="true" OnEvent="btnSearch_Event" />
                                    </DirectEvents>
                                </ext:Button>
                                <ext:Button runat="server" Icon="PageWhiteExcel" Text="导出" ID="btnExport">
                                    <ToolTips>
                                        <ext:ToolTip ID="ToolTip2" runat="server" Html="点击将查询结果导出到Excel中" />
                                    </ToolTips>
                                    <Listeners>
                                        <Click Handler="$('#btnExportSubmit').click();">
                                        </Click>
                                    </Listeners>
                                </ext:Button>
                            </Items>
                        </ext:Toolbar>
                    </Items>
                </ext:Panel>
                <ext:Panel runat="server" Region="Center" Layout="FitLayout">
                    <Items>
                        <ext:GridPanel ID="gridPanelMain" runat="server" Region="Center">
                            <Store>
                                <ext:Store ID="store" runat="server">
                                    <Model>
                                        <ext:Model ID="model" runat="server" IDProperty="PlanInfo">
                                            <Fields>
                                                <ext:ModelField Name="guige" />
                                                <ext:ModelField Name="sap" />
                                                <ext:ModelField Name="j一级品" />
                                                <ext:ModelField Name="j二级品" />
                                                <ext:ModelField Name="j废品" />
                                                <ext:ModelField Name="j停机检测" />
                                                <ext:ModelField Name="y一级品" />
                                                <ext:ModelField Name="y二级品" />
                                                <ext:ModelField Name="y废品" />
                                                <ext:ModelField Name="y停机检测" />
                                                <ext:ModelField Name="b一级品" />
                                                <ext:ModelField Name="b二级品" />
                                                <ext:ModelField Name="b废品" />
                                                <ext:ModelField Name="b停机检测" />
                                                <ext:ModelField Name="beizhu" />
                                            </Fields>
                                        </ext:Model>
                                    </Model>
                                </ext:Store>
                            </Store>
                            <ColumnModel ID="colModel" runat="server">
                                <Columns>
                                    <ext:Column runat="server" Text="规格" DataIndex="guige" Width="180" />
                                    <ext:Column runat="server" Text="sap" DataIndex="sap" Width="100" />
                                    <ext:Column runat="server" Text="甲班入库">
                                        <Columns>
                                            <ext:Column runat="server" Text="合格品" DataIndex="j一级品" Width="60" />
                                            <ext:Column runat="server" Text="次品" DataIndex="j二级品" Width="60" />
                                            <ext:Column runat="server" Text="废品" DataIndex="j废品" Width="60" />
                                            <ext:Column runat="server" Text="停机检测" DataIndex="j停机检测" Width="60" />
                                        </Columns>
                                    </ext:Column>
                                    <ext:Column runat="server" Text="乙班入库">
                                        <Columns>
                                            <ext:Column runat="server" Text="合格品" DataIndex="y一级品" Width="60" />
                                            <ext:Column runat="server" Text="次品" DataIndex="y二级品" Width="60" />
                                            <ext:Column runat="server" Text="废品" DataIndex="y废品" Width="60" />
                                            <ext:Column runat="server" Text="停机检测" DataIndex="y停机检测" Width="60" />
                                        </Columns>
                                    </ext:Column>
                                    <ext:Column runat="server" Text="丙班入库">
                                        <Columns>
                                            <ext:Column runat="server" Text="合格品" DataIndex="b一级品" Width="60" />
                                            <ext:Column runat="server" Text="次品" DataIndex="b二级品" Width="60" />
                                            <ext:Column runat="server" Text="废品" DataIndex="b废品" Width="60" />
                                            <ext:Column runat="server" Text="停机检测" DataIndex="b停机检测" Width="60" />
                                        </Columns>
                                    </ext:Column>
                                    <ext:Column runat="server" Text="备注" DataIndex="beizhu" Width="100" />
                                </Columns>
                            </ColumnModel>
                        </ext:GridPanel>
                    </Items>
                </ext:Panel>
            </Items>
        </ext:Viewport>
    </form>
</body>
</html>
