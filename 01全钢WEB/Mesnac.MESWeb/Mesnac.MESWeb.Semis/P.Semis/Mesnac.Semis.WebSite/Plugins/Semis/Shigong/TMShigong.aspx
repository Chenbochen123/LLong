<%@ Page Language="C#" AutoEventWireup="true" CodeFile="TMShigong.aspx.cs" Inherits="Plugins_Semis_Shigong_TMShigong" %>

<%@ Register Assembly="Ext.Net" Namespace="Ext.Net" TagPrefix="ext" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>胎面施工表</title>
    <script type="text/javascript" src="<%= Page.ResolveUrl("~/") %>resources/js/jquery-1.7.1.js"></script>
    <link rel="Stylesheet" type="text/css" href="<%= Page.ResolveUrl("~/") %>resources/css/ext-chinese-font.css" />
    <link rel="Stylesheet" type="text/css" href="<%= Page.ResolveUrl("~/") %>resources/css/main.css" />
    <style type="text/css">
        .x-grid-row-collapsed .x-grid-cell {
            background-color: #B0FFBA !important;
        }
    </style>
    <script type="text/javascript">
        //分页
        var pnlListFresh = function () {
            return false;
        }
    </script>
</head>
<body>
    <form id="form1" runat="server">
        <ext:ResourceManager ID="rmMoldingStorage" runat="server" />

        <ext:Viewport ID="vpMoldingStorage" runat="server" Layout="border">
            <Items>

                <ext:Panel ID="Panel3" runat="server" Region="West" AutoScroll="true" Flex="1">
                    <Items>
                        <ext:FormPanel ID="container_top" runat="server" Layout="ColumnLayout">
                            <Items>
                                <ext:TextField ID="txtmater" runat="server" FieldLabel="物料名称(模糊)" LabelAlign="Right"></ext:TextField>

                                <ext:Button runat="server" Icon="Find" Text="查询" ID="btnSearch">
                                    <DirectEvents>
                                        <Click OnEvent="btnQuary_Click" />
                                    </DirectEvents>
                                </ext:Button>
                            </Items>
                            <Listeners>
                                <ValidityChange Handler="#{btnSearch}.setDisabled(!valid);" />
                            </Listeners>
                        </ext:FormPanel>
                        <ext:GridPanel ID="pnlList" runat="server" Region="Center">
                            <Store>
                                <ext:Store ID="store" runat="server" PageSize="90">
                                    <Model>
                                        <ext:Model ID="model" runat="server">
                                            <Fields>
                                                <ext:ModelField Name="OBJID" />
                                                <ext:ModelField Name="MATERIAL_NAME" />
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
                                    <ext:Column ID="GREENTYRE_VERSION" runat="server" Text="版本" DataIndex="GREENTYRE_VERSION" Width="80" />
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
                <ext:Panel runat="server" Region="Center" ID="panelDetailInfo" Title="" Layout="Fit" Flex="3">
                    <Loader runat="server" Mode="frame">
                    </Loader>
                    <Items>
                        <ext:GridPanel ID="GridPanel2" runat="server" MarginsSummary="0 5 5 5">
                            <Store>
                                <ext:Store ID="storeDetail" runat="server" PageSize="10" OnReadData="storeDetail_ReadData1">
                                    <Model>
                                        <ext:Model ID="modelDetail" runat="server" IDProperty="OBJID">
                                            <Fields>
                                                <ext:ModelField Name="OBJID" />
                                                <ext:ModelField Name="GREEN_TYRE_NO" />
                                            </Fields>
                                        </ext:Model>
                                    </Model>
                                    <Parameters>
                                        <ext:StoreParameter Name="MATERIAL_NAME" Mode="Raw" Value="#{pnlList}.getSelectionModel().hasSelection() ? #{pnlList}.getSelectionModel().getSelection()[0].data.MATERIAL_NAME : -1  " />
                                        <ext:StoreParameter Name="GREENTYRE_VERSION" Mode="Raw" Value="#{pnlList}.getSelectionModel().hasSelection() ? #{pnlList}.getSelectionModel().getSelection()[0].data.GREENTYRE_VERSION : -1  " />
                                    </Parameters>
                                </ext:Store>
                            </Store>

                        </ext:GridPanel>
                    </Items>
                </ext:Panel>
            </Items>
        </ext:Viewport>
    </form>
</body>
</html>
