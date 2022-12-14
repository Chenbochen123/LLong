<%@ Page Language="C#" AutoEventWireup="true" CodeFile="BomCopy.aspx.cs" Inherits="Plugins_Semis_BomCopy" %>

<%@ Register Assembly="Ext.Net" Namespace="Ext.Net" TagPrefix="ext" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <script type="text/javascript" src="<%= Page.ResolveUrl("~/") %>resources/js/jquery-1.7.1.js"></script>
    <link rel="Stylesheet" type="text/css" href="<%= Page.ResolveUrl("~/") %>resources/css/ext-chinese-font.css" />
    <link rel="Stylesheet" type="text/css" href="<%= Page.ResolveUrl("~/") %>resources/css/main.css" />
    <style type="text/css">
        .x-grid-row-collapsed .x-grid-cell {
            background-color: #B0FFBA !important;
        }
    </style>
    
    <script type="text/javascript">

        var pnlListFresh = function () {

            App.storeDetail.currentPage = 1;
            App.pageToolBar.DoRefresh();
            return false;
        }

        var prepareToolbar = function (grid, toolbar, rowIndex, record) {
            if (record.get("FiledFlag") == "1") {
                toolbar.items.getAt(0).hide();
                toolbar.items.getAt(1).hide();
            }
            else if (record.get("LockedFlag") == "1") {
                toolbar.items.getAt(0).hide();
                toolbar.items.getAt(1).hide();
            }
        };

        var commandcolumn_click = function (command, record) {
            commandcolumn_click_confirm(command, record);
            return false;
        };
        var commandcolumn_click_confirm = function (command, record) {
            if (command.toLowerCase() == "delete") {
                Ext.Msg.confirm("提示", '您确定需要复制吗？', function (btn) { commandcolumn_direct_Delete(btn, record) });
            }
            return false;
        };
        var commandcolumn_direct_Delete = function (btn, record) {

            if (btn != 'yes') {
                return;
            }

            var SapCode = record.data.SAP_CODE;
            var BomType = record.data.BOM_TYPE;
            var BomFactroy = record.data.BOM_FACTROY;
            var BomVersion = record.data.BOM_VERSION;
            var GeeenTyreVersion = record.data.GREENTYRE_VERSION;
            var Objid = record.data.OBJID;
            debugger;
            App.direct.commandcolumn_direct_Delete(SapCode, BomType, BomFactroy, BomVersion, GeeenTyreVersion, Objid, {
                success: function (result) {
                },

                failure: function (errorMsg) {
                    Ext.Msg.alert('操作', errorMsg);
                }
            });
        }
    </script>
</head>
<body>
    <form id="form1" runat="server">
        <ext:ResourceManager ID="rmMoldingStorage" runat="server" />
        <ext:Viewport ID="vpMoldingStorage" runat="server" Layout="border">
            <Items>
                <ext:Panel ID="pnMoldingStorage" runat="server" Region="North" Height="70">
                    <TopBar>
                        <ext:Toolbar runat="server" ID="tbMoldingStorage">
                            <Items>
                                <ext:Button runat="server" Icon="Find" Text="查询" ID="btnSearch">
                                    <DirectEvents>
                                        <Click OnEvent="btnQuary_Click" Timeout="300000">
                                            <EventMask ShowMask="true" Msg="查询中..." />
                                        </Click>
                                    </DirectEvents>
                                </ext:Button>
                                <ext:Hidden runat="server" ID="hiddenMaterialName" Text=" "></ext:Hidden>
                                <ext:ToolbarSeparator ID="tsEnd" />
                                <ext:ToolbarSpacer runat="server" ID="tspacerEnd" />
                                <ext:ToolbarFill ID="tfEnd" />
                            </Items>
                        </ext:Toolbar>
                    </TopBar>
                    <Items>
                        <ext:FormPanel ID="container_top" runat="server" Layout="ColumnLayout" AutoHeight="true">
                            <Items>
                                <ext:Container ID="container1" runat="server" Layout="FormLayout" ColumnWidth=".3"
                                    Padding="5">
                                    <Items>
                                        <ext:TextField ID="txtMaterialName" runat="server" FieldLabel="SAP品号" LabelAlign="Right" Editable="false"></ext:TextField>
                                    </Items>
                                </ext:Container>
                            </Items>
                            <Listeners>
                                <ValidityChange Handler="#{btnSearch}.setDisabled(!valid);" />
                            </Listeners>
                        </ext:FormPanel>
                    </Items>
                </ext:Panel>

                <ext:Panel ID="Panel" runat="server" Region="Center" Frame="true" Layout="Fit" MarginsSummary="0 5 0 5">
                    <Items>
                        <ext:GridPanel ID="pnlList" runat="server">
                            <Store>
                                <%-- ^^^^^^^^^^^^^^^^^^ --%>
                                <ext:Store ID="store" runat="server" PageSize="90">
                                    <Model>
                                        <ext:Model ID="model" runat="server">
                                            <Fields>
                                                <ext:ModelField Name="OBJID" />
                                                <ext:ModelField Name="MATERIAL_NAME" />
                                                <ext:ModelField Name="MATERIAL_CODE" />
                                                <ext:ModelField Name="SAP_CODE" />
                                                <ext:ModelField Name="MINOR_TYPE_NAME" />
                                                <ext:ModelField Name="BOM_TYPE" />
                                                <ext:ModelField Name="TYPE_NAME" />
                                                <ext:ModelField Name="BOM_FACTROY" />
                                                <ext:ModelField Name="BOM_VERSION" />
                                                <ext:ModelField Name="GREENTYRE_VERSION" />
                                            </Fields>
                                        </ext:Model>
                                    </Model>
                                </ext:Store>
                            </Store>
                            <ColumnModel ID="ColumnModel1" runat="server">
                                <Columns>
                                    <ext:RowNumbererColumn ID="RowNumbererColumn1" runat="server" Width="35" />
                                    <ext:Column ID="MATERIAL_NAME" runat="server" Text="物料规格" DataIndex="MATERIAL_NAME" Width="200" />
                                    <ext:Column ID="MATERIAL_CODE" runat="server" Text="物料CODE" DataIndex="MATERIAL_CODE" Width="150" />
                                    <ext:Column ID="SAP_CODE" runat="server" Text="SAP号" DataIndex="SAP_CODE" Width="100" />
                                    <ext:Column ID="MINOR_TYPE_NAME" runat="server" Text="物料细类" DataIndex="MINOR_TYPE_NAME" Width="100" />
                                    <ext:Column ID="TYPE_NAME" runat="server" Text="BOM类型" DataIndex="TYPE_NAME" Width="80" />
                                    <ext:Column ID="BOM_FACTROY" runat="server" Text="BOM分厂" DataIndex="BOM_FACTROY" Width="80" />
                                    <ext:Column ID="BOM_VERSION" runat="server" Text="BOM版本" DataIndex="BOM_VERSION" Width="80" />
                                    <ext:Column ID="GREENTYRE_VERSION" runat="server" Text="胎胚版本" DataIndex="GREENTYRE_VERSION" Width="80" />
                                    <ext:CommandColumn ID="Col" runat="server" Text="操作" Align="Center">
                                        <Commands>
                                            <ext:GridCommand Icon="TableEdit" CommandName="Delete" Text="复制">
                                            </ext:GridCommand>
                                        </Commands>
                                        <Listeners>
                                            <Command Handler="return commandcolumn_click(command, record);" />
                                        </Listeners>
                                    </ext:CommandColumn>

                                </Columns>
                            </ColumnModel>

                            <SelectionModel>
                                <ext:RowSelectionModel ID="RowSelectionModel1" runat="server" Mode="Single">
                                    <Listeners>
                                        <Select Handler="#{storeDetail}.reload();" Buffer="250" />
                                    </Listeners>
                                </ext:RowSelectionModel>
                            </SelectionModel>

                        </ext:GridPanel>
                    </Items>
                </ext:Panel>
                <ext:Panel ID="pnlDetail" runat="server" Region="South" Title="BOM明细数据" Height="300" Icon="Basket" Layout="Fit" Collapsible="true"
                    Split="true" MarginsSummary="0 5 5 5">
                    <Items>
                        <ext:GridPanel ID="pnlDetailList" runat="server" MarginsSummary="0 5 5 5">
                            <Store>
                                <ext:Store ID="storeDetail" runat="server" PageSize="10" OnReadData="storeDetail_ReadData">
                                    <Model>
                                        <ext:Model ID="modelDetail" runat="server" IDProperty="OBJID">
                                            <Fields>
                                                <ext:ModelField Name="MATERIAL_NAME" />
                                                <ext:ModelField Name="MATERIAL_CODE" />
                                                <ext:ModelField Name="SAP_CODE" />
                                                <ext:ModelField Name="MINOR_TYPE_NAME" />
                                                <ext:ModelField Name="TYPE_NAME" />
                                                <ext:ModelField Name="BOM_FACTROY" />
                                                <ext:ModelField Name="BOM_VERSION" />
                                                <ext:ModelField Name="GREENTYRE_VERSION" />
                                                <ext:ModelField Name="UNIT_NAME" />
                                                <ext:ModelField Name="GROUP_UNIT_NUM" />
                                            </Fields>
                                        </ext:Model>
                                    </Model>
                                    <Parameters>
                                        <ext:StoreParameter Name="SAP_CODE" Mode="Raw" Value="#{pnlList}.getSelectionModel().hasSelection() ? #{pnlList}.getSelectionModel().getSelection()[0].data.SAP_CODE : -1" />
                                        <ext:StoreParameter Name="BOM_TYPE" Mode="Raw" Value="#{pnlList}.getSelectionModel().hasSelection() ? #{pnlList}.getSelectionModel().getSelection()[0].data.BOM_TYPE : -1" />
                                        <ext:StoreParameter Name="BOM_FACTROY" Mode="Raw" Value="#{pnlList}.getSelectionModel().hasSelection() ? #{pnlList}.getSelectionModel().getSelection()[0].data.BOM_FACTROY : -1" />
                                        <ext:StoreParameter Name="BOM_VERSION" Mode="Raw" Value="#{pnlList}.getSelectionModel().hasSelection() ? #{pnlList}.getSelectionModel().getSelection()[0].data.BOM_VERSION : -1" />
                                        <ext:StoreParameter Name="GREENTYRE_VERSION" Mode="Raw" Value="#{pnlList}.getSelectionModel().hasSelection() ? #{pnlList}.getSelectionModel().getSelection()[0].data.GREENTYRE_VERSION : -1" />
                                    </Parameters>
                                </ext:Store>
                            </Store>
                            <ColumnModel ID="ColumnModelDetail" runat="server">
                                <Columns>
                                    <ext:RowNumbererColumn ID="rowNumCol1" runat="server" Width="35" />
                                    <ext:Column ID="Column1" runat="server" Text="物料规格" DataIndex="MATERIAL_NAME" Width="150">
                                    </ext:Column>
                                    <ext:Column ID="Column2" runat="server" Text="物料CODE" DataIndex="MATERIAL_CODE" Width="200">
                                    </ext:Column>
                                    <ext:Column ID="Column3" runat="server" Text="SAP号" DataIndex="SAP_CODE" Width="100">
                                    </ext:Column>
                                    <ext:Column ID="Column4" runat="server" Text="物料细类" DataIndex="MINOR_TYPE_NAME" Width="100">
                                    </ext:Column>
                                    <ext:Column ID="Column5" runat="server" Text="BOM类型" DataIndex="TYPE_NAME" Width="80">
                                    </ext:Column>
                                    <ext:Column ID="Column6" runat="server" Text="BOM分厂" DataIndex="BOM_FACTROY" Width="80">
                                    </ext:Column>
                                    <ext:Column ID="Column7" runat="server" Text="BOM版本" DataIndex="BOM_VERSION" Width="80">
                                    </ext:Column>
                                    <ext:Column ID="Column8" runat="server" Text="胎胚版本" DataIndex="GREENTYRE_VERSION" Width="80">
                                    </ext:Column>
                                    <ext:Column ID="Column9" runat="server" Text="单位" DataIndex="UNIT_NAME" Width="80">
                                    </ext:Column>
                                    <ext:Column ID="Column10" runat="server" Text="数量" DataIndex="GROUP_UNIT_NUM" Width="80">
                                    </ext:Column>
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
                                                <ext:ListItem Text="50" />
                                                <ext:ListItem Text="100" />
                                                <ext:ListItem Text="200" />
                                            </Items>
                                            <SelectedItems>
                                                <ext:ListItem Value="10" />
                                            </SelectedItems>
                                            <Listeners>
                                                <Select Handler="#{pnlDetailList}.storeDetail.pageSize = parseInt(this.getValue(), 10); #{pageToolBar}.DoRefresh(); return false;" />
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
