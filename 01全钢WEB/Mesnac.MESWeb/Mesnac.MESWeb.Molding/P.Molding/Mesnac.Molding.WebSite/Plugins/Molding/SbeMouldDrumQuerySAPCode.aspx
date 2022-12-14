<%@ Page Language="C#" AutoEventWireup="true" CodeFile="SbeMouldDrumQuerySAPCode.aspx.cs" Inherits="Plugins_Molding_SbeMouldDrumQuerySAPCode" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title></title>
    <script type="text/javascript" src="<%= Page.ResolveUrl("~/") %>resources/js/jquery-1.7.1.js"></script>
    <script type="text/javascript" src="<%= Page.ResolveUrl("~/") %>resources/js/taglabel.js"></script>
    <link rel="Stylesheet" type="text/css" href="<%= Page.ResolveUrl("~/") %>resources/css/ext-chinese-font.css" />
    <link rel="Stylesheet" type="text/css" href="<%= Page.ResolveUrl("~/") %>resources/css/taglabel.css" />
    <link rel="Stylesheet" type="text/css" href="<%= Page.ResolveUrl("~/") %>resources/css/main.css" />
    <style type="text/css">
        .x-grid-row-collapsed .x-grid-cell
        {
            background-color: #B0FFBA !important;
        }
    </style>
    <script type="text/javascript">

        var pnlListFresh = function () {
            App.pnlList.store.reload();
            return false;
        }

        var commandcolumn_click = function (command, record) {
            commandcolumn_click_confirm(command, record);
            return false;
        };

        //区分删除操作，并进行二次确认操作
        var commandcolumn_click_confirm = function (command, record) {
            if (command.toLowerCase() == "add") {
                commandcolumn_direct_adddefect(record);
            }
            if (command.toLowerCase() == "delete") {
                Ext.Msg.confirm("提示", '您确定要删除此条信息吗？', function (btn) { commandcolumn_direct_deletedefect(btn, record) });
            }
            return false;
        };

        var commandcolumn_direct_adddefect = function (record) {
            var SAP_CODE = record.data.SAP_CODE
            App.direct.commandcolumn_direct_adddefect(SAP_CODE, {
                success: function (result) {
                    parent.pnlListFresh();
                },

                failure: function (errorMsg) {
                    Ext.Msg.alert('操作', errorMsg);
                }
            });
        }

        //点击删除按钮
        var commandcolumn_direct_deletedefect = function (btn, record) {
            if (btn != "yes") {
                return;
            }
            var SAP_CODE = record.data.SAP_CODE;
            App.direct.commandcolumn_direct_deletedefect(SAP_CODE, {
                success: function (result) {
                    parent.pnlListFresh();
                },

                failure: function (errorMsg) {
                    Ext.Msg.alert('操作', errorMsg);
                }
            });
            this.pnlListFresh();
        }
    </script>
</head>
<body>
    <form id="form1" runat="server">
    <ext:ResourceManager ID="rmDefect" runat="server" />
    <ext:Viewport ID="vpDefect" runat="server" Layout="border">
        <Items>
            <ext:Panel ID="pnDefect" runat="server" Region="North">
                <TopBar>
                    <ext:Toolbar runat="server" ID="tbDefect">
                        <Items>
                            <ext:Button runat="server" Icon="Find" Text="查询" ID="btnSearch">
                                <Listeners>
                                    <Click Fn="pnlListFresh" />
                                </Listeners>
                            </ext:Button>
                            <ext:ToolbarFill ID="tfEnd" />
                        </Items>
                    </ext:Toolbar>
                </TopBar>
                <Items>
                    <ext:FormPanel ID="container_top" runat="server" Layout="ColumnLayout" AutoHeight="true"
                        Collapsible="false">
                        <Items>
                            <ext:Container ID="container2" runat="server" Layout="FormLayout" ColumnWidth=".33"
                                Padding="5">
                                <Items>
                                      <ext:TextField ID="txtmaterCode" runat="server" FieldLabel="胎胚编号"  
                                        LabelAlign="Right" />
                                </Items>
                            </ext:Container>
                            <ext:Container ID="container1" runat="server" Layout="FormLayout" ColumnWidth=".33"
                                Padding="5">
                                <Items>
                                      <ext:TextField ID="txtbarcode" runat="server" FieldLabel="SAP编码"  
                                        LabelAlign="Right" />
                                </Items>
                            </ext:Container>
                            <ext:Container ID="container3" runat="server" Layout="FormLayout" ColumnWidth=".33"
                                Padding="5">
                                <Items>
                                      <ext:TextField ID="txtmaterName" runat="server" FieldLabel="胎胚名称"  
                                        LabelAlign="Right" />
                                </Items>
                            </ext:Container>
                        </Items>
                    </ext:FormPanel>
                </Items>
            </ext:Panel>
            <ext:Panel ID="Panel2" Title="全部规格" runat="server" Region="Center" AutoScroll="true" Flex="1">
                <Items>
                    <ext:GridPanel ID="pnlList" runat="server">
                        <Store>
                            <ext:Store ID="store" runat="server" PageSize="10">
                                <Proxy>
                                    <ext:PageProxy DirectFn="App.direct.GridPanelBindData" />
                                </Proxy>
                                <Model>
                                    <ext:Model ID="model" runat="server" IDProperty="OBJID">
                                        <Fields>
                                            <ext:ModelField Name="OBJID" />
                                            <ext:ModelField Name="MATERIAL_CODE" />
                                            <ext:ModelField Name="SAP_CODE" />
                                            <ext:ModelField Name="MATERIAL_NAME" />
                                        </Fields>
                                    </ext:Model>
                                </Model>
                            </ext:Store>
                        </Store>
                        <ColumnModel ID="colModel" runat="server">
                            <Columns>
                                <ext:RowNumbererColumn ID="rowNumCol1" runat="server" Width="35" />
                                 <ext:Column ID="OBJID" runat="server" Text="设备编号" Hidden="true" DataIndex="OBJID" Flex="1"/>
                                 <ext:Column ID="MATERIAL_CODE" runat="server" Text="胎胚编号" DataIndex="MATERIAL_CODE" Flex="1"/>
                                 <ext:Column ID="SAP_CODE" runat="server" Text="SAP编码" DataIndex="SAP_CODE" Flex="1"/>
                                 <ext:Column ID="MATERIAL_NAME" runat="server" Text="胎胚名称" DataIndex="MATERIAL_NAME" Flex="1"/>
                                <ext:CommandColumn ID="commandCol" runat="server" Width="60" Text="操作" Align="Center">
                                    <Commands>
                                        <ext:GridCommand Icon="TableAdd" CommandName="Add" Text="添加" />
                                    </Commands>
                                    <Listeners>
                                        <Command Handler="return commandcolumn_click(command, record);" />
                                    </Listeners>
                                    
                                </ext:CommandColumn>
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
                            <BottomBar>
                                <ext:PagingToolbar ID="pageToolBar" runat="server">
                                    <Items>
                                        <ext:ToolbarSpacer ID="ToolbarSpacer1" runat="server" Width="10" />
                                        <ext:ComboBox ID="ComboBox1" runat="server" Width="80" Hidden="true">
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
                                                <Select Handler="#{pnlDetailList}.storeData.pageSize = parseInt(this.getValue(), 10); #{pageToolBar}.doRefresh(); return false;" />
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
            <ext:Panel ID="Panel1" Title="不允许规格" runat="server" Region="South" AutoScroll="true" Flex="1">
                <Items>
                     <ext:GridPanel ID="pnlList2" runat="server">
                        <Store>
                            <ext:Store ID="store1" runat="server" PageSize="10">
                                <Proxy>
                                    <ext:PageProxy DirectFn="App.direct.GridPanelBindData1" />
                                </Proxy>
                                <Model>
                                    <ext:Model ID="model1" runat="server" IDProperty="OBJID">
                                        <Fields>
                                            <ext:ModelField Name="OBJID" />
                                            <ext:ModelField Name="MATERIAL_CODE" />
                                            <ext:ModelField Name="SAP_CODE" />
                                            <ext:ModelField Name="MATERIAL_NAME" />
                                        </Fields>
                                    </ext:Model>
                                </Model>
                            </ext:Store>
                        </Store>
                        <ColumnModel ID="ColumnModel1" runat="server">
                            <Columns>
                                <ext:RowNumbererColumn ID="RowNumbererColumn1" runat="server" Width="35" />
                                 <ext:Column ID="Column1" runat="server" Text="设备编号" Hidden="true" DataIndex="OBJID" Flex="1"/>
                                 <ext:Column ID="Column2" runat="server" Text="胎胚编号" DataIndex="MATERIAL_CODE" Flex="1"/>
                                 <ext:Column ID="Column3" runat="server" Text="SAP编码" DataIndex="SAP_CODE" Flex="1"/>
                                 <ext:Column ID="Column4" runat="server" Text="胎胚名称" DataIndex="MATERIAL_NAME" Flex="1"/>
                                <ext:CommandColumn ID="CommandColumn1" runat="server" Width="60" Text="操作" Align="Center">
                                    <Commands>
                                        <ext:GridCommand Icon="TableDelete" CommandName="delete" Text="删除" />
                                    </Commands>
                                    <Listeners>
                                        <Command Handler="return commandcolumn_click(command, record);" />
                                    </Listeners>
                                    
                                </ext:CommandColumn>
                            </Columns>
                        </ColumnModel>
                            <Plugins>
                                <ext:CellEditing ID="cellEditing2" runat="server" ClicksToEdit="1">
                                </ext:CellEditing>
                            </Plugins>

                            <SelectionModel>
                                <ext:RowSelectionModel ID="RowSelectionModel1" runat="server" Mode="Single">
                                    <Listeners>
                                        <Select Handler="#{storeDetail}.reload();" Buffer="250" />
                                    </Listeners>
                                </ext:RowSelectionModel>
                            </SelectionModel>
                            <BottomBar>
                                <ext:PagingToolbar ID="PagingToolbar1" runat="server">
                                    <Items>
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
                                                <Select Handler="#{pnlDetailList}.storeData.pageSize = parseInt(this.getValue(), 10); #{pageToolBar}.doRefresh(); return false;" />
                                            </Listeners>
                                        </ext:ComboBox>
                                    </Items>
                                    <Plugins>
                                        <ext:ProgressBarPager ID="ProgressBarPager1" runat="server" />
                                    </Plugins>
                                </ext:PagingToolbar>
                            </BottomBar>
                    </ext:GridPanel>
                </Items>
            </ext:Panel>
            <%--end 修改机台信息--%>
        </Items>
    </ext:Viewport>
    </form>
</body>
</html>
