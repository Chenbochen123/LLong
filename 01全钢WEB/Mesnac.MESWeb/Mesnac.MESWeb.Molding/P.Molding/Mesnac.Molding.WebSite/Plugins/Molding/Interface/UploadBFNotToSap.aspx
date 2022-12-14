<%@ Page Language="C#" AutoEventWireup="true" CodeFile="UploadBFNotToSap.aspx.cs" Inherits="Plugins_Molding_Interface_UploadBFNotToSap" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>胎胚判废单</title>
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
        //点击修改按钮
        var commandcolumn_direct_edit = function (record) {
            if (record.data.SUCCESS_FLAG != "新建") {
                Ext.Msg.alert('提示', "信息已上传，无法修改！");
                return;
            }
            var ObjId = record.data.OBJID;
            var PostDate = record.data.POST_DATE;
            var DocDate = record.data.DOC_DATE;
            var MaterialId = record.data.MATERIAL_ID;
            var Qty = record.data.QTY;
            var Reject_Qty = record.data.REJECT_QTY;
            var ShiftDate = record.data.SHIFT_DATE;
            var MaterialCode = record.data.MATERIAL_CODE;
            var HeadTxt = record.data.REMARK;
            debugger;
            App.direct.commandcolumn_direct_edit(ObjId, ShiftDate, MaterialCode, MaterialId, Qty, Reject_Qty, HeadTxt, {
                success: function (result) {
                    // Ext.Msg.alert('操作', result);
                    pnlListFresh();
                },

                failure: function (errorMsg) {
                    Ext.Msg.alert('操作', errorMsg);
                }
            });
        }
        var commandcolumn_direct_delete = function (btn, record) {
            if (btn != "yes") {
                return;
            }
            var ObjId = record.data.OBJID;

            debugger;
            App.direct.commandcolumn_direct_delete(ObjId, {
                success: function (result) {
                    // Ext.Msg.alert('操作', result);
                    pnlListFresh();
                },

                failure: function (errorMsg) {
                    Ext.Msg.alert('操作', errorMsg);
                }
            });
        }
        //区分删除操作，并进行二次确认操作
        var commandcolumn_click_confirm = function (command, record) {
            if (command.toLowerCase() == "edit") {
                commandcolumn_direct_edit(record);
            }
            if (command.toLowerCase() == "delete") {
                Ext.Msg.confirm("提示", '您确定需要删除未上传的产量吗？', function (btn) { commandcolumn_direct_delete(btn, record) });
            }

            return false;
        };

        //根据按钮类别进行删除和编辑操作
        var commandcolumn_click = function (command, record) {
            commandcolumn_click_confirm(command, record);
            return false;
        };

        Ext.apply(Ext.form.VTypes, {
            integer: function (val, field) {
                if (!val) {
                    return true;
                }
                try {
                    if (/^[\d]+$/.test(val)) {
                        return true;
                    }
                    else {
                        return false;
                    }
                }
                catch (e) {
                    return false;
                }
            },
            integerText: "此填入项格式为正整数"
        });


        //列表刷新数据重载方法
        var pnlListFresh = function () {
            App.pnlList.store.reload();
            return false;
        }
    </script>

    <script type="text/javascript">

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
                        if (box[i].data.SUCCESS_FLAG != "新建") {
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
                    App.direct.upload_product_qty(isall, null);
                });
            }
        };

        var upload_state_confirm = function (isall) {
            if (isall == 0) {
                Ext.Msg.confirm("提示", '您确认要修改选中的状态吗？', function (btn) {
                    if (btn != "yes") {
                        return;
                    }

                    var box = App.CheckboxSelectionModel1.selected.items;
                    var e = new Array();
                    for (var i = 0 ; i < box.length; i++) {
                        if (box[i].data.SUCCESS_FLAG == "新建") {
                            Ext.Msg.alert("提示", "所选数据包含新建信息！");
                            return;
                        }
                        if (box[i].data.SUCCESS_FLAG == "上传成功") {
                            Ext.Msg.alert("提示", "所选数据包含已上传成功信息！");
                            return;
                        }
                        e.push(box[i].data.PRODUCTINFO);
                    }
                    var arr = Ext.encode(e);
                    App.direct.upload_state(isall, arr);
                });
            }
            else {

                Ext.Msg.confirm("提示", '您确认要修改全部状态吗？', function (btn) {
                    if (btn != "yes") {
                        return;
                    }

                    App.CheckboxSelectionModel1.selectAll();
                    var box = App.CheckboxSelectionModel1.selected.items;
                    for (var i = 0 ; i < box.length; i++) {
                        if (box[i].data.SUCCESS_FLAG == "新建") {
                            Ext.Msg.alert("提示", "所选数据包含新建信息！");
                            return;
                        }
                        if (box[i].data.SUCCESS_FLAG == "上传成功") {
                            Ext.Msg.alert("提示", "所选数据包含已上传成功信息！");
                            return;
                        }
                    }
                    App.direct.upload_state(isall, null);
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
    </script>
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
                                <ext:DateField runat="server" ID="ShiftDate" Text="生产日期">
                                    <%-- <Listeners>
                                        <Change Fn="pnlListFresh" />
                                    </Listeners>--%>
                                </ext:DateField>
                                <ext:ComboBox runat="server" ID="cbxShift" Text="班次">
                                    <%--  <Listeners>
                                        <Change Fn="pnlListFresh" />
                                    </Listeners>--%>
                                </ext:ComboBox>
                                <ext:ToolbarSeparator />
                                <ext:Button runat="server" Icon="Find" Text="查询" Enabled="false" ID="btnSearch">
                                    <ToolTips>
                                        <ext:ToolTip ID="ToolTip2" runat="server" Html="查询MES产量" />
                                    </ToolTips>
                                    <Listeners>
                                        <Click Fn="pnlListFresh" />
                                    </Listeners>
                                </ext:Button>
                                <ext:ToolbarSeparator runat="server" />
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
                        <ext:Store ID="store" runat="server" PageSize="50">
                            <Proxy>
                                <ext:PageProxy DirectFn="App.direct.GridPanelBindData" />
                            </Proxy>
                            <Model>
                                <ext:Model ID="model" runat="server" >
                                    <Fields>
                                        <ext:ModelField Name="SHIFT_DATE" />
                                        <ext:ModelField Name="SHIFT_NAME" />
                                        <ext:ModelField Name="SAP_CODE" />
                                        <ext:ModelField Name="BOM_VER" />
                                        <ext:ModelField Name="MATERIAL_NAME" />
                                        <ext:ModelField Name="QTY" />
                                    </Fields>
                                </ext:Model>
                            </Model>
                        </ext:Store>
                    </Store>
                    <ColumnModel ID="colModel" runat="server">
                        <Columns>
                            <ext:RowNumbererColumn runat="server" />
                            <ext:DateColumn ID="SHIFT_DATE" runat="server" Text="生产日期" DataIndex="SHIFT_DATE" Format="yyyy-MM-dd" Width="120" />
                            <ext:Column ID="SHIFT_NAME" runat="server" Text="生产班次" DataIndex="SHIFT_NAME" Width="120" />
                            <ext:Column ID="SAPCODE" runat="server" Text="SAP物料号" Selectable="true" DataIndex="SAP_CODE" Width="120" />
                            <ext:Column ID="PROVERSION" runat="server" Text="BOM版本" Selectable="true" DataIndex="BOM_VER" Width="100" />
                            <ext:Column ID="MATERIALCODE" runat="server" Text="胎胚规格" DataIndex="MATERIAL_NAME" Width="300" />
                            <ext:Column ID="MESQTY" runat="server" Text="数量" DataIndex="QTY" Width="80" />
                        </Columns>
                    </ColumnModel>
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
