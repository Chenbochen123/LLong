<%@ Page Language="C#" AutoEventWireup="true" CodeFile="mproduction.aspx.cs" Inherits="Plugins_Molding_Interface_mproduction" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>成型产量查询</title>
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
        ////点击修改按钮
        //var commandcolumn_direct_edit = function (record) {
        //    if (record.data.SUCCESS_FLAG != "新建") {
        //        Ext.Msg.alert('提示', "信息已上传，无法修改！");
        //        return;
        //    }
        //    var ObjId = record.data.OBJID;
        //    var PostDate = record.data.POST_DATE;
        //    var DocDate = record.data.DOC_DATE;
        //    var MaterialId = record.data.MATERIAL_ID;
        //    var Qty = record.data.QTY;
        //    var Reject_Qty = record.data.REJECT_QTY;
        //    var ShiftDate = record.data.SHIFT_DATE;
        //    var MaterialCode = record.data.MATERIAL_CODE;
        //    var HeadTxt = record.data.REMARK;
        //    debugger;
        //    App.direct.commandcolumn_direct_edit(ObjId, ShiftDate, MaterialCode, MaterialId, Qty, Reject_Qty,HeadTxt, {
        //        success: function (result) {
        //            // Ext.Msg.alert('操作', result);
        //            pnlListFresh();
        //        },

        //        failure: function (errorMsg) {
        //            Ext.Msg.alert('操作', errorMsg);
        //        }
        //    });
        //}
        //var commandcolumn_direct_delete = function (btn, record) {
        //    if (btn != "yes") {
        //        return;
        //    }
        //    var ObjId = record.data.OBJID;

        //    debugger;
        //    App.direct.commandcolumn_direct_delete(ObjId, {
        //        success: function (result) {
        //            // Ext.Msg.alert('操作', result);
        //            pnlListFresh();
        //        },

        //        failure: function (errorMsg) {
        //            Ext.Msg.alert('操作', errorMsg);
        //        }
        //    });
        //}
        ////区分删除操作，并进行二次确认操作
        //var commandcolumn_click_confirm = function (command, record) {
        //    if (command.toLowerCase() == "edit") {
        //        commandcolumn_direct_edit(record);
        //    }
        //    if (command.toLowerCase() == "delete") {
        //        Ext.Msg.confirm("提示", '您确定需要删除未上传的产量吗？', function (btn) { commandcolumn_direct_delete(btn, record) });
        //    }

        //    return false;
        //};

        ////根据按钮类别进行删除和编辑操作
        //var commandcolumn_click = function (command, record) {
        //    commandcolumn_click_confirm(command, record);
        //    return false;
        //};

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


        //列表刷新数据重载方法
        var pnlListFresh = function () {
            App.pnlList.store.reload();
            return false;
        }
    </script>

<%--    <script type="text/javascript">

        Ext.create("Ext.window.Window", {//物料查询带回窗体
            id: "McUI_SearchBox_SearchBoxSbmMaterialMolding_Window",
            height: 430,
            hidden: true,
            width: 360,
            html: "<iframe src='" + thisRootUrl + "McUI/SearchBox/SearchBoxSbmMaterialMolding.aspx' width=100% height=100% scrolling=no  frameborder=0></iframe>",
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
                    for (var i = 0 ; i < box.length; i++) {
                        if (box[i].data.SUCCESS_FLAG != "新建")
                        {
                            Ext.Msg.alert("提示", "所选数据包含已上传信息！");
                            return;
                        }
                        e.push(box[i].data.PRODUCTINFO);
                    }
                    var arr = Ext.encode(e);
                    App.direct.upload_product_qty(isall,arr);
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
        var tgrSearchMaterialCode_Click = function (item, trigger, index) {//胎胚规格查询
            if (index == 0) {
                item.setValue('');
                App.hdnSearchMaterialId.setValue('');
            }
            else if (index == 1) {
                App.McUI_SearchBox_SearchBoxSbmMaterialMolding_Window.show();
            }
        }
        var McUI_SearchBox_SearchBoxSbmMaterialMolding_Request = function (record) {
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
                                </ext:DateField>
                                <ext:ComboBox runat="server" ID="cbxShift" Text="班次">
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
                            </Items>
                        </ext:Toolbar>
                    </TopBar>
                </ext:Panel>

                <ext:GridPanel ID="pnlList" runat="server" Region="Center">
                    <View>
                        <ext:GridView EnableTextSelection="true" />
                    </View>
                    <Store>
                        <ext:Store ID="store" runat="server" PageSize="50">
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
                                        <ext:ModelField Name="MATERIAL_CODE" />
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
                                         <ext:ModelField Name="STATE_FLAG"/>
                                    </Fields>
                                </ext:Model>
                            </Model>
                        </ext:Store>
                    </Store>
                    <ColumnModel ID="colModel" runat="server">
                        <Columns>
                            <ext:RowNumbererColumn runat="server" />
                            <ext:Column ID="OBJID" runat="server" Hidden="true"></ext:Column>
                            <ext:Column ID="SUCCESS_FLAG" runat="server" Text="状态" DataIndex="SUCCESS_FLAG" Width="60" />
                            <ext:Column ID="STATE_FLAG" runat="server" Text="数据来源" DataIndex="STATE_FLAG" Width="60" />
                            <ext:DateColumn ID="SHIFT_DATE" runat="server" Text="生产日期" DataIndex="SHIFT_DATE" Format="yyyy-MM-dd" Width="80" />
                            <ext:Column ID="POSTDATE" runat="server" Text="过账日期" DataIndex="POST_DATE" Width="80" />
                            <ext:Column ID="DOCDATE" runat="server" Text="凭证日期" DataIndex="DOC_DATE" Width="80" />
                            <ext:Column ID="SHIFT_NAME" runat="server" Text="生产班次" DataIndex="SHIFT_NAME" Width="80" />
                            <ext:Column ID="SAPCODE" runat="server" Text="SAP物料号" Selectable="true" DataIndex="SAP_CODE" Width="80" />
                            <ext:Column ID="PROVERSION" runat="server" Text="生产版本" Selectable="true" DataIndex="PROVERSION" Width="80" />
                            <ext:Column ID="MATERIALCODE" runat="server" Text="胎胚规格" DataIndex="MATERIAL_CODE" Width="300" />
                            <ext:Column ID="QTY" runat="server" Text="SAP上报产量" DataIndex="QTY" Width="80" />
                            <ext:Column ID="MESQTY" runat="server" Text="MES产量" DataIndex="MES_QTY" Width="80" />
                            <ext:Column ID="SAPQTY" runat="server" Text="已上报产量" Hidden="true" DataIndex="SAP_QTY" Width="80" />
                            
                            <ext:Column ID="MESREJECTQTY" runat="server" Text="MES废品数量" DataIndex="MES_REJECT_QTY" Width="80" />
                            <ext:Column ID="SAPREJECTQTY" runat="server" Text="已上报废品数量" Hidden="true" DataIndex="SAP_REJECT_QTY" Width="80" />
                            <ext:Column ID="REJECTQTY" runat="server" Text="废品数量" DataIndex="REJECT_QTY" Width="80" />
                            <ext:Column ID="REMARK" runat="server" Text="凭证抬头文本" DataIndex="REMARK" Width="80" />
                            
<%--                            <ext:CommandColumn ID="commandCol" runat="server" Width="120" Text="操作" Align="Center">
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
            </Items>
        </ext:Viewport>
    </form>
</body>
</html>
