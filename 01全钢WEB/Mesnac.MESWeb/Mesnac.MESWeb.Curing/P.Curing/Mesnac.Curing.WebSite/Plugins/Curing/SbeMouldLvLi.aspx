<%@ Page Language="C#" AutoEventWireup="true" CodeFile="SbeMouldLvLi.aspx.cs" Inherits="Plugins_Curing_SbeMouldLvLi" %>

<%@ Register Assembly="Ext.Net" Namespace="Ext.Net" TagPrefix="ext" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>模具使用记录</title>
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

        //区分删除操作，并进行二次确认操作
        var commandcolumn_click_confirm = function (command, record) {
            if (command.toLowerCase() == "edit") {
                commandcolumn_direct_edit(record);
            }
            return false;
        };

        //根据按钮类别进行删除和编辑操作
        var commandcolumn_click = function (command, record) {
            commandcolumn_click_confirm(command, record);
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
        var SetRowClass = function (record, rowIndex, rowParams, store) {
            var date = new Date();
            var date1 = formatDate(date);
            var date2 = formatDate(record.get("CLEAR_TIME"));
            var rowClass = '';
            if (record.get("OUT_FLAG") == "出库" && record.get("TOTAL_DAY") >= "365" && record.get("CLEAR_TIME") <= record.get("OUT_TIME")) {
                rowClass = 'x-grid-row-collapsedYellow';
            }
            if (record.get("OUT_FLAG") == "在库" && record.get("TOTAL_DAY") >= "183" && record.get("CLEAR_TIME") <= record.get("IN_TIME")) {
                rowClass = 'x-grid-row-collapsedYellow';
            }
            if (record.get("TOTAL_NUM") >= "20000" && DateDiff(date1, date2) > 30) {
                rowClass = 'x-grid-row-collapsedYellow';
            }
            return rowClass;
        }
        function formatDate(date) {
            var d = new Date(date),
              month = '' + (d.getMonth() + 1),
              day = '' + d.getDate(),
              year = d.getFullYear();

            if (month.length < 2) month = '0' + month;
            if (day.length < 2) day = '0' + day;

            return [year, month, day].join('-');
        }
        function DateDiff(sDate1, sDate2) {    //sDate1和sDate2是2002-12-18格式 
            var aDate, oDate1, oDate2, iDays
            aDate = sDate1.split("-")
            oDate1 = new Date(aDate[1] + '-' + aDate[2] + '-' + aDate[0])    //转换为12-18-2002格式 
            aDate = sDate2.split("-")
            oDate2 = new Date(aDate[1] + '-' + aDate[2] + '-' + aDate[0])
            iDays = parseInt(Math.abs(oDate1 - oDate2) / 1000 / 60 / 60 / 24)    //把相差的毫秒数转换为天数 
            return iDays
        }
    </script>
    
    <style type="text/css">
        .x-grid-row-collapsedYellow .x-grid-cell {
            background-color: #ffd800 !important;
        }

        .x-grid-row-collapsedRed .x-grid-cell {
            background-color: #ff0000 !important;
        }
    </style>
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
                                <ext:ToolbarSeparator ID="ct3" />
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
                                        <ext:FieldContainer runat="server" FieldLabel="出库开始时间" Layout="HBoxLayout" LabelAlign="Right">
                                            <Items>
                                                <ext:DateField ID="txtBeginDate" runat="server" Flex="1" Editable="false" />
                                                <ext:TimeField ID="txtBeginTime" runat="server" Width="80" Editable="true" />
                                            </Items>
                                        </ext:FieldContainer>
                                        <ext:FieldContainer runat="server" FieldLabel="出库结束时间" Layout="HBoxLayout" LabelAlign="Right">
                                            <Items>
                                                <ext:DateField ID="txtEndDate" runat="server" Flex="1" Editable="false" />
                                                <ext:TimeField ID="txtEndTime" runat="server" Width="80" Editable="true" />
                                            </Items>
                                        </ext:FieldContainer>
                                        </Items>
                                </ext:Container>
                                <ext:Container ID="container2" runat="server" Layout="FormLayout" ColumnWidth=".25"
                                    Padding="5">
                                    <Items>
                                        <ext:TextField ID="txtname" runat="server" FieldLabel="模具名称" LabelAlign="Right" Editable="true" >
                                        </ext:TextField>
                                        <ext:TextField ID="txtcode" runat="server" FieldLabel="模具编号" LabelAlign="Right" Editable="true" >
                                        </ext:TextField>
                                    </Items>
                                </ext:Container>
                                <ext:Container ID="container3" runat="server" Layout="FormLayout" ColumnWidth=".25"
                                    Padding="5">
                                    <Items>
                                        <ext:TextField ID="txtsize" runat="server" FieldLabel="规格" LabelAlign="Right" Editable="true" >
                                        </ext:TextField>
                                        <ext:TextField ID="txthuawen" runat="server" FieldLabel="花纹" LabelAlign="Right" Editable="true" >
                                        </ext:TextField>
                                    </Items>
                                </ext:Container>
                                <ext:Container ID="container4" runat="server" Layout="FormLayout" ColumnWidth=".25"
                                    Padding="5">
                                    <Items>
                                        <ext:TextField ID="txttotalnum" runat="server" FieldLabel="累计次数" LabelAlign="Right" Editable="true" EmptyText="累计次数>=该值">
                                        </ext:TextField>
                                    </Items>
                                </ext:Container>
                            </Items>
                            <Listeners>
                                <ValidityChange Handler="#{btnSearch}.setDisabled(!valid);" />
                            </Listeners>
                        </ext:FormPanel>
                    </Items>
                </ext:Panel>

                <ext:Panel ID="Panel2" runat="server" Region="Center" Frame="true" Layout="Fit" MarginsSummary="0 5 0 5" Title="">
                    <Items>
                        <ext:GridPanel ID="pnlList" runat="server">
                            <Store>
                                <ext:Store ID="store" runat="server" PageSize="100">
                                    <Proxy>
                                        <ext:PageProxy DirectFn="App.direct.GridPanelBindData" />
                                    </Proxy>
                                    <Model>
                                        <ext:Model ID="model" runat="server" IDProperty="OBJID">                                            
                                            <Fields>                                                
                                                <ext:ModelField Name="OBJID" />
                                                <ext:ModelField Name="MOULD_CODE" />
                                                <ext:ModelField Name="MOULD_NAME" />
                                                <ext:ModelField Name="SIZE_NAME" />
                                                <ext:ModelField Name="PATTERN_NAME" />
                                                <ext:ModelField Name="EQUIP_NAME" />
                                                <ext:ModelField Name="SUB_STORE_PLACE_NAME" />
                                                <ext:ModelField Name="OUT_TIME" />
                                                <ext:ModelField Name="OUT_USER" />
                                                <ext:ModelField Name="OUT_FLAG" />
                                                <ext:ModelField Name="IN_TIME" />
                                                <ext:ModelField Name="IN_USER" />
                                                <ext:ModelField Name="USE_NUM" />
                                                <ext:ModelField Name="TOTAL_NUM" />
                                                <ext:ModelField Name="TOTAL_DAY" />
                                                <ext:ModelField Name="CLEAR_TIME" />
                                            </Fields>
                                        </ext:Model>
                                    </Model>
                                </ext:Store>
                            </Store>
                            <ColumnModel ID="colModel" runat="server">                              
                                <Columns>
                                    <ext:RowNumbererColumn ID="rowNumCol" runat="server" Width="35" />
                                    <%--<ext:Column ID="OBJID" runat="server" Text="编号" DataIndex="OBJID" Width="100" Hidden="TRUE" />--%>
                                    <ext:Column ID="BLADDER_CODE" runat="server" Text="模具编号" Selectable="true" DataIndex="MOULD_CODE" Width="90" />
                                    <ext:Column ID="BUY_TYPE_NAME" runat="server" Text="模具名称" Selectable="true" DataIndex="MOULD_NAME" Width="80" />
                                    <ext:Column ID="TYPE_NEW_NAME" runat="server" Text="规格" DataIndex="SIZE_NAME" Width="80" />
                                    <ext:Column ID="SPEC_NAME" runat="server" Text="花纹" DataIndex="PATTERN_NAME" Width="80" />
                                    <ext:Column ID="BLADDER_SPEC" runat="server" Text="机台" DataIndex="EQUIP_NAME" Width="80" />
                                    <ext:Column ID="BLADDER_BATCH" runat="server" Text="子库位" DataIndex="SUB_STORE_PLACE_NAME" Width="80"  />
                                    <ext:DateColumn ID="DUMMY1" runat="server" Text="出库时间" DataIndex="OUT_TIME" Width="150"   Format="yyyy-MM-dd HH:mm:ss" />
                                    <ext:Column ID="DUMMY5" runat="server" Text="出库人" DataIndex="OUT_USER" Width="70"  />
                                    <ext:Column ID="OUT_FLAG" runat="server" Text="状态" DataIndex="OUT_FLAG" Width="50"  />
                                    <ext:DateColumn ID="FACTORY_NAME" runat="server" Text="入库时间" DataIndex="IN_TIME" Width="150"  Format="yyyy-MM-dd HH:mm:ss"  />
                                    <ext:Column ID="RECORD_USER_NAME" runat="server" Text="入库人" DataIndex="IN_USER" Width="70" />
                                    <ext:Column ID="RECORD_DATE" runat="server" Text="使用次数" DataIndex="USE_NUM" Width="80"/>
                                    <ext:Column ID="REMARK" runat="server" Text="累计次数" DataIndex="TOTAL_NUM" Width="80" />
                                    <ext:Column ID="Column1" runat="server" Text="（出）入库天数" DataIndex="TOTAL_DAY" Width="100" />
                                    <ext:CommandColumn ID="commandCol" runat="server" Width="70" Text="操作" Align="Center">
                                        <Commands>
                                            <ext:GridCommand Icon="TableEdit" CommandName="Edit" Text="修改">
                                                <ToolTip Text="修改本条数据" />
                                            </ext:GridCommand>
                                            <ext:CommandSeparator />
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
                            <View>
                                <ext:GridView ID="gvRows" runat="server">
                                    <GetRowClass Fn="SetRowClass" />
                                </ext:GridView>
                            </View>
                        </ext:GridPanel>
                    </Items>
                </ext:Panel>
            </Items>
        </ext:Viewport>
        <ext:Window ID="ModifyConfigWin" runat="server" Closable="false" Icon="Add" Title="修改信息"
            Width="200" Height="200" Hidden="true" Modal="false">
            <Items>
                <ext:FormPanel ID="FormPanel1" runat="server" BodyPadding="5">
                    <FieldDefaults>
                        <CustomConfig>
                            <ext:ConfigItem Name="LabelWidth" Value="80" Mode="Raw" />
                            <ext:ConfigItem Name="PreserveIndicatorIcon" Value="true" Mode="Raw" />
                        </CustomConfig>
                    </FieldDefaults>
                    <Items>
                        <ext:Container ID="Container14" runat="server" AutoHeight="true">
                            <Items>
                                <ext:FieldSet ID="FieldSet4" runat="server" Title="" Layout="AnchorLayout" DefaultAnchor="100%"
                                    Padding="5">
                                    <Items>
                                        <ext:Container ID="Container12" runat="server" Layout="HBoxLayout" MarginSpec="5 5 5 5">
                                            <Items>
                                        <ext:TextField ID="txtcishu" runat="server" FieldLabel="累计次数" LabelAlign="Right" Editable="true" >
                                        </ext:TextField>
                                            </Items>
                                        </ext:Container>
                                    </Items>
                                </ext:FieldSet>
                            </Items>
                        </ext:Container>
                    </Items>
                    <Listeners>
                        <ValidityChange Handler="#{btnModifySave}.setDisabled(!valid);" />
                    </Listeners>
                </ext:FormPanel>
            </Items>
            <Buttons>
                <ext:Button ID="btnModifySave" runat="server" Text="确定" Icon="Accept" Disabled="true">
                    <DirectEvents>
                        <Click OnEvent="BtnModifySave_Click">
                            <EventMask ShowMask="true" Msg="Saving..." MinDelay="50" />
                        </Click>
                    </DirectEvents>
                </ext:Button>
                <ext:Button ID="btnModifyCancel" runat="server" Text="取消" Icon="Cancel">
                    <DirectEvents>
                        <Click OnEvent="BtnModifyCancel_Click">
                        </Click>
                    </DirectEvents>
                </ext:Button>
            </Buttons>
            <Listeners>
                <Show Handler="for(var i=0;i<#{Viewport1}.items.length;i++){#{Viewport1}.getComponent(i).disable(true);}" />
                <Hide Handler="for(var i=0;i<#{Viewport1}.items.length;i++){#{Viewport1}.getComponent(i).enable(true);}" />
            </Listeners>
        </ext:Window>
    </form>
</body>
</html>
