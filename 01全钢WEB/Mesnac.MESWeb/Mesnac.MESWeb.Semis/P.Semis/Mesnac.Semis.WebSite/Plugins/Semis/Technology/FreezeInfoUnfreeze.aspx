<%@ Page Language="C#" AutoEventWireup="true" CodeFile="FreezeInfoUnfreeze.aspx.cs" Inherits="Plugins_Semis_FreezeInfoUnfreeze" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>条码解冻</title>
    <script type="text/javascript" src="<%= Page.ResolveUrl("~/") %>resources/js/jquery-1.7.1.js"></script>
    <link rel="Stylesheet" type="text/css" href="<%= Page.ResolveUrl("~/") %>resources/css/ext-chinese-font.css" />
    <link rel="Stylesheet" type="text/css" href="<%= Page.ResolveUrl("~/") %>resources/css/main.css" />
    <style type="text/css">
        .x-grid-row-collapsed .x-grid-cell {
            background-color: #B0FFBA !important;
        }
        /*21位原材料，18位胶料或小料车条码，17位半制品，10位C开头硫化，10位不是C开头成型*/
    </style>
    <script type="text/javascript">

        var pnlListFresh = function () {
            if (App.txtBarcode.getValue() == '' && (App.txtBeginDate.getValue() == null || App.txtEndDate.getValue() == null)) {
                Ext.Msg.alert('提示', '请填写条码号或日期');
                return;
            }
            //App.pnlList.store.reload();
            App.direct.SelectData(
                App.txtBarcode.getValue(),
                App.ComboBox1.getValue(),
                App.txtBeginDate.getRawValue(),
                App.txtEndDate.getRawValue(),
                {
                    eventMask: {
                        showMask: true,
                        target: 'customtarget',
                        customTarget: 'pnlList',
                    },
                    timeOut: 180000
                });
            return false;
        }

        var btnUnfreezeClick = function () {
            let select = App.pnlList.getSelectionModel().getSelection().map(item => item.data);
            if (select.length == 0) {
                Ext.Msg.alert('提示', '请选择数据');
                return;
            }

            Ext.Msg.confirm("提示", '您确定需要解冻吗？', function (btn) {
                if (btn != "yes") {
                    return;
                }

                let rawData = select.map(item => item.BARCODE).filter(item => item.length == 21),
                    rubberData = select.map(item => item.BARCODE).filter(item => item.length == 18),
                    semisData = select.map(item => item.BARCODE).filter(item => item.length == 17),
                    greentyreData = select.map(item => item.BARCODE).filter(item => item.length == 10);
                    //greentyreData = select.map(item => item.BARCODE).filter(item => item.length == 10 && !item.startsWith('C')),
                    //tyreData = select.map(item => item.BARCODE).filter(item => item.length == 10 && item.startsWith('C'));
                App.direct.UnfreezeData(
                    rawData, rubberData, semisData, greentyreData, select.map(item => item.BARCODE), {
                        success: function (result) {
                            if (result != '') {
                                Ext.Msg.alert('提示', result);
                            }
                        },
                        failure: function (msg) {
                            Ext.Msg.alert('错误', msg);
                        },
                        eventMask: {
                            showMask: true,
                            target: 'customtarget',
                            customTarget: 'vpDefect',
                        },
                        timeOut: 180000
                    }
                );
            });
        }

        var commandcolumn_click = function (command, record) {
            commandcolumn_click_confirm(command, record);
            return false;
        };

        //区分删除操作，并进行二次确认操作
        var commandcolumn_click_confirm = function (command, record) {

            if (command.toLowerCase() == "delete") {
                Ext.Msg.confirm("提示", '您确定要删除此条信息吗？', function (btn) { commandcolumn_direct_deletedefect(btn, record) });
            }
            return false;
        };

        var prepareToolbar = function (grid, toolbar, rowIndex, record) {
            var firstButton = toolbar.items.get(0);

            if (record.data.DELETE_FLAG == 1 || record.data.MARK_FLAG != 2) {
                firstButton.hide();
            }
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
        <ext:ResourceManager ID="rmDefect" runat="server" />
        <ext:Viewport ID="vpDefect" runat="server" Layout="border">
            <Items>
                <ext:Panel ID="pnDefect" runat="server" Region="North">
                    <TopBar>
                        <ext:Toolbar runat="server" ID="tbDefect">
                            <Items>
                                <ext:Button runat="server" Icon="Find" Text="查询" ID="btnSearch">
                                    <Listeners>
                                        <Click Fn="pnlListFresh">
                                        </Click>
                                    </Listeners>
                                </ext:Button>
                                <ext:Button runat="server" Icon="Delete" Text="解冻" ID="btnUnfreeze">
                                    <Listeners>
                                        <Click Fn="btnUnfreezeClick" />
                                    </Listeners>
                                </ext:Button>
                                <ext:ToolbarSeparator ID="tsEnd" />
                                <ext:ToolbarSpacer runat="server" ID="tspacerEnd" />
                                <ext:ToolbarFill ID="tfEnd" />
                            </Items>
                        </ext:Toolbar>
                    </TopBar>
                    <Items>
                        <ext:FormPanel ID="container_top" runat="server" Layout="ColumnLayout" AutoHeight="true"
                            Collapsible="false">
                            <Items>
                                <ext:Container ID="container2" runat="server" Layout="FormLayout" ColumnWidth=".25">
                                    <Items>
                                        <ext:TextField ID="txtBarcode" runat="server" FieldLabel="条码号" LabelAlign="Right" />
                                    </Items>
                                </ext:Container>
                                <ext:Container ID="container5" runat="server" Layout="FormLayout" ColumnWidth=".25">
                                    <Items>
                                        <ext:ComboBox ID="ComboBox1" runat="server" FieldLabel="条码类型" LabelAlign="Right">
                                            <Items>
                                                <ext:ListItem Text="原材料" Value="21" />
                                                <ext:ListItem Text="胶料/小料" Value="18" />
                                                <ext:ListItem Text="半制品" Value="17" />
                                                <ext:ListItem Text="胎胚/成品胎" Value="10" />
                                            </Items>
                                            <SelectedItems>
                                                <ext:ListItem Value="21" />
                                            </SelectedItems>

                                        </ext:ComboBox>
                                    </Items>
                                </ext:Container>
                                <ext:Container ID="container1" runat="server" Layout="FormLayout" ColumnWidth=".25">
                                    <Items>
                                        <ext:DateField ID="txtBeginDate" runat="server" FieldLabel="冻结开始日期" LabelAlign="Right" Type="Date" Format="yyyy-MM-dd" />
                                    </Items>
                                </ext:Container>
                                <ext:Container ID="container3" runat="server" Layout="FormLayout" ColumnWidth=".25">
                                    <Items>
                                        <ext:DateField ID="txtEndDate" runat="server" FieldLabel="结束日期" LabelAlign="Right" Type="Date" Format="yyyy-MM-dd" />
                                    </Items>
                                </ext:Container>
                            </Items>
                        </ext:FormPanel>
                    </Items>
                </ext:Panel>
                <ext:GridPanel ID="pnlList" runat="server" Region="Center" Header="false">
                    <View>
                        <ext:GridView EnableTextSelection="true"></ext:GridView>
                    </View>
                    <Store>
                        <ext:Store ID="store" runat="server">
                            <Model>
                                <ext:Model ID="model" runat="server">
                                    <Fields>
                                        <ext:ModelField Name="OBJID" />
                                        <ext:ModelField Name="RECORD_TIME" />
                                        <ext:ModelField Name="RECORD_USER_ID" />
                                        <ext:ModelField Name="USER_NAME" />
                                        <ext:ModelField Name="BARCODE" />
                                        <ext:ModelField Name="DELETE_FLAG" />
                                        <ext:ModelField Name="MARK_FLAG" />
                                        <ext:ModelField Name="MARK_FLAG_STATUS" />
                                        <ext:ModelField Name="REASON_ID" />
                                        <ext:ModelField Name="REASON_NAME" />
                                        <ext:ModelField Name="REMARK" />
                                        <ext:ModelField Name="MATERIAL_CODE" />
                                        <ext:ModelField Name="MATERIAL_NAME" />
                                        <ext:ModelField Name="EQUIP_NAME" />
                                    </Fields>
                                </ext:Model>
                            </Model>
                        </ext:Store>
                    </Store>
                    <ColumnModel ID="colModel" runat="server">
                        <Columns>
                            <ext:RowNumbererColumn ID="rowNumCol1" runat="server" Width="35" />
                            <ext:Column runat="server" Text="编码" DataIndex="OBJID" Width="60" Visible="false" />
                            <ext:Column runat="server" Text="条码号" DataIndex="BARCODE" Width="150" />
                            <ext:Column runat="server" Text="物料编码" DataIndex="MATERIAL_CODE" Width="120" />
                            <ext:Column runat="server" Text="物料名称" DataIndex="MATERIAL_NAME" Width="200" />
                            <ext:Column runat="server" Text="生产机台" DataIndex="EQUIP_NAME" />
                            <ext:Column runat="server" Text="锁定/冻结" DataIndex="MARK_FLAG_STATUS" />
                            <ext:Column runat="server" Text="锁定/冻结原因" DataIndex="REASON_NAME" />
                            <ext:Column runat="server" Text="记录人" DataIndex="USER_NAME" />
                            <ext:DateColumn runat="server" Text="记录时间" DataIndex="RECORD_TIME" Format="yyyy-MM-dd HH:mm:ss" Width="120" />
                            <%--<ext:CommandColumn ID="commandCol" runat="server" Width="90" Text="操作" Align="Center">
                                <Commands>
                                    <ext:GridCommand Icon="Delete" CommandName="Delete" Text="解冻" />
                                </Commands>
                                <PrepareToolbar Fn="prepareToolbar" />
                                <Listeners>
                                    <Command Handler="return commandcolumn_click(command, record);" />
                                </Listeners>

                            </ext:CommandColumn>--%>
                        </Columns>
                    </ColumnModel>
                    <SelectionModel>
                        <ext:CheckboxSelectionModel AllowDeselect="true" IgnoreRightMouseSelection="true" Mode="Multi" />
                    </SelectionModel>
                    <%-- <BottomBar>
                        <ext:PagingToolbar runat="server"/>
                    </BottomBar>--%>
                </ext:GridPanel>
            </Items>
        </ext:Viewport>
    </form>
</body>
</html>
