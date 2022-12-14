<%@ Page Language="C#" AutoEventWireup="true" CodeFile="WMSRecordInfo.aspx.cs" Inherits="Plugins_Storage_WMSRecordInfo" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>WMS数据查询</title>
    <link rel="Stylesheet" type="text/css" href="<%= Page.ResolveUrl("~/") %>resources/css/ext-chinese-font.css" />
    <link rel="Stylesheet" type="text/css" href="<%= Page.ResolveUrl("~/") %>resources/css/main.css" />
    <script type="text/javascript">
        var thisDirUrl = "<%= Page.ResolveUrl("./") %>";
        var thisRootUrl = "<%= Page.ResolveUrl("~/") %>";
    </script>
    <script type="text/javascript" src="<%= Page.ResolveUrl("~/") %>resources/js/jquery-1.7.1.js"></script>
    <script type="text/javascript">
        //-------物料-----查询带回弹出框--BEGIN
        var McUI_SearchBox_SearchBoxSbmMaterialSemis_Request = function (record) {//物料返回值处理
            App.txt_material.getTrigger(0).show();
            App.txt_material.setValue(record.data.MATERIAL_NAME);
            App.hidden_txt_material.setValue(record.data.OBJID);
        }

        var SelectMaterial = function (field, trigger, index) {//物料查询
            switch (index) {
                case 0:
                    field.getTrigger(0).hide();
                    field.setValue('');
                    App.hidden_txt_material.setValue("");
                    field.getEl().down('input.x-form-text').setStyle('background', "white");
                    break;
                case 1:
                    App.McUI_SearchBox_SearchBoxSbmMaterialSemis_Window.show();
                    break;
            }
        }

        var UpdateDepartment = function (field, trigger, index) {//物料查询
            App.McUI_SearchBox_SearchBoxSbmMaterialSemis_Window.show();
        }
        Ext.create("Ext.window.Window", {//物料查询带回窗体
            id: "McUI_SearchBox_SearchBoxSbmMaterialSemis_Window",
            height: 430,
            hidden: true,
            width: 360,
            html: "<iframe src='" + thisRootUrl + "McUI/SearchBox/SearchBoxSbmMaterialSemis.aspx' width=100% height=100% scrolling=no  frameborder=0></iframe>",
            bodyStyle: "background-color: #fff;",
            closable: true,
            title: "请选择物料",
            modal: true
        })
        //------------查询带回弹出框--END 
    </script>

    <script type="text/javascript">

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

        //点击恢复按钮
        var commandcolumn_direct_recover = function (btn, record) {
            if (btn != "yes") {
                return;
            }
            var ObjId = record.data.OBJID;
            App.direct.commandcolumn_direct_recover(ObjId, {
                success: function (result) {
                },

                failure: function (errorMsg) {
                    Ext.Msg.alert('操作', errorMsg);
                }
            });
        }

        //点击删除按钮
        var commandcolumn_direct_delete = function (btn, record) {
            if (btn != "yes") {
                return;
            }
            var ObjId = record.data.OBJID;
            App.direct.commandcolumn_direct_delete(ObjId, {
                success: function (result) {
                    Ext.Msg.alert('操作', result);
                },

                failure: function (errorMsg) {
                    Ext.Msg.alert('操作', errorMsg);
                }
            });
        }


        //点击删除密码按钮
        var commandcolumn_direct_deletepwd = function (btn, record) {
            if (btn != "yes") {
                return;
            }
            var ObjId = record.data.OBJID;
            App.direct.commandcolumn_direct_deletepwd(ObjId, {
                success: function (result) {
                    Ext.Msg.alert('操作', result);
                },

                failure: function (errorMsg) {
                    Ext.Msg.alert('操作', errorMsg);
                }
            });
        }

        //点击初始化密码按钮
        var commandcolumn_direct_initpwd = function (btn, record) {
            if (btn != "yes") {
                return;
            }
            var ObjId = record.data.OBJID;
            App.direct.commandcolumn_direct_initpwd(ObjId, {
                success: function (result) {
                    Ext.Msg.alert('操作', result);
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
                Ext.Msg.confirm("提示", '您确定需要删除此条信息？', function (btn) { commandcolumn_direct_delete(btn, record) });
            }
            if (command.toLowerCase() == "recover") {
                Ext.Msg.confirm("提示", '您确定需要恢复此条信息？', function (btn) { commandcolumn_direct_recover(btn, record) });
            }
            if (command.toLowerCase() == "deletepwd") {
                Ext.Msg.confirm("提示", '您确定需要禁止该用户登录系统？', function (btn) { commandcolumn_direct_deletepwd(btn, record) });
            }
            if (command.toLowerCase() == "initpwd") {
                Ext.Msg.confirm("提示", '您确定需要初始化密码？', function (btn) { commandcolumn_direct_initpwd(btn, record) });
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
            App.hidden_delete_flag.setValue("0");
            App.store.currentPage = 1;
            App.pageToolBar.doRefresh();
            return false;
        }

        //历史查询按钮点击列表刷新数据重载方法
        var pnlHistoryListFresh = function () {
            App.hidden_delete_flag.setValue("");
            App.store.currentPage = 1;
            App.pageToolBar.doRefresh();
            return false;
        }

        //历史查询的每行按钮准备加载
        var prepareToolbar = function (grid, toolbar, rowIndex, record) {
            if (record.get("DELETE_FLAG") == "1") {
                toolbar.items.getAt(0).hide();
                toolbar.items.getAt(1).hide();
                toolbar.items.getAt(2).hide();
            } else {
                toolbar.items.getAt(3).hide();
            }
        }
    </script>
</head>
<body>
    <form id="fmUser" runat="server">
        <asp:Button ID="btnExportSubmit" Style="display: none" runat="server" Text="Button"
            OnClick="btnExportSubmit_Click" />
        <ext:ResourceManager ID="ResourceManager1" runat="server" />
        <ext:Viewport ID="Viewport1" runat="server" Layout="border">
            <Items>
                <ext:Panel ID="pnlQueryTitle" runat="server" Region="North" AutoHeight="true">
                    <TopBar>
                        <ext:Toolbar runat="server" ID="barUser">
                            <Items>
                                <ext:Button runat="server" Icon="Find" Text="查询信息" ID="btnSearch">
                                    <ToolTips>
                                        <ext:ToolTip ID="ttSearch" runat="server" Html="点击进行查询" />
                                    </ToolTips>
                                    <Listeners>
                                        <Click Fn="pnlListFresh">
                                        </Click>
                                    </Listeners>
                                </ext:Button>
                                <ext:ToolbarSeparator ID="toolbarSeparator_middle" />
                                <ext:Hidden ID="hidden_delete_flag" runat="server" Text="0" />
                                <ext:Button runat="server" Icon="PageWhiteExcel" Text="导出查询结果" ID="btnExport">
                                    <ToolTips>
                                        <ext:ToolTip ID="ToolTip2" runat="server" Html="点击将查询结果导出到Excel中" />
                                    </ToolTips>
                                    <Listeners>
                                        <Click Handler="$('#btnExportSubmit').click();">
                                        </Click>
                                    </Listeners>
                                </ext:Button>
                                <ext:ToolbarSeparator ID="toolbarSeparator_end" />
                                <ext:ToolbarSpacer runat="server" ID="toolbarSpacer_end" />
                                <ext:ToolbarFill ID="toolbarFill_end" />
                            </Items>
                        </ext:Toolbar>
                    </TopBar>
                    <Items>
                        <ext:Panel ID="pnlQuery" runat="server" AutoHeight="true">
                            <Items>
                                <ext:FormPanel ID="container_top" runat="server" Layout="ColumnLayout" AutoHeight="true">
                                    <Items>
                                        <ext:Container ID="container_1" runat="server" Layout="FormLayout" ColumnWidth=".33"
                                            Padding="5">
                                            <Items>
                                                <ext:FieldContainer runat="server" FieldLabel="开始时间" Layout="HBoxLayout" LabelAlign="Right">
                                                    <Items>
                                                        <ext:DateField ID="txtBeginDate" runat="server" Flex="1" Editable="false" />
                                                        <ext:TimeField ID="txtBeginTime" runat="server" Editable="true" />
                                                    </Items>
                                                </ext:FieldContainer>
                                                <ext:TextField runat="server" ID="txtCardNo" LabelAlign="Right" FieldLabel="条码号">
                                                </ext:TextField>
                                                <ext:TextField runat="server" ID="txtsap" LabelAlign="Right" FieldLabel="SAP号">
                                                </ext:TextField>
                                            </Items>
                                        </ext:Container>
                                        <ext:Container ID="container_2" runat="server" Layout="FormLayout" ColumnWidth=".33"
                                            Padding="5">
                                            <Items>
                                                <ext:FieldContainer runat="server" FieldLabel="结束时间" Layout="HBoxLayout" LabelAlign="Right">
                                                    <Items>
                                                        <ext:DateField ID="txtEndDate" runat="server" Flex="1" Editable="false" />
                                                        <ext:TimeField ID="txtEndTime" runat="server" Editable="true" />
                                                    </Items>
                                                </ext:FieldContainer>
                                                <%--<ext:TextField runat="server" ID="txtShelf" LabelAlign="Right" FieldLabel="工装架子号">
                                                </ext:TextField>--%>
                                                <ext:ComboBox ID="cbxisStore" runat="server" FieldLabel="是否入库" LabelAlign="left"
                                                    Editable="false">
                                                    <Items>
                                                        <ext:ListItem Text="全部" Value="2">
                                                        </ext:ListItem>
                                                        <ext:ListItem Text="是" Value="1">
                                                        </ext:ListItem>
                                                        <ext:ListItem Text="否" Value="0">
                                                        </ext:ListItem>
                                                    </Items>
                                                    <Listeners>
                                                        <TriggerClick Handler="this.setValue('');" />
                                                    </Listeners>
                                                </ext:ComboBox>
                                            </Items>
                                        </ext:Container>
                                        <ext:Container ID="container1" runat="server" Layout="FormLayout" ColumnWidth=".33"
                                            Padding="5">
                                            <Items>
                                                <ext:ComboBox ID="cbxlock" runat="server" FieldLabel="是否锁定" LabelAlign="left"
                                                    Editable="false">
                                                    <Items>
                                                        <ext:ListItem Text="全部" Value="2">
                                                        </ext:ListItem>
                                                        <ext:ListItem Text="是" Value="1">
                                                        </ext:ListItem>
                                                        <ext:ListItem Text="否" Value="0">
                                                        </ext:ListItem>
                                                    </Items>
                                                    <Listeners>
                                                        <TriggerClick Handler="this.setValue('');" />
                                                    </Listeners>
                                                </ext:ComboBox>
                                                <ext:ComboBox ID="cbxshiyan" runat="server" FieldLabel="是否实验胎" LabelAlign="left"
                                                    Editable="false">
                                                    <Items>
                                                        <ext:ListItem Text="全部" Value="2">
                                                        </ext:ListItem>
                                                        <ext:ListItem Text="是" Value="1">
                                                        </ext:ListItem>
                                                        <ext:ListItem Text="否" Value="0">
                                                        </ext:ListItem>
                                                    </Items>
                                                    <Listeners>
                                                        <TriggerClick Handler="this.setValue('');" />
                                                    </Listeners>
                                                </ext:ComboBox>
                                            </Items>
                                        </ext:Container>
                                    </Items>
                                </ext:FormPanel>
                            </Items>
                        </ext:Panel>
                    </Items>
                </ext:Panel>
                <ext:GridPanel ID="pnlList" runat="server" Region="Center">
                    <Store>
                        <ext:Store ID="store" runat="server" PageSize="15">
                            <Proxy>
                                <ext:PageProxy DirectFn="App.direct.GridPanelBindData" />
                            </Proxy>
                            <Model>
                                <ext:Model ID="model" runat="server">
                                    <Fields>
                                        <ext:ModelField Name="OBJID" />
                                        <ext:ModelField Name="WH_ID" />
                                        <ext:ModelField Name="TYRE_NO" />
                                        <ext:ModelField Name="SUB_WARE_HOUSE" />
                                        <ext:ModelField Name="ITEM_NUMBER" />
                                        <ext:ModelField Name="MATERIAL_CODE" />
                                        <ext:ModelField Name="SAP_LINE_LOC" />
                                        <ext:ModelField Name="LOT_NUMBER" />
                                        <ext:ModelField Name="MES_LOT_UP" />
                                        <ext:ModelField Name="TESTFLAG" />
                                        <ext:ModelField Name="RETURNFLAG" />
                                        <ext:ModelField Name="GRADE" />
                                        <ext:ModelField Name="WEEK" />
                                        <ext:ModelField Name="PRODUCTION_TIME" Type="Date" />
                                        <ext:ModelField Name="FLAG" />
                                        <ext:ModelField Name="LOCKFLAG" />
                                        <ext:ModelField Name="USER_NAME" />
                                        <ext:ModelField Name="RECORD_TIME" Type="Date" />
                                        <ext:ModelField Name="UPLOAD_TIME" Type="Date" />
                                        <ext:ModelField Name="RETURNSTATE" />
                                        <ext:ModelField Name="RETURNMSG" />
                                        <ext:ModelField Name="INSTORE" />
                                        <ext:ModelField Name="ISJUN" />
                                        <ext:ModelField Name="UFMRANK" />
                                    </Fields>
                                </ext:Model>
                            </Model>
                        </ext:Store>
                    </Store>
                    <ColumnModel ID="colModel" runat="server">
                        <Columns>
                            <ext:RowNumbererColumn ID="rowNumCol" Width="45" runat="server" />
                            <ext:Column ID="OBJID" runat="server" Text="编号" DataIndex="OBJID" Width="60" Hidden="true" />
                            <ext:Column ID="WH_ID" runat="server" Text="工厂" DataIndex="WH_ID" Width="100" />
                            <ext:Column ID="TYRE_NO" runat="server" Text="条码号" DataIndex="TYRE_NO" Width="100" />
                            <ext:Column ID="SUB_WARE_HOUSE" runat="server" Text="分厂" DataIndex="SUB_WARE_HOUSE" Width="100" />
                            <ext:Column ID="ITEM_NUMBER" runat="server" Text="SAP号" DataIndex="ITEM_NUMBER" Width="100" />
                            <ext:Column ID="MATERIAL_CODE" runat="server" Text="物料规格" DataIndex="MATERIAL_CODE" Width="120" />
                            <ext:Column ID="SAP_LINE_LOC" runat="server" Text="SAP线边仓" DataIndex="SAP_LINE_LOC" Width="100" />
                            <ext:Column ID="LOT_NUMBER" runat="server" Text="批次" DataIndex="LOT_NUMBER" Width="100" />
                            <ext:Column ID="MES_LOT_UP" runat="server" Text="硫化报产批次" DataIndex="MES_LOT_UP" Width="100" />
                            <ext:Column ID="TESTFLAG" runat="server" Text="实验胎标志" DataIndex="TESTFLAG" Width="100" />
                            <ext:Column ID="RETURNFLAG" runat="server" Text="复检返修标志" DataIndex="RETURNFLAG" Width="100" />
                            <ext:Column ID="Column2" runat="server" Text="是否过均匀性" DataIndex="ISJUN" Width="100" />
                            <ext:Column ID="Column3" runat="server" Text="均匀性标志" DataIndex="UFMRANK" Width="100" />
                            <ext:Column ID="GRADE" runat="server" Text="质量等级" DataIndex="GRADE" Width="100" />
                            <ext:Column ID="WEEK" runat="server" Text="周年号" DataIndex="WEEK" Width="100" />
                            <ext:DateColumn ID="PRODUCTION_TIME" runat="server" Text="硫化时间" DataIndex="PRODUCTION_TIME" Width="150" Format="yyyy-MM-dd HH:mm:ss" />
                            <ext:Column ID="FLAG" runat="server" Text="德州标识" DataIndex="FLAG" Width="100" />
                            <ext:Column ID="LOCKFLAG" runat="server" Text="锁定标志" DataIndex="LOCKFLAG" Width="100" />
                            <ext:Column ID="Column1" runat="server" Text="入库标志" DataIndex="INSTORE" Width="100" />
                            <ext:Column ID="USER_NAME" runat="server" Text="记录人" DataIndex="USER_NAME" Width="80" />
                            <ext:DateColumn ID="RECORD_TIME" runat="server" Text="记录时间" DataIndex="RECORD_TIME" Width="150" Format="yyyy-MM-dd HH:mm:ss" />
                            <ext:DateColumn ID="UPLOAD_TIME" runat="server" Text="上传时间" DataIndex="UPLOAD_TIME" Width="150" Format="yyyy-MM-dd HH:mm:ss" />
                            <ext:Column ID="RETURNSTATE" runat="server" Text="返回状态" DataIndex="RETURNSTATE" Width="80" />
                            <ext:Column ID="RETURNMSG" runat="server" Text="返回消息" DataIndex="RETURNMSG" Width="100" />
                            <ext:CommandColumn ID="commandCol" runat="server" Width="60" Text="操作" Align="Center" Hidden="true">
                                <Commands>
                                    <ext:GridCommand Icon="TableEdit" CommandName="Edit" Text="修改">
                                        <ToolTip Text="修改本条数据" />
                                    </ext:GridCommand>
                                    <ext:CommandSeparator />
                                    <ext:GridCommand Icon="Delete" CommandName="Delete" Text="删除" Hidden="true">
                                        <ToolTip Text="删除本条数据" />
                                    </ext:GridCommand>
                                    <ext:GridCommand Icon="Accept" CommandName="Recover" Text="恢复" Hidden="true">
                                        <ToolTip Text="恢复本条数据" />
                                    </ext:GridCommand>
                                </Commands>
                                <PrepareToolbar Fn="prepareToolbar" />
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
                </ext:GridPanel>
            </Items>
        </ext:Viewport>
    </form>
</body>
</html>
