<%@ page language="C#" autoeventwireup="true" inherits="Plugins_Main_SysTask_TaskRemind, Mesnac.Main.WebSite" %>
<%@ Register Assembly="Ext.Net" Namespace="Ext.Net" TagPrefix="ext" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>待办任务</title>
    <link rel="Stylesheet" type="text/css" href="<%= Page.ResolveUrl("~/") %>resources/css/ext-chinese-font.css" />
    <link rel="Stylesheet" type="text/css" href="<%= Page.ResolveUrl("~/") %>resources/css/main.css" />
    <script type="text/javascript">
        var thisDirUrl = "<%= Page.ResolveUrl("./") %>";
        var thisRootUrl = "<%= Page.ResolveUrl("~/") %>";
    </script>
    <script type="text/javascript" src="<%= Page.ResolveUrl("~/") %>resources/js/jquery-1.7.1.js"></script>
    <script type="text/javascript">
        //点击删除按钮
        var commandcolumn_direct_done = function (btn, record) {
            if (btn != "yes") {
                return;
            }
            var ObjId = record.data.OBJID;
            App.direct.commandcolumn_direct_done(ObjId, {
                success: function (result) {
                    Ext.Msg.alert('操作', result);
                },

                failure: function (errorMsg) {
                    Ext.Msg.alert('操作', errorMsg);
                }
            });
        }

        //区分完成操作，并进行二次确认操作
        var commandcolumn_click_confirm = function (command, record) {
            if (command.toLowerCase() == "done") {
                Ext.Msg.confirm("提示", '您确定需要删除此条信息？', function (btn) { commandcolumn_direct_done(btn, record) });
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

        //历史查询根据DeleteFlag的值进行样式绑定
        var SetRowClass = function (record, rowIndex, rowParams, store) {
            if (record.get("DELETE_FLAG") == "1") {
                return "x-grid-row-collapsedGreen";
            }
        }

        var FinishStateFn = function myfunction() {

        }
    </script>
    <script type="text/javascript">
        var FinishStateFn = function (value) {
            return Ext.String.format((value > 0) ? "完成" : "未完成");
        };
        var ImportantLevelFn = function (value) {
            var result = "";
            switch (value) {
                case 1: result = "次要";
                    break;
                case 2: result = "一般";
                    break;
                case 3: result = "重要";
                    break;
                case 4: result = "紧急";
                    break;
                default:
            }
            return result;
        };
        //历史查询的每行按钮准备加载
        var prepareToolbar = function (grid, toolbar, rowIndex, record) {
            if (record.get("DELETE_FLAG") == "1") {
                toolbar.items.getAt(0).hide();
            }
        }
    </script>
</head>
<body>
    <form id="fmUser" runat="server">
        <ext:ResourceManager ID="rmUser" runat="server" />
        <ext:Viewport ID="vwUnit" runat="server" Layout="border">
            <Items>
                <ext:GridPanel ID="pnlList" runat="server" Region="Center">
                    <Store>
                        <ext:Store ID="store" runat="server" PageSize="10">
                            <Proxy>
                                <ext:PageProxy DirectFn="App.direct.GridPanelBindData" />
                            </Proxy>
                            <Model>
                                <ext:Model ID="model" runat="server">
                                    <Fields>
                                        <ext:ModelField Name="OBJID" />
                                        <ext:ModelField Name="EVENT_NAME" />
                                        <ext:ModelField Name="EVENT_TIME" />
                                        <ext:ModelField Name="EVENT_CONTENT" />
                                        <ext:ModelField Name="CREATE_USER_ID" />
                                        <ext:ModelField Name="RECEIVE_USER_ID" />
                                        <ext:ModelField Name="IMPORTANT_LEVEL" />
                                        <ext:ModelField Name="DELETE_FLAG" />
                                    </Fields>
                                </ext:Model>
                            </Model>
                        </ext:Store>
                    </Store>
                    <ColumnModel ID="colModel" runat="server">
                        <Columns>
                            <ext:RowNumbererColumn ID="rowNumCol" Width="45" runat="server" />
                            <ext:Column ID="OBJID" runat="server" Text="编号" DataIndex="OBJID" Width="60" Hidden="true" />
                            <ext:Column ID="EVENT_NAME" runat="server" Text="标题" DataIndex="EVENT_NAME" Width="120" />
                            <ext:DateColumn Format="yyyy-MM-dd hh:mm:ss" ID="EVENT_TIME" runat="server" Text="时间" DataIndex="EVENT_TIME" Width="130" />
                            <ext:Column ID="EVENT_CONTENT" runat="server" Text="内容" DataIndex="EVENT_CONTENT" Width="150" />
                            <ext:Column ID="CREATE_USER_ID" runat="server" Text="发送人" DataIndex="CREATE_USER_ID" Width="60" />
                            <ext:Column ID="RECEIVE_USER_ID" runat="server" Text="接收人" DataIndex="RECEIVE_USER_ID" Width="60" />
                            <ext:Column ID="IMPORTANT_LEVEL" runat="server" Text="重要等级" DataIndex="IMPORTANT_LEVEL" Width="60" >
                                <Renderer Fn="ImportantLevelFn"/>
                            </ext:Column>
                            <ext:Column ID="DELETE_FLAG" runat="server" Text="完成标志" DataIndex="DELETE_FLAG" Width="60" >
                                <Renderer Fn="FinishStateFn"/>
                            </ext:Column>
                            <ext:CommandColumn ID="commandCol" runat="server" Width="60" Text="操作" Align="Center">
                                <Commands>
                                    <ext:GridCommand Icon="Accept" CommandName="Done" Text="完成">
                                        <ToolTip Text="完成任务" />
                                    </ext:GridCommand>
                                </Commands>
                                <PrepareToolbar Fn="prepareToolbar" />
                                <Listeners>
                                    <Command Handler="return commandcolumn_click(command, record);" />
                                </Listeners>
                            </ext:CommandColumn>
                        </Columns>
                    </ColumnModel>
                    <View>
                        <ext:GridView ID="gvRows" runat="server">
                            <GetRowClass Fn="SetRowClass" />
                        </ext:GridView>
                    </View>
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

