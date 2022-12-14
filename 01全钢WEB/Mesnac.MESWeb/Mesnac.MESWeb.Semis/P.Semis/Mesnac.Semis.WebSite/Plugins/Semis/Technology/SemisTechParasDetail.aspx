<%@ Page Language="C#" AutoEventWireup="true" CodeFile="SemisTechParasDetail.aspx.cs" Inherits="Plugins_Semis_Technology_SemisTechParasDetail" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
    <script type="text/javascript" src="<%= Page.ResolveUrl("~/") %>resources/js/jquery-1.7.1.js"></script>
</head>
<body>
    <form id="form1" runat="server">
    <ext:ResourceManager runat="server" />
        <ext:Viewport runat="server" Layout="BorderLayout">
            <Items>
                <ext:Panel runat="server" Region="North" Layout="FitLayout">
                    <Items>
                        <ext:Toolbar runat="server">
                            <Items>
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
                                        <ext:Model ID="model" runat="server">
                                        </ext:Model>
                                    </Model>
                                </ext:Store>
                            </Store>
                            <ColumnModel ID="colModel" runat="server">
                                <Columns>
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
