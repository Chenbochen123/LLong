<%@ Page Language="C#" AutoEventWireup="true" CodeFile="QuerySparePart.aspx.cs" Inherits="Plugins_Equip_BasicInfo_QuerySparePart" %>
<%@ Register Assembly="Ext.Net" Namespace="Ext.Net" TagPrefix="ext" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="head" runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>备件信息</title>
    <!--通用-->
    <link rel="Stylesheet" type="text/css" href="<%= Page.ResolveUrl("~/") %>resources/css/ext-chinese-font.css" />
    <link rel="Stylesheet" type="text/css" href="<%= Page.ResolveUrl("~/") %>resources/css/main.css" />
    <script type="text/javascript">
        var gridPanelRefresh = function () {
            App.store.currentPage = 1;
            App.pageToolbar.doRefresh();
            return false;
        }
        //点击弹出窗口，height=100%设置，google浏览器无法获取其高度方法
        window.onload = function () {
            if (parent && parent.document) {
                var iframes = parent.document.getElementsByTagName("iframe");
                if (iframes) {
                    for (var i = 0; i < iframes.length; i++) {
                        if (iframes[i].contentWindow == window) {
                            iframes[i].height = iframes[i].parentElement.style.height;
                        }
                    }
                }
            }
        };
    </script>

    <!--特殊-->
    <script type="text/javascript">
        var response = function (command, record) {
            parent.Plugins_Equip_BasicInfo_QuerySparePart_Request(record);
            parent.App.Plugins_Equip_BasicInfo_QuerySparePart_Window.close();
            return false;
        }
        var commandColumn_click = function (command, record) {
            return response(command, record);
        };
        //grid:panelgrid   td
        var cellDblClick = function (grid, td, tdindex, record, tr, trindex, e, fn) {
            return response('dblclick', record);
        }
    </script>
</head>
<body>
    <form id="form" runat="server">
        <ext:ResourceManager ID="resourceManager" runat="server" />
        <ext:Viewport ID="viewport" runat="server" Layout="BorderLayout">
            <Items>
                <ext:Panel ID="northPanel" runat="server" Region="North" AutoHeight="true">
                    <TopBar>
                        <ext:Toolbar runat="server" ID="northToolbar">
                            <Items>
                                <ext:ToolbarSeparator ID="toolbarSeparator_begin" />
                                <ext:Button runat="server" Icon="Find" Text="查询" ID="btn_search">
                                    <ToolTips>
                                        <ext:ToolTip ID="ttSearch" runat="server" Html="点击进行查询" />
                                    </ToolTips>
                                    <Listeners>
                                        <Click Fn="gridPanelRefresh"></Click>
                                    </Listeners>
                                </ext:Button>
                                <ext:ToolbarSeparator ID="toolbarSeparator_end" />
                                <ext:ToolbarSpacer runat="server" ID="toolbarSpacer_end" />
                                <ext:ToolbarFill ID="toolbarFill_end" />
                            </Items>
                        </ext:Toolbar>
                    </TopBar>
                    <Items>
                        <ext:Panel ID="panelNorthQuery" runat="server" AutoHeight="true">
                            <Items>
                                <ext:Container ID="container_Query" runat="server" Layout="ColumnLayout" AutoHeight="true">
                                    <Items>
                                        <ext:Container ID="container1" runat="server" Layout="FormLayout" Padding="5" ColumnWidth="1">
                                            <Items>
                                                <ext:TextField ID="txtSpartPartCode" runat="server" FieldLabel="备件代号" LabelAlign="Right" />
                                                <ext:TextField ID="txtSpartPartName" runat="server" FieldLabel="备件名称" LabelAlign="Right" >
                                                    <Listeners>
                                                        <Change Fn="gridPanelRefresh"></Change>
                                                    </Listeners>
                                                </ext:TextField>
                                                <ext:ComboBox ID="txtSpartPartMajor" runat="server" FieldLabel="备件大类" LabelAlign="Right"
                                                     DisplayField="MAJOR_TYPR_NAME" ValueField="OBJID" Editable="false" >
                                                    <Listeners>                                       
                                                        <Select Handler="this.getTrigger(0).show(); #{detailStore}.reload();" />
                                                    </Listeners>
                                                    <Store>
                                                        <ext:Store ID="majorStore" runat="server">
                                                            <Model>
                                                                <ext:Model ID="majorModel" runat="server">
                                                                    <Fields>
                                                                        <ext:ModelField Name="OBJID" />
                                                                        <ext:ModelField Name="MAJOR_TYPR_NAME" />
                                                                    </Fields>
                                                                </ext:Model>
                                                            </Model>
                                                        </ext:Store>
                                                    </Store>
                                                    <Triggers>
                                                       <ext:FieldTrigger Icon="Clear" QTip="Remove selected" />
                                                    </Triggers>
                                                    <Listeners>
                                                        <TriggerClick Handler="this.removeByValue(this.getValue());
                                                                               this.clearValue();" />
                                                    </Listeners>
                                                </ext:ComboBox>
                                                <ext:ComboBox ID="txtSpartPartMinor" runat="server" FieldLabel="备件小类" LabelAlign="Right"
                                                    DisplayField="MINOR_TYPE_NAME" ValueField="MINOR_TYPE_CODE" Editable="false"  >
                                                    <Store>
                                                        <ext:Store ID="detailStore" runat="server" OnReadData="Minor_Refersh">
                                                            <Model>
                                                                <ext:Model ID="detailModel" runat="server">
                                                                    <Fields>
                                                                        <ext:ModelField Name="OBJID" Type="String" ServerMapping="Id" />
                                                                        <ext:ModelField Name="MINOR_TYPE_NAME" Type="String" ServerMapping="Name" />
                                                                        <ext:ModelField Name="MINOR_TYPE_CODE" Type="String" ServerMapping="MINOR_TYPE_CODE"/>
                                                                    </Fields>
                                                                </ext:Model>
                                                            </Model>
                                                        </ext:Store>
                                                    </Store>
                                                    <Triggers>
                                                       <ext:FieldTrigger Icon="Clear" QTip="Remove selected" />
                                                    </Triggers>
                                                  <Listeners>
                                                        <Select Handler="this.getTrigger(0).show();" />
                                                        <%--<BeforeQuery Handler="this.getTrigger(0)[this.getRawValue().toString().length == 0 ? 'hide' : 'show']();" />
                                                        <TriggerClick Handler="if (index == 0) { this.clearValue(); this.getTrigger(0).hide();}" />--%>
                                                    </Listeners>
                                                </ext:ComboBox>
                                                <ext:Hidden ID="index" runat="server" />
                                            </Items>
                                        </ext:Container>
                                    </Items>
                                </ext:Container>
                            </Items>
                        </ext:Panel>
                    </Items>
                </ext:Panel>
                <ext:GridPanel ID="gridPanelCenter" runat="server" Region="Center">
                    <Store>
                        <ext:Store ID="store" runat="server" PageSize="10">
                            <Proxy>
                                <ext:PageProxy DirectFn="App.direct.GridPanelBindData" />
                            </Proxy>
                            <Model>
                                <ext:Model ID="model" runat="server">
                                    <Fields>
                                        <ext:ModelField Name="OBJID" />
                                        <ext:ModelField Name="SPAREPARTS_CODE" />
                                        <ext:ModelField Name="SPAREPARTS_NAME" />
                                    </Fields>
                                </ext:Model>
                            </Model>
                        </ext:Store>
                    </Store>
                    <ColumnModel ID="columnModel" runat="server">
                        <Columns>
                            <ext:RowNumbererColumn ID="rowNumCol" runat="server" Width="30" />
                            <ext:Column ID="spare_part_code" runat="server" Text="备件编码" DataIndex="SPAREPARTS_CODE" Width="120"  />
                            <ext:Column ID="spare_part_name" runat="server" Text="备件名称" DataIndex="SPAREPARTS_NAME" Width="200"  />
                            <ext:Column ID="Column1" runat="server" Text="备件ID" DataIndex="OBJID" Width="200" Hidden="true"  />
                            <ext:CommandColumn ID="commandColumn" runat="server" Width="60" Text="确认" Align="Center">
                                <Commands>
                                    <ext:GridCommand Icon="accept" CommandName="Select" Text="确认">
                                        <ToolTip Text="确认使用本条数据" />
                                    </ext:GridCommand>
                                </Commands>
                                <PrepareToolbar />
                                <Listeners>
                                    <Command Handler="return commandColumn_click(command, record);" />
                                </Listeners>
                            </ext:CommandColumn>
                        </Columns>
                    </ColumnModel>
                    <Listeners>
                        <CellDblClick Fn="cellDblClick" />
                    </Listeners>
                    <BottomBar>
                        <ext:PagingToolbar ID="pageToolbar" runat="server">
                        </ext:PagingToolbar>
                    </BottomBar>
                </ext:GridPanel>
            </Items>
        </ext:Viewport>
    </form>
</body>
</html>
