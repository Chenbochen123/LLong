<%@ Page Language="C#" AutoEventWireup="true" CodeFile="HppBadRecord.aspx.cs" Inherits="Plugins_Semis_HppBadRecord" %>

<%@ Register Assembly="Ext.Net" Namespace="Ext.Net" TagPrefix="ext" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <script type="text/javascript" src="<%= Page.ResolveUrl("~/") %>resources/js/jquery-1.7.1.js"></script>
    <link rel="Stylesheet" type="text/css" href="<%= Page.ResolveUrl("~/") %>resources/css/ext-chinese-font.css" />
    <link rel="Stylesheet" type="text/css" href="<%= Page.ResolveUrl("~/") %>resources/css/main.css" />
    <script type="text/javascript">
        var thisDirUrl = "<%= Page.ResolveUrl("./") %>";
        var thisRootUrl = "<%= Page.ResolveUrl("~/") %>";
    </script>
    <script type="text/javascript">

        //刷新页面
        var pnlListFresh = function () {
            if (App.txtBeginDate.getValue() > App.txtEndDate.getValue()) {
                Ext.Msg.alert('操作', '开始时间不能大于结束时间！');
                return false;
            }
            App.store.currentPage = 1;
            App.pageToolBar.doRefresh();
            return false;
        }
        var commandcolumn_click = function (command, record) {
            commandcolumn_click_confirm(command, record);
            return false;
        };


        //区分删除操作，并进行二次确认操作
        var commandcolumn_click_confirm = function (command, record) {
            if (command.toLowerCase() == "confirm") {

                Ext.Msg.confirm("提示", '您确定要确认此条码吗？', function (btn) { commandcolumn_direct_confirm(btn, record) });
            }
            return false;
        };
        var commandcolumn_direct_confirm = function (btn, record) {
            if (btn != "yes") {
                return;
            }
            //确认按钮调用后台事件
            var Barcode = record.data.BARCODE;
            var Grade = record.data.CL_GRADE;
            App.direct.commandcolumn_direct_confirm(Barcode, Grade, {
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
        <ext:ResourceManager ID="rmMoldingStorage" runat="server" />
        <ext:Viewport ID="vpMoldingStorage" runat="server" Layout="border">
            <Items>
                <ext:Panel ID="pnMoldingStorage" runat="server" Region="North" Height="90">
                    <TopBar>
                        <ext:Toolbar runat="server" ID="tbMoldingStorage">
                            <Items>
                                <ext:Button runat="server" Icon="Find" Text="查询" ID="btnSearch">
                                     <Listeners>
                                       <Click Fn="pnlListFresh">
                                       </Click>
                                    </Listeners>
                                </ext:Button>
                                <ext:ToolbarSeparator ID="ToolbarSeparator1" />
                                <ext:Button runat="server" Icon="PageExcel" Text="导出Excel" ID="btnExport" >
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

                        <ext:FormPanel ID="container_top" runat="server" Layout="ColumnLayout" AutoHeight="true">
                            <Items>
                                <ext:Container ID="container1" runat="server" Layout="FormLayout" ColumnWidth=".3"
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
                                <ext:Container ID="container3" runat="server" Layout="FormLayout" ColumnWidth=".3"
                                    Padding="5">
                                    <Items>
                                        <ext:TextField ID="txtMaterName" runat="server" FieldLabel="规格" LabelAlign="Right" Editable="false"></ext:TextField>
                                        <ext:TextField ID="txtCardNo" runat="server" FieldLabel="条码" LabelAlign="Right" Editable="false"></ext:TextField>
                                    </Items>
                                </ext:Container>
                                <ext:Container ID="container2" runat="server" Layout="FormLayout" ColumnWidth=".3"
                                    Padding="5">
                                    <Items>
                                        <ext:TextField ID="txtGrade" runat="server" FieldLabel="处理品级" LabelAlign="Right" Editable="false"></ext:TextField>
                                    </Items>
                                </ext:Container>
                            </Items>
                            <Listeners>
                                <ValidityChange Handler="#{btnSearch}.setDisabled(!valid);" />
                            </Listeners>
                        </ext:FormPanel>
                    </Items>
                </ext:Panel>
                <ext:Panel ID="pnlDetail" runat="server"  Title="不合格处理记录" Height="500" Region="Center" Frame="true" Layout="Fit"  MarginsSummary="0 5 5 5">
                    <Items>
                        <ext:GridPanel ID="pnlList" runat="server" MarginsSummary="0 5 5 5">
                           
                            <Store>
                                <ext:Store ID="store" runat="server" PageSize="15" >
                                <Proxy>
                                    <ext:PageProxy DirectFn="App.direct.GridPanelBindData" />
                                </Proxy>
                                    <Model>
                                        <ext:Model ID="model" runat="server" IDProperty="OBJID">
                                            <Fields>
                                                <ext:ModelField Name="OBJID" />
                                                <ext:ModelField Name="BARCODE" />
                                                <ext:ModelField Name="RETURN_TIME" />
                                                <ext:ModelField Name="RETURN_USERID" />
                                                <ext:ModelField Name="CHECK_TIME" />
                                                <ext:ModelField Name="CHECK_USERID" />
                                                <ext:ModelField Name="PD_TIME" />
                                                <ext:ModelField Name="PD_USERID" />
                                                <ext:ModelField Name="CL_TIME" />
                                                <ext:ModelField Name="CL_USERID" />
                                                <ext:ModelField Name="CL_GRADE" />
                                                <ext:ModelField Name="CL_DEFECT" />
                                                <ext:ModelField Name="CL_REASON" />
                                                <ext:ModelField Name="CONFIRM_TIME" />
                                                <ext:ModelField Name="CONFIRM_USERID" />
                                                <ext:ModelField Name="FINALQR_TIME" />
                                                <ext:ModelField Name="FINALQR_USERID" />
                                                <ext:ModelField Name="RECORD_TIME" />
                                                <ext:ModelField Name="DUMMY1" />
                                                <ext:ModelField Name="DUMMY2" />
                                                <ext:ModelField Name="CL_NUM" />
                                                <ext:ModelField Name="XRXC" />
                                                <ext:ModelField Name="XRXCUSERID" />
                                                <ext:ModelField Name="XRXCRECORD_TIME" />
                                                <ext:ModelField Name="RETURN_USERNAME" />
                                                <ext:ModelField Name="CHECK_USERNAME" />
                                                <ext:ModelField Name="PD_USERNAME" />
                                                <ext:ModelField Name="CL_USERNAME" />
                                                <ext:ModelField Name="CONFIRM_USERNAME" />
                                                <ext:ModelField Name="FINALQR_USERNAME" />
                                                <ext:ModelField Name="XRXCUSERNAME" />
                                                <ext:ModelField Name="END_TIME" />
                                                <ext:ModelField Name="MATERIAL_NAME" />
                                                <ext:ModelField Name="STORE_PLACE_NAME" />
                                                <ext:ModelField Name="XRXCNAME" />
                                            </Fields>
                                        </ext:Model>
                                    </Model>
                     
                                </ext:Store>
                            </Store>
                            <ColumnModel ID="ColumnModelDetail" runat="server">
                                <Columns>
                                    <ext:RowNumbererColumn ID="rowNumCol1" runat="server" Width="35" />
                                    <ext:Column ID="OBJID" runat="server" Hidden="true" Text="编号" DataIndex="OBJID" />
                                    <ext:Column ID="BARCODE" runat="server" Text="条码" DataIndex="BARCODE" Width="150" />
                                    <ext:Column ID="MATERIAL_NAME" runat="server" Text="规格" DataIndex="MATERIAL_NAME" Width="150" />
                                    <ext:Column ID="Column2" runat="server" Text="当前库位" DataIndex="STORE_PLACE_NAME" Width="120" />
                                    <ext:DateColumn ID="END_TIME" runat="server" Text="生产时间" DataIndex="END_TIME" Width="150" Format="yyyy-MM-dd HH:mm:ss" />
                                    <ext:DateColumn ID="RETURN_TIME" runat="server" Text="退库时间" DataIndex="RETURN_TIME" Width="150" Format="yyyy-MM-dd HH:mm:ss" />
                                    <ext:Column ID="RETURN_USERNAME" runat="server" Text="退库人" DataIndex="RETURN_USERNAME" Width="80" />
                                    <ext:DateColumn ID="CHECK_TIME" runat="server" Text="质检时间" DataIndex="CHECK_TIME" Width="150" Format="yyyy-MM-dd HH:mm:ss" />
                                    <ext:Column ID="CHECK_USERNAME" runat="server" Text="质检人" DataIndex="CHECK_USERNAME" Width="80" />
                                    <ext:DateColumn ID="PD_TIME" runat="server" Text="盘点时间" DataIndex="PD_TIME" Width="150" Format="yyyy-MM-dd HH:mm:ss" />
                                    <ext:Column ID="PD_USERNAME" runat="server" Text="盘点人" DataIndex="PD_USERNAME" Width="80" />
                                    <ext:DateColumn ID="CL_TIME" runat="server" Text="处理时间" DataIndex="CL_TIME" Width="150" Format="yyyy-MM-dd HH:mm:ss" />
                                    <ext:Column ID="CL_USERNAME" runat="server" Text="处理人" DataIndex="CL_USERNAME" Width="80" />
                                    <ext:Column ID="CL_GRADE" runat="server" Text="等级" DataIndex="CL_GRADE" Width="80" />
                                    <ext:Column ID="CL_DEFECT" runat="server" Text="病疵" DataIndex="CL_DEFECT" Width="80" />
                                    <ext:Column ID="CL_REASON" runat="server" Text="不合格原因" DataIndex="CL_REASON" Width="300" />
                                    <ext:DateColumn ID="CONFIRM_TIME" runat="server" Text="确认时间" DataIndex="CONFIRM_TIME" Width="150" Format="yyyy-MM-dd HH:mm:ss" />
                                    <ext:Column ID="CONFIRM_USERNAME" runat="server" Text="确认人" DataIndex="CONFIRM_USERNAME" Width="80" />
                                    <ext:DateColumn ID="FINALQR_TIME" runat="server" Text="最终确认时间" DataIndex="FINALQR_TIME" Width="150" Format="yyyy-MM-dd HH:mm:ss" />
                                    <ext:Column ID="FINALQR_USERNAME" runat="server" Text="最终确认人" DataIndex="FINALQR_USERNAME" Width="80" />
                                    <ext:Column ID="CL_NUM" runat="server" Text="不合格数量" DataIndex="CL_NUM" Width="80" />
                                    <ext:Column ID="Column1" runat="server" Text="处理先入先出" DataIndex="XRXCNAME" Width="80" />
                                    <ext:Column ID="XRXCUSERNAME" runat="server" Text="处理先入先出操作人" DataIndex="XRXCUSERNAME" Width="80" />
                                    <ext:DateColumn ID="XRXCRECORD_TIME" runat="server" Text="处理先入先出操作时间" DataIndex="XRXCRECORD_TIME" Width="150" Format="yyyy-MM-dd HH:mm:ss" />

                                    <ext:CommandColumn runat="server" Width="60" Text="操作" Align="Center">
                                        <Commands>
                                            <ext:GridCommand Icon="TableEdit" CommandName="Confirm" Text="确认">
                                                <ToolTip Text="确认本条数据" />
                                            </ext:GridCommand>
                                        </Commands>
                                        <Listeners>
                                            <Command Handler="return commandcolumn_click (command, record);" />
                                        </Listeners>
                            </ext:CommandColumn>
                                </Columns>
                            </ColumnModel>   
                    <View>
                    </View>
                    <BottomBar>
                        <ext:PagingToolbar ID="pageToolBar" runat="server">
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

