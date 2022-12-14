<%@ Page Language="C#" AutoEventWireup="true" CodeFile="SbeMouldDrum.aspx.cs" Inherits="Plugins_Molding_SbeMouldDrum" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>成型鼓信息维护</title>
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
            App.pnlList.store.reload();
            return false;
        }

        var commandcolumn_click = function (command, record) {
            commandcolumn_click_confirm(command, record);
            return false;
        };

        //区分删除操作，并进行二次确认操作
        var commandcolumn_click_confirm = function (command, record) {
            if (command.toLowerCase() == "edit") {
                commandcolumn_direct_editdefect(record);
            }
            if (command.toLowerCase() == "delete") {
                Ext.Msg.confirm("提示", '您确定要删除此条信息吗？', function (btn) { commandcolumn_direct_deletedefect(btn, record) });
            }
            if (command.toLowerCase() == "addremark"){
                commandcolumn_direct_addremark(record);
            }
            return false;
        };

        var prepareToolbar = function (grid, toolbar, rowIndex, record) {

        }
        var commandcolumn_direct_addremark = function (record) {
            QuerySAPCode_Window_Create(record);
            App.QuerySAPCode_Window.show();
        }
        var QuerySAPCode_Request = function (record) {//返回值处理
            
        }
        var Close = function () {
            App.QuerySAPCode_Window.close();
        }
        var QuerySAPCode_Window_Create = function (record) {
            var ObjID = record.data.OBJID;
            var EQUIP_NAME = record.data.EQUIP_NAME;
            var BARCODE = record.data.BARCODE;
            Ext.create("Ext.window.Window", {
                id: "QuerySAPCode_Window",
                height: 600,
                hidden: true,
                width: 800,
                html: "<iframe src='SBEMOULDDRUMQUERYSAPCODE.ASPX?ObjID=" + ObjID + "' width=100% style='height:100%' scrolling=no  frameborder=0></iframe>",
                bodyStyle: "background-color: #fff;",
                closable: true,
                title: EQUIP_NAME + BARCODE+"不允许规格维护",
                modal: true
            })
        }
        var commandcolumn_direct_editdefect = function (record) {
            var ObjID = record.data.OBJID;
            App.direct.commandcolumn_direct_editdefect(ObjID, {
                success: function (result) {
                },

                failure: function (errorMsg) {
                    Ext.Msg.alert('操作', errorMsg);
                }
            });
        }

        //点击删除按钮
        var commandcolumn_direct_deletedefect = function (btn, record) {
            if (btn != "yes") {
                return;
            }
            var id = record.data.OBJID;
            App.direct.commandcolumn_direct_deletedefect(id, {
                success: function (result) {
                    Ext.Msg.alert('操作', result);
                },

                failure: function (errorMsg) {
                    Ext.Msg.alert('操作', errorMsg);
                }
            });
            this.pnlListFresh();
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
                            <ext:ToolbarSeparator ID="tsBegin" />
                            <ext:Button runat="server" Icon="Add" Text="添加" ID="btnAdd">
                                <DirectEvents>
                                    <Click OnEvent="btnAdd_Click">
                                    </Click>
                                </DirectEvents>
                            </ext:Button>
                            <ext:ToolbarSeparator ID="tsEnd" />
                                <ext:Button runat="server" Icon="PageExcel" Text="导出Excel" ID="btnExport">
                                    <ToolTips>
                                        <ext:ToolTip ID="ToolTip2" runat="server" Html="点击将查询结果导出到Excel中" />
                                    </ToolTips>
                                    <Listeners>
                                        <Click Handler="$('#btnExportSubmit').click();">
                                        </Click>
                                    </Listeners>
                                </ext:Button>
                            <ext:ToolbarSpacer runat="server" ID="tspacerEnd" />
                            <ext:ToolbarFill ID="tfEnd" />
                        </Items>
                    </ext:Toolbar>
                </TopBar>
                <Items>
                    <ext:FormPanel ID="container_top" runat="server" Layout="ColumnLayout" AutoHeight="true"
                        Collapsible="false">
                        <Items>
                             <ext:Container ID="container2" runat="server" Layout="FormLayout" ColumnWidth=".33"
                                Padding="5">
                                <Items>
                                      <ext:TextField ID="txtbarcode" runat="server" FieldLabel="成型鼓编号"  
                                        LabelAlign="Right" />
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
                                            <ext:ModelField Name="BARCODE" />
                                            <ext:ModelField Name="EQUIP_NAME" />
                                            <ext:ModelField Name="USE" />
                                            <ext:ModelField Name="SIZE_1" />
                                            <ext:ModelField Name="AMOUNT" />
                                            <ext:ModelField Name="FACTORY" />
                                            <ext:ModelField Name="IN_TIME" />
                                            <ext:ModelField Name="EQUIP_USE" />
                                            <ext:ModelField Name="STATUS" />
                                            <ext:ModelField Name="STORE_PLACE" />
                                            <ext:ModelField Name="REASON" />
                                            <ext:ModelField Name="REMARK2" />
                                            <ext:ModelField Name="REMARK3" />
                                            <ext:ModelField Name="REMARK4" />
                                            <ext:ModelField Name="REMARK5" />
                                        </Fields>
                                    </ext:Model>
                                </Model>
                            </ext:Store>
                        </Store>
                        <ColumnModel ID="colModel" runat="server">
                            <Columns>
                                <ext:RowNumbererColumn ID="rowNumCol1" runat="server" Width="35" />
                                 <ext:Column ID="DefectCode" runat="server" Text="设备编号" DataIndex="BARCODE" Flex="1"/>
                                 <ext:Column ID="Column1" runat="server" Text="设备名称" DataIndex="EQUIP_NAME" Flex="1"/>
                                 <ext:Column ID="Column2" runat="server" Text="用途" DataIndex="USE" Flex="1"/>
                                 <ext:Column ID="Column3" runat="server" Text="规格尺寸" DataIndex="SIZE_1" Flex="1"/>
                                 <ext:Column ID="Column4" runat="server" Text="数量" DataIndex="AMOUNT" Flex="1"/>
                                 <ext:Column ID="Column10" runat="server" Text="生产厂家" DataIndex="FACTORY" Flex="1"/>
                                 <ext:DateColumn ID="Column5" runat="server" Text="入厂时间" DataIndex="IN_TIME" Flex="1" Format="yyyy-MM-dd"/>
                                 <ext:Column ID="Column6" runat="server" Text="适用机台/用途" DataIndex="EQUIP_USE" Flex="1"/>
                                 <ext:Column ID="Column7" runat="server" Text="当前状态" DataIndex="STATUS" Flex="1"/>
                                 <ext:Column ID="Column8" runat="server" Text="存放状态" DataIndex="STORE_PLACE" Flex="1"/>
                                 <ext:Column ID="Column9" runat="server" Text="备注" DataIndex="REASON" Flex="1"/>
                                 <ext:Column ID="Column11" runat="server" Text="备注2" DataIndex="REMARK2" Flex="1"/>
                                 <ext:Column ID="Column12" runat="server" Text="备注3" DataIndex="REMARK3" Flex="1"/>
                                 <ext:Column ID="Column13" runat="server" Text="备注4" DataIndex="REMARK4" Flex="1"/>
                                 <ext:Column ID="Column14" runat="server" Text="不允许规格" DataIndex="REMARK5" Flex="1"/>
                                <ext:CommandColumn ID="commandCol" runat="server" Width="240" Text="操作" Align="Center">
                                    <Commands>
                                        <ext:GridCommand Icon="TableEdit" CommandName="Edit" Text="修改" />
                                        <ext:CommandSeparator />
                                        <ext:GridCommand Icon="TableDelete" CommandName="Delete" Text="删除" />
                                        <ext:CommandSeparator />
                                        <ext:GridCommand Icon="TableEdit" CommandName="AddRemark" Text="维护不允许规格" />
                                    </Commands>
                                    <PrepareToolbar Fn="prepareToolbar" />
                                    <Listeners>
                                        <Command Handler="return commandcolumn_click(command, record);" />
                                    </Listeners>
                                    
                                </ext:CommandColumn>
                            </Columns>
                        </ColumnModel>
                    </ext:GridPanel>
                </Items>
            </ext:Panel>
              <ext:Window ID="winAddMouldDrum" runat="server" Icon="MonitorAdd" Closable="true" Title="添加成型鼓信息"
                Width="400" Height="500" Resizable="false" Hidden="true" Modal="false" BodyStyle="background-color:#fff;"
                BodyPadding="5" Layout="Form">
                <Items>
                    <ext:FormPanel ID="FormPanel1" runat="server" BodyPadding="5">
                        <FieldDefaults>
                            <CustomConfig>
                                <ext:ConfigItem Name="LabelWidth" Value="80" Mode="Raw" />
                                <ext:ConfigItem Name="PreserveIndicatorIcon" Value="true" Mode="Raw" />
                            </CustomConfig>
                        </FieldDefaults>
                        <Items>
                            <ext:Container ID="Container10" runat="server" Layout="ColumnLayout" AutoHeight="true">
                                <Items>
                                    <ext:Container ID="Container11" runat="server" Layout="FormLayout" ColumnWidth="1"
                                        Padding="5">
                                        <Items>
                                            <ext:TextField ID="txtbarcode1" runat="server" FieldLabel="设备编号"  
                                                LabelAlign="Right" AllowBlank="false">
                                            </ext:TextField>
                                            <ext:TextField ID="txtequipname1" runat="server" FieldLabel="设备名称"  
                                                LabelAlign="Right" AllowBlank="false"/>
                                            <ext:TextField ID="txtuse1" runat="server" FieldLabel="用途"  
                                                LabelAlign="Right"  AllowBlank="false"/>
                                            <ext:TextField ID="txtsize1" runat="server" FieldLabel="规格尺寸"  
                                                LabelAlign="Right" AllowBlank="false" />
                                            <ext:TextField ID="txtnum1" runat="server" FieldLabel="数量"  
                                                LabelAlign="Right"  AllowBlank="false" InputType="Number"/>
                                            <ext:TextField ID="txtfac1" runat="server" FieldLabel="生产厂家"  
                                                LabelAlign="Right" AllowBlank="false" />
                                            <ext:DateField ID="txtintime1" runat="server" FieldLabel="入厂时间"  
                                                LabelAlign="Right" Format="yyyy-MM-dd" InputType="Date"  AllowBlank="false"/>
                                            <ext:TextField ID="txtequipuse1" runat="server" FieldLabel="适用机型/用途"  
                                                LabelAlign="Right"  AllowBlank="false"/>
                                            <ext:TextField ID="txtstatus1" runat="server" FieldLabel="当前状态"  
                                                LabelAlign="Right"  AllowBlank="false"/>
                                            <ext:TextField ID="txtplace1" runat="server" FieldLabel="存放状态"  
                                                LabelAlign="Right" AllowBlank="false" />
                                            <ext:TextField ID="txtreason1" runat="server" FieldLabel="备注"  
                                                LabelAlign="Right" />
                                            <ext:TextField ID="txtremark2" runat="server" FieldLabel="备注2"  
                                                LabelAlign="Right" />
                                            <ext:TextField ID="txtremark3" runat="server" FieldLabel="备注3"  
                                                LabelAlign="Right" />
                                            <ext:TextField ID="txtremark4" runat="server" FieldLabel="备注4"  
                                                LabelAlign="Right" />
                                        </Items>
                                    </ext:Container>
                                </Items>
                            </ext:Container>
                        </Items>
                    </ext:FormPanel>
                </Items>
                <Buttons>
                    <ext:Button ID="btnAddMouldDrum" runat="server" Text="确定" Icon="Accept">
                        <DirectEvents>
                            <Click OnEvent="btnAddMouldDrum_Click">
                            </Click>
                        </DirectEvents>
                    </ext:Button>
                    <ext:Button ID="btnAddMouldDrumCancel" runat="server" Text="取消" Icon="Cancel">
                        <Listeners>
                            <Click Handler=" App.winAddMouldDrum.close(); return false;" />
                        </Listeners>
                    </ext:Button>
                </Buttons>
                <Listeners>
                    <Show Handler="for(var i=0;i<#{vwUnit}.items.length;i++){#{vwUnit}.getComponent(i).disable(true);}" />
                    <Hide Handler="for(var i=0;i<#{vwUnit}.items.length;i++){#{vwUnit}.getComponent(i).enable(true);}" />
                </Listeners>
            </ext:Window>
            <%--end 添加病疵信息--%>
            <%--修改病疵信息--%>
            <ext:Window ID="winModifyDefect" runat="server" Icon="MonitorEdit" Closable="false"
                Title="修改成型鼓信息" Width="320" Height="500" Resizable="false" Hidden="true" Modal="false"
                BodyStyle="background-color:#fff;" BodyPadding="5" Layout="Form">
                <Items>
                    <ext:FormPanel ID="pnlEdit" runat="server" Flex="1" BodyPadding="5">
                        <FieldDefaults>
                            <CustomConfig>
                                <ext:ConfigItem Name="LabelWidth" Value="80" Mode="Raw" />
                                <ext:ConfigItem Name="PreserveIndicatorIcon" Value="true" Mode="Raw" />
                            </CustomConfig>
                        </FieldDefaults>
                        <Items>
                            <ext:Container ID="Container5" runat="server" Layout="ColumnLayout" AutoHeight="true">
                                <Items>
                                    <ext:Container ID="Container6" runat="server" Layout="FormLayout" ColumnWidth="1"
                                        Padding="2">
                                        <Items>
                                            <ext:TextField ID="txtbarcode2" runat="server" FieldLabel="设备编号"  
                                                LabelAlign="Right" AllowBlank="false" Enabled="false" ReadOnly="true">
                                            </ext:TextField>
                                            <ext:TextField ID="txtequipname2" runat="server" FieldLabel="设备名称"  
                                                LabelAlign="Right" AllowBlank="false"/>
                                            <ext:TextField ID="txtuse2" runat="server" FieldLabel="用途"  
                                                LabelAlign="Right"  AllowBlank="false"/>
                                            <ext:TextField ID="txtsize2" runat="server" FieldLabel="规格尺寸"  
                                                LabelAlign="Right" AllowBlank="false" />
                                            <ext:TextField ID="txtnum2" runat="server" FieldLabel="数量"  
                                                LabelAlign="Right"  AllowBlank="false" InputType="Number"/>
                                            <ext:TextField ID="txtfac2" runat="server" FieldLabel="生产厂家"  
                                                LabelAlign="Right" AllowBlank="false" />
                                            <ext:DateField ID="txtintime2" runat="server" FieldLabel="入厂时间"  
                                                LabelAlign="Right" Format="yyyy-MM-dd" InputType="Date"  AllowBlank="false"/>
                                            <ext:TextField ID="txtequipuse2" runat="server" FieldLabel="适用机型/用途"  
                                                LabelAlign="Right"  AllowBlank="false"/>
                                            <ext:TextField ID="txtstatus2" runat="server" FieldLabel="当前状态"  
                                                LabelAlign="Right"  AllowBlank="false"/>
                                            <ext:TextField ID="txtplace2" runat="server" FieldLabel="存放状态"  
                                                LabelAlign="Right" AllowBlank="false" />
                                            <ext:TextField ID="txtreason2" runat="server" FieldLabel="备注"  
                                                LabelAlign="Right" />
                                            <ext:TextField ID="txtremark22" runat="server" FieldLabel="备注2"  
                                                LabelAlign="Right" />
                                            <ext:TextField ID="txtremark33" runat="server" FieldLabel="备注3"  
                                                LabelAlign="Right" />
                                            <ext:TextField ID="txtremark44" runat="server" FieldLabel="备注4"  
                                                LabelAlign="Right" />
                                        </Items>
                                    </ext:Container>
                                </Items>
                            </ext:Container>
                        </Items>
                    </ext:FormPanel>
                </Items>
                <Buttons>
                    <ext:Button ID="btnModifyDetailSave" runat="server" Text="确定" Icon="Accept">
                        <DirectEvents>
                            <Click OnEvent="btnModifyDefectSave_Click">
                            </Click>
                        </DirectEvents>
                    </ext:Button>
                    <ext:Button ID="btnModifyDetailCancel" runat="server" Text="取消" Icon="Cancel">
                        <Listeners>
                            <Click Handler=" App.winModifyDefect.close(); return false;" />
                        </Listeners>
                    </ext:Button>
                </Buttons>
                <Listeners>
                    <Show Handler="for(var i=0;i<#{vwUnit}.items.length;i++){#{vwUnit}.getComponent(i).disable(true);}" />
                    <Hide Handler="for(var i=0;i<#{vwUnit}.items.length;i++){#{vwUnit}.getComponent(i).enable(true);}" />
                </Listeners>
            </ext:Window>
                <ext:Hidden ID="hidden_objid" runat="server"></ext:Hidden>
            <%--end 修改机台信息--%>
        </Items>
    </ext:Viewport>
    </form>
</body>
</html>
