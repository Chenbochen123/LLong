<%@ Page Language="C#" AutoEventWireup="true" CodeFile="PlanNoTech.aspx.cs" Inherits="Plugins_Semis_SemisPlan_PlanNoTech" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>无工艺计划</title>
    <link rel="Stylesheet" type="text/css" href="<%= Page.ResolveUrl("~/") %>resources/css/ext-chinese-font.css" />
    <link rel="Stylesheet" type="text/css" href="<%= Page.ResolveUrl("~/") %>resources/css/main.css" />
    <style type="text/css">
        .redcs {
            color: #ff0000;
        }
    </style>
    <script type="text/javascript">
        var thisDirUrl = "<%= Page.ResolveUrl("./") %>";
        var thisRootUrl = "<%= Page.ResolveUrl("~/") %>";
    </script>
    <script type="text/javascript" src="<%= Page.ResolveUrl("~/") %>resources/js/jquery-1.7.1.js"></script>
    <script type="text/javascript">



        Ext.apply(Ext.form.VTypes, {
            integer: function (val, field) {
                if (!val) {
                    return true;
                }
                try {
                    if (/^[\d]+$/.test(val)) {
                        return true;
                    }
                    else {
                        return false;
                    }
                }
                catch (e) {
                    return false;
                }
            },
            integerText: "此填入项格式为正整数"
        });


        //列表刷新数据重载方法
        var pnlListFresh = function () {
            var value = App.cobProcedure.value;
            App.hidden_Procedure.setValue(value);
            App.pnlList.store.reload();
            return false;
        }
    </script>

    <script type="text/javascript">
        var pad = function (num, n) {
            var len = num.toString().length;
            while (len < n) {
                num = "0" + num;
                len++;
            }
            return num;
        }
    </script>
</head>
<body>
    <form id="form1" runat="server">
        <asp:Button ID="btnExportSubmit" Style="display: none" runat="server" Text="Button"
            OnClick="btnExportSubmit_Click" />
        <ext:ResourceManager ID="ResourceManager1" runat="server" />
        <ext:Viewport ID="Viewport1" runat="server" Layout="border">
            <Items>
                <ext:Hidden ID="hidden_Procedure" runat="server" Text="0" />
                <ext:Panel ID="pnlQueryTitle" runat="server" Region="North" AutoHeight="true">
                    <TopBar>
                        <ext:Toolbar runat="server" ID="barUser">
                            <Items>
                                <ext:ToolbarSeparator ID="toolbarSeparator_begin" />
                                <ext:DateField runat="server" ID="PlanDate" Text="计划日期">
                                    <Listeners>
                                        <Change Fn="pnlListFresh" />
                                    </Listeners>
                                </ext:DateField>
                                <ext:ToolbarSeparator />
                                <ext:ComboBox ID="cobProcedure" runat="server" FieldLabel="工序" LabelAlign="Left" Editable="false"
                                    ValueField="Value" DisplayField="Text" LabelWidth="35" Width="120" ForceSelection="true">
                                    <Listeners>
                                        <Change Fn="pnlListFresh" />
                                    </Listeners>
                                </ext:ComboBox>
                                <ext:TextField ID="txtmater" runat="server" FieldLabel="物料" LabelAlign="Right" Editable="true"></ext:TextField>
                                <ext:ToolbarSeparator />
                                <ext:ToolbarSeparator ID="toolbarSeparator_middle_2" Hidden="true" />
                                <ext:Button runat="server" Icon="Find" Text="查询" ID="btnSearch">
                                    <Listeners>
                                        <Click Fn="pnlListFresh">
                                        </Click>
                                    </Listeners>
                                </ext:Button>
                                <ext:Button runat="server" Icon="PageWhiteExcel" Text="导出计划" ID="btnExport">
                                    <ToolTips>
                                        <ext:ToolTip ID="ToolTip2" runat="server" Html="点击将查询结果导出到Excel中" />
                                    </ToolTips>
                                    <Listeners>
                                        <Click Handler="$('#btnExportSubmit').click();">
                                        </Click>
                                    </Listeners>
                                </ext:Button>
                                <ext:ToolbarSeparator ID="toolbarSeparator_end" />
                                <ext:ToolbarSpacer runat="server" ID="toolbarSpacer_end" />
                                <ext:ToolbarFill ID="toolbarFill_end" />
                            </Items>
                        </ext:Toolbar>
                    </TopBar>
                </ext:Panel>
                <ext:GridPanel ID="pnlList" runat="server" Region="Center">
                    <Store>
                        <ext:Store ID="store" runat="server" PageSize="90">
                            <Proxy>
                                <ext:PageProxy DirectFn="App.direct.GridPanelBindData" />
                            </Proxy>
                            <Model>
                                <ext:Model ID="model" runat="server">
                                    <Fields>
                                        <ext:ModelField Name="OBJID" />
                                        <ext:ModelField Name="MATER" />

                                    </Fields>
                                </ext:Model>
                            </Model>
                        </ext:Store>
                    </Store>
                    <ColumnModel ID="colModel" runat="server">
                        <Columns>
                            <ext:Column runat="server" Text="物料" DataIndex="MATER" Width="300" />
                        </Columns>
                    </ColumnModel>
                    <BottomBar>
                        <ext:PagingToolbar ID="pageToolBar" runat="server">
                            <Items>
                                <ext:Label ID="Label1" runat="server" Text="每页条数:" Hidden="true" />
                                <ext:ToolbarSpacer ID="ToolbarSpacer1" runat="server" Width="10" />
                                <ext:ComboBox ID="ComboBox1" runat="server" Width="80" Hidden="true">
                                    <Items>
                                        <ext:ListItem Text="10" />
                                        <ext:ListItem Text="90" />
                                        <ext:ListItem Text="100" />
                                        <ext:ListItem Text="200" />
                                    </Items>
                                    <SelectedItems>
                                        <ext:ListItem Value="90" />
                                    </SelectedItems>
                                    <Listeners>
                                        <Select Handler="#{pnlList}.store.pageSize = parseInt(this.getValue(), 10); #{pageToolBar}.DoRefresh(); return false;" />
                                    </Listeners>
                                </ext:ComboBox>
                            </Items>
                            <Plugins>
                                <ext:ProgressBarPager ID="ProgressBarPager" runat="server" />
                            </Plugins>
                        </ext:PagingToolbar>
                    </BottomBar>
                </ext:GridPanel>
            </Items>
        </ext:Viewport>
    </form>
</body>
</html>
