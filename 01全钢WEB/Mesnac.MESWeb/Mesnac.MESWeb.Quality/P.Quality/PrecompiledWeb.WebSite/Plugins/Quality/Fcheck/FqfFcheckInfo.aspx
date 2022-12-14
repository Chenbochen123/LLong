<%@ page language="C#" autoeventwireup="true" inherits="Plugins_Quality_Fcheck_FqfFcheckInfo, Mesnac.Quality.WebSite" %>
<%@ Register Assembly="Ext.Net" Namespace="Ext.Net" TagPrefix="ext" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
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
        //var SetRowClass = function (record, rowIndex, rowParams, store) {
        //    if (record.get("GRADEID") == "3") {
        //        return "x-grid-row-collapsed";
        //    }
        //}

        //Ext.apply(Ext.form.VTypes, {
        //    integer: function (val, field) {
        //        if (!val) {
        //            return true;
        //        }
        //        try {
        //            if (/^[\d]+$/.test(val)) {
        //                return true;
        //            }
        //            else {
        //                return false;
        //            }
        //        }
        //        catch (e) {
        //            return false;
        //        }
        //    },
        //    integerText: "此填入项格式为正整数"
        //});

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

        //Ext.create("Ext.window.Window", {//厂家带窗体
        //    id: "",
        //    height: 460,
        //    hidden: true,
        //    width: 360,
        //    html: "<iframe src='../../../McUI/SearchBox/SearchBoxCbeCuringEquip.aspx' width=100% height=100% scrolling=no  frameborder=0></iframe>",
        //    bodyStyle: "background-color: #fff;",
        //    closable: true,
        //    title: "请选择厂家名称",
        //    modal: true
        //})
        
        //Ext.create("Ext.window.Window", {//人员信息带回查询信息
        //    id: "McUI_SearchBox_SearchBoxSsbUser_Window",
        //    height: 460,
        //    hidden: true,
        //    width: 360,
        //    html: "<iframe src='../../../McUI/SearchBox/SearchBoxSsbUser.aspx' width=100% height=100% scrolling=no frameborder=0></iframe>",
        //    bodyStyle: "background-color: #fff;",
        //    closable: true,
        //    title: "请选择人员",
        //    modal: true
        //})

        //点击取消作废按钮
        //var commandcolumn_direct_usedflag = function (btn) {
        //    if (btn != "yes") {
        //        return;
        //    }
        //    App.direct.btnBatchUsing_Click({
        //        success: function (result) {
        //            Ext.Msg.alert('操作', result);
        //        },

        //        failure: function (errorMsg) {
        //            Ext.Msg.alert('操作', errorMsg);
        //        }
        //    });
        //}

        //var IsNewChange = function (value) {
        //    return Ext.String.format(value == "1" ? "是" : "否");
        //};

    </script>
</head>
<body>
    <form id="form1" runat="server">
    <asp:Button ID="btnExportSubmit" Style="display: none" runat="server" Text="Button"
        OnClick="btnExportSubmit_Click" />
    <ext:ResourceManager ID="rmFcheckInfo" runat="server" />
    <ext:Viewport ID="vpFcheckInfo" runat="server" Layout="border">
        <Items>
            <ext:Panel ID="pnFcheckInfo" runat="server" Region="North" Height="90">
                <TopBar>
                    <ext:Toolbar runat="server" ID="tbFcheckInfo">
                        <Items>
                            <ext:Button runat="server" Icon="Find" Text="查询" ID="btnSearch">
                                <DirectEvents>
                                    <Click OnEvent="btnQuary_Click" />
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
                                    <ext:TextField ID="txtGreenTyreNo" runat="server" FieldLabel="胎胚号" LabelAlign="Right" />
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
                                    <ext:TextField ID="txtTyreNo" runat="server" FieldLabel="硫化号" LabelAlign="Right" Editable="false"></ext:TextField>
                                </Items>
                            </ext:Container>
                            <ext:Container ID="container3" runat="server" Layout="FormLayout" ColumnWidth=".25"
                                Padding="5">
                                <Items>
                                    <ext:TextField ID="txtMaterialName" runat="server" FieldLabel="规格" LabelAlign="Right" Editable="false"></ext:TextField>
                                    <ext:ComboBox ID="cbxGrade" runat="server" FieldLabel="质检品级" LabelAlign="Right" Editable="false"></ext:ComboBox>
                                </Items>
                            </ext:Container>
                            <ext:Container ID="container4" runat="server" Layout="FormLayout" ColumnWidth=".25" 
                                Padding="5">
                                <Items>
                                    <ext:ComboBox ID="cbxDefect" runat="server" FieldLabel="病疵" LabelAlign="Right" Editable="false">
                                    </ext:ComboBox>
                                    <ext:ComboBox ID="cbxShift" runat="server" FieldLabel="质检班次" LabelAlign="Right" Hidden="true" Editable="false"></ext:ComboBox>
                                    <ext:ComboBox ID="cbxClass" runat="server" FieldLabel="质检班组" LabelAlign="Right" Hidden="true" Editable="false">
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
                <ext:Panel ID="pnlDetail" runat="server" Region="Center" Title="外观质检数据查询" Height="200" Icon="Basket" Layout="Fit" Collapsible="true" 
                Split="true" MarginsSummary="0 5 5 5">
                    <Items>
                        <ext:GridPanel ID="pnlDetailList" runat="server" MarginsSummary="0 5 5 5">
                            <Store>
                                <ext:Store ID="storeDetail" runat="server" PageSize="15" >
                                    <Proxy>
                                        <ext:PageProxy DirectFn="App.direct.GridPanelBindData" />
                                    </Proxy>
                                    <Model>
                                        <ext:Model ID="modelDetail" runat="server" IDProperty="OBJID">
                                            <Fields>
                                                <ext:ModelField Name="OBJID" />
                                                <ext:ModelField Name="TYREID" />
                                                <ext:ModelField Name="TYRE_NO" />
                                                <ext:ModelField Name="MATERIAL_NAME" />
                                                <ext:ModelField Name="GRADENAME" />
                                                <ext:ModelField Name="OLD_GRADENAME" />
                                                <ext:ModelField Name="M_EQUIP_NAME"/>
                                                <ext:ModelField Name="C_EQUIP_NAME"/>
                                                <ext:ModelField Name="M_CLASS_NAME"/>
                                                <ext:ModelField Name="C_CLASS_NAME"/>
                                                <ext:ModelField Name="DEFECTNAME" />
                                                <ext:ModelField Name="RECORD_TIME" Type="Date"/>
                                                <ext:ModelField Name="USER_NAME" />
                                                <ext:ModelField Name="SHIFT_NAME" />
                                                <ext:ModelField Name="CLASS_NAME" />
                                                <ext:ModelField Name="OLD_DEFECTNAME" />
                                                <ext:ModelField Name="CURINGNAME" />
                                            </Fields>
                                        </ext:Model>
                                    </Model>
                                    <%--<Parameters>
                                        <ext:StoreParameter Name="OBJID" Mode="Raw" Value="#{pnlDetailList}.getSelectionModel().hasSelection() ? #{pnlDetailList}.getSelectionModel().getSelection()[0].data.OBJID : -1" />
                                    </Parameters>--%>
                                </ext:Store>
                            </Store>
                            <ColumnModel ID="ColumnModelDetail" runat="server">
                                <Columns>
                                    <ext:RowNumbererColumn ID="rowNumCol1" runat="server" Width="35" />
                                    <ext:Column ID="TYREID" runat="server" Text="胎胚号" DataIndex="TYREID"  />
                                     <ext:Column ID="TYRE_NO" runat="server" Text="硫化号" DataIndex="TYRE_NO" />
                                    <ext:Column ID="MATERIAL_NAME_DETAIL" runat="server" Text="规格" Width="240" DataIndex="MATERIAL_NAME"/>
                                    <ext:Column ID="GRADENAME" runat="server" Text="品级" Width="60" DataIndex="GRADENAME" />
                                    <ext:Column ID="OLD_GRADENAME" runat="server" Text="改判前品级" Width="80" DataIndex="OLD_GRADENAME" />
                                     <ext:Column ID="OLD_DEFECTNAME" runat="server" Text="改判前病疵" Width="80" DataIndex="OLD_DEFECTNAME" />
                                    <ext:Column ID="M_EQUIP_NAME" runat="server" Text="成型机台" Width="100" DataIndex="M_EQUIP_NAME" />
                                    <ext:Column ID="M_CLASS_NAME" runat="server" Text="成型班组" Width="60" DataIndex="M_CLASS_NAME" />
                                    <ext:Column ID="C_EQUIP_NAME" runat="server" Text="硫化机台" Width="60" DataIndex="C_EQUIP_NAME" />
                                    <ext:Column ID="C_CLASS_NAME" runat="server" Text="硫化班组" Width="60" DataIndex="C_CLASS_NAME"/>
                                    <ext:Column ID="DEFECTNAME" runat="server" Text="病疵" DataIndex="DEFECTNAME"/>
                                    <ext:Column ID="USER_NAME" runat="server" Text="质检员" DataIndex="USER_NAME"/>
                                    <ext:Column ID="SHIFT_NAME" runat="server" Text="质检班次" DataIndex="SHIFT_NAME" Hidden="true" />
                                    <ext:Column ID="CLASS_NAME" runat="server" Text="质检班组" DataIndex="CLASS_NAME" Hidden="true" />
                                    <ext:DateColumn ID="F_RECORD_TIME" runat="server" Text="质检时间" Width="200" DataIndex="RECORD_TIME" Format="yyyy-MM-dd HH:mm:ss"/>
                                    <ext:Column ID="CURING_NAME" runat="server" Text="硫化人员" Width="80" DataIndex="CURINGNAME" />
                                </Columns>
                            </ColumnModel>
                          <%--  <SelectionModel>
                                <ext:RowSelectionModel ID="rowSelectMutiDetail" runat="server" Mode="Single" />
                            </SelectionModel>--%>
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
                                                <Select Handler="#{pnlDetailList}.storeDetail.pageSize = parseInt(this.getValue(), 10); #{pageToolBar}.doRefresh(); return false;" />
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
        </Items>
    </ext:Viewport>
    </form>
</body>
</html>
