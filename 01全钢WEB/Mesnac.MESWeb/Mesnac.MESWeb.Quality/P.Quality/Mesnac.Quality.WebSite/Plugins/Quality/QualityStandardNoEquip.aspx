<%@ Page Language="C#" AutoEventWireup="true" CodeFile="QualityStandardNoEquip.aspx.cs" Inherits="Plugins_Quality_QualityStandardNoEquip" %>

<%@ Register Assembly="Ext.Net" Namespace="Ext.Net" TagPrefix="ext" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link rel="Stylesheet" type="text/css" href="<%= Page.ResolveUrl("~/") %>resources/css/ext-chinese-font.css" />
    <link rel="Stylesheet" type="text/css" href="<%= Page.ResolveUrl("~/") %>resources/css/main.css" />
    <style type="text/css">
        .x-grid-row-collapsed .x-grid-cell {
            background-color: #B0FFBA !important;
        }
    </style>
    <script type="text/javascript">

        var pnlListFresh = function () {
            App.store.currentPage = 1;
            App.pageToolBar.doRefresh();
            return false;
        }

        var pnListSave = function () {
            Ext.Msg.confirm("提示", '您确定要保存修改的标准吗？', function (btn) {
                if (btn != "yes") { return; }

                var arr = new Array();
                var store = App.store;
                if (store.type == "store") {
                    Ext.each(store.data.items, function (record) {
                        arr.push(record.data);
                    });
                }
                var str = Ext.encode(arr);
                App.direct.commandcolumn_direct_saveStandard(str,{
                    success: function (result) {
                        Ext.Msg.alert('提示', result);
                    },

                    failure: function (errorMsg) {
                        Ext.Msg.alert('提示', errorMsg);
                    }
                });
            });
        }
    </script>
</head>
<body>
    <form id="form1" runat="server">
        <ext:ResourceManager ID="rmQualityStandard" runat="server" />
        <ext:Viewport ID="vpQualityStandard" runat="server" Layout="border">
            <Items>
                <ext:Panel ID="pnQualityStandard" runat="server" Region="North" Height="90">
                    <TopBar>
                        <ext:Toolbar runat="server" ID="tbQualityStandard">
                            <Items>

                                <ext:Button runat="server" Icon="Find" Text="查询" ID="btnSearch">
                                    <Listeners>
                                        <Click Fn="pnlListFresh" />
                                    </Listeners>
                                </ext:Button>
                                <ext:ToolbarSeparator ID="tsBegin" />
                                <ext:Button runat="server" Icon="PageSave" Text="保存" ID="btnSave">
                                    <Listeners>
                                        <Click Fn="pnListSave" />
                                    </Listeners>
                                </ext:Button>
                                <ext:ToolbarSeparator ID="tsEnd" />
                                <ext:ToolbarSpacer runat="server" ID="tspacerEnd" />
                                <ext:ToolbarFill ID="tfEnd" />
                            </Items>
                        </ext:Toolbar>
                    </TopBar>
                    <Items>
                        <ext:FormPanel ID="container_top" runat="server" Layout="ColumnLayout" AutoHeight="true">
                            <Items>
                                <ext:Container ID="container1" runat="server" Layout="FormLayout" ColumnWidth=".33"
                                    Padding="5">
                                    <Items>
                                        <ext:TextField ID="tbxCode" runat="server" FieldLabel="规格代码" LabelAlign="Right" Editable="true" enableKeyEvents="true" >
                                          
                                        </ext:TextField>
                                    </Items>
                                </ext:Container>
                                 <ext:Container ID="container2" runat="server" Layout="FormLayout" ColumnWidth=".33"
                                    Padding="5">
                                    <Items>
                                       <ext:TextField ID="tbxName" runat="server" FieldLabel="规格名称" LabelAlign="Right" Editable="true" EnableKeyEvents="true" >
                                          
                                        </ext:TextField>
                                    </Items>
                                </ext:Container>
                            </Items>
                            <Listeners>
                                <ValidityChange Handler="#{btnSearch}.setDisabled(!valid);" />
                            </Listeners>
                        </ext:FormPanel>
                    </Items>
                </ext:Panel>

                <ext:Panel ID="Panel2" runat="server" Region="Center" Frame="true" Layout="Fit" MarginsSummary="0 5 0 5" Title="物料质检标准">
                    <Items>
                        <ext:GridPanel ID="pnlList" runat="server">
                            <Store>
                                <ext:Store ID="store" runat="server" PageSize="20">
                                    <Proxy>
                                        <ext:PageProxy DirectFn="App.direct.GridPanelBindData" />
                                    </Proxy>
                                    <Model>
                                        <ext:Model ID="model" runat="server" IDProperty="OBJID">
                                            <Fields>
                                                <ext:ModelField Name="OBJID" />
                                                <ext:ModelField Name="EQUIP_NAME" />
                                                <ext:ModelField Name="MATERIAL_CODE" />
                                                <ext:ModelField Name="MATERIAL_NAME" />
                                                <ext:ModelField Name="BSTANDARD_ID" />
                                                <ext:ModelField Name="XSTANDARD_ID" />
                                                <ext:ModelField Name="USTANDARD_ID" />
                                                <ext:ModelField Name="IS_DONG" />
                                                <ext:ModelField Name="IS_JUN" />
                                                <ext:ModelField Name="IS_AGAIN" />
                                                <ext:ModelField Name="FJ_NUM" />
                                            </Fields>
                                        </ext:Model>
                                    </Model>
                                </ext:Store>
                            </Store>
                            <ColumnModel ID="colModel" runat="server">
                                <Columns>
                                    <ext:RowNumbererColumn ID="rowNumCol" runat="server" Width="35" />
                             <%--       <ext:Column ID="Column1" runat="server" Text="编号" DataIndex="OBJID" Flex="1" />--%>
                                    <ext:Column ID="MATERIAL_CODE" runat="server" Text="规格代码" DataIndex="MATERIAL_CODE" Flex="1" />
                                    <ext:Column ID="MATERIAL_NAME" runat="server" Text="规格名称" DataIndex="MATERIAL_NAME" Flex="1" />
                                    <ext:Column ID="BSTANDARD" runat="server" Text="动平衡质检标准" DataIndex="BSTANDARD_ID" Flex="1">
                                        <Editor>
                                            <ext:TextField runat="server" ID="BSTANDARD_EDITOR" />
                                        </Editor>
                                    </ext:Column>
                                    <ext:Column ID="XSTANDARD" runat="server" Text="X光质检标准" DataIndex="XSTANDARD_ID" Flex="1">
                                        <Editor>
                                            <ext:TextField runat="server" ID="XSTANDARD_EDITOR" />
                                        </Editor>
                                    </ext:Column>
                                    <ext:Column ID="USTANDARD" runat="server" Text="均匀性质检标准" DataIndex="USTANDARD_ID" Flex="1">
                                        <Editor>
                                            <ext:TextField runat="server" ID="USTANDARD_EDITOR" />
                                        </Editor>
                                    </ext:Column>
                                    <ext:Column ID="Column1" runat="server" Text="是否过动平衡" DataIndex="IS_DONG" Flex="1">
                                        <Editor>
                                            <ext:TextField runat="server" ID="TextField1" />
                                        </Editor>
                                    </ext:Column>
                                    <ext:Column ID="Column2" runat="server" Text="是否过均匀性" DataIndex="IS_JUN" Flex="1">
                                        <Editor>
                                            <ext:TextField runat="server" ID="TextField2" />
                                        </Editor>
                                    </ext:Column>
                                    <ext:Column ID="Column3" runat="server" Text="是否再测定" DataIndex="IS_AGAIN" Flex="1">
                                        <Editor>
                                            <ext:TextField runat="server" ID="TextField3" />
                                        </Editor>
                                    </ext:Column>
                                    <ext:Column ID="Column4" runat="server" Text="复检次数" DataIndex="FJ_NUM" Flex="1">
                                        <Editor>
                                            <ext:TextField runat="server" ID="TextField4" />
                                        </Editor>
                                    </ext:Column>
                                </Columns>
                            </ColumnModel>
                            <Plugins>
                                <ext:CellEditing ID="cellEditing1" runat="server" ClicksToEdit="1">
                                </ext:CellEditing>
                            </Plugins>

                            <SelectionModel>
                                <ext:RowSelectionModel ID="rowSelectMuti" runat="server" Mode="Single">
                                    <Listeners>
                                        <Select Handler="#{storeDetail}.reload();" Buffer="250" />
                                    </Listeners>
                                </ext:RowSelectionModel>
                            </SelectionModel>
                            <%--      <View>
                                <ext:GridView ID="gvRows" runat="server">
                                    <GetRowClass Fn="SetRowClass" />
                                </ext:GridView>
                            </View>--%>
                            <BottomBar>
                                <ext:PagingToolbar ID="pageToolBar" runat="server">
                                    <Items>
                                        <ext:Label ID="Label2" runat="server" Text="每页条数:" Hidden="true"/>
                                        <ext:ToolbarSpacer ID="ToolbarSpacer2" runat="server" Width="10" />
                                        <ext:ComboBox ID="ComboBox2" runat="server" Width="80" Hidden="true">
                                            <Items>
                                                <ext:ListItem Text="10" />
                                                <ext:ListItem Text="50" />
                                                <ext:ListItem Text="100" />
                                                <ext:ListItem Text="200" />
                                            </Items>
                                            <SelectedItems>
                                                <ext:ListItem Value="10" />
                                            </SelectedItems>
                                            <Listeners>
                                                <Select Handler="#{pnlList}.store.pageSize = parseInt(this.getValue(), 10); #{pageToolBar}.doRefresh(); return false;" />
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
                </ext:Panel>
            </Items>
        </ext:Viewport>
    </form>
</body>
</html>
