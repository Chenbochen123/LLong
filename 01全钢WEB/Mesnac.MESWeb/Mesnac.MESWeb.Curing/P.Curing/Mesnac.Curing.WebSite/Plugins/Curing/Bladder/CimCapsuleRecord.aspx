<%@ Page Language="C#" AutoEventWireup="true" CodeFile="CimCapsuleRecord.aspx.cs" Inherits="Plugins_Curing_Bladder_CimCapsuleRecord" %>

<%@ Register Assembly="Ext.Net" Namespace="Ext.Net" TagPrefix="ext" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>胶囊退库记录</title>
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

        var McUI_SearchBox_SearchBoxCbeCuringEquip_Request = function (record) {
                App.txt_equip.getTrigger(0).show();
                App.txt_equip.setValue(record.data.EQUIP_NAME);
                App.hidden_equip_id.setValue(record.data.OBJID);
        }

        var SelectCuringEquip = function (field, trigger, index) {//查询
            switch (index) {
                case 0:
                    field.getTrigger(0).hide();
                    field.setValue('');
                    App.hidden_equip_id.setValue("");
                    field.getEl().down('input.x-form-text').setStyle('background', "white");
                    break;
                case 1:
                    App.McUI_SearchBox_SearchBoxCbeCuringEquip_Window.show();
                    break;
            }
        }

        Ext.create("Ext.window.Window", {//查询带回窗体
            id: "McUI_SearchBox_SearchBoxCbeCuringEquip_Window",
            height: 430,
            hidden: true,
            width: 360,
            html: "<iframe src='../../../McUI/SearchBox/SearchBoxCbeCuringEquip.aspx' width=100% height=100% scrolling=no  frameborder=0></iframe>",
            bodyStyle: "background-color: #fff;",
            closable: true,
            title: "请选择机台",
            modal: true
        })
    </script>
</head>
<body>    
    <form id="form1" runat="server">
        <ext:Hidden ID="hidden_update_objId" runat="server"></ext:Hidden>
        <asp:Button ID="btnExportSubmit" Style="display: none" runat="server" Text="Button"
        OnClick="btnExportSubmit_Click" />
        <ext:ResourceManager ID="rmQCRecord" runat="server" />
        <ext:Viewport ID="vpQCRecord" runat="server" Layout="border">
            <Items>
                <ext:Panel ID="pnMEquipControl" runat="server" Region="North" Height="120">
                    <TopBar>
                        <ext:Toolbar runat="server" ID="tbMEquipControl">
                            <Items>
                                <ext:ToolbarSeparator ID="ctl" />
                                <ext:Button runat="server" Icon="Find" Text="查询" ID="btnSearch">
                                    <Listeners>
                                        <Click Fn="pnlListFresh" />
                                    </Listeners>
                                </ext:Button>
                                <ext:ToolbarSeparator ID="ct2" />
                                <ext:Button runat="server" Icon="PageExcel" Text="导出" ID="btnExport">
                                    <ToolTips>
                                        <ext:ToolTip ID="ToolTip2" runat="server" Html="点击将查询结果导出到Excel中" />
                                    </ToolTips>
                                    <Listeners>
                                        <Click Handler="$('#btnExportSubmit').click();">
                                        </Click>
                                    </Listeners>
                                </ext:Button>
                                <ext:ToolbarSeparator ID="tsBegin" />
                                <ext:ToolbarSpacer runat="server" ID="tspacerEnd" />
                                <ext:ToolbarFill ID="tfEnd" />
                            </Items>
                        </ext:Toolbar>
                    </TopBar>
                    <Items>
                        <ext:FormPanel ID="container_top" runat="server" Layout="ColumnLayout" AutoHeight="true">
                            <Items>

                                <ext:Container ID="container1" runat="server" Layout="FormLayout" ColumnWidth=".25"
                                    Padding="5">
                                    <Items>
                                        <ext:FieldContainer runat="server" FieldLabel="开始时间" Layout="HBoxLayout" LabelAlign="Right">
                                            <Items>
                                                <ext:DateField ID="txtBeginDate" runat="server" Flex="1" Editable="false" />
                                                <ext:TimeField ID="txtBeginTime" runat="server" Width="80" Editable="true" />
                                            </Items>
                                        </ext:FieldContainer>
                                        <ext:FieldContainer runat="server" FieldLabel="结束时间" Layout="HBoxLayout" LabelAlign="Right">
                                            <Items>
                                                <ext:DateField ID="txtEndDate" runat="server" Flex="1" Editable="false" />
                                                <ext:TimeField ID="txtEndTime" runat="server" Width="80" Editable="true" />
                                            </Items>
                                        </ext:FieldContainer>
                                        </Items>
                                </ext:Container>
                                <ext:Container ID="container3" runat="server" Layout="FormLayout" ColumnWidth=".25"
                                    Padding="5">
                                    <Items>
                                        <ext:TextField ID="txtcapsule" Flex="1" FieldLabel="胶囊编号" runat="server" LabelAlign="Right">
                                        </ext:TextField>
                                    </Items>
                                </ext:Container>
                                <ext:Container ID="container4" runat="server" Layout="FormLayout" ColumnWidth=".25"
                                    Padding="5">
                                    <Items>
                                        <ext:TriggerField ID="txt_equip" runat="server" FieldLabel="机台" LabelAlign="Right"
                                            Editable="false">
                                            <Triggers>
                                                <ext:FieldTrigger Icon="Clear" HideTrigger="true" />
                                                <ext:FieldTrigger Icon="Search" />
                                            </Triggers>
                                            <Listeners>
                                                <TriggerClick Fn="SelectCuringEquip" />
                                            </Listeners>
                                        </ext:TriggerField>
                                        <ext:Hidden ID="hidden_equip_id" runat="server" />
                                    </Items>
                                </ext:Container>
                                <ext:Container ID="container2" runat="server" Layout="FormLayout" ColumnWidth=".25"
                                    Padding="5">
                                    <Items>
                                        <ext:ComboBox ID="cbxPosition" runat="server" FieldLabel="左右模" LabelAlign="right" Editable="false">
                                            <Triggers>
                                                <ext:FieldTrigger Icon="Clear" Qtip="清空" />
                                            </Triggers>
                                            <Listeners>
                                                <TriggerClick Handler="this.clearValue();" />
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
                </ext:Panel>

                <ext:Panel ID="Panel2" runat="server" Region="Center" Frame="true" Layout="Fit" MarginsSummary="0 5 0 5" Title="退库信息">
                    <Items>
                        <ext:GridPanel ID="pnlList" runat="server">
                            <View><ext:GridView EnableTextSelection="true"></ext:GridView></View>
                            <Store>
                                <ext:Store ID="store" runat="server" PageSize="20">
                                    <Proxy>
                                        <ext:PageProxy DirectFn="App.direct.GridPanelBindData" />
                                    </Proxy>
                                    <Model>
                                        <ext:Model ID="model" runat="server" IDProperty="OBJID">                                            
                                            <Fields>                                                
                                                <ext:ModelField Name="OBJID" />
                                                <ext:ModelField Name="EQUIPCODE" />
                                                <ext:ModelField Name="LR" />
                                                <ext:ModelField Name="CAPSULECODE" />
                                                <ext:ModelField Name="RECORD_TIME" />
                                                <ext:ModelField Name="USER_NAME" />
                                                <ext:ModelField Name="TYPE_NAME" />
                                                <ext:ModelField Name="BLADDER_SPEC" />
                                                <ext:ModelField Name="DUMMY1" />
                                            </Fields>
                                        </ext:Model>
                                    </Model>
                                </ext:Store>
                            </Store>
                            <ColumnModel ID="colModel" runat="server">                              
                                <Columns>
                                    <ext:RowNumbererColumn ID="rowNumCol" runat="server" Width="35" />
                                    <ext:Column ID="EQUIP_NAME" runat="server" Text="机台" Selectable="true" DataIndex="EQUIPCODE" Width="60" />
                                    <ext:Column ID="SHOW_NAME" runat="server" Text="左右模" Selectable="true" DataIndex="LR" Width="60" />
                                     <ext:Column ID="USER_NAME1" runat="server" Text="胶囊编号" DataIndex="CAPSULECODE" Width="100" />
                                     <ext:Column ID="USER_NAME2" runat="server" Text="胶囊规格" DataIndex="TYPE_NAME" Width="100" />
                                     <ext:Column ID="Column2" runat="server" Text="胶囊品号" DataIndex="BLADDER_SPEC" Width="100" />
                                    <ext:Column ID="Column5" runat="server" Text="使用次数" Selectable="true" DataIndex="DUMMY1" Width="100" />
                                    <ext:Column ID="CAPSULEID" runat="server" Text="操作人" Selectable="true" DataIndex="USER_NAME" Width="120" />
                                    <ext:DateColumn ID="DateColumn1" runat="server" Text="操作时间" DataIndex="RECORD_TIME" Width="160" Format="yyyy-MM-dd HH:mm:ss" />
                                </Columns>
                            </ColumnModel>
                            <BottomBar>
                                <ext:PagingToolbar ID="pageToolBar" runat="server">
                                    <Items>
                                        <ext:TextField ID="txtTotalNum" runat="server" LabelAlign="Right" ReadOnly="true" />
                                    </Items>
                                    <Plugins>
                                        <ext:ProgressBarPager ID="ProgressBarPager" runat="server" />
                                    </Plugins>
                                </ext:PagingToolbar>
                            </BottomBar>
                            <Features>
                                <ext:Summary runat="server"></ext:Summary>
                            </Features>
                        </ext:GridPanel>
                    </Items>
                </ext:Panel>
            </Items>
        </ext:Viewport>
    </form>
</body>
</html>
