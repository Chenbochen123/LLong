<%@ page language="C#" autoeventwireup="true" inherits="McUI_ReportBill, Mesnac.Main.WebSite" %>

<%@ Register Assembly="Ext.Net" Namespace="Ext.Net" TagPrefix="ext" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <WebPage></WebPage>
    <!--通用-->
    <script Type="text/javascript" src="../../resources/js/jquery-1.7.1.js"></script>
    <link rel="Stylesheet" Type="text/css" href="../resources/css/Main.css" />
    <link rel="Stylesheet" Type="text/css" href="../resources/css/ext-chinese-font.css" />
    <script Type="text/javascript">
        //列表刷新数据重载方法
        var GridPanelCenterFresh = function () {
            App.gridPanelMainStore.currentPage = 1;
            App.gridPanelMainPageToolbar.doRefresh();
            return false;
        }
        var showdetailcommandcolumn_click = function (constructor, command, record, rowid, fn) {
            var ss = Ext.encode(record.data);
            App.hiddenDetailSearchParam.setValue(ss);

            if (command.toLowerCase() == "ShowFieldsInfo".toLowerCase()) {
                App.direct.commandcolumn_direct_ShowFieldsInfo(ss, {
                    success: function (result) {
                        // Ext.Msg.alert('操作', result);
                    },

                    failure: function (errorMsg) {
                        //Ext.Msg.alert('操作', errorMsg);
                    }
                });
            }

            if (command.toLowerCase() == "ShowDetail".toLowerCase()) {
                App.gridPanelDetailStore.currentPage = 1;
                App.gridPanelDetailPageToolbar.doRefresh();
                App.winDetail.show();
            }
            return false;
        }
    </script>
</head>
<body>
    <form id="form1" runat="server">
    <!--数据导出-->
    <asp:Button ID="btnExportSubmit" Style="display: none" runat="server" Text="Button"
        OnClick="btnExportSubmit_Click" />
    <ext:ResourceManager ID="resourceManager" runat="server" />
    <ext:Viewport ID="viewport" runat="server" Layout="BorderLayout">
        <Items>
            <ext:Panel ID="northPanel" runat="server" Region="North" AutoHeight="true">
                <TopBar>
                    <ext:Toolbar runat="server" ID="northToolbar">
                        <Items>
                            <ext:ToolbarSpacer runat="server" ID="tspacerBegin" />
                            <ext:Hidden runat="server" ID="hiddenIsSearchAllInfo" Text="0" />
                            <ext:Button runat="server" Icon="Find" Text="查询信息" ID="btnSearch">
                                <ToolTips>
                                    <ext:ToolTip ID="ttSearch" runat="server" Html="点击进行查询" />
                                </ToolTips>
                                <Listeners>
                                    <Click Fn="GridPanelCenterFresh">
                                    </Click>
                                </Listeners>
                            </ext:Button>
                            <ext:ToolbarSeparator ID="tsBegin" />
                            <ext:Button runat="server" Icon="PageExcel" Text="导出查询结果" ID="btnExport">
                                <ToolTips>
                                    <ext:ToolTip ID="ToolTip2" runat="server" Html="点击将查询结果导出到Excel中" />
                                </ToolTips>
                                <Listeners>
                                    <Click Handler="$('#btnExportSubmit').click();">
                                    </Click>
                                </Listeners>
                            </ext:Button>
                            <ext:ToolbarSpacer runat="server" ID="tspacerEnd" />
                            <ext:ToolbarFill ID="tfEnd" />
                        </Items>
                    </ext:Toolbar>
                </TopBar>
                <Items>
                    <ext:Panel ID="panelNorthQueryParam" runat="server" AutoHeight="true">
                        <Items>
                            <ext:Container ID="containerQueryParam" runat="server" Layout="ColumnLayout" AutoHeight="true">
                            </ext:Container>
                        </Items>
                    </ext:Panel>
                </Items>
            </ext:Panel>
            <ext:GridPanel ID="gridPanelMain" runat="server" Region="Center">
                <Store>
                    <ext:Store ID="gridPanelMainStore" runat="server">
                        <Model>
                            <ext:Model ID="GridPanelmodel" runat="server">
                            </ext:Model>
                        </Model>
                    </ext:Store>
                </Store>
                <ColumnModel ID="ColumnModel" runat="server">
                    <Columns>
                    </Columns>
                </ColumnModel>
                <BottomBar>
                    <ext:PagingToolbar ID="gridPanelMainPageToolbar" runat="server">
                    </ext:PagingToolbar>
                </BottomBar>
            </ext:GridPanel>
            <ext:Panel ID="panelMainDetail" runat="server" Region="East" BodyPadding="5" Width="200" Collapsible="true"  Collapsed="true"
                Title="详细信息" AutoScroll="true">
                <Items>
                    <ext:Container ID="containerMainDetail" runat="server">
                    </ext:Container>
                </Items>
            </ext:Panel>
        </Items>
    </ext:Viewport>
    <ext:Window ID="winDetail" runat="server" Icon="TableColumn" Closable="true" Resizable="true"
        Hidden="true" Modal="true" Layout="BorderLayout">
        <Items>
            <ext:Hidden runat="server" ID="hiddenDetailSearchParam">
            </ext:Hidden>
            <ext:GridPanel ID="gridPanelDetail" runat="server" Region="Center">
                <Store>
                    <ext:Store ID="gridPanelDetailStore" runat="server" PageSize="10">
                        <Model>
                            <ext:Model ID="gridPanelDetailModel" runat="server">
                            </ext:Model>
                        </Model>
                    </ext:Store>
                </Store>
                <ColumnModel ID="columnDetailModel" runat="server">
                    <Columns>
                    </Columns>
                </ColumnModel>
                <BottomBar>
                    <ext:PagingToolbar ID="gridPanelDetailPageToolbar" runat="server">
                    </ext:PagingToolbar>
                </BottomBar>
                <View>
                    <ext:GridView ID="GridView2" runat="server" EnableTextSelection="true">
                    </ext:GridView>
                </View>
            </ext:GridPanel>
        </Items>
    </ext:Window>
    </form>
</body>
</html>
