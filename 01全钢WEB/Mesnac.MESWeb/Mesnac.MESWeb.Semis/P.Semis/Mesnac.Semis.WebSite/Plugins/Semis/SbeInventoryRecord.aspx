<%@ Page Language="C#" AutoEventWireup="true" CodeFile="SbeInventoryRecord.aspx.cs" Inherits="Plugins_Semis_SbeInventoryRecord" %>

<%@ Register Assembly="Ext.Net" Namespace="Ext.Net" TagPrefix="ext" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>库存盘点记录</title>
    <script type="text/javascript" src="<%= Page.ResolveUrl("~/") %>resources/js/jquery-1.7.1.js"></script>
    <link rel="Stylesheet" type="text/css" href="<%= Page.ResolveUrl("~/") %>resources/css/ext-chinese-font.css" />
    <link rel="Stylesheet" type="text/css" href="<%= Page.ResolveUrl("~/") %>resources/css/main.css" />

</head>
<body>
    <form id="form1" runat="server">
        <asp:Button ID="btnExportSubmit" Style="display: none" runat="server" Text="Button"
            OnClick="btnExportSubmit_Click" />
        <ext:ResourceManager ID="rmMoldingStorage" runat="server" />
        <ext:Viewport ID="vpMoldingStorage" runat="server" Layout="border">
            <Items>
                <ext:Panel ID="pnMoldingStorage" runat="server" Region="North" Height="120">
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
                                <ext:Button runat="server" Icon="PageExcel" Text="导出Excel" ID="btnExport">
                                    <ToolTips>
                                        <ext:ToolTip ID="ToolTip2" runat="server" Html="点击将查询结果导出到Excel中" />
                                    </ToolTips>
                                    <Listeners>
                                        <Click Handler="$('#btnExportSubmit').click();">
                                        </Click>
                                    </Listeners>
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
                                        <ext:FieldContainer runat="server" FieldLabel="开始时间" Layout="HBoxLayout" LabelAlign="Right">
                                            <Items>
                                                <ext:DateField ID="txtBeginDate" runat="server" Flex="1" Editable="false" />
                                                <ext:TimeField ID="txtBeginTime" runat="server" Editable="true" />
                                            </Items>
                                        </ext:FieldContainer>
                                        <ext:TextField ID="txtbarcode" runat="server" FieldLabel="条码" LabelAlign="Right" Editable="true"></ext:TextField>

                                    </Items>
                                </ext:Container>

                                <ext:Container ID="container4" runat="server" Layout="FormLayout" ColumnWidth=".3"
                                    Padding="5">
                                    <Items>
                                        <ext:FieldContainer runat="server" FieldLabel="结束时间" Layout="HBoxLayout" LabelAlign="Right">
                                            <Items>
                                                <ext:DateField ID="txtEndDate" runat="server" Flex="1" Editable="false" />
                                                <ext:TimeField ID="txtEndTime" runat="server" Editable="true" />
                                            </Items>
                                        </ext:FieldContainer>
                                        <ext:ComboBox ID="cbxtype" runat="server" FieldLabel="类型" LabelAlign="Right"
                                            Editable="false">
                                            <Items>
                                                <ext:ListItem Text="半制品库存盘点清库" Value="半制品库存盘点清库">
                                                </ext:ListItem>
                                                <ext:ListItem Text="半制品库存盘点" Value="半制品库存盘点">
                                                </ext:ListItem>
                                                <ext:ListItem Text="半制品线边库盘点" Value="半制品线边库盘点">
                                                </ext:ListItem>
                                                <ext:ListItem Text="半制品线边库盘点清空" Value="半制品线边库盘点清空">
                                                </ext:ListItem>
                                                <ext:ListItem Text="成型库存盘点清库" Value="成型库存盘点清库">
                                                </ext:ListItem>
                                                <ext:ListItem Text="成型库存盘点" Value="成型库存盘点">
                                                </ext:ListItem>
                                                <ext:ListItem Text="成型线边库盘点" Value="成型线边库盘点">
                                                </ext:ListItem>
                                                <ext:ListItem Text="成型线边库盘点清空" Value="成型线边库盘点清空">
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
                                <ext:Container ID="container2" runat="server" Layout="FormLayout" ColumnWidth=".3"
                                    Padding="5">
                                    <Items>
                                        <ext:TextField ID="txtstore" runat="server" FieldLabel="库位" LabelAlign="Right" Editable="true"></ext:TextField>
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
                                <ext:Store ID="store" runat="server" PageSize="90">
                                    <Model>
                                        <ext:Model ID="model" runat="server">
                                            <Fields>
                                                <ext:ModelField Name="TYPE" />
                                                <ext:ModelField Name="CARD_NO" />
                                                <ext:ModelField Name="RFID_NO" />
                                                <ext:ModelField Name="STORE_PLACE_NAME" />
                                                <ext:ModelField Name="USER_NAME" />
                                                <ext:ModelField Name="RECORD_TIME" />
                                            </Fields>
                                        </ext:Model>
                                    </Model>
                                </ext:Store>
                            </Store>
                            <ColumnModel ID="ColumnModel1" runat="server">
                                <Columns>
                                    <ext:RowNumbererColumn ID="RowNumbererColumn1" runat="server" Width="35" />
                                    <ext:Column ID="STOREPLACE" runat="server" Text="盘库操作" DataIndex="TYPE" Width="200" />
                                    <ext:Column ID="MATERIALNAME" runat="server" Text="卡号" DataIndex="CARD_NO" Width="200" />
                                    <ext:Column ID="SAP_CODE" runat="server" Text="工装号" DataIndex="RFID_NO" Width="200" />
                                    <ext:Column ID="Column3" runat="server" Text="库位" DataIndex="STORE_PLACE_NAME" Width="200" />
                                    <ext:Column ID="Column2" runat="server" Text="操作人" DataIndex="USER_NAME" Width="200" />
                                    <ext:DateColumn ID="Column1" runat="server" Text="盘点时间" DataIndex="RECORD_TIME" Width="200" Format="yyyy-MM-dd HH:mm:ss" />
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

