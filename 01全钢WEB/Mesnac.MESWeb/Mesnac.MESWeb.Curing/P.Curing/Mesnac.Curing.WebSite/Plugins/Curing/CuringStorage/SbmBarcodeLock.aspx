<%@ Page Language="C#" AutoEventWireup="true" CodeFile="SbmBarcodeLock.aspx.cs" Inherits="Plugins_Curing_CuringStorage_SbmBarcodeLock" %>

<%@ Register Assembly="Ext.Net" Namespace="Ext.Net" TagPrefix="ext" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>条码锁定解锁记录</title>
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
            App.store.currentPage = 1;
            App.pageToolBar.doRefresh();
            return false;
        }
    </script>
</head>
<body>
    <form id="form1" runat="server">
         <asp:Button ID="btnExportSubmit" Style="display: none" runat="server" Text="Button"
            OnClick="btnExportSubmit_Click" />
        <ext:ResourceManager ID="rmMoldingStorage" runat="server" />

        <ext:Viewport ID="vpMoldingStorage" runat="server" Layout="border">
            <Items>

                <ext:Panel ID="pnMoldingStorage" runat="server" Region="North" Height="90">
                    <%-- 菜单 --%>
                    <TopBar>

                        <ext:Toolbar runat="server" ID="tbMoldingStorage">
                            <Items>
                                <ext:Button runat="server" Icon="Find" Text="查询" ID="btnSearch">
                                   <Listeners>
                                       <Click Fn="pnlListFresh" />
                                   </Listeners>
                                </ext:Button>

                                <ext:Button runat="server" Icon="PageExcel" Text="导出Excel" ID="btnExport" >
                                    <ToolTips>
                                        <ext:ToolTip ID="ToolTip2" runat="server" Html="点击将查询结果导出到Excel中" />
                                    </ToolTips>
                                    <Listeners>
                                        <Click Handler="$('#btnExportSubmit').click();">
                                        </Click>
                                    </Listeners>
                                </ext:Button>
                                <%--导出--%>

                                <ext:Hidden runat="server" ID="hiddenMaterialName" Text=" "></ext:Hidden>

                                <ext:ToolbarSeparator ID="tsEnd" />

                                <ext:ToolbarSpacer runat="server" ID="tspacerEnd" />

                                <ext:ToolbarFill ID="tfEnd" />

                            </Items>
                        </ext:Toolbar>
                    </TopBar>
                    <%--end 菜单  --%>

                    <%-- 条件查询 --%>
                    <Items>
                        <ext:FormPanel ID="container_top" runat="server" Layout="ColumnLayout" AutoHeight="true">
                            <Items>
                                <ext:Container ID="container1" runat="server" Layout="FormLayout" ColumnWidth=".3"
                                    Padding="5">
                                    <Items>
                                        <ext:FieldContainer runat="server" FieldLabel="开始锁定时间" Layout="HBoxLayout" LabelAlign="Right">
                                            <Items>
                                                <ext:DateField ID="txtBeginDate" runat="server" Flex="1" Editable="false" />
                                                <ext:TimeField ID="txtBeginTime" runat="server" Width="80" Editable="true" />
                                            </Items>
                                        </ext:FieldContainer>
                                        <ext:TextField ID="txtbarcode" runat="server" FieldLabel="条码" LabelAlign="Right" Editable="false"></ext:TextField>
                                    </Items>
                                </ext:Container>

                                <ext:Container ID="container4" runat="server" Layout="FormLayout" ColumnWidth=".3"
                                    Padding="5">
                                    <Items>
                                        <ext:FieldContainer runat="server" FieldLabel="结束锁定时间" Layout="HBoxLayout" LabelAlign="Right">
                                            <Items>
                                                <ext:DateField ID="txtEndDate" runat="server" Flex="1" Editable="false" />
                                                <ext:TimeField ID="txtEndTime" runat="server" Width="80" Editable="true" />
                                            </Items>
                                        </ext:FieldContainer>
                                        <ext:ComboBox ID="cbxlock" runat="server" FieldLabel="锁定" LabelAlign="Right" Editable="false">
                                            <Items>
                                                <ext:ListItem Text="锁定" Value="0">
                                                </ext:ListItem>
                                                <ext:ListItem Text="解锁" Value="1">
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

                                <ext:Container ID="container3" runat="server" Layout="FormLayout" ColumnWidth=".3"
                                    Padding="5">
                                    <Items>
                                        <ext:ComboBox ID="cbxstore" runat="server" FieldLabel="入库" LabelAlign="Right" Editable="false">
                                           <Items>
                                                <ext:ListItem Text="未入库" Value="0">
                                                </ext:ListItem>
                                                <ext:ListItem Text="入库" Value="1">
                                                </ext:ListItem>
                                               <%-- <ext:ListItem Text="出库" Value="2">
                                                </ext:ListItem>--%>
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
                            <Listeners>
                                <ValidityChange Handler="#{btnSearch}.setDisabled(!valid);" />
                            </Listeners>
                        </ext:FormPanel>
                    </Items>
                    <%-- end 条件查询 --%>
                </ext:Panel>

             <ext:Panel ID="Panel2" runat="server" Region="Center" Frame="true" Layout="Fit" MarginsSummary="0 5 0 5" Title="">
                    <Items>
                        <ext:GridPanel ID="pnlDetailList" runat="server" MarginsSummary="0 5 5 5">
                          <View><ext:GridView EnableTextSelection="true"></ext:GridView></View>
                            <Store>
                                 <ext:Store ID="store" runat="server" PageSize="15">
                                    <Proxy>
                                        <ext:PageProxy DirectFn="App.direct.GridPanelBindData" />
                                    </Proxy>
                           
                                     <Model>
                                        <ext:Model ID="modelDetail" runat="server" IDProperty="OBJID">
                                            <Fields>
                                                <ext:ModelField Name="OBJID" />
                                                <ext:ModelField Name="BARCODE" />
                                                <ext:ModelField Name="LOCKNAME" />
                                                <ext:ModelField Name="REASON" />
                                                <ext:ModelField Name="STORENAME" />
                                                <ext:ModelField Name="LOCK_TIME"  Type="Date"/>
                                                <ext:ModelField Name="UNLOCK_TIME"  Type="Date"/>
                                                <ext:ModelField Name="LOCKUSER" />
                                                <ext:ModelField Name="UNLOCKUSER" />
                                                <ext:ModelField Name="GRADENAME" />
                                            </Fields>
                                        </ext:Model>
                                    </Model>
                                    </ext:Store>
                            </Store>
                            <%-- 头 --%>
                            <ColumnModel ID="ColumnModelDetail" runat="server">
                                <Columns>
                                    <ext:RowNumbererColumn ID="rowNumCol1" runat="server" Width="35" />
                                    <ext:Column ID="GREEN_TYRE_NO" runat="server" Text="条码" DataIndex="BARCODE" Flex="1" />
                                    <ext:Column ID="MATERIAL_NAME" runat="server" Text="锁定" DataIndex="LOCKNAME" Flex="1"  />
                                    <ext:Column ID="Column1" runat="server" Text="品级" DataIndex="GRADENAME" Flex="1"  />
                                    <ext:Column ID="OLD_STORE_NAME" runat="server" Text="入库" DataIndex="STORENAME" Flex="1" />
                                    <ext:Column ID="OLD_STORE_PLACE_NAME" runat="server" Text="锁定原因" DataIndex="REASON" Flex="1" />
                                    <ext:DateColumn ID="DateColumn1" runat="server" Text="锁定时间" DataIndex="LOCK_TIME" Flex="1" Format="yyyy-MM-dd HH:mm:ss" />
                                     <ext:Column ID="NEW_STORE_NAME" runat="server" Text="锁定人" DataIndex="LOCKUSER" Flex="1" />
                                    <ext:DateColumn ID="DateColumn2" runat="server" Text="解锁时间" DataIndex="UNLOCK_TIME" Flex="1" Format="yyyy-MM-dd HH:mm:ss" />
                                    <ext:Column ID="TOOLING_BARCODE" runat="server" Text="解锁人" DataIndex="UNLOCKUSER" Flex="1" />
                                </Columns>
                            </ColumnModel>

                            <%-- 分页 --%>
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
                                                <Select Handler="#{pnlDetailList}.store.pageSize = parseInt(this.getValue(), 10); #{pageToolBar}.DoRefresh(); return false;" />
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
