<%@ Page Language="C#" AutoEventWireup="true" CodeFile="CapsuleDegradeManger.aspx.cs" Inherits="Plugins_Curing_Technology_CapsuleDegradeManger" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title></title>
    <link rel="Stylesheet" type="text/css" href="<%= Page.ResolveUrl("~/") %>resources/css/ext-chinese-font.css" />
    <link rel="Stylesheet" type="text/css" href="<%= Page.ResolveUrl("~/") %>resources/css/main.css" />
    <script type="text/javascript" src="<%= Page.ResolveUrl("~/") %>resources/js/jquery-1.7.1.js"></script>
    <script type="text/javascript">
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
            var green = record.data.GREEN_TYRE_NO;
            var tyreNo = record.data.TYRE_NO;
            var equipID = record.data.EQUIP_ID;
            var userID = record.data.WORKER_ID;
            App.direct.commandcolumn_direct_edit(green,tyreNo,equipID,userID, {
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
        <%--        <asp:Button ID="btnExportSubmit" Style="display: none" runat="server" Text="Button"
            OnClick="btnExportSubmit_Click" />--%>
        <ext:ResourceManager ID="rmCDM" runat="server" />
        <ext:Viewport ID="vwUnit" runat="server" Layout="border">
            <Items>
                <ext:Panel ID="pnlUserTitle" runat="server" Region="North" AutoHeight="true">
                    <TopBar>
                        <ext:Toolbar runat="server" ID="barUser">
                            <Items>
                                <%--   <ext:ToolbarSeparator ID="toolbarSeparator_begin" />--%>
                                <ext:Button runat="server" Icon="Find" Text="查询" ID="btnSearch">
                                    <ToolTips>
                                        <ext:ToolTip ID="ttSearch" runat="server" Html="点击进行查询" />
                                    </ToolTips>
                                    <DirectEvents>
                                        <Click OnEvent="GridPanelBindData">
                                             <EventMask ShowMask="true" Msg="正在查询..."></EventMask>
                                        </Click>
                                    </DirectEvents>
                                </ext:Button>
                              
                                <%--           <ext:Button runat="server" Icon="PageWhiteExcel" Text="导出" ID="btnExport">
                                    <ToolTips>
                                        <ext:ToolTip ID="ToolTip2" runat="server" Html="点击将查询结果导出到Excel中" />
                                    </ToolTips>
                                    <Listeners>
                                        <Click Handler="$('#btnExportSubmit').click();">
                                        </Click>
                                    </Listeners>
                                </ext:Button>--%>
                                <ext:ToolbarSeparator ID="toolbarSeparator_end" />
                                  <ext:TextField runat="server" ID="txtNum" FieldLabel="查询条数" Text="3" Width="200" LabelAlign="Left">

                                </ext:TextField>
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
                                                        <ext:TextField ID="txt_green_no" runat="server" FieldLabel="胎胚号" LabelAlign="Right" />
                                                    </Items>
                                                </ext:Container>
                                                <ext:Container ID="container4" runat="server" Layout="FormLayout" ColumnWidth=".33"
                                                    Padding="5">
                                                    <Items>
                                                        <ext:TextField ID="txt_tyre_no" runat="server" FieldLabel="硫化号" LabelAlign="Right" />
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
                        <ext:Store ID="store" runat="server" PageSize="15">
                            <Model>
                                <ext:Model ID="model" runat="server">
                                    <Fields>
                                        <ext:ModelField Name="TYRE_NO" />
                                        <ext:ModelField Name="GREEN_TYRE_NO" />
                                        <ext:ModelField Name="MATERIAL_NAME" />
                                        <ext:ModelField Name="EQUIP_NAME" />
                                        <ext:ModelField Name="EQUIP_POSITON" />
                                        <ext:ModelField Name="BLADDER_USER_AMOUNT" />
                                        <ext:ModelField Name="SHIFT_DATE" Type="Date" />
                                        <ext:ModelField Name="BEGIN_TIME" Type="Date" />
                                        <ext:ModelField Name="END_TIME" Type="Date" />
                                        <ext:ModelField Name="SHIFT_NAME" />
                                        <ext:ModelField Name="CLASS_NAME" />
                                        <ext:ModelField Name="USER_NAME" />
                                        <ext:ModelField Name="GRADENAME" />
                                        <ext:ModelField Name="EQUIP_ID" />
                                    <%--    <ext:ModelField Name="DEGRADE_ID" />--%>
                                        <ext:ModelField Name="WORKER_ID" />
                                        <ext:ModelField Name="GRADE_NAME" />
                                        <ext:ModelField Name="DEFECTNAME" />
                                    </Fields>
                                </ext:Model>
                            </Model>
                        </ext:Store>
                    </Store>
                    <ColumnModel ID="colModel" runat="server">
                        <Columns>
                            <ext:Column ID="TYRE_NO" runat="server" Text="胎号" DataIndex="TYRE_NO" Width="100" />
                            <ext:Column ID="GREEN_TYRE_NO" runat="server" Text="胎胚号" DataIndex="GREEN_TYRE_NO" Width="100" />
                            <ext:Column ID="MATERIAL_NAME" runat="server" Text="物料规格" DataIndex="MATERIAL_NAME" Flex="1" />
                            <ext:Column ID="EQUIP_NAME" runat="server" Text="机台" DataIndex="EQUIP_NAME" Width="50" />
                            <ext:Column ID="EQUIP_POSITON" runat="server" Text="左右模" DataIndex="EQUIP_POSITON" Width="50" />
                            <ext:Column ID="BLADDER_USER_AMOUNT" runat="server" Text="胶囊使用次数" DataIndex="BLADDER_USER_AMOUNT" Width="80" />
                            <ext:DateColumn ID="SHIFT_DATE" runat="server" Text="接班日期" DataIndex="SHIFT_DATE" Width="100" Format="yyyy-MM-dd" />
                            <ext:DateColumn ID="BEGIN_TIME" runat="server" Text="硫化开始时间" DataIndex="BEGIN_TIME" Width="100" Format="yyyy-MM-dd HH:mm:ss" />
                            <ext:DateColumn ID="END_TIME" runat="server" Text="硫化结束时间" DataIndex="END_TIME" Width="100" Format="yyyy-MM-dd HH:mm:ss" />
                            <%--     <ext:Column ID="SHIFT_NAME" runat="server" Text="班次" DataIndex="SHIFT_NAME" Width="60" />
                                <ext:Column ID="CLASS_NAME" runat="server" Text="班组" DataIndex="CLASS_NAME" Width="60" />--%>
                            <ext:Column ID="USER_NAME" runat="server" Text="硫化工" DataIndex="USER_NAME" Width="80" />
                            <ext:Column ID="GRADENAME" runat="server" Text="品级" DataIndex="GRADENAME" Width="80" />
                            <ext:Column ID="DEFECTNAME" runat="server" Text="外观病疵" DataIndex="DEFECTNAME" Width="150" />
                            <ext:CommandColumn ID="commandCol" runat="server" Width="60" Text="操作" Align="Center">
                                <Commands>
                                    <ext:GridCommand Icon="TableEdit" CommandName="Edit" Text="降级">
                                        <ToolTip Text="降级" />
                                    </ext:GridCommand>
                                    <%--         <ext:GridCommand Icon="IpodNanoConnect" CommandName="Search" Text="查看曲线">
                                        <ToolTip Text="查看曲线" />
                                    </ext:GridCommand>--%>
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
                <ext:Window ID="winModify" runat="server" Icon="MonitorEdit" Closable="false" Title="降级"
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
                                        <ext:TextField ID="modify_green_tyre_no" runat="server" FieldLabel="成型号" LabelAlign="Left"
                                            ReadOnly="true" Enabled="true" />
                                        <%--   <ext:TextField ID="modify_txtDegradeId" runat="server" FieldLabel="改判前品级" LabelAlign="Left"
                                            ReadOnly="true" Enabled="true" Hidden="true"/>--%>
                                        <ext:Container runat="server" Layout="FormLayout">
                                            <Items>
                                                <ext:ComboBox runat="server" ID="cboModifyDegradeId" LabelAlign="Left" FieldLabel="品级"
                                                    QueryMode="Local" ForceSelection="true">
                                                    <DirectEvents>
                                                        <Change OnEvent="cbxChange_Event"></Change>
                                                    </DirectEvents>
                                                </ext:ComboBox>
                                                <ext:ComboBox runat="server" ID="cbxChangeReason" LabelAlign="Left" FieldLabel="病疵"
                                                    QueryMode="Local" ForceSelection="true" Editable="FALSE">
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
                                <Click OnEvent="BtnModifySave_Click" Timeout="300000">
                                    <EventMask ShowMask="true" Msg="正在降级..." >
                                       
                                    </EventMask>
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
                <ext:Hidden runat="server" ID="hiddenEquip"></ext:Hidden>
                  <ext:Hidden runat="server" ID="hiddenTyreNo"></ext:Hidden>
                  <ext:Hidden runat="server" ID="hiddenUser"></ext:Hidden>
                <%--           <ext:Window ID="winSearch" runat="server" Icon="MonitorEdit" Closable="true" Title="查看曲线"
                    Width="800" Height="520" Resizable="false" Hidden="true" Modal="false" BodyStyle="background-color:#fff;"
                    BodyPadding="5" Layout="FitLayout">
                    <Items>
                        <ext:Panel runat="server" Region="Center" AutoScroll="true" ID="CuringChart">
                        </ext:Panel>
                    </Items>
                </ext:Window>--%>
            </Items>
        </ext:Viewport>
    </form>
</body>
</html>
