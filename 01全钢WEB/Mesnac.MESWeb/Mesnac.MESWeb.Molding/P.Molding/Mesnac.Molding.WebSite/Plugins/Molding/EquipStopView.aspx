<%@ Page Language="C#" AutoEventWireup="true" CodeFile="EquipStopView.aspx.cs" Inherits="Plugins_Molding_EquipStopView" %>


<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>停机记录</title>
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
            if (App.txtBeginDate.getValue() > App.txtEndDate.getValue()) {
                Ext.Msg.alert('操作', '开始时间不能大于结束时间！');
                return false;
            }
            App.store.currentPage = 1;
            App.pageToolBar.doRefresh();
            return false;
        }

        //根据按钮类别进行删除和编辑操作
        var commandcolumn_click = function (command, record) {
            commandcolumn_click_confirm(command, record);
            return false;
        };

        //区分删除操作，并进行二次确认操作
        var commandcolumn_click_confirm = function (command, record) {
            if (command.toLowerCase() == "edit") {
                commandcolumn_direct_edit(record);
            }
            return false;
        };

        //点击修改按钮
        var commandcolumn_direct_edit = function (record) {
            var objid = record.data.OBJID;
            App.direct.commandcolumn_direct_edit(objid, {
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
        <asp:Button ID="btnExportSubmit" Style="display: none" runat="server" Text="Button"
            OnClick="btnExportSubmit_Click" />
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
                                <ext:ToolbarSeparator ID="tsMiddle" />
                                <ext:Button runat="server" Icon="PageExcel" Text="导出Excel" ID="btnExport">
                                    <ToolTips>
                                        <ext:ToolTip ID="ToolTip2" runat="server" Html="点击将查询结果导出到Excel中" />
                                    </ToolTips>
                                    <Listeners>
                                        <Click Handler="$('#btnExportSubmit').click();">
                                        </Click>
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
                                <ext:Container ID="container1" runat="server" Layout="FormLayout" ColumnWidth=".22"
                                    Padding="5">
                                    <Items>
                                        <ext:FieldContainer runat="server" FieldLabel="开始日期" Layout="HBoxLayout" LabelAlign="Left">
                                            <Items>
                                                <ext:DateField ID="txtBeginDate" runat="server" Flex="1" Editable="false" />
                                            </Items>
                                        </ext:FieldContainer>
                                        <ext:TextField ID="txtEquipName" runat="server" FieldLabel="机台名称" LabelAlign="Left"></ext:TextField>
                                        
                                    </Items>
                                </ext:Container>
                                <ext:Container ID="container2" runat="server" Layout="FormLayout" ColumnWidth=".22"
                                    Padding="5">
                                    <Items>
                                        <ext:FieldContainer runat="server" FieldLabel="结束日期" Layout="HBoxLayout" LabelAlign="Left">
                                            <Items>
                                                <ext:DateField ID="txtEndDate" runat="server" Flex="1" Editable="false" />
                                            </Items>
                                        </ext:FieldContainer>
                                        <ext:TextField ID="txttime" runat="server" FieldLabel="停机时间大于(s)" LabelAlign="Left"></ext:TextField>
                                        
                                    </Items>
                                </ext:Container>
                                <ext:Container ID="container_3" runat="server" Layout="FormLayout" ColumnWidth=".22"
                                            Padding="5">
                                            <Items>
                                                <ext:ComboBox ID="cbxStore" runat="server" FieldLabel="机台大类" LabelAlign="Right" Editable="false">
                                                    <Listeners>
                                                        <Select Handler="#{cbxStorePlace}.clearValue(); #{PlaceStore}.reload();#{cbxReason}.clearValue(); #{ReasonStore}.reload();
                                                            #{ComboBox3}.clearValue(); #{Store2}.reload();#{ComboBox2}.clearValue(); #{Store1}.reload();" />
                                                    </Listeners>
                                                </ext:ComboBox>
                                                <ext:ComboBox ID="cbxStorePlace" runat="server" DisplayField="SSVALUE"
                                                    ValueField="SSKEY" FieldLabel="停机类型" LabelAlign="Right" Editable="false">
                                                    <Store>
                                                        <ext:Store
                                                            runat="server"
                                                            ID="PlaceStore"
                                                            AutoLoad="false"
                                                            OnReadData="StorePlaceRefresh">
                                                            <Model>
                                                                <ext:Model runat="server" IDProperty="SSKEY">
                                                                    <Fields>
                                                                        <ext:ModelField Name="SSKEY" Type="String" Mapping="SSKEY" />
                                                                        <ext:ModelField Name="SSVALUE" Type="String" Mapping="SSVALUE" />
                                                                    </Fields>
                                                                </ext:Model>
                                                            </Model>

                                                        </ext:Store>
                                                    </Store>
                                                </ext:ComboBox>
                                            </Items>
                                        </ext:Container>
                                <ext:Container ID="container3" runat="server" Layout="FormLayout" ColumnWidth=".22"
                                    Padding="5">
                                    <Items>
                                        
                                        <ext:ComboBox ID="cbxReason" runat="server" DisplayField="SSVALUE"
                                            ValueField="SSKEY" FieldLabel="停机原因" LabelAlign="Right" Editable="false">
                                            <Store>
                                                <ext:Store
                                                    runat="server"
                                                    ID="ReasonStore"
                                                    AutoLoad="false"
                                                    OnReadData="StoreReasonRefresh">
                                                    <Model>
                                                        <ext:Model runat="server" IDProperty="SSKEY">
                                                            <Fields>
                                                                <ext:ModelField Name="SSKEY" Type="String" Mapping="SSKEY" />
                                                                <ext:ModelField Name="SSVALUE" Type="String" Mapping="SSVALUE" />
                                                            </Fields>
                                                        </ext:Model>
                                                    </Model>
                                                </ext:Store>
                                            </Store>
                                        </ext:ComboBox>
                                    </Items>
                                </ext:Container>
                                
                            </Items>
                        </ext:FormPanel>
                    </Items>
                </ext:Panel>
                <ext:Panel ID="Panel2" runat="server" Region="Center" Frame="true" Layout="Fit" MarginsSummary="0 5 0 5 ">
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
                                                <ext:ModelField Name="EQUIP_CODE" />
                                                <ext:ModelField Name="EQUIP_STOP_TYPE_NAME" />
                                                <ext:ModelField Name="EQUIP_STOP_REASON_NAME" />
                                                <ext:ModelField Name="STOP_BEGIN_TIME" Type="Date" />
                                                <ext:ModelField Name="STOP_END_TIME" Type="Date" />
                                                <ext:ModelField Name="ROUNDSECEND" />
                                                <ext:ModelField Name="REMARK" />
                                            </Fields>
                                        </ext:Model>
                                    </Model>
                                </ext:Store>
                            </Store>
                            <ColumnModel ID="colModel" runat="server">
                                <Columns>
                                    <ext:RowNumbererColumn ID="rowNumCol1" runat="server" Width="35" />
                                    <ext:Column ID="OBJID" runat="server" DataIndex="OBJID" Width="160" Hidden="true" />
                                    <ext:Column ID="EQUIP_NAME" runat="server" Text="机台名称" DataIndex="EQUIP_CODE" Width="160" />
                                    <ext:Column ID="NAME1" runat="server" Text="停机类型" DataIndex="EQUIP_STOP_TYPE_NAME" Width="120" />
                                    <ext:Column ID="NAME2" runat="server" Text="停机原因" DataIndex="EQUIP_STOP_REASON_NAME" Width="120" />
                                    <ext:DateColumn ID="RECORD_TIME" runat="server" Text="开始时间" DataIndex="STOP_BEGIN_TIME" Width="160" Format="yyyy-MM-dd HH:mm:ss" />
                                    <ext:DateColumn ID="DateColumn1" runat="server" Text="结束时间" DataIndex="STOP_END_TIME" Width="160" Format="yyyy-MM-dd HH:mm:ss" />
                                    <ext:Column ID="Column1" runat="server" Text="耗时（秒）" DataIndex="ROUNDSECEND" Width="120" />
                                    <ext:Column ID="Column2" runat="server" Text="说明" DataIndex="REMARK" Width="120" />
                                    <ext:CommandColumn ID="commandCol" runat="server" Width="60" Text="操作" Align="Center">
                                        <Commands>
                                            <ext:GridCommand Icon="TableEdit" CommandName="Edit" Text="修改">
                                                <ToolTip Text="修改" />
                                            </ext:GridCommand>
                                        </Commands>
                                        <Listeners>
                                            <Command Handler="return commandcolumn_click(command, record);" />
                                        </Listeners>
                                    </ext:CommandColumn>
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
                <ext:Window ID="winEditProduct" runat="server" Icon="MonitorEdit" Closable="true"
                    Title="修改说明" Width="360" Height="360" Resizable="false" Hidden="true" Modal="true"
                    BodyStyle="background-color:#fff;" BodyPadding="5" Layout="FitLayout">
                    <Items>
                        <ext:FormPanel ID="FormPanel2" runat="server" Flex="1" BodyPadding="5">
                            <Defaults>
                                <ext:Parameter Name="allowBlank" Value="false" Mode="Raw" />
                            </Defaults>
                            <FieldDefaults>
                                <CustomConfig>
                                    <ext:ConfigItem Name="LabelWidth" Value="80" Mode="Raw" />
                                    <ext:ConfigItem Name="PreserveIndicatorIcon" Value="true" Mode="Raw" />
                                </CustomConfig>
                            </FieldDefaults>
                            <Items>
                                <ext:TextField runat="server" ID="txtbeizhu" FieldLabel="说明" Editable="true" />
                                <ext:ComboBox ID="ComboBox3" runat="server" DisplayField="SSVALUE"
                                    ValueField="SSKEY" FieldLabel="停机类型" LabelAlign="Right" Editable="false">
                                    <Store>
                                        <ext:Store
                                            runat="server"
                                            ID="Store2"
                                            AutoLoad="false"
                                            OnReadData="StorePlaceRefresh">
                                            <Model>
                                                <ext:Model runat="server" IDProperty="SSKEY">
                                                    <Fields>
                                                        <ext:ModelField Name="SSKEY" Type="String" Mapping="SSKEY" />
                                                        <ext:ModelField Name="SSVALUE" Type="String" Mapping="SSVALUE" />
                                                    </Fields>
                                                </ext:Model>
                                            </Model>

                                        </ext:Store>
                                    </Store>
                                </ext:ComboBox>
                                <ext:ComboBox ID="ComboBox2" runat="server" DisplayField="SSVALUE"
                                    ValueField="SSKEY" FieldLabel="停机原因" LabelAlign="Right" Editable="false">
                                    <Store>
                                        <ext:Store
                                            runat="server"
                                            ID="Store1"
                                            AutoLoad="false"
                                            OnReadData="StoreReasonRefresh">
                                            <Model>
                                                <ext:Model runat="server" IDProperty="SSKEY">
                                                    <Fields>
                                                        <ext:ModelField Name="SSKEY" Type="String" Mapping="SSKEY" />
                                                        <ext:ModelField Name="SSVALUE" Type="String" Mapping="SSVALUE" />
                                                    </Fields>
                                                </ext:Model>
                                            </Model>
                                        </ext:Store>
                                    </Store>
                                </ext:ComboBox>
                                <ext:Hidden runat="server" ID="hiddenobjid" />
                            </Items>
                        </ext:FormPanel>
                    </Items>
                    <Buttons>
                        <ext:Button ID="btnEditOK" runat="server" Text="确定" Icon="Accept">
                            <DirectEvents>
                                <Click OnEvent="btnEditOK_Click"></Click>
                            </DirectEvents>
                        </ext:Button>
                        <ext:Button ID="btnEditCancle" runat="server" Text="取消" Icon="Cancel">
                            <DirectEvents>
                                <Click OnEvent="btnEditCancle_Click"></Click>
                            </DirectEvents>
                        </ext:Button>
                    </Buttons>
                </ext:Window>

            </Items>
        </ext:Viewport>
    </form>
</body>
</html>