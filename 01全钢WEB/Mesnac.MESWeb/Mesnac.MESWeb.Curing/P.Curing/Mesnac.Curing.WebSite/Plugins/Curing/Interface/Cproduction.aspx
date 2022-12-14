<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Cproduction.aspx.cs" Inherits="Plugins_Curing_Interface_Cproduction" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>SAP报产信息查询</title>
    <link rel="Stylesheet" type="text/css" href="<%= Page.ResolveUrl("~/") %>resources/css/ext-chinese-font.css" />
    <link rel="Stylesheet" type="text/css" href="<%= Page.ResolveUrl("~/") %>resources/css/main.css" />
    <style type="text/css">
        .redcs {
            color: #ff0000;
        }
    </style>
    <script type="text/javascript">
        var thisDirUrl = "<%= Page.ResolveUrl("./") %>";
        var thisRootUrl = "<%= Page.ResolveUrl("~/") %>";
    </script>
    <script type="text/javascript" src="<%= Page.ResolveUrl("~/") %>resources/js/jquery-1.7.1.js"></script>
    <script type="text/javascript">

        //列表刷新数据重载方法
        var pnlListFresh = function () {
            App.pnlList.store.reload();
            return false;
        }
    </script>

    <%--<script type="text/javascript">

        Ext.create("Ext.window.Window", {//物料查询带回窗体
            id: "McUI_SearchBox_SearchBoxVCbmMaterial_Window",
            height: 430,
            hidden: true,
            width: 360,
            html: "<iframe src='" + thisRootUrl + "McUI/SearchBox/SearchBoxVCbmMaterial.aspx' width=100% height=100% scrolling=no  frameborder=0></iframe>",
            bodyStyle: "background-color: #fff;",
            closable: true,
            title: "选择物料",
            modal: true
        })
        //------------查询带回弹出框--END 
    </script>

    <script type="text/javascript">
        //区分删除操作，并进行二次确认操作
        var upload_product_qty_confirm = function (isall) {
            if (isall == 0) {
                Ext.Msg.confirm("提示", '您确认要上报选中的产量吗？', function (btn) {
                    if (btn != "yes") {
                        return;
                    }
     
                    var box = App.CheckboxSelectionModel1.selected.items;
                    var e = new Array();
                    for (var i = 0 ; i < box.length; i++)
                    {
                        if (box[i].data.SUCCESS_FLAG != "新建")
                        {
                            Ext.Msg.alert("提示", "所选数据包含已上传信息！");
                            return;
                        }
                        e.push(box[i].data.PRODUCTINFO);
                    }
                    var arr = Ext.encode(e);
                    App.direct.upload_product_qty(isall, arr);
                });
            }
            else {

                Ext.Msg.confirm("提示", '您确认要上报全部产量吗？', function (btn) {
                    if (btn != "yes") {
                        return;
                    }
                
                    App.CheckboxSelectionModel1.selectAll();
                    var box = App.CheckboxSelectionModel1.selected.items;
                    for (var i = 0 ; i < box.length; i++) {
                        if (box[i].data.SUCCESS_FLAG != "新建") {
                            Ext.Msg.alert("提示", "所选数据包含已上传信息！");
                            return;
                        }
                    }
                    App.direct.upload_product_qty(isall,null);
                });
            }
        };

        var prepareToolbar = function (grid, toolbar, rowIndex, record) {

        };
        var InsertMoldingProductWindowShow = function () {
            var shiftDate = App.ShiftDate.getValue();
            if (shiftDate.length == 0) {
                Ext.Msg.alert('提示', "请选择日期");
                return;
            }
            var headtxt = App.cbxShift.rawValue;
            App.AddDocDate.setValue(shiftDate);
            App.AddPostDate.setValue(shiftDate);
            App.tgrAddMaterialCode.setValue("");
            App.AddQty.setValue("");
            App.AddRejectQty.setValue("");
            App.AddHeadTxt.setValue(headtxt);
            App.AddShift.setValue(App.cbxShift.getValue());
            App.winAddProduct.show();
        }
        var pad = function (num, n) {
            var len = num.toString().length;
            while (len < n) {
                num = "0" + num;
                len++;
            }
            return num;
        }
        var tgrSearchMaterialCode_Click = function (item, trigger, index) {//成品胎规格查询
            if (index == 0) {
                item.setValue('');
                App.hdnSearchMaterialId.setValue('');
            }
            else if (index == 1) {
                App.McUI_SearchBox_SearchBoxVCbmMaterial_Window.show();
            }
        }
        var McUI_SearchBox_SearchBoxVCbmMaterial_Request = function (record) {
            App.tgrAddMaterialCode.setValue(record.data.MATERIAL_NAME);
            App.hdnSearchMaterialId.setValue(record.data.OBJID);
        }
        var on_bom_version_change = function (sender) {//物料返回值处理
            App.direct.on_bom_version_change(sender.getValue());
        }
    </script>--%>
</head>
<body>
    <form id="form1" runat="server">
             <asp:Button ID="btnExportSubmit" Style="display: none" runat="server" Text="Button"
            OnClick="btnExportSubmit_Click" />
        <ext:ResourceManager ID="ResourceManager1" runat="server" />
        <ext:Viewport ID="Viewport1" runat="server" Layout="border">
            <Items>
                <ext:Panel ID="pnlQueryTitle" runat="server" Region="North" AutoHeight="true">
                    <TopBar>
                        <ext:Toolbar runat="server" ID="barUser">
                            <Items>
                                <ext:ToolbarSeparator ID="toolbarSeparator_begin" />
                                <ext:DateField runat="server" ID="txtShiftDate" Text="生产日期">
                                    <%-- <Listeners>
                                        <Change Fn="pnlListFresh" />
                                    </Listeners>--%>
                                </ext:DateField>
                                <ext:ComboBox runat="server" ID="cbxShift" Text="班次">
                                    <%--  <Listeners>
                                        <Change Fn="pnlListFresh" />
                                    </Listeners>--%>
                                </ext:ComboBox>
                                <ext:TextField ID="txtSAPMaterial" runat="server" FieldLabel="sap物料号">
                                </ext:TextField>

                                <ext:ToolbarSeparator />
                                <ext:Button runat="server" Icon="Find" Text="查询" Enabled="false" ID="btnSearch">
                                    <ToolTips>
                                        <ext:ToolTip ID="ToolTip2" runat="server" Html="查询MES产量" />
                                    </ToolTips>
                                    <Listeners>
                                        <Click Fn="pnlListFresh" />
                                    </Listeners>
                                </ext:Button>
                                <ext:ToolbarSeparator />

                                   <ext:Button runat="server" Icon="PageWhiteExcel" Text="导出" ID="btnExport">
                                    <ToolTips>
                                        <ext:ToolTip ID="ToolTip3" runat="server" Html="点击将查询结果导出到Excel中" />
                                    </ToolTips>
                                    <Listeners>
                                        <Click Handler="$('#btnExportSubmit').click();">
                                        </Click>
                                    </Listeners>
                                </ext:Button>

                                <ext:Hidden runat="server" ID="hdnSearchMaterialId" />
                                <ext:ToolbarSeparator ID="toolbarSeparator_middle_2" />
                                <ext:ToolbarSpacer runat="server" ID="toolbarSpacer_end" />
                                <ext:ToolbarFill ID="toolbarFill_end" />
                            </Items>
                        </ext:Toolbar>
                    </TopBar>
                </ext:Panel>
                <ext:GridPanel ID="pnlList" runat="server" Region="Center">
                    <View>
                        <ext:GridView EnableTextSelection="true" />
                    </View>
                    <Store>
                        <ext:Store ID="store" runat="server" PageSize="100">
                            <Proxy>
                                <ext:PageProxy DirectFn="App.direct.GridPanelBindData" />
                            </Proxy>
                            <Model>
                                <ext:Model ID="model" runat="server" IDProperty="PRODUCTINFO">
                                    <Fields>
                                        <ext:ModelField Name="OBJID" />
                                        <ext:ModelField Name="PRODUCTINFO" />
                                        <ext:ModelField Name="SUCCESS_FLAG" />
                                        <ext:ModelField Name="POST_DATE" />
                                        <ext:ModelField Name="DOC_DATE" />
                                        <ext:ModelField Name="MATERIAL_NAME" />
                                        <ext:ModelField Name="MATERIAL_ID" />
                                        <ext:ModelField Name="PROVERSION" />
                                        <ext:ModelField Name="QTY" />
                                        <ext:ModelField Name="MES_QTY" />
                                        <ext:ModelField Name="SAP_QTY" />
                                        <ext:ModelField Name="REJECT_QTY" />
                                        <ext:ModelField Name="MES_REJECT_QTY" />
                                        <ext:ModelField Name="SAP_REJECT_QTY" />
                                        <ext:ModelField Name="SHIFT_NAME" />
                                        <ext:ModelField Name="SHIFT_DATE" />
                                        <ext:ModelField Name="SAP_CODE" />
                                        <ext:ModelField Name="RETURN_MSG" />
                                         <ext:ModelField Name="REMARK" />
                                         <ext:ModelField Name="STATE_FLAG" />
                                    </Fields>
                                </ext:Model>
                            </Model>
                        </ext:Store>
                    </Store>
                    <ColumnModel ID="colModel" runat="server">
                        <Columns>
                            <ext:RowNumbererColumn runat="server" Width="30"/>
                            <ext:Column ID="OBJID" runat="server" Hidden="true" ></ext:Column>
                            <ext:Column ID="SUCCESS_FLAG" runat="server" Text="状态" DataIndex="SUCCESS_FLAG" Width="60" />
                            <ext:Column ID="STATE_FLAG" runat="server" Text="数据来源" DataIndex="STATE_FLAG" Width="60" />
                            <ext:DateColumn ID="SHIFT_DATE" runat="server" Text="生产日期" DataIndex="SHIFT_DATE" Format="yyyy-MM-dd" Width="80" />
                            <ext:Column ID="POSTDATE" runat="server" Text="过账日期" DataIndex="POST_DATE" Width="80" />
                            <ext:Column ID="DOCDATE" runat="server" Text="凭证日期" DataIndex="DOC_DATE" Width="80" />
                            <ext:Column ID="SHIFT_NAME" runat="server" Text="生产班次" DataIndex="SHIFT_NAME" Width="80" />
                            <ext:Column ID="SAPCODE" runat="server" Text="SAP物料号" Selectable="true" DataIndex="SAP_CODE" Width="80" />
                            <ext:Column ID="PROVERSION" runat="server" Text="BOM版本" Selectable="true" DataIndex="PROVERSION" Width="80" />
                            <ext:Column ID="MATERIALNAME" runat="server" Text="轮胎规格" DataIndex="MATERIAL_NAME" Width="300" />
                               <ext:Column ID="QTY" runat="server" Text="上报产量" DataIndex="QTY" Width="80" />
                            <ext:Column ID="MESQTY" runat="server" Text="MES产量" DataIndex="MES_QTY" Width="80" />
                            <ext:Column ID="SAPQTY" runat="server" Text="已上报产量" Hidden="true" DataIndex="SAP_QTY" Width="80" />
                            <ext:Column ID="MESREJECTQTY" runat="server" Text="MES废品数量" DataIndex="MES_REJECT_QTY" Width="80" />
                            <ext:Column ID="SAPREJECTQTY" runat="server" Text="已上报废品数量" Hidden="true" DataIndex="SAP_REJECT_QTY" Width="80" />
                            <ext:Column ID="REJECTQTY" runat="server" Text="废品数量" DataIndex="REJECT_QTY" Width="80" />
                             <ext:Column ID="REMARK" runat="server" Text="凭证抬头文本" DataIndex="REMARK" Width="80" />
                     <%--       <ext:CommandColumn ID="commandCol" runat="server" Width="120" Text="操作" Align="Center">
                                <Commands>
                                    <ext:GridCommand Icon="TableEdit" CommandName="Edit" Text="修改">
                                    </ext:GridCommand>
                                    <ext:CommandSeparator />
                                    <ext:GridCommand Icon="Delete" CommandName="Delete" Text="删除">
                                    </ext:GridCommand>
                                </Commands>
                                <PrepareToolbar Fn="prepareToolbar" />
                                <Listeners>
                                    <Command Handler="return commandcolumn_click(command, record);" />
                                </Listeners>
                            </ext:CommandColumn>--%>
                            <ext:Column ID="RETURN_MSG" runat="server" Text="SAP返回消息" Hidden="false" DataIndex="RETURN_MSG" Width="220" />
                        </Columns>
                    </ColumnModel>
<%--                    <SelectionModel>
                        <ext:CheckboxSelectionModel ID="CheckboxSelectionModel1" runat="server" Mode="Multi" />
                    </SelectionModel>--%>
                    <BottomBar>
                        <ext:PagingToolbar ID="pageToolbar1" runat="server">
                            <Items>
                                <ext:Label ID="Label2" runat="server" Text="每页条数:" Hidden="true" />
                                <ext:ToolbarSpacer ID="ToolbarSpacer2" runat="server" Width="10" />
                                <ext:ComboBox ID="ComboBox2" runat="server" Width="80" Hidden="true">
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
                                        <Select Handler="#{pnlList}.store.pageSize = parseInt(this.getValue(), 10); #{pageToolbar1}.doRefresh(); return false;" />
                                    </Listeners>
                                </ext:ComboBox>
                            </Items>
                            <Plugins>
                                <ext:ProgressBarPager ID="ProgressBarPager1" runat="server" />
                            </Plugins>
                        </ext:PagingToolbar>
                    </BottomBar>
                </ext:GridPanel>

                <%--<ext:Window ID="winEditProduct" runat="server" Icon="MonitorEdit" Closable="true"
                    Title="修改报产信息" Width="360" Height="360" Resizable="false" Hidden="true" Modal="true"
                    BodyStyle="background-color:#fff;" BodyPadding="5" Layout="FitLayout">
                    <Items>
                        <ext:FormPanel ID="FormPanel2" runat="server" Flex="1" BodyPadding="5">
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
                                <ext:DateField runat="server" ID="EditPostDate" FieldLabel="过账日期" Editable="false" LabelAlign="Right" />
                                <ext:DateField runat="server" ID="EditDocDate" FieldLabel="凭证日期" Editable="false" LabelAlign="Right" />
                                <ext:ComboBox runat="server" ID="EditShift" FieldLabel="生产班次" Editable="false" LabelAlign="Right" />
                                <ext:TriggerField runat="server" ID="tgrEditMaterialCode" ReadOnly="true" Enabled="false" Editable="false" FieldLabel="轮胎规格" LabelAlign="Right">
                                    <Triggers>
                                        <ext:FieldTrigger Icon="Clear" Qtip="清空" />
                                        <ext:FieldTrigger Icon="Search" Qtip="查找" />
                                    </Triggers>
                                    <Listeners>
                                        <TriggerClick Handler="return tgrSearchMaterialCode_Click(item,trigger,index);" />
                                    </Listeners>
                                     <DirectEvents>
                                        <Change OnEvent="MaterialChange_Event"></Change>
                                    </DirectEvents>
                                </ext:TriggerField>
                                <ext:TextField runat="server" ID="EditQty" FieldLabel="合格数量" LabelAlign="Right" />
                                <ext:TextField runat="server" ID="EditRejectQty" FieldLabel="报废数量" LabelAlign="Right" />
                                <ext:TextField runat="server" ID="EditHeadTxt" FieldLabel="凭证抬头文本" LabelAlign="Right" />
                                <ext:Hidden runat="server" ID="hdnEditSearchMaterialId" />
                                <ext:Hidden runat="server" ID="hdnEditPostDate" />
                                <ext:Hidden runat="server" ID="hdnEditDocDate" />
                                <ext:Hidden runat="server" ID="hdnEditShift" />
                                <ext:Hidden runat="server" ID="hdnEditMaterialCode" />
                            </Items>
                        </ext:FormPanel>
                    </Items>
                    <Buttons>
                        <ext:Button ID="Button1" runat="server" Text="确定" Disabled="false">
                            <DirectEvents>
                                <Click OnEvent="btnEditOK_Click"></Click>
                            </DirectEvents>
                        </ext:Button>
                    </Buttons>
                </ext:Window>--%>
            </Items>
        </ext:Viewport>
    </form>
</body>
</html>
