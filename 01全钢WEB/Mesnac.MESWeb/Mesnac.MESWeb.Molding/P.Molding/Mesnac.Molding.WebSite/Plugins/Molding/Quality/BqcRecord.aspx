<%@ Page Language="C#" AutoEventWireup="true" CodeFile="BqcRecord.aspx.cs" Inherits="Plugins_Molding_Quality_BqcRecord" %>

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
            else {
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
            if (record.get("GRADE_NAME") == "合格") {
                toolbar.items.getAt(0).hide();
            }
        };

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
            if (command.toLowerCase() == "delete") {
                Ext.Msg.confirm("提示", '您确定需要删除未下发的计划吗？', function (btn) { commandcolumn_direct_delete(btn, record) });
            }
            return false;
        };

        //点击修改按钮
        var commandcolumn_direct_edit = function (record) {
            debugger;
            if (record.data.GRADE_NAME == "合格") {
                Ext.Msg.alert('提示', "品级已是合格，无法修改！");
                return;
            }
            var TYREID = record.data.TYREID;
            var GRADE_NAME = record.data.GRADE_NAME;
            debugger;
            App.direct.commandcolumn_direct_edit(TYREID, GRADE_NAME,  {
                success: function (result) {
                    // Ext.Msg.alert('操作', result);
                    pnlListFresh();
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
        <ext:ResourceManager ID="rmQCRecord" runat="server" />
        <ext:Viewport ID="vpQCRecord" runat="server" Layout="border">
            <Items>
                <ext:Panel ID="pnMEquipControl" runat="server" Region="North" Height="120">
                    <TopBar>
                        <ext:Toolbar runat="server" ID="tbMEquipControl">
                            <Items>

                                <ext:Button runat="server" Icon="Find" Text="查询" ID="btnSearch">
                                    <Listeners>
                                        <Click Fn="pnlListFresh" />
                                    </Listeners>
                                </ext:Button>
                                <ext:Button runat="server" Icon="PageExcel" Text="导出Excel" ID="btnExport">
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
                                <ext:Container ID="container4" runat="server" Layout="FormLayout" ColumnWidth=".25"
                                    Padding="5">
                                    <Items>
                                        <ext:FieldContainer runat="server" FieldLabel="生产开始时间" Layout="HBoxLayout" LabelAlign="Right">
                                            <Items>
                                                <ext:DateField ID="txtBeginDate" runat="server" Flex="1" Editable="false" />
                                                <ext:TimeField ID="txtBeginTime" runat="server" Width="80" Editable="true" />
                                            </Items>
                                        </ext:FieldContainer>
                                        <ext:TextField ID="txtGreenTyreNo" runat="server" FieldLabel="胎胚号" Flex="1" LabelAlign="Right" Editable="false">
                                        </ext:TextField>                             
                                         <ext:ComboBox ID="change" runat="server" FieldLabel="检查类型" LabelAlign="Right" Editable="false">
                                         </ext:ComboBox>    
                                        </Items>
                                </ext:Container>
                                <ext:Container ID="container3" runat="server" Layout="FormLayout" ColumnWidth=".25"
                                    Padding="5">
                                    <Items>
                                        <ext:FieldContainer runat="server" FieldLabel="生产结束时间" Layout="HBoxLayout" LabelAlign="Right">
                                            <Items>
                                                <ext:DateField ID="txtEndDate" runat="server" Flex="1" Editable="false" />
                                                <ext:TimeField ID="txtEndTime" runat="server" Width="80" Editable="true" />
                                            </Items>
                                        </ext:FieldContainer>
                                        <ext:TextField ID="txtMaterialName" runat="server" FieldLabel="规格" LabelAlign="Right" Flex="1">
                                        </ext:TextField>
                                    </Items>
                                </ext:Container>
                                <ext:Container ID="container1" runat="server" Layout="FormLayout" ColumnWidth=".25"
                                    Padding="5">
                                    <Items>
                                        <ext:ComboBox ID="cbxShift" runat="server" FieldLabel="成型班次" LabelAlign="Right" Editable="false">
                                        </ext:ComboBox>
                                        <ext:ComboBox ID="cbxEquip" runat="server" FieldLabel="机台名称" LabelAlign="Right" Editable="true" EnableKeyEvents="true">
                                        </ext:ComboBox>
                                    </Items>
                                </ext:Container>
                                <ext:Container ID="container2" runat="server" Layout="FormLayout" ColumnWidth=".25"
                                    Padding="5">
                                    <Items>
                                        <ext:ComboBox ID="cbxGrade" runat="server" FieldLabel="等级" LabelAlign="Right" Editable="false">
                                        </ext:ComboBox>
                                         <ext:ComboBox ID="cbxQShift" runat="server" FieldLabel="质检班次" LabelAlign="Right" Editable="false">
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
                <ext:Panel ID="Panel2" runat="server" Region="Center" Frame="true" Layout="Fit" MarginsSummary="0 5 0 5" Title="胎胚质检信息">
                    <Items>
                        <ext:GridPanel ID="pnlList" runat="server">
                            <View><ext:GridView EnableTextSelection="true"></ext:GridView></View>
                            <Store>
                                <ext:Store ID="store" runat="server" PageSize="15">
                                    <Proxy>
                                        <ext:PageProxy DirectFn="App.direct.GridPanelBindData" />
                                    </Proxy>
                                    <Model>
                                        <ext:Model ID="model" runat="server" IDProperty="OBJID">                                            
                                            <Fields>                                                
                                                <ext:ModelField Name="OBJID" />
                                                <ext:ModelField Name="TYREID" />
                                                <ext:ModelField Name="EQUIP_NAME" />
                                                <ext:ModelField Name="MATERIAL_CODE" />
                                                <ext:ModelField Name="SHIFT_NAME" />
                                                <ext:ModelField Name="CLASS_NAME" />
                                                <ext:ModelField Name="EMP1" />
                                                <ext:ModelField Name="EMP2" />
                                                <ext:ModelField Name="EMP3" />
                                                <ext:ModelField Name="GRADE_NAME" />
                                                <ext:ModelField Name="DEFECT_NAME" />
                                                <ext:ModelField Name="SHIFT_DATE" />
                                                <ext:ModelField Name="RECORD_TIME" Type="Date" />
                                                <ext:ModelField Name="USER_NAME" />
                                                <ext:ModelField Name="DUMMY2" />
                                                <ext:ModelField Name="DUMMY3" />
                                            </Fields>
                                        </ext:Model>
                                    </Model>
                                </ext:Store>
                            </Store>
                            <ColumnModel ID="colModel" runat="server">                              
                                
                                <Columns>
                                    <ext:RowNumbererColumn ID="rowNumCol" runat="server" Width="35" />
                                    <ext:Column ID="OBJID" runat="server" Text="" DataIndex="OBJID" Width="100" Hidden="TRUE" />
                                    <ext:Column ID="TYREID" runat="server" Text="胎胚号" Selectable="true" DataIndex="TYREID" Width="100" />
                                    <ext:Column ID="MATERIAL_NAME" runat="server" Text="规格" DataIndex="MATERIAL_CODE" Width="260" />
                                    <ext:Column ID="GRADE_NAME" runat="server" Text="品级" DataIndex="GRADE_NAME" Width="120" />
                                    <ext:SummaryColumn ID="DEFECT_NAME" runat="server" Text="病疵" DataIndex="DEFECT_NAME" Width="200" SummaryType="Count">
                                         <SummaryRenderer Handler="return '当前页总计：共' + value + '条'"> </SummaryRenderer>
                                    </ext:SummaryColumn>
                                    <ext:Column ID="Column3" runat="server" Text="返修项目" DataIndex="DUMMY2" Width="100" />
                                    <ext:Column ID="Column4" runat="server" Text="返修部位" DataIndex="DUMMY3" Width="100" />
                                    <ext:DateColumn ID="SHIFT_DATE" runat="server" Text="生产时间" DataIndex="SHIFT_DATE" Width="200"  Format="yyyy-MM-dd" />
                                    <ext:Column ID="EQUIP_NAME" runat="server" Text="生产机台" DataIndex="EQUIP_NAME" Width="100" />
                                    <ext:Column ID="SHIFT_NAME" runat="server" Text="生产班次" DataIndex="SHIFT_NAME" Width="100" />
                                    <ext:Column ID="CLASS_NAME" runat="server" Text="生产班组" DataIndex="CLASS_NAME" Width="100" />
                                    <ext:Column ID="EMP1_NAME" runat="server" Text="成型主机" DataIndex="EMP1" Width="100" />
                                    <ext:Column ID="Column1" runat="server" Text="成型副机" DataIndex="EMP2" Width="100" />
                                    <ext:Column ID="Column2" runat="server" Text="成型帮车" DataIndex="EMP3" Width="100" />
                                    <ext:Column ID="USER_NAME" runat="server" Text="质检人" DataIndex="USER_NAME" Width="100" />
                                    <ext:DateColumn ID="RECORD_TIME" runat="server" Text="质检时间" DataIndex="RECORD_TIME" Width="200"  Format="yyyy-MM-dd HH:mm:ss" />
                                    <ext:CommandColumn ID="commandCol" runat="server" Width="120" Text="操作" Align="Center"  Hidden="true">
                                        <Commands>
                                            <ext:GridCommand Icon="TableEdit" CommandName="Edit" Text="修改">
                                            </ext:GridCommand>
                                        </Commands>
                                        <PrepareToolbar Fn="prepareToolbar" />
                                        <Listeners>
                                            <Command Handler="return commandcolumn_click(command, record);" />
                                        </Listeners>
                                    </ext:CommandColumn>
                                </Columns>
                            </ColumnModel>
                            <Plugins>
                                <ext:CellEditing ID="cellEditing1" runat="server" ClicksToEdit="1">
                                </ext:CellEditing>
                            </Plugins>
                            
                            <SelectionModel>
                                <ext:RowSelectionModel ID="rowSelectMuti" runat="server" Mode="Single">
                                    <Listeners>
                                        <Select Handler="#{storeDetail}.reload();" Buffer="250" />
                                    </Listeners>
                                </ext:RowSelectionModel>
                            </SelectionModel>
                            <BottomBar>
                                <ext:PagingToolbar ID="pageToolBar" runat="server">
                                    <Items>
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
                                                <Select Handler="#{pnlDetailList}.storeData.pageSize = parseInt(this.getValue(), 10); #{pageToolBar}.doRefresh(); return false;" />
                                            </Listeners>
                                        </ext:ComboBox>
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

                <ext:Window ID="winEditProduct" runat="server" Icon="MonitorEdit" Closable="true"
                    Title="修改品级" Width="360" Height="200" Resizable="false" Hidden="true" Modal="true"
                    BodyStyle="background-color:#fff;" BodyPadding="5" Layout="FitLayout">
                    <Items>
                        <ext:FormPanel ID="FormPanel3" runat="server" Flex="1" BodyPadding="5">
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
                                <ext:TextField runat="server" ID="EditObjId" Hidden="true"></ext:TextField>
                                <ext:TextField runat="server" ID="EditGreenTyreNo" FieldLabel="胎胚号" LabelAlign="Right" ReadOnly="true" />
                                <ext:TextField runat="server" ID="EditGradeName" FieldLabel="原品级" LabelAlign="Right" ReadOnly="true" />
                                <%--<ext:ComboBox runat="server" ID="EditGradeNameNew" FieldLabel="改判品级" LabelAlign="Right" />--%>
                            </Items>
                        </ext:FormPanel>
                    </Items>
                    <Buttons>
                        <ext:Button ID="Button4" runat="server" Text="确定" Disabled="false">
                            <DirectEvents>
                                <Click OnEvent="btnEditOK_Click"></Click>
                            </DirectEvents>
                        </ext:Button>
                    </Buttons>
                </ext:Window>
            </Items>
        </ext:Viewport>
    </form>
</body>
</html>
