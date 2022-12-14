<%@ Page Language="C#" AutoEventWireup="true" CodeFile="BladderChangeRecord.aspx.cs" Inherits="Plugins_Curing_Bladder_BladderChangeRecord" %>

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
                                        <ext:TextField ID="txtqian" Flex="1" FieldLabel="更换前胶囊编号" runat="server" LabelAlign="Right">
                                        </ext:TextField>
                                        <ext:TextField ID="txtNewBladder" Flex="1" FieldLabel="更换后胶囊编号" runat="server" LabelAlign="Right">
                                        </ext:TextField>
                                        <ext:ComboBox ID="cbxChange" runat="server" FieldLabel="更换原因" LabelAlign="Right" Editable="true" EnableKeyEvents="true" Hidden="true">
                                        </ext:ComboBox>
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
                                <ext:Container ID="container2" runat="server" Layout="FormLayout" ColumnWidth=".25"
                                    Padding="5">
                                    <Items>
                                        <ext:ComboBox ID="cbxBuyType" runat="server" FieldLabel="采购类型" LabelAlign="Right" Editable="true" EnableKeyEvents="true" Hidden ="true">
                                        </ext:ComboBox>
                                        <ext:ComboBox ID="cbxBladderType" runat="server" FieldLabel="胶囊类型" LabelAlign="Right" Editable="true" EnableKeyEvents="true" Hidden ="true">
                                        </ext:ComboBox>
                                        <ext:TextField ID="txtUserName" Flex="1" FieldLabel="更换人编号" runat="server" LabelAlign="Right" Hidden="true">
                                        </ext:TextField>
                                        <ext:ComboBox ID="cbxBladderSpec" runat="server" FieldLabel="胶囊规格" LabelAlign="Right" Editable="true" EnableKeyEvents="true">
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

                <ext:Panel ID="Panel2" runat="server" Region="Center" Frame="true" Layout="Fit" MarginsSummary="0 5 0 5" Title="胶囊信息">
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
                                                <ext:ModelField Name="BUY_TYPE_NAME" />
                                                <ext:ModelField Name="TYPE_NEW_NAME" />
                                                <ext:ModelField Name="NEW_GUIGE" />
                                                <ext:ModelField Name="OLD_GUIGE" />
                                                <ext:ModelField Name="NEW_SAP" />
                                                <ext:ModelField Name="OLD_SAP" />
                                                <ext:ModelField Name="USER_NAME" />
                                                <ext:ModelField Name="RECORD_DATE" />
                                                <ext:ModelField Name="SHOW_NAME" />
                                                <ext:ModelField Name="NEW_CAPSULE" />
                                                <ext:ModelField Name="NEW_REALNUM" />
                                                <ext:ModelField Name="OLD_REALNUM" />
                                                <ext:ModelField Name="NEW_MAXNUM" />
                                                <ext:ModelField Name="OLD_MAXNUM" />
                                                <ext:ModelField Name="CHANGE_NAME" />
                                                <ext:ModelField Name="EQUIP_NAME" />
                                                <ext:ModelField Name="OLD_CAPSULE" />
                                                <ext:ModelField Name="USERNAME1" />
                                                <ext:ModelField Name="USERNAME2" />
                                                <ext:ModelField Name="USERNAME3" />
                                                <ext:ModelField Name="CHANGE_NUM" />
                                                <ext:ModelField Name="YC1_NUM" />
                                                <ext:ModelField Name="YC2_NUM" />
                                                <ext:ModelField Name="YC3_NUM" />
                                                <ext:ModelField Name="YC1_TIME" />
                                                <ext:ModelField Name="YC2_TIME" />
                                                <ext:ModelField Name="YC3_TIME" />
                                                <ext:ModelField Name="YC1_USER" />
                                                <ext:ModelField Name="YC2_USER" />
                                                <ext:ModelField Name="YC3_USER" />
                                                <ext:ModelField Name="REMARK" />
                                                <ext:ModelField Name="CURRENTCOUNT" />
                                                <ext:ModelField Name="HSTIME" />
                                                <ext:ModelField Name="HSUSER" />
                                                <ext:ModelField Name="MATERIAL_NAME" />
                                            </Fields>
                                        </ext:Model>
                                    </Model>
                                </ext:Store>
                            </Store>
                            <ColumnModel ID="colModel" runat="server">                              
                                <Columns>
                                    <ext:RowNumbererColumn ID="rowNumCol" runat="server" Width="35" />
                                    <ext:Column ID="EQUIP_NAME" runat="server" Text="机台" Selectable="true" DataIndex="EQUIP_NAME" Width="60" />
                                    <ext:Column ID="SHOW_NAME" runat="server" Text="左右模" Selectable="true" DataIndex="SHOW_NAME" Width="60" />
                                     <ext:Column ID="USER_NAME1" runat="server" Text="换胶囊人员1" DataIndex="USERNAME1" Width="80" />
                                     <ext:Column ID="USER_NAME2" runat="server" Text="换胶囊人员2" DataIndex="USERNAME2" Width="80" />
                                     <ext:Column ID="USER_NAME3" runat="server" Text="换胶囊人员3" DataIndex="USERNAME3" Width="80" />
                                    <ext:Column ID="SPEC_NAME" runat="server" Text="换胶囊后规格" DataIndex="NEW_GUIGE" Width="160" />
                                    <ext:Column ID="Column2" runat="server" Text="换胶囊后品号" DataIndex="NEW_SAP" Width="160" />
                                    <ext:Column ID="Column18" runat="server" Text="生产规格" DataIndex="MATERIAL_NAME" Width="200" />
                                    <ext:Column ID="BLADDER_CODE" runat="server" Text="换胶囊后编号" Selectable="true" DataIndex="NEW_CAPSULE" Width="120" />
                                    <ext:Column ID="Column3" runat="server" Text="换胶囊后上限次数" Selectable="true" DataIndex="NEW_MAXNUM" Width="80" />
                                    <ext:Column ID="NUM1" runat="server" Text="换胶囊后当前次数" Selectable="true" DataIndex="NEW_REALNUM" Width="80" />
                                    <ext:Column ID="Column4" runat="server" Text="换胶囊前规格" Selectable="true" DataIndex="OLD_GUIGE" Width="120" />
                                    <ext:Column ID="Column5" runat="server" Text="换胶囊前品号" Selectable="true" DataIndex="OLD_SAP" Width="120" />
                                    <ext:Column ID="Column15" runat="server" Text="换胶囊前编号" Selectable="true" DataIndex="OLD_CAPSULE" Width="120" />
                                    <ext:Column ID="Column16" runat="server" Text="换胶囊前上限次数" Selectable="true" DataIndex="OLD_MAXNUM" Width="80" />
                                    <ext:Column ID="Column17" runat="server" Text="换胶囊前使用次数" Selectable="true" DataIndex="CURRENTCOUNT" Width="80" />
                                    <ext:DateColumn ID="DateColumn5" runat="server" Text="换上时间" DataIndex="HSTIME" Width="160" Format="yyyy-MM-dd HH:mm:ss" />
                                    <ext:Column ID="Column6" runat="server" Text="换上人" Selectable="true" DataIndex="HSUSER" Width="80" />
                                    <ext:DateColumn ID="DateColumn1" runat="server" Text="换下时间" DataIndex="RECORD_DATE" Width="160" Format="yyyy-MM-dd HH:mm:ss" />
                                    <ext:Column ID="Column19" runat="server" Text="换下人" Selectable="true" DataIndex="USER_NAME" Width="80" />
                                    <ext:Column ID="Column7" runat="server" Text="延长次数" Selectable="true" DataIndex="CHANGE_NUM" Width="80" />
                                    <ext:Column ID="Column8" runat="server" Text="第一次延长次数" Selectable="true" DataIndex="YC1_NUM" Width="80" />
                                    <ext:Column ID="Column9" runat="server" Text="第一次延长人" Selectable="true" DataIndex="YC1_USER" Width="80" />
                                    <ext:DateColumn ID="DateColumn2" runat="server" Text="第一次延长时间" DataIndex="YC1_TIME" Width="160" Format="yyyy-MM-dd HH:mm:ss" />
                                    <ext:Column ID="Column10" runat="server" Text="第二次延长次数" Selectable="true" DataIndex="YC2_NUM" Width="80" />
                                    <ext:Column ID="Column11" runat="server" Text="第二次延长人" Selectable="true" DataIndex="YC2_USER" Width="80" />
                                    <ext:DateColumn ID="DateColumn3" runat="server" Text="第二次延长时间" DataIndex="YC2_TIME" Width="160" Format="yyyy-MM-dd HH:mm:ss" />
                                    <ext:Column ID="Column12" runat="server" Text="第三次延长次数" Selectable="true" DataIndex="YC3_NUM" Width="80" />
                                    <ext:Column ID="Column13" runat="server" Text="第三次延长人" Selectable="true" DataIndex="YC3_USER" Width="80" />
                                    <ext:DateColumn ID="DateColumn4" runat="server" Text="第三次延长时间" DataIndex="YC3_TIME" Width="160" Format="yyyy-MM-dd HH:mm:ss" />
                                     <ext:Column ID="Column14" runat="server" Text="更换原因" Selectable="true" DataIndex="CHANGE_NAME" Width="80" />
                                    <ext:Column ID="Column1" runat="server" Text="备注" Selectable="true" DataIndex="REMARK" Width="80" />
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
