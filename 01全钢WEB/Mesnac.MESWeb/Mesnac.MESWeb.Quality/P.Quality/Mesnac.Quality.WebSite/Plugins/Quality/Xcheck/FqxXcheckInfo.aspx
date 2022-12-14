<%@ Page Language="C#" AutoEventWireup="true" CodeFile="FqxXcheckInfo.aspx.cs" Inherits="Plugins_Quality_Xcheck_FqxXcheckInfo" %>

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

            App.storeDetail.currentPage = 1;
            App.pageToolBar.doRefresh();
            return false;
        }

        var prepareToolbar = function (grid, toolbar, rowIndex, record) {
            if (record.get("FiledFlag") == "1") {
                toolbar.items.getAt(0).hide();
                toolbar.items.getAt(1).hide();
            }
            else if (record.get("LockedFlag") == "1") {
                toolbar.items.getAt(0).hide();
                toolbar.items.getAt(1).hide();
            }
        };

        var commandcolumn_click = function (command, record) {
            commandcolumn_direct_showpic(record);
            return false;
        };
        var commandcolumn_direct_showpic = function (record) {
            var picturePath = record.data.PICTURE_PATH;
            App.direct.commandcolumn_direct_showpic(picturePath, {
                success: function (result) {
                },

                failure: function (errorMsg) {
                    Ext.Msg.alert('操作', errorMsg);
                }
            });
        }

        var startTrack = function () {
            this.checkboxes = [];
            var cb;

            Ext.select(".x-form-item", false).each(function (checkEl) {
                cb = Ext.getCmp(checkEl.dom.id.selected);
                cb.setValue(false);
                this.rowselect.push(cb);
            }, this);
        };

    </script>
</head>
<body>
    <form id="form1" runat="server">
        <asp:Button ID="btnExportSubmit" Style="display: none" runat="server" Text="Button"
            OnClick="btnExportSubmit_Click" />
        <ext:ResourceManager ID="rmFcheckInfo" runat="server" />
        <ext:Viewport ID="vpFcheckInfo" runat="server" Layout="border">
            <Items>
                <ext:Panel ID="pnFcheckInfo" runat="server" Region="North" Height="110">
                    <TopBar>
                        <ext:Toolbar runat="server" ID="tbFcheckInfo">
                            <Items>
                                <ext:Button runat="server" Icon="Find" Text="查询" ID="btnSearch">
                                    <DirectEvents>
                                        <Click OnEvent="btnQuary_Click" />
                                    </DirectEvents>
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
                                <ext:ToolbarSeparator ID="tsEnd" />
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
                                                <ext:TimeField ID="txtBeginTime" runat="server" width="80" Editable="true" />
                                            </Items>
                                        </ext:FieldContainer>
                                        <ext:TextField ID="txtTyreNo" runat="server" FieldLabel="硫化号" LabelAlign="Right" />
                                        <ext:ComboBox ID="cbxchengxing" runat="server" FieldLabel="成型机台" LabelAlign="Right" Editable="false"></ext:ComboBox>
                                    </Items>
                                </ext:Container>
                                <ext:Container ID="container2" runat="server" Layout="FormLayout" ColumnWidth=".25"
                                    Padding="5">
                                    <Items>
                                        <ext:FieldContainer runat="server" FieldLabel="结束时间" Layout="HBoxLayout" LabelAlign="Right">
                                            <Items>
                                                <ext:DateField ID="txtEndDate" runat="server" Flex="1" Editable="false" />
                                                <ext:TimeField ID="txtEndTime" runat="server" width="80" Editable="true" />
                                            </Items>
                                        </ext:FieldContainer>
                                        <ext:TextField ID="txtGreenTyreNo" runat="server" FieldLabel="胎胚号" LabelAlign="Right" Editable="true"></ext:TextField>
                                        <ext:ComboBox ID="cbxliuhua" runat="server" FieldLabel="硫化机台" LabelAlign="Right" Editable="false"></ext:ComboBox>
                                    </Items>
                                </ext:Container>
                                <ext:Container ID="container3" runat="server" Layout="FormLayout" ColumnWidth=".25"
                                    Padding="5">
                                    <Items>
                                        <ext:ComboBox ID="cbxGrade" runat="server" FieldLabel="质检品级" LabelAlign="Right" Editable="false"></ext:ComboBox>
                                         <ext:TextField ID="txtMaterialName" runat="server" FieldLabel="规格" LabelAlign="Right" Editable="true"></ext:TextField>
                                         <ext:TextField ID="txtpdm" runat="server" FieldLabel="PDM编码" LabelAlign="Right" Editable="true"></ext:TextField>
                                    </Items>
                                </ext:Container>
                                   <ext:Container ID="container4" runat="server" Layout="FormLayout" ColumnWidth=".25"
                                    Padding="5">
                                    <Items>
                                        <ext:ComboBox ID="cbxEquip" runat="server" FieldLabel="机台号" LabelAlign="Right" Editable="false"></ext:ComboBox>
                                        <ext:ComboBox ID="cbxDefect" runat="server" FieldLabel="病疵" LabelAlign="Right" Editable="false">
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
                <ext:Panel ID="pnlData" runat="server" Region="Center" Title="检验数据" Height="200" Icon="Basket" Layout="Fit" Collapsible="true"
                    Split="true" MarginsSummary="0 5 5 5">
                    <Items>
                        <ext:GridPanel ID="pnlList" runat="server" MarginsSummary="0 5 5 5">
                            <Store>
                                <ext:Store ID="store" runat="server" PageSize="10">
                                    <Proxy>
                                        <ext:PageProxy DirectFn="App.direct.GridPanelBindData" />
                                    </Proxy>
                                    <Model>
                                        <ext:Model ID="modelDetail" runat="server" IDProperty="OBJID">
                                            <Fields>
                                                <ext:ModelField Name="OBJID" />
                                                <ext:ModelField Name="TYRDID" />
                                                <ext:ModelField Name="TYRE_NO" />
                                                <ext:ModelField Name="GRADEID" />
                                                <ext:ModelField Name="GRADENAME" />
                                                <ext:ModelField Name="MATERIAL_NAME" />
                                                <ext:ModelField Name="SHIFT_ID" />
                                                <ext:ModelField Name="SHIFT_NAME" />
                                                <ext:ModelField Name="USER_NAME" />
                                                <ext:ModelField Name="RECORD_TIME" Type="Date" />
                                                <ext:ModelField Name="DEFECTID" />
                                                <ext:ModelField Name="DEFECTNAME" />
                                                <ext:ModelField Name="DEFECT_PART" />
                                                <ext:ModelField Name="UP_OR_DOWN" />
                                                <ext:ModelField Name="PROCEDURE_NAME" />
                                                <ext:ModelField Name="B_GRADENAME" />
                                                <ext:ModelField Name="SET_WEIGHT" />
                                                <ext:ModelField Name="WEIGHT"  />
                                                <ext:ModelField Name="EQUIP_NAME" />
                                                <ext:ModelField Name="C_EQUIP_NAME" />
                                                <ext:ModelField Name="C_CLASS_NAME" />
                                                <ext:ModelField Name="M_BEGIN_TIME" />
                                                <ext:ModelField Name="M_END_TIME" />
                                                <ext:ModelField Name="C_BEGIN_TIME" />
                                                <ext:ModelField Name="C_END_TIME" />
                                                <ext:ModelField Name="M_EQUIP_NAME" />
                                                <ext:ModelField Name="M_CLASS_NAME" />
                                                <ext:ModelField Name="EQUIPCODE" />
                                                <ext:ModelField Name="PICTURE_PATH" />
                                                <ext:ModelField Name="OLD_DEFECTNAME" />
                                                <ext:ModelField Name="CHANGE_GRADE_USER_NAME" />
                                                <ext:ModelField Name="CURINGNAME" />
                                                <ext:ModelField Name="MOLDINGNAME" />
                                                <ext:ModelField Name="MOLDINGNAME1" />
                                                <ext:ModelField Name="MOLDINGNAME2" />
                                                <ext:ModelField Name="ZUOYOUMO" />
                                                <ext:ModelField Name="PDM_CODE" />
                                                <ext:ModelField Name="NEW_BARCODE" />
                                            </Fields>
                                        </ext:Model>
                                    </Model>
                                </ext:Store>
                            </Store>
                            <ColumnModel ID="ColumnModelDetail" runat="server">
                                <Columns>
                                    <ext:RowNumbererColumn ID="rowNumCol1" runat="server" Width="35" />
                                    <ext:CommandColumn ID="commandCol" runat="server" Width="80" Text="操作" Align="Center">
                                        <Commands>
                                            <ext:GridCommand Icon="Picture" CommandName="Pic" Text="图片" />
                                        </Commands>
                                        <Listeners>
                                            <Command Handler="return commandcolumn_click(command, record);" />
                                        </Listeners>
                                    </ext:CommandColumn>
                                    <ext:Column ID="TYREID" runat="server" Text="胎胚号" DataIndex="TYRDID" />
                                    <ext:Column ID="TYRE_NO" runat="server" Text="硫化号" DataIndex="TYRE_NO"/>
                                    <ext:Column ID="MATERIAL_NAME_DETAIL" runat="server" Text="规格" DataIndex="MATERIAL_NAME" Width="220" />
                                    <ext:Column ID="Column2" runat="server" Text="PDM编码" DataIndex="PDM_CODE"/>
                                    <ext:Column ID="EQUIP_NAME" runat="server" Text="质检机台" DataIndex="EQUIP_NAME" Width="60"/>
                                    <ext:Column ID="M_EQUIP_NAME" runat="server" Text="成型机台" DataIndex="M_EQUIP_NAME" Width="100"/>
                                    <ext:Column ID="Column3" runat="server" Text="成型鼓编号" DataIndex="NEW_BARCODE" Width="100"/>
                                    <ext:Column ID="M_CLASS_NAME" runat="server" Text="成型班组" DataIndex="M_CLASS_NAME" Width="60"/>
                                    <ext:Column ID="M_BEGIN_TIME" runat="server" Text="成型开始时间" DataIndex="M_BEGIN_TIME" Width ="160" />
                                    <ext:Column ID="M_END_TIME" runat="server" Text="成型结束时间" DataIndex="M_END_TIME" Width ="160"  />
                                    <ext:Column ID="MOLDINGNAME" runat="server" Text="主手" DataIndex="MOLDINGNAME" Width="60"/>
                                    <ext:Column ID="MOLDINGNAME1" runat="server" Text="副手" DataIndex="MOLDINGNAME1" Width="60"/>
                                    <ext:Column ID="MOLDINGNAME2" runat="server" Text="帮车" DataIndex="MOLDINGNAME2" Width="60"/>
                                    <ext:Column ID="C_EQUIP_NAME" runat="server" Text="硫化机台" DataIndex="C_EQUIP_NAME" Width="60"/>
                                    <ext:Column ID="Column1" runat="server" Text="左右模" DataIndex="ZUOYOUMO" Width="60"/>
                                    <ext:Column ID="C_CLASS_NAME" runat="server" Text="硫化班组" DataIndex="C_CLASS_NAME" Width="60"/>
                                    <ext:Column ID="C_BEGIN_TIME" runat="server" Text="硫化开始时间" DataIndex="C_BEGIN_TIME" Width ="160"  />
                                    <ext:Column ID="C_END_TIME" runat="server" Text="硫化结束时间" DataIndex="C_END_TIME" Width ="160"   />
                                    <ext:Column ID="CURINGNAME" runat="server" Text="硫化工" DataIndex="CURINGNAME" Width="60" />
                                    <ext:Column ID="GRADENAME" runat="server" Text="品级" DataIndex="GRADENAME" Width="80"/>
                                    <ext:Column ID="B_GRADENAME" runat="server" Text="改判前品级" DataIndex="B_GRADENAME" Width="80" />
                                     <ext:Column ID="OLD_DEFECTNAME" runat="server" Text="改判前病疵" DataIndex="OLD_DEFECTNAME" Width="80" />
                                    <ext:Column ID="WEIGHT" runat="server" Text="重量" Hidden="true" DataIndex="WEIGHT" Width="60" />
                                    <ext:Column ID="SET_WEIGHT" runat="server" Text="标准重量" Hidden="true" DataIndex="SET_WEIGHT" Width="60" />
                                    <ext:Column ID="SHIFT_NAME" runat="server" Text="质检班次" DataIndex="SHIFT_NAME" Hidden="true" />
                                    <ext:Column ID="USER_NAME" runat="server" Text="质检员" DataIndex="USER_NAME" Width="80" />
                                    <ext:Column ID="CHANGE_GRADE_USER_NAME" runat="server" Text="改判人" DataIndex="CHANGE_GRADE_USER_NAME" Width="80" />
                                    <ext:DateColumn ID="F_RECORD_TIME" runat="server" Text="质检时间" DataIndex="RECORD_TIME" Width="160" Format="yyyy-MM-dd HH:mm:ss" />
                                    
                                </Columns>
                            </ColumnModel>
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
                <ext:Panel ID="pnlDetail" runat="server" Region="South" Title="检验明细数据" Height="200" Icon="Basket" Layout="Fit" Collapsible="true"
                    Split="true" MarginsSummary="0 5 5 5">
                    <Items>
                        <ext:GridPanel ID="GridPanel1" runat="server" MarginsSummary="0 5 5 5">
                            <Store>
                                <ext:Store ID="storeDetail" runat="server" PageSize="10" OnReadData="RowSelect">
                                    <Model>
                                        <ext:Model ID="model1" runat="server" IDProperty="OBJID">
                                            <Fields>
                                                <ext:ModelField Name="DEFECTID" />
                                                <ext:ModelField Name="DEFECTNAME" />
                                                <ext:ModelField Name="DEFECT_PART" />
                                                <ext:ModelField Name="UP_OR_DOWN" />
                                                <ext:ModelField Name="PROCEDURE_NAME" />
                                            </Fields>
                                        </ext:Model>
                                    </Model>
                                     <Parameters>
                                        <ext:StoreParameter Name="OBJID" Mode="Raw" Value="#{pnlList}.getSelectionModel().hasSelection() ? #{pnlList}.getSelectionModel().getSelection()[0].data.TYRDID : -1" />
                                    </Parameters>
                                </ext:Store>
                            </Store>
                            <ColumnModel ID="ColumnModel1" runat="server">
                                <Columns>
                                    <ext:Column ID="DEFECTNAME" runat="server" Text="病疵" DataIndex="DEFECTNAME" Width="200" />
                                    <ext:Column ID="DEFECT_PART" runat="server" Text="病疵位置" DataIndex="DEFECT_PART" Hidden="true" Flex="1" />
                                    <ext:Column ID="UP_OR_DOWM" runat="server" Text="上下模" DataIndex="UP_OR_DOWN" Width="200" />
                                    <ext:Column ID="PROCEDURE_NAME" runat="server" Text="病疵责任工序" DataIndex="PROCEDURE_NAME" Width="200" />

                                </Columns>
                            </ColumnModel>
                        </ext:GridPanel>
                    </Items>
                </ext:Panel>
                <ext:Window ID="winShowPic" runat="server" Icon="picture" Closable="true" Hidden="true"
                    Title="X光图片" Width="600" Height="500" Resizable="true" Shadow="false" AutoScroll="true"
                    BodyStyle="background-color:#fff;" BodyPadding="10" Layout="Fit" Maximizable="true">
                    <Items>
                        <ext:Image ID="Image1" runat="server" XDelta="-4555"
                            YDelta="-3286" AllowPan="true" />
                    </Items>
                </ext:Window>
            </Items>
        </ext:Viewport>
    </form>
</body>
</html>
