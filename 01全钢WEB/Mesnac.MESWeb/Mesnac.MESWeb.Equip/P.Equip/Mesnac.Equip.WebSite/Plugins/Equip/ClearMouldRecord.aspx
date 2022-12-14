<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ClearMouldRecord.aspx.cs" Inherits="Plugins_Equip_ClearMouldRecord" %>

<%@ Register Assembly="Ext.Net" Namespace="Ext.Net" TagPrefix="ext" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>药水洗模记录</title>
    <link rel="Stylesheet" type="text/css" href="<%= Page.ResolveUrl("~/") %>resources/css/ext-chinese-font.css" />
    <link rel="Stylesheet" type="text/css" href="<%= Page.ResolveUrl("~/") %>resources/css/main.css" />
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
            App.store.currentPage = 1;
            App.pageToolBar.doRefresh();
            return false;
        }

        var SetRowClass = function (record, rowIndex, rowParams, store) {
            var rowClass = ''; 
            if (record.get("IN_TYPE") == "弹簧模具" && record.get("REALNUM") >= "320" && record.get("REALNUM") < "400") {
                rowClass = 'x-grid-row-collapsedYellow';
            }
            else if (record.get("IN_TYPE") != "弹簧模具" && record.get("REALNUM") >= "480" && record.get("REALNUM") < "600") {
                rowClass = 'x-grid-row-collapsedYellow';
            }
            else if (record.get("IN_TYPE") == "弹簧模具" && record.get("REALNUM") >= "400")
            { rowClass = 'x-grid-row-collapsedRed'; }
            else if (record.get("IN_TYPE") != "弹簧模具" && record.get("REALNUM") >= "600")
            { rowClass = 'x-grid-row-collapsedRed'; }
            return rowClass;
        }

    </script>
    <style type="text/css">
        .x-grid-row-collapsedYellow .x-grid-cell {
            background-color: #ffd800 !important;
        }

        .x-grid-row-collapsedRed .x-grid-cell {
            background-color: #ff0000 !important;
        }
    </style>
</head>
<body>
    <form id="fmUser" runat="server">
        <asp:Button ID="btnExportSubmit" Style="display: none" runat="server" Text="Button"
            OnClick="btnExportSubmit_Click" />
        <ext:ResourceManager ID="ResourceManager1" runat="server" />
        <ext:Viewport ID="Viewport1" runat="server" Layout="border">
            <Items>
                <ext:Panel ID="pnlQueryTitle" runat="server" Region="North" AutoHeight="true">
                    <TopBar>
                        <ext:Toolbar runat="server" ID="barUser">
                            <Items>
                                <ext:Button runat="server" Icon="Find" Text="查询" ID="btnSearch">
                                    <ToolTips>
                                        <ext:ToolTip ID="ttSearch" runat="server" Html="点击进行查询" />
                                    </ToolTips>
                                    <Listeners>
                                        <Click Fn="pnlListFresh">
                                        </Click>
                                    </Listeners>
                                </ext:Button>
                                <ext:ToolbarSeparator ID="toolbarSeparator_middle" />
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
                    </TopBar>
                    <Items>
                        <ext:Panel ID="pnlQuery" runat="server" AutoHeight="true">
                            <Items>
                                <ext:FormPanel ID="container_top" runat="server" Layout="ColumnLayout" AutoHeight="true">
                                    <Items>
                                        <ext:Container ID="container_1" runat="server" Layout="FormLayout" ColumnWidth=".33"
                                            Padding="5">
                                            <Items>
                                                <ext:TextField ID="txtMouldName" Vtype="integer" runat="server" FieldLabel="模具名称"
                                                    LabelAlign="Right" />
                                                <ext:TextField ID="txtnum" Vtype="integer" runat="server" FieldLabel="模具次数" EmptyText="大于等于该值"
                                                    LabelAlign="Right" />
                                            </Items>
                                        </ext:Container>
                                        <ext:Container ID="container_2" runat="server" Layout="FormLayout" ColumnWidth=".33"
                                            Padding="5">
                                            <Items>
                                                <ext:DateField ID="txt_begin_stop_date" runat="server" FieldLabel="开始时间" LabelAlign="Right" Editable="false" />
                                                <ext:ComboBox ID="cbxnew" runat="server" FieldLabel="是否最新" LabelAlign="left"
                                                    Editable="false">
                                                    <Items>
                                                        <ext:ListItem Text="是" Value="1">
                                                        </ext:ListItem>
                                                        <ext:ListItem Text="否" Value="2">
                                                        </ext:ListItem>
                                                    </Items>
                                                    <Triggers>
                                                        <ext:FieldTrigger Icon="Clear" Qtip="清空">
                                                        </ext:FieldTrigger>
                                                    </Triggers>
                                                    <Listeners>
                                                        <TriggerClick Handler="this.setValue('');" />
                                                    </Listeners>
                                                </ext:ComboBox>

                                            </Items>
                                        </ext:Container>
                                        <ext:Container ID="container_3" runat="server" Layout="FormLayout" ColumnWidth=".33"
                                            Padding="5">
                                            <Items>
                                                <ext:DateField ID="txt_end_stop_date" runat="server" FieldLabel="结束时间" LabelAlign="Right" Editable="false" />
                                                <ext:ComboBox ID="cbxmouldtype" runat="server" FieldLabel="洗模类型" LabelAlign="Right"
                                                    Editable="false">
                                                    <Items>
                                                        <ext:ListItem Text="喷砂洗模" Value="0">
                                                        </ext:ListItem>
                                                        <ext:ListItem Text="激光洗模" Value="1">
                                                        </ext:ListItem>
                                                    </Items>
                                                    <Triggers>
                                                        <ext:FieldTrigger Icon="Clear" Qtip="清空">
                                                        </ext:FieldTrigger>
                                                    </Triggers>
                                                    <Listeners>
                                                        <TriggerClick Handler="this.setValue('');" />
                                                    </Listeners>
                                                </ext:ComboBox>
                                            </Items>
                                        </ext:Container>
                                    </Items>
                                </ext:FormPanel>
                            </Items>
                        </ext:Panel>
                    </Items>
                </ext:Panel>
                <ext:GridPanel ID="pnlList" runat="server" Region="Center">
                    <Store>
                        <ext:Store ID="store" runat="server" PageSize="15">
                            <Proxy>
                                <ext:PageProxy DirectFn="App.direct.GridPanelBindData" />
                            </Proxy>
                            <Model>
                                <ext:Model ID="model" runat="server">
                                    <Fields>
                                        <ext:ModelField Name="OBJID" />
                                        <ext:ModelField Name="MOULDNAME" />
                                        <ext:ModelField Name="MAXNUM" />
                                        <ext:ModelField Name="REALNUM" />
                                        <ext:ModelField Name="WARNING_FLAG" />
                                        <ext:ModelField Name="LOCK_FLAG" />
                                        <ext:ModelField Name="USER_NAME" />
                                        <ext:ModelField Name="RECORD_TIME" Type="Date" />
                                        <ext:ModelField Name="IN_TYPE" />
                                        <ext:ModelField Name="BAUP_FLAG" />
                                        <ext:ModelField Name="EQUIP_NAME" />
                                        <ext:ModelField Name="USER_NAME2" />
                                        <ext:ModelField Name="DUMMY3" />
                                        <ext:ModelField Name="OKFLAG" />
                                        <ext:ModelField Name="OKUSER" />
                                        <ext:ModelField Name="OK_TIME" Type="Date" />
                                        <ext:ModelField Name="ERROR_NUMBER" />
                                        <ext:ModelField Name="MOULDFLAGNAME" />
                                        <ext:ModelField Name="UP_NUMBER" />
                                        <ext:ModelField Name="REALNUMS" />

                                    </Fields>
                                </ext:Model>
                            </Model>
                        </ext:Store>
                    </Store>
                    <ColumnModel ID="colModel" runat="server">
                        <Columns>
                            <ext:RowNumbererColumn ID="rowNumCol" Width="45" runat="server" />
                            <ext:Column ID="OBJID" runat="server" Text="编号" DataIndex="OBJID" Width="60" Hidden="true" />
                            <ext:Column ID="MOULD_NAME" runat="server" Text="模具名称" DataIndex="MOULDNAME" Width="100" />
                            <ext:Column ID="Column2" runat="server" Text="机台" DataIndex="EQUIP_NAME" Width="100" />
                            <ext:Column ID="Column3" runat="server" Text="左右模" DataIndex="BAUP_FLAG" Width="100" />
                            <ext:Column ID="Column8" runat="server" Text="洗模类型" DataIndex="MOULDFLAGNAME" Width="100" />
                            <ext:Column ID="SIZE_NAME" runat="server" Text="实际次数" DataIndex="REALNUMS" Width="100" />
                            <ext:Column ID="Column7" runat="server" Text="最大次数" DataIndex="UP_NUMBER" Width="100" />
                            <ext:Column ID="Column9" runat="server" Text="预警次数" DataIndex="ERROR_NUMBER" Width="100" />
                            <ext:Column ID="Column1" runat="server" Text="类型" DataIndex="IN_TYPE" Width="100" />
                            <ext:Column ID="USER_NAME" runat="server" Text="记录人（开始）" DataIndex="USER_NAME" Width="100" />
                            <ext:DateColumn ID="RECORD_TIME" runat="server" Text="记录时间（开始）" DataIndex="RECORD_TIME" Width="150" Format="yyyy-MM-dd HH:mm:ss" />
                            <ext:Column ID="Column4" runat="server" Text="记录人(结束)" DataIndex="USER_NAME2" Width="100" />
                            <ext:Column ID="DateColumn1" runat="server" Text="记录时间(结束)" DataIndex="DUMMY3" Width="150"   />
                            <ext:Column ID="Column5" runat="server" Text="合格标志" DataIndex="OKFLAG" Width="100" />
                            <ext:Column ID="Column6" runat="server" Text="确认人" DataIndex="OKUSER" Width="100" />
                            <ext:DateColumn ID="DateColumn2" runat="server" Text="确认时间" DataIndex="OK_TIME" Width="150" Format="yyyy-MM-dd HH:mm:ss" />

                        </Columns>
                    </ColumnModel>
                    <View>
                        <ext:GridView ID="gvRows" runat="server">
                            <GetRowClass Fn="SetRowClass" />
                        </ext:GridView>
                    </View>
                    <BottomBar>
                        <ext:PagingToolbar ID="pageToolBar" runat="server">
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
