<%@ Page Language="C#" AutoEventWireup="true" CodeFile="DegradeManger.aspx.cs" Inherits="Plugins_Curing_Technology_DegradeManger" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title></title>
    <link rel="Stylesheet" type="text/css" href="<%= Page.ResolveUrl("~/") %>resources/css/ext-chinese-font.css" />
    <link rel="Stylesheet" type="text/css" href="<%= Page.ResolveUrl("~/") %>resources/css/main.css" />
    <script type="text/javascript" src="<%= Page.ResolveUrl("~/") %>resources/js/jquery-1.7.1.js"></script>
    <script type="text/javascript">
        //列表刷新数据重载方法
        var pnlListFresh = function () {
            App.hidden_delete_flag.setValue("0");
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
            if (command.toLowerCase() == "search") {
                commandcolumn_direct_search(record);
            }
            return false;
        };

        //点击修改按钮
        var commandcolumn_direct_edit = function (record) {
            var ObjId = record.data.OBJID;
            App.direct.commandcolumn_direct_edit(ObjId, {
                success: function (result) {
                },

                failure: function (errorMsg) {
                    Ext.Msg.alert('操作', errorMsg);
                }
            });
        }

        var commandcolumn_direct_search = function (record) {
            var tyreno = record.data.TYRE_NO;
            App.direct.commandcolumn_direct_search(tyreno, {
                success: function (result) {
                    refreshChart(tyreno);
                },

                failure: function (errorMsg) {
                    Ext.Msg.alert('操作', errorMsg);
                }
            });
        }
    </script>

    <script>
        var xdata0;
        var xdata1;
        var xdata2;
        var ydata1;
        var ydata2;
        var ydata3;
        var ydata4;
        var ydata5;
        var ydata6;
        var ydata7;
        var ydata8;

        var refreshChart = function (tyreno) {
            App.direct.chartMainBindData(tyreno,{
                success: function (result) {
                    if (result[0] == 'L') {
                        result = result.slice(1);
                        refreshDataL(JSON.parse(result));
                    }
                    else {
                        result = result.slice(1);
                        refreshDataR(JSON.parse(result))
                    }
                },
                failure: function (errorMsg) {
                    Ext.Msg.alert("提示", errorMsg);
                    return false;
                },
                eventMask: {
                    showMask: true
                }
            });
            return false;
        }

        var refreshDataL = function (data) {

            xdata0 = [];

            for (var i = 0; i < data.length; i++) {
                xdata0.push(data[i]["SHOW_TIME"]);
            }
            xdata1 = [];
            for (var i = 0; i < data.length; i++) {
                xdata1.push(data[i]["LEFT_TYRE_NO"]);
            }
            ydata1 = [];

            for (var i = 0; i < data.length; i++) {
                ydata1.push(data[i]["LEFT_INNER_TEMP"]);
            }
            ydata2 = [];
            for (var i = 0; i < data.length; i++) {
                ydata2.push(data[i]["LEFT_INNER_PRESS"]);
            }
            ydata3 = [];
            for (var i = 0; i < data.length; i++) {
                ydata3.push(data[i]["LEFT_PLATE_TEMP"]);
            }
            ydata4 = [];
            for (var i = 0; i < data.length; i++) {
                ydata4.push(data[i]["LEFT_MODEL_TEMP"]);
            }
            ydata5 = [];
            for (var i = 0; i < data.length; i++) {
                ydata5.push(data[i]["CURRENTSTEP"]);
            }
            App.CuringChart.getBody().update("<iframe src='CuringPressTempL.html' width=100% height=100% scrolling=no  frameborder=0></iframe>");
        }
        var refreshDataR = function (data) {

            xdata0 = [];
            for (var i = 0; i < data.length; i++) {
                xdata0.push(data[i]["SHOW_TIME"]);
            }
            xdata1 = [];
            for (var i = 0; i < data.length; i++) {
                xdata1.push(data[i]["RIGHT_TYRE_NO"]);

            }
            ydata1 = [];
            for (var i = 0; i < data.length; i++) {
                ydata1.push(data[i]["RIGHT_INNER_TEMP"]);
            }
            ydata2 = [];
            for (var i = 0; i < data.length; i++) {
                ydata2.push(data[i]["RIGHT_INNER_PRESS"]);
            }
            ydata3 = [];
            for (var i = 0; i < data.length; i++) {
                ydata3.push(data[i]["RIGHT_PLATE_TEMP"]);
            }
            ydata4 = [];
            for (var i = 0; i < data.length; i++) {
                ydata4.push(data[i]["RIGHT_MODEL_TEMP"]);
            }
            ydata5 = [];
            for (var i = 0; i < data.length; i++) {
                ydata5.push(data[i]["CURRENTSTEP"]);
            }
            App.CuringChart.getBody().update("<iframe src='CuringPressTempR.html' width=100% height=100% scrolling=no  frameborder=0></iframe>");
        }
    </script>
</head>
<body>
    <form id="form1" runat="server">
        <asp:Button ID="btnExportSubmit" Style="display: none" runat="server" Text="Button"
            OnClick="btnExportSubmit_Click" />
        <ext:ResourceManager ID="rmUser" runat="server" />
        <ext:Viewport ID="vwUnit" runat="server" Layout="border">
            <Items>
                <ext:Panel ID="pnlUserTitle" runat="server" Region="North" AutoHeight="true">
                    <TopBar>
                        <ext:Toolbar runat="server" ID="barUser">
                            <Items>
                                <ext:ToolbarSeparator ID="toolbarSeparator_begin" />
                                <ext:Button runat="server" Icon="Find" Text="查询" ID="btnSearch">
                                    <ToolTips>
                                        <ext:ToolTip ID="ttSearch" runat="server" Html="点击进行查询" />
                                    </ToolTips>
                                    <Listeners>
                                        <Click Fn="pnlListFresh">
                                        </Click>
                                    </Listeners>
                                </ext:Button>
                                <ext:ToolbarSeparator ID="toolbarSeparator_middle" />
                                <ext:Hidden ID="hidden_delete_flag" runat="server" Text="0" />
                                <ext:ToolbarSeparator ID="toolbarSeparator_middle_2" />
                                <ext:Button runat="server" Icon="PageWhiteExcel" Text="导出" ID="btnExport">
                                    <ToolTips>
                                        <ext:ToolTip ID="ToolTip2" runat="server" Html="点击将查询结果导出到Excel中" />
                                    </ToolTips>
                                    <Listeners>
                                        <Click Handler="$('#btnExportSubmit').click();">
                                        </Click>
                                    </Listeners>
                                </ext:Button>
                                <ext:ToolbarSeparator ID="toolbarSeparator_end" />
                                <ext:ToolbarSpacer runat="server" ID="toolbarSpacer_end" />
                                <ext:ToolbarFill ID="toolbarFill_end" />
                            </Items>
                        </ext:Toolbar>
                    </TopBar>
                    <Items>
                        <ext:Panel ID="pnlUserQuery" runat="server" AutoHeight="true">
                            <Items>
                                <ext:FormPanel ID="container_top" runat="server" Layout="ColumnLayout" AutoHeight="true">
                                    <Items>
                                        <ext:FieldContainer runat="server" Layout="ColumnLayout" ColumnWidth="1">
                                            <Items>
                                                <ext:Container ID="container_1" runat="server" Layout="FormLayout" ColumnWidth=".33"
                                                    Padding="5">
                                                    <Items>
                                                        <ext:Container ID="container1" runat="server" Layout="HBoxLayout">
                                                            <Items>
                                                                <ext:DateField runat="server" ID="datSearchBeginDate" LabelAlign="Right" FieldLabel="开始时间" Format="yyyy-MM-dd" Editable="false"
                                                                    LabelWidth="80" />
                                                                <ext:TimeField runat="server" ID="timSearchBeginTime" HideLabel="true" Format="HH:mm:ss"/>
                                                            </Items>
                                                        </ext:Container>
                                                        <ext:TextField ID="txt_green_no" runat="server" FieldLabel="胎胚号" LabelAlign="Right" />
                                                    </Items>
                                                </ext:Container>
                                                <ext:Container ID="container2" runat="server" Layout="FormLayout" ColumnWidth=".33"
                                                    Padding="5">
                                                    <Items>
                                                        <ext:Container ID="container3" runat="server" Layout="HBoxLayout">
                                                            <Items>
                                                                <ext:DateField runat="server" ID="datSearchEndDate" LabelAlign="Right" FieldLabel="结束时间" Format="yyyy-MM-dd" Editable="false"
                                                                    LabelWidth="80"  />
                                                                <ext:TimeField runat="server" ID="timSearchEndTime" HideLabel="true" Format="HH:mm:ss"  />
                                                            </Items>
                                                        </ext:Container>
                                                        <ext:ComboBox runat="server" ID="cboSearchEquipId" LabelAlign="Right" FieldLabel="硫化机台"
                                                            QueryMode="Local" ForceSelection="true" LabelWidth="80" >
                                                            <Triggers>
                                                                <ext:FieldTrigger Icon="Clear" Qtip="清空" HideTrigger="true" />
                                                            </Triggers>
                                                            <Listeners>
                                                                <TriggerClick Handler="this.setValue('');" />
                                                            </Listeners>
                                                        </ext:ComboBox>
                                                    </Items>
                                                </ext:Container>

                                                <ext:Container ID="container4" runat="server" Layout="FormLayout" ColumnWidth=".33"
                                                    Padding="5">
                                                    <Items>
                                                        <ext:TextField ID="txt_tyre_no" runat="server" FieldLabel="硫化号"  LabelAlign="Right" />
                                                        <ext:ComboBox runat="server" ID="cboSearchDegradeId" LabelAlign="Right" FieldLabel="品级"
                                                            QueryMode="Local" ForceSelection="true" LabelWidth="80">
                                                            <Triggers>
                                                                <ext:FieldTrigger Icon="Clear" Qtip="清空" />
                                                            </Triggers>
                                                            <Listeners>
                                                                <TriggerClick Handler="this.setValue('');" />
                                                            </Listeners>
                                                        </ext:ComboBox>
                                                    </Items>
                                                </ext:Container>
                                            </Items>
                                        </ext:FieldContainer>
                                    </Items>
                                </ext:FormPanel>
                            </Items>
                        </ext:Panel>
                    </Items>
                </ext:Panel>
                <ext:GridPanel ID="pnlList" runat="server" Region="Center">
                    <Store>
                        <ext:Store ID="store" runat="server" PageSize="100">
                            <Proxy>
                                <ext:PageProxy DirectFn="App.direct.GridPanelBindData" />
                            </Proxy>
                            <Model>
                                <ext:Model ID="model" runat="server">
                                    <Fields>
                                        <ext:ModelField Name="OBJID" />
                                        <ext:ModelField Name="EQUIP_NAME" />
                                        <ext:ModelField Name="RECORD_TIME" />
                                        <ext:ModelField Name="RECORD_USER_NAME" />
                                  <%--      <ext:ModelField Name="CONFIRM_USER_NAME" />--%>
                                        <ext:ModelField Name="TYRE_NO" />
                                        <ext:ModelField Name="GREEN_TYRE_NO" />
                                        <ext:ModelField Name="MATERIAL" />
                                        <ext:ModelField Name="DEGRADE_REASON" />
                                        <ext:ModelField Name="GRADENAME" />
                                       <%-- <ext:ModelField Name="EDIT_GRADENAME" />--%>
                                        <ext:ModelField Name="EQUIP_ID" />
                                        <ext:ModelField Name="DEGRADE_ID" />
                                        <ext:ModelField Name="RECORD_USER_ID" />
                                       <%-- <ext:ModelField Name="EDIT_DEGRADE_ID" />--%>
                                        <ext:ModelField Name="DEGRADE_NAME" />
                                        <ext:ModelField Name="REASON" />
                                        <ext:ModelField Name="MOULD_EQUIPNAME" />
                                        <ext:ModelField Name="USER_NAME" />
                                        <ext:ModelField Name="EMP1" />
                                        <ext:ModelField Name="EMP2" />
                                        <ext:ModelField Name="EMP3" />
                                        <ext:ModelField Name="EQUIP_POSITION" />
                                    </Fields>
                                </ext:Model>
                            </Model>
                        </ext:Store>
                    </Store>
                    <ColumnModel ID="colModel" runat="server">
                        <Columns>
                            <ext:Column ID="EQUIP_NAME" runat="server" Text="设备名称" DataIndex="EQUIP_NAME" Width="80" />
                            <ext:Column ID="Column5" runat="server" Text="左右模" DataIndex="EQUIP_POSITION" Width="80" />
                            <ext:Column ID="RECORD_TIME" runat="server" Text="记录时间" DataIndex="RECORD_TIME" Width="180" />
                            <ext:Column ID="RECORD_USER_NAME" runat="server" Text="记录人" DataIndex="RECORD_USER_NAME" Width="100" />
                       <%--     <ext:Column ID="CONFIRM_USER_NAME" runat="server" Text="确认人" DataIndex="CONFIRM_USER_NAME" Width="100" />--%>
                            <ext:Column ID="TYRE_NO" runat="server" Text="胎号" DataIndex="TYRE_NO" Width="100" />
                            <ext:Column ID="GREEN_TYRE_NO" runat="server" Text="胎胚号" DataIndex="GREEN_TYRE_NO" Width="100" />
                            <ext:Column ID="MATERIAL" runat="server" Text="物料规格" DataIndex="MATERIAL" Width="200" />                            
                            <ext:Column ID="DEGRADE_REASON" runat="server" Text="降级原因" DataIndex="DEGRADE_REASON" Width="150" />
                            <ext:Column ID="GRADENAME" runat="server" Text="品级" DataIndex="GRADENAME" Width="100" />
                            <ext:Column ID="Column1" runat="server" Text="成型机台" DataIndex="MOULD_EQUIPNAME" Width="100" />
                            <ext:Column ID="Column2" runat="server" Text="成型主机" DataIndex="EMP1" Width="100" />
                            <ext:Column ID="Column3" runat="server" Text="成型副机" DataIndex="EMP2" Width="100" />
                            <ext:Column ID="Column4" runat="server" Text="成型帮车" DataIndex="EMP3" Width="100" />
                         <%--   <ext:Column ID="EDIT_GRADENAME" runat="server" Text="改判前品级" DataIndex="EDIT_GRADENAME" Width="100" />--%>
                            <ext:Column ID="DEGRADE_NAME" runat="server" Text="改判人" DataIndex="DEGRADE_NAME" Width="100" />
                             <ext:Column ID="REASON" runat="server" Text="改判原因" DataIndex="REASON" Width="100" />
                            <ext:CommandColumn ID="commandCol" runat="server" Width="229" Text="操作" Align="Center">
                                <Commands>
                                    <ext:GridCommand Icon="TableEdit" CommandName="Edit" Text="改判">
                                        <ToolTip Text="改判" />
                                    </ext:GridCommand>
                                    <ext:CommandSeparator />
                                    <ext:GridCommand Icon="IpodNanoConnect" CommandName="Search" Text="查看曲线">
                                        <ToolTip Text="查看曲线" />
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
                            <Plugins>
                                <ext:ProgressBarPager ID="ProgressBarPager" runat="server" />
                            </Plugins>
                        </ext:PagingToolbar>
                    </BottomBar>
                </ext:GridPanel>
                <ext:Window ID="winModify" runat="server" Icon="MonitorEdit" Closable="false" Title="改判"
                    Width="600" Height="350" Resizable="false" Hidden="true" Modal="false" BodyStyle="background-color:#fff;"
                    BodyPadding="5" Layout="Form">
                    <Items>
                        <ext:FormPanel ID="pnlEdit" runat="server" Flex="1" BodyPadding="5">
                            <FieldDefaults>
                                <CustomConfig>
                                    <ext:ConfigItem Name="LabelWidth" Value="80" Mode="Raw" />
                                    <ext:ConfigItem Name="PreserveIndicatorIcon" Value="true" Mode="Raw" />
                                </CustomConfig>
                            </FieldDefaults>
                            <Items>
                                <ext:Container runat="server" Layout="ColumnLayout" AutoHeight="true">
                                    <Items>
                                        <ext:TextField ID="modify_objid" runat="server" FieldLabel="编号" LabelAlign="Left"
                                            ReadOnly="true" Enabled="true" />
                                     <%--   <ext:TextField ID="modify_txtDegradeId" runat="server" FieldLabel="改判前品级" LabelAlign="Left"
                                            ReadOnly="true" Enabled="true" Hidden="true"/>--%>
                                        <ext:Container runat="server" Layout="FormLayout">
                                            <Items>
                                                <ext:ComboBox runat="server" ID="cboModifyDegradeId" LabelAlign="Left" FieldLabel="品级"
                                                    QueryMode="Local" ForceSelection="true">
                                                </ext:ComboBox>
                                                <ext:ComboBox runat="server" ID="cbxChangeReason" LabelAlign="Left" FieldLabel="改判原因"
                                                    QueryMode="Local" ForceSelection="true">
                                                </ext:ComboBox>
                                            </Items>
                                        </ext:Container>
                                    </Items>
                                </ext:Container>
                            </Items>
                        </ext:FormPanel>
                    </Items>
                    <Buttons>
                        <ext:Button ID="btnModifySave" runat="server" Text="确定" Icon="Accept">
                            <DirectEvents>
                                <Click OnEvent="BtnModifySave_Click">
                                </Click>
                            </DirectEvents>
                        </ext:Button>
                        <ext:Button ID="btnModifyCancel" runat="server" Text="取消" Icon="Cancel">
                            <DirectEvents>
                                <Click OnEvent="BtnCancel_Click">
                                </Click>
                            </DirectEvents>
                        </ext:Button>
                    </Buttons>
                    <Listeners>
                        <Show Handler="for(var i=0;i<#{vwUnit}.items.length;i++){#{vwUnit}.getComponent(i).disable(true);}" />
                        <Hide Handler="for(var i=0;i<#{vwUnit}.items.length;i++){#{vwUnit}.getComponent(i).enable(true);}" />
                    </Listeners>
                </ext:Window>
                <ext:Window ID="winSearch" runat="server" Icon="MonitorEdit" Closable="true" Title="查看曲线"
                    Width="800" Height="520" Resizable="false" Hidden="true" Modal="false" BodyStyle="background-color:#fff;"
                    BodyPadding="5" Layout="FitLayout">
                    <Items>
                             <ext:Panel runat="server" Region="Center" AutoScroll="true" ID="CuringChart">
                </ext:Panel>
                    </Items>
                </ext:Window>
            </Items>
        </ext:Viewport>
    </form>
</body>
</html>
