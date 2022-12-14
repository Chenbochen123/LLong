<%@ Page Language="C#" AutoEventWireup="true" CodeFile="UploadStorageOutToSap.aspx.cs" Inherits="Plugins_Storage_SapInterface_UploadStorageOutToSap" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>SAP成品胎退库</title>
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
                Ext.Msg.confirm("提示", '您确定需要删除未上传的退库信息吗？', function (btn) { commandcolumn_direct_delete(btn, record) });
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
                Ext.Msg.confirm("提示", '您确认要上报选中的退库信息吗？', function (btn) {
                    if (btn != "yes") {
                        return;
                    }
                    var box = App.CheckboxSelectionModel1.selected.items;
                    var e = new Array();
                    for (var i = 0 ; i < box.length; i++) {
                        if (box[i].data.SUCCESS_FLAG == "") {
                            Ext.Msg.alert("提示", "所选数据不能包含合计信息！");
                            return;
                        }
                    }
                    for (var i = 0 ; i < box.length; i++) {
                        if (box[i].data.SUCCESS_FLAG == "上传中" || box[i].data.SUCCESS_FLAG == "上传成功") {
                            Ext.Msg.alert("提示", "所选数据包含已上传信息！");
                            return;
                        }
                        e.push(box[i].data.STORAGEINFO);
                    }
                    var arr = Ext.encode(e);
                    App.direct.upload_product_qty(isall, arr);
                });
            }
            else {

                Ext.Msg.confirm("提示", '您确认要上报全部退库信息吗？', function (btn) {
                    if (btn != "yes") {
                        return;
                    }
                    App.CheckboxSelectionModel1.selectAll();
                    var box = App.CheckboxSelectionModel1.selected.items;
                    for (var i = 0 ; i < box.length; i++) {
                        if (box[i].data.SUCCESS_FLAG == "上传中" || box[i].data.SUCCESS_FLAG == "上传成功") {
                            Ext.Msg.alert("提示", "所选数据不能包含已上传信息！");
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
                        e.push(box[i].data.STORAGEINFO);
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
            App.AddDocDate.setValue(shiftDate);
            App.AddPostDate.setValue(shiftDate);
            App.tgrAddMaterialCode.setValue("");
            App.AddQty.setValue("");
            //App.AddCbxRecBatch.setValue("");
            App.AddReciever.setValue("");
          //  App.AddCbxStoloc.setValue("");
            App.AddHeadTxt.setValue("");
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
        var on_sto_loc_change = function (sender) {//物料返回值处理
            App.direct.on_sto_loc_change(sender.getValue());
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
                                <ext:ToolbarSeparator />
                                <ext:Button runat="server" Icon="Add" Text="添加退库信息" ID="btnAdd">
                                    <ToolTips>
                                        <ext:ToolTip ID="ttAdd" runat="server" Html="点击添加退库信息" />
                                    </ToolTips>
                                    <Listeners>
                                        <Click Fn="InsertMoldingProductWindowShow" />
                                    </Listeners>
                                </ext:Button>
                                <ext:ToolbarSeparator />
                                <ext:Button runat="server" Icon="ShapesManySelect" Text="上报选中信息" ID="btnCheckStorageState">
                                    <ToolTips>
                                        <ext:ToolTip ID="ttSearch" runat="server" Html="上报选中信息" />
                                    </ToolTips>
                                    <Listeners>
                                        <Click Handler="upload_product_qty_confirm(0);" />
                                    </Listeners>
                                </ext:Button>
                                <ext:ToolbarSeparator ID="toolbarSeparator_middle" />
                                <ext:Button runat="server" Icon="ShapesMany" Text="上报全部信息" ID="btnAllStorageState">
                                    <ToolTips>
                                        <ext:ToolTip ID="ToolTip1" runat="server" Html="上报全部信息" />
                                    </ToolTips>
                                    <Listeners>
                                        <Click Handler="upload_product_qty_confirm(1);" />
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

                                <ext:ToolbarSeparator runat="server" />
                                <ext:Button runat="server" Icon="ShapesManySelect" Text="修改选中状态" ID="btnUpdateState">
                                    <ToolTips>
                                        <ext:ToolTip ID="ToolTip4" runat="server" Html="修改选中状态" />
                                    </ToolTips>
                                    <Listeners>
                                        <Click Handler="upload_state_confirm(0);" />
                                    </Listeners>
                                </ext:Button>

                                <ext:Hidden runat="server" ID="hdnSearchMaterialId" />
                                <ext:ToolbarSeparator ID="toolbarSeparator_middle_2" />
                                <%--  <ext:Button runat="server" Icon="PageWhiteExcel" Text="导出报产信息" ID="btnExport">
                                    <ToolTips>
                                        <ext:ToolTip ID="ToolTip2" runat="server" Html="点击将查询结果导出到Excel中" />
                                    </ToolTips>
                                    <Listeners>
                                        <Click Handler="$('#btnExportSubmit').click();">
                                        </Click>
                                    </Listeners>
                                </ext:Button>--%>
                                <%--<ext:ToolbarSeparator />
                                <ext:ToolbarSeparator ID="toolbarSeparator_end" />--%>
                                <ext:ToolbarSpacer runat="server" ID="toolbarSpacer_end" />
                                <ext:ToolbarFill ID="toolbarFill_end" />
                            </Items>
                        </ext:Toolbar>
                    </TopBar>
                </ext:Panel>
                <ext:GridPanel ID="pnlList" runat="server" Region="Center">
                    <View>
                        <ext:GridView EnableTextSelection="true" PreserveScrollOnRefresh="true" />
                    </View>
                    <Store>
                        <ext:Store ID="store" runat="server" PageSize="50">
                            <Proxy>
                                <ext:PageProxy DirectFn="App.direct.GridPanelBindData" />
                            </Proxy>
                            <Model>
                                <ext:Model ID="model" runat="server" IDProperty="STORAGEINFO">
                                    <Fields>
                                        <ext:ModelField Name="OBJID" />
                                        <ext:ModelField Name="STORAGEINFO" />
                                        <ext:ModelField Name="SUCCESS_FLAG" />
                                        <ext:ModelField Name="POST_DATE" />
                                        <ext:ModelField Name="DOC_DATE" />
                                        <ext:ModelField Name="MATERIAL_NAME" />
                                        <ext:ModelField Name="MATERIAL_ID" />
                                        <ext:ModelField Name="QTY" />
                                        <ext:ModelField Name="MES_QTY" />
                                        <ext:ModelField Name="SHIFT_NAME" />
                                        <ext:ModelField Name="SHIFT_DATE" />
                                        <ext:ModelField Name="SAP_CODE" />
                                        <ext:ModelField Name="HEAD_TXT" />
                                        <ext:ModelField Name="REC_STOLOC" />
                                        <ext:ModelField Name="REC_BATCH" />
                                        <ext:ModelField Name="RECIEVER" />
                                        <ext:ModelField Name="HEAD_TXT" />
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
                            <ext:DateColumn ID="SHIFT_DATE" runat="server" Text="入库日期" DataIndex="SHIFT_DATE" Format="yyyy-MM-dd" Width="80" />
                            <ext:Column ID="POSTDATE" runat="server" Text="过账日期" DataIndex="POST_DATE" Width="80" />
                            <ext:Column ID="DOCDATE" runat="server" Text="凭证日期" DataIndex="DOC_DATE" Width="80" />
                            <ext:Column ID="SHIFT_NAME" runat="server" Text="退库班次" DataIndex="SHIFT_NAME" Width="80" />
                            <ext:Column ID="SAPCODE" runat="server" Text="SAP物料号" Selectable="true" DataIndex="SAP_CODE" Width="80" />
                            <ext:Column ID="REC_STOLOC" runat="server" Text="收货库区" Selectable="true" DataIndex="REC_STOLOC" Width="80" />
                            <ext:Column ID="MATERIALNAME" runat="server" Text="轮胎规格" DataIndex="MATERIAL_NAME" Width="300" />
                            <ext:Column ID="MESQTY" runat="server" Text="MES数量" DataIndex="MES_QTY" Width="80" />
                            <ext:Column ID="QTY" runat="server" Text="上报数量" DataIndex="QTY" Width="80" />
                            <ext:Column ID="REC_BATCH" runat="server" Text="收货批次" DataIndex="REC_BATCH" Width="80" />
                            <ext:Column ID="RECIEVER" runat="server" Text="收货人" DataIndex="RECIEVER" Width="80" />
                            <ext:Column ID="HEAD_TXT" runat="server" Text="凭证抬头文本" DataIndex="HEAD_TXT" Width="80" />
                            <ext:CommandColumn ID="commandCol" runat="server" Width="120" Text="操作" Align="Center">
                                <Commands>                                
                                    <ext:GridCommand Icon="Delete" CommandName="Delete" Text="删除">
                                    </ext:GridCommand>
                                </Commands>
                                <PrepareToolbar Fn="prepareToolbar" />
                                <Listeners>
                                    <Command Handler="return commandcolumn_click(command, record);" />
                                </Listeners>
                            </ext:CommandColumn>
                        
                        </Columns>
                    </ColumnModel>
                    <SelectionModel>
                        <ext:CheckboxSelectionModel ID="CheckboxSelectionModel1" runat="server" Mode="Multi" />
                    </SelectionModel>
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
                   <ext:Panel ID="pnlDetail" runat="server" Region="South" Title="凭证信息" Height="200" Icon="Basket" Layout="Fit" Collapsible="true"
                    Split="true" MarginsSummary="0 5 5 5">
                    <Items>
                        <ext:GridPanel ID="GridPanel1" runat="server" MarginsSummary="0 5 5 5">
                            <Store>
                                <ext:Store ID="storeDetail" runat="server" PageSize="10">
                                    <Model>
                                        <ext:Model ID="model1" runat="server" IDProperty="OBJID">
                                            <Fields>
                                                <ext:ModelField Name="OBJID" />
                                                <ext:ModelField Name="BUSID" />
                                                <ext:ModelField Name="SUCCESS_FLAG" />
                                                <ext:ModelField Name="RETURN_MSG" />
                                                <ext:ModelField Name="RECORD_TIME" Type="Date" />
                                            </Fields>
                                        </ext:Model>
                                    </Model>
                                    <Parameters>
                                        <ext:StoreParameter Name="OBJID" Mode="Raw" Value="#{pnlList}.getSelectionModel().hasSelection() ? #{pnlList}.getSelectionModel().getSelection()[0].data.OBJID : -1" />
                                    </Parameters>
                                </ext:Store>
                            </Store>
                            <ColumnModel ID="ColumnModel1" runat="server">
                                <Columns>
                                    <ext:Column ID="BUSID" runat="server" Text="MES业务代码" DataIndex="BUSID" Width="200" />
                                    <ext:Column ID="SUCCESS_FLAG1" runat="server" Text="返回标识" DataIndex="SUCCESS_FLAG" />
                                    <ext:Column ID="Column1" runat="server" Text="返回消息" DataIndex="RETURN_MSG" Width="200" />
                                    <ext:DateColumn ID="RECORD_TIME" runat="server" Text="上传时间" DataIndex="RECORD_TIME" Format="yyyy-MM-dd HH:mm:ss" Width="200" />
                                </Columns>
                            </ColumnModel>
                            <%--  <SelectionModel>
                                <ext:RowSelectionModel ID="rowSelectMuti" runat="server" Mode="Single">
                                    <Listeners>
                                        <Select Handler="#{store}.reload();" Buffer="250" />
                                    </Listeners>
                                </ext:RowSelectionModel>
                            </SelectionModel>--%>
                        </ext:GridPanel>
                    </Items>
                </ext:Panel>
                <ext:Window ID="winAddProduct" runat="server" Icon="MonitorAdd" Closable="true"
                    Title="添加入库信息" Width="360" Height="360" Resizable="false" Hidden="true" Modal="true"
                    BodyStyle="background-color:#fff;" BodyPadding="5" Layout="FitLayout">
                    <Items>
                        <ext:FormPanel ID="FormPanel1" runat="server" Flex="1" BodyPadding="5">
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
                                <ext:DateField runat="server" ID="AddPostDate" FieldLabel="过账日期" ReadOnly="true" Editable="false" LabelAlign="Right" />
                                <ext:DateField runat="server" ID="AddDocDate" FieldLabel="凭证日期" ReadOnly="true" Editable="false" LabelAlign="Right" />
                                <ext:ComboBox runat="server" ID="AddShift" FieldLabel="退库班次" LabelAlign="Right" />
                                <ext:TriggerField runat="server" ID="tgrAddMaterialCode" FieldLabel="轮胎规格" Editable="false" LabelAlign="Right">
                                    <Triggers>
                                        <ext:FieldTrigger Icon="Clear" Qtip="清空" />
                                        <ext:FieldTrigger Icon="Search" Qtip="查找" />
                                    </Triggers>
                                    <Listeners>
                                        <TriggerClick Handler="return tgrSearchMaterialCode_Click(item,trigger,index);" />
                                    </Listeners>
                                </ext:TriggerField>
                                <ext:ComboBox runat="server" ID="AddCbxStoLoc" FieldLabel="收货库区" LabelAlign="Right" >
                                    <Listeners>
                                        <Change Fn="on_sto_loc_change" />
                                    </Listeners>
                                </ext:ComboBox>
                                <ext:TextField runat="server" ID="AddQty" FieldLabel="退库数量" LabelAlign="Right" />
                                <ext:ComboBox runat="server" ID="AddCbxRecBatch" FieldLabel="收货批次" LabelAlign="Right" />
                                <ext:TextField runat="server" ID="AddReciever" FieldLabel="收货人" LabelAlign="Right" />
                                <ext:TextField runat="server" ID="AddHeadTxt" FieldLabel="凭证抬头文本" LabelAlign="Right" />
                            </Items>
                        </ext:FormPanel>
                    </Items>
                    <Buttons>
                        <ext:Button ID="Button2" runat="server" Text="确定" Disabled="false">
                            <DirectEvents>
                                <Click OnEvent="btnAddOK_Click"></Click>
                            </DirectEvents>
                        </ext:Button>
                    </Buttons>
                </ext:Window>
            </Items>
        </ext:Viewport>
    </form>
</body>
</html>
