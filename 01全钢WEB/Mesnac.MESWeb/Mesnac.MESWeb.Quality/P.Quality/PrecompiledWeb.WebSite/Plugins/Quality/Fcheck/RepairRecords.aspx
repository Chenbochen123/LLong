<%@ page language="C#" autoeventwireup="true" inherits="Plugins_Quality_Fcheck_RepairRecords, Mesnac.Quality.WebSite" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title></title>
    <script type="text/javascript" src="<%= Page.ResolveUrl("~/") %>resources/js/jquery-1.7.1.js"></script>
    <link rel="Stylesheet" type="text/css" href="<%= Page.ResolveUrl("~/") %>resources/css/ext-chinese-font.css" />
    <link rel="Stylesheet" type="text/css" href="<%= Page.ResolveUrl("~/") %>resources/css/main.css" />
    <style type="text/css">
        .x-grid-row-collapsed .x-grid-cell
        {
            background-color: #B0FFBA !important;
        }
    </style>
    <script type="text/javascript">

        var pnlListFresh = function () {
            if (App.txtBeginDate.getValue() > App.txtEndDate.getValue()) {
                Ext.Msg.alert('操作', '开始时间不能大于结束时间！');
                return false;
            }
            else
            {
                if (App.txtBeginTime.getValue() > App.txtEndTime.getValue()) {
                    Ext.Msg.alert('操作', '开始时间不能大于结束时间！');
                    return false;
                }
            }
            App.store.currentPage = 1;
            App.pageToolBar.doRefresh();
            return false;
        }

        var prepareToolbar = function (grid, toolbar, rowIndex, record) {

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
                            <ext:ToolbarSeparator ID="tsEnd" />
                            <ext:ToolbarSpacer runat="server" ID="tspacerEnd" />
                            <ext:ToolbarFill ID="tfEnd" />
                        </Items>
                    </ext:Toolbar>
                </TopBar>
                <Items>
                    <ext:FormPanel ID="container_top" runat="server" Layout="ColumnLayout" AutoHeight="true"
                        Collapsible="false">
                        <Items>
                             <ext:Container ID="container1" runat="server" Layout="FormLayout" ColumnWidth=".3"
                                Padding="5">
                                <Items>
                                      <ext:FieldContainer runat="server" FieldLabel="开始时间" Layout="HBoxLayout" LabelAlign="Right">
                                            <Items>
                                                <ext:DateField ID="txtBeginDate" runat="server" Flex="1" Editable="false" />
                                                <ext:TimeField ID="txtBeginTime" runat="server" width="80" Editable="true" />
                                            </Items>
                                        </ext:FieldContainer>
                                    <ext:TextField ID="txtTyreNo" runat="server" FieldLabel="胎号" LabelAlign="Right" />
                                </Items>
                            </ext:Container>
                            <ext:Container ID="container2" runat="server" Layout="FormLayout" ColumnWidth=".3"
                                Padding="5">
                                <Items>
                                    <ext:FieldContainer runat="server" FieldLabel="结束时间" Layout="HBoxLayout" LabelAlign="Right">
                                            <Items>
                                                <ext:DateField ID="txtEndDate" runat="server" Flex="1" Editable="false" />
                                                <ext:TimeField ID="txtEndTime" runat="server" width="80" Editable="true" />
                                            </Items>
                                        </ext:FieldContainer>
                                    <ext:TextField ID="txtMaterialName" runat="server" FieldLabel="规格" LabelAlign="Right" Editable="false"></ext:TextField>
                                </Items>
                            </ext:Container>
                            <ext:Container ID="container3" runat="server" Layout="FormLayout" ColumnWidth=".3"
                                Padding="5">
                                <Items>
                                    <ext:ComboBox ID="cbxResult" runat="server" FieldLabel="修补结果" LabelAlign="Right" Editable="false"></ext:ComboBox>
                                    <ext:ComboBox ID="cbxRepeat" runat="server" FieldLabel="修补操作" LabelAlign="Right" Editable="false">
                                    </ext:ComboBox>
                                </Items>
                            </ext:Container>
                        </Items>
                    </ext:FormPanel>
                </Items>
            </ext:Panel>
            <ext:Panel ID="Panel2" runat="server" Region="Center" Frame="true" Layout="Fit" MarginsSummary="0 5 0 5 "
                Title="成品胎修补记录">
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
                                            <ext:ModelField Name="TYRE_NO" />
                                            <ext:ModelField Name="GREEN_TYRE_NO" />
                                            <ext:ModelField Name="REPEAT_NAME" />
                                            <ext:ModelField Name="REPEAT_ID" />
                                            <ext:ModelField Name="REPAIR_RESULT_ID" />
                                            <ext:ModelField Name="RESULT_NAME" />
                                            <ext:ModelField Name="SHIFT_NO" />
                                            <ext:ModelField Name="SHIFT_NAME" />
                                            <ext:ModelField Name="RECORD_USER_ID" />
                                            <ext:ModelField Name="USER_NAME" />
                                            <ext:ModelField Name="MATERIAL_NAME" />
                                            <ext:ModelField Name="MATERIAL_ID" />
                                            <ext:ModelField Name="RECORD_TIME" Type="Date" />
                                            <ext:ModelField Name="REMARK" />
                                        </Fields>
                                    </ext:Model>
                                </Model>
                            </ext:Store>
                        </Store>
                        <ColumnModel ID="colModel" runat="server">
                            <Columns>
                                <ext:RowNumbererColumn ID="rowNumCol1" runat="server" Width="35" />
                                <ext:Column ID="TyreNo" runat="server" Text="胎号" DataIndex="TYRE_NO" Width="160" />
                                <ext:Column ID="MaterialName" runat="server" Text="规格" DataIndex="MATERIAL_NAME" Width="200"/>
                                <ext:Column ID="RepeatID" runat="server" Text="修补操作" DataIndex="REPEAT_ID" Width="160" />
                                <ext:Column ID="RepairResultID" runat="server" Text="修补结果" DataIndex="REPAIR_RESULT_ID" Width="300" />
                                <ext:Column ID="ShiftName" runat="server" Text="班次" DataIndex="SHIFT_NAME" Width="60" />
                                <ext:Column ID="UserName" runat="server" Text="修补人" DataIndex="RECORD_USER_ID" Width="100" />
                                <ext:DateColumn ID="RecordTime" runat="server" Text="修补时间" DataIndex="RECORD_TIME" Width="200" Format="yyyy-MM-dd HH:mm:ss"/>
                                <ext:Column ID="Remark" runat="server" Text="备注" DataIndex="RECORD_TIME" Width="160" Flex="1"/>
                            </Columns>
                        </ColumnModel>
                        <BottomBar>
                            <ext:PagingToolbar ID="pageToolBar" runat="server">
                                <Items>
                                    <ext:Label ID="Label1" runat="server" Text="每页条数:" Hidden="true"/>
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
