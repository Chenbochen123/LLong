<%@ page language="C#" autoeventwireup="true" inherits="Plugins_Semis_Technology_SemisTechParas, Mesnac.Semis.WebSite" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title></title>
    <link rel="Stylesheet" type="text/css" href="<%= Page.ResolveUrl("~/") %>resources/css/ext-chinese-font.css" />
    <link rel="Stylesheet" type="text/css" href="<%= Page.ResolveUrl("~/") %>resources/css/main.css" />
    <script type="text/javascript" src="<%= Page.ResolveUrl("~/") %>resources/js/jquery-1.7.1.js"></script>
      <script type="text/javascript">
          var thisDirUrl = "<%= Page.ResolveUrl("./") %>";
          var thisRootUrl = "<%= Page.ResolveUrl("~/") %>";
    </script>
    <script type="text/javascript">
        //列表刷新数据重载方法
        var pnlListFresh = function () {
            App.hidden_delete_flag.setValue("0");
            App.store.currentPage = 1;
            App.pageToolBar.doRefresh();
            return false;
        }

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
            if (command.toLowerCase() == "search") {
                commandcolumn_direct_search(record);
            }
            return false;
        };

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

        var commandcolumn_direct_search = function (record) {
            var tyreno = record.data.TYRE_NO;
            App.direct.commandcolumn_direct_search(tyreno, {
                success: function (result) {
                    refreshChart(tyreno);
                },

                failure: function (errorMsg) {
                    Ext.Msg.alert('操作', errorMsg);
                }
            });
        }
        //-------查看明细-----查询带回弹出框--BEGIN
        var SearchTechDetailWindowShow = function () {
            var equipID = App.cboSearchEquipId.getValue();
            if (equipID==null || equipID.length == 0) {
                Ext.Msg.alert('提示', "请选择机台");
                return;
            }
            var myDate = new Date(App.datSearchBeginDate.getValue());
            var myTime = new Date(App.timSearchBeginTime.getValue());
            var startdate = myDate.getFullYear().toString() + "-" + (myDate.getMonth() + 1) + "-" + myDate.getDate() + " " + myTime.getHours() + ":" + myTime.getMinutes() + ":" + myTime.getSeconds();
            myDate = new Date(App.datSearchEndDate.getValue());
            myTime = new Date(App.timSearchEndTime.getValue());
            var enddate = myDate.getFullYear().toString() + "-" + (myDate.getMonth() + 1) + "-" + myDate.getDate() + " " + myTime.getHours() + ":" + myTime.getMinutes() + ":" + myTime.getSeconds();

            //var myDate = new Date(planDate);
            //var ymd = myDate.getFullYear().toString() + pad(myDate.getMonth() + 1, 2) + pad(myDate.getDate(), 2);
            //var procedure = App.cobProcedure.getValue();
            //var procedurename = App.cobProcedure.displayTplData[0].field2;
            var window = App.McUI_SearchBox_SearchSemisTechParasDetail_Window;
            var html = "<iframe src='" + thisDirUrl + "SemisTechParasDetail.aspx?StartDate=" + startdate + "&EndDate=" + enddate + "&EquipID=" + equipID + "' width=100% height=100% scrolling=no  frameborder=0></iframe>";
            if (window.getBody()) {
                window.getBody().update(html);
            } else {
                window.html = html;
            }
            window.show();
        }
        Ext.create("Ext.window.Window", {//物料查询带回窗体
            id: "McUI_SearchBox_SearchSemisTechParasDetail_Window",
            hidden: true,
            maximized: true,
            html: "<iframe src='" + thisRootUrl + "SemisTechParasDetail.aspx' width=100% height=100% scrolling=no  frameborder=0></iframe>",
            bodyStyle: "background-color: #fff;",
            closable: true,
            title: "工艺参数明细",
            modal: true,
            listeners: {
                beforeclose: function (panel, eOpts) {
                    //pnlListFresh();
                }
            }
        })
    </script>
</head>
<body>
    <form id="form1" runat="server">
        <ext:ResourceManager ID="rmUser" runat="server" />
        <ext:Viewport ID="vwUnit" runat="server" Layout="border">
            <Items>
                <ext:Panel ID="pnlUserTitle" runat="server" Region="North" AutoHeight="true">
                    <TopBar>
                        <ext:Toolbar runat="server" ID="barUser">
                            <Items>
                                <ext:ToolbarSeparator ID="toolbarSeparator_begin" />
                                <ext:Button runat="server" Icon="Find" Text="查询" ID="btnSearch">
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
                                <ext:ToolbarSeparator ID="toolbarSeparator_middle_2" />
                                <ext:Button runat="server" Icon="Find" Text="查询明细" ID="btnAdd">
                                    <ToolTips>
                                        <ext:ToolTip ID="ttAdd" runat="server" Html="查询明细" />
                                    </ToolTips>
                                    <Listeners>
                                        <Click Fn="SearchTechDetailWindowShow" />
                                    </Listeners>
                                </ext:Button>
                                <ext:ToolbarSeparator ID="toolbarSeparator_end" />
                                <ext:ToolbarSpacer runat="server" ID="toolbarSpacer_end" />
                                <ext:ToolbarFill ID="toolbarFill_end" />
                            </Items>
                        </ext:Toolbar>
                    </TopBar>
                    <Items>
                        <ext:Panel ID="pnlUserQuery" runat="server" AutoHeight="true">
                            <Items>
                                <ext:FormPanel ID="container_top" runat="server" Layout="ColumnLayout" AutoHeight="true">
                                    <Items>
                                        <ext:FieldContainer runat="server" Layout="ColumnLayout" ColumnWidth="1">
                                            <Items>
                                                <ext:Container ID="container_1" runat="server" Layout="FormLayout" ColumnWidth=".33"
                                                    Padding="5">
                                                    <Items>
                                                        <ext:Container ID="container1" runat="server" Layout="HBoxLayout">
                                                            <Items>
                                                                <ext:DateField runat="server" ID="datSearchBeginDate" LabelAlign="Right" FieldLabel="开始时间" Format="yyyy-MM-dd" Editable="false"
                                                                    LabelWidth="80" />
                                                                <ext:TimeField runat="server" ID="timSearchBeginTime" HideLabel="true" Format="HH:mm:ss" />
                                                            </Items>
                                                        </ext:Container>
                                                        <ext:TextField ID="txt_green_no" runat="server" FieldLabel="胎胚号" LabelAlign="Right" />
                                                    </Items>
                                                </ext:Container>
                                                <ext:Container ID="container2" runat="server" Layout="FormLayout" ColumnWidth=".33"
                                                    Padding="5">
                                                    <Items>
                                                        <ext:Container ID="container3" runat="server" Layout="HBoxLayout">
                                                            <Items>
                                                                <ext:DateField runat="server" ID="datSearchEndDate" LabelAlign="Right" FieldLabel="结束时间" Format="yyyy-MM-dd" Editable="false"
                                                                    LabelWidth="80" />
                                                                <ext:TimeField runat="server" ID="timSearchEndTime" HideLabel="true" Format="HH:mm:ss" />
                                                            </Items>
                                                        </ext:Container>
                                                        <ext:ComboBox runat="server" ID="cboSearchEquipId" LabelAlign="Right" FieldLabel="机台"
                                                            QueryMode="Local" ForceSelection="true" LabelWidth="80">
                                                            <Triggers>
                                                                <ext:FieldTrigger Icon="Clear" Qtip="清空" HideTrigger="true" />
                                                            </Triggers>
                                                            <Listeners>
                                                                <TriggerClick Handler="this.setValue('');" />
                                                            </Listeners>
                                                        </ext:ComboBox>
                                                    </Items>
                                                </ext:Container>

                                                <ext:Container ID="container4" runat="server" Layout="FormLayout" ColumnWidth=".33"
                                                    Padding="5">
                                                    <Items>
                                                        <ext:TextField ID="txt_tyre_no" runat="server" FieldLabel="硫化号" LabelAlign="Right" />
                                                        <ext:TextField ID="txt_mould_no" runat="server" FieldLabel="模具号" LabelAlign="Right" />
                                                    </Items>
                                                </ext:Container>
                                            </Items>
                                        </ext:FieldContainer>
                                    </Items>
                                </ext:FormPanel>
                            </Items>
                        </ext:Panel>
                    </Items>
                </ext:Panel>
                <ext:GridPanel ID="pnlList" runat="server" Region="Center">
                    <Store>
                        <ext:Store ID="store" runat="server" PageSize="10">
                            <Proxy>
                                <ext:PageProxy DirectFn="App.direct.GridPanelBindData" />
                            </Proxy>
                            <Model>
                                <ext:Model ID="model" runat="server">
                                    <Fields>
                                        <ext:ModelField Name="EQUIP_ID" />
                                        <ext:ModelField Name="EQUIP_NAME" />
                                        <ext:ModelField Name="SHIFT_NAME" />
                                        <ext:ModelField Name="CALSS_NAME" />
                                        <ext:ModelField Name="MATERIAL_NAME" />
                                        <ext:ModelField Name="OBJID" />
                                        <ext:ModelField Name="RECORD_TIME" />
                                        <ext:ModelField Name="SHIFT_ID" />
                                        <ext:ModelField Name="GROUP_ID" />
                                        <ext:ModelField Name="PLAN_ID" />
                                        <ext:ModelField Name="PLAN_DETAIL_ID" />
                                    </Fields>
                                </ext:Model>
                            </Model>
                        </ext:Store>
                    </Store>
                    <ColumnModel ID="colModel" runat="server">
                        <Columns>
                            <ext:Column ID="EQUIP_NAME" runat="server" Text="设备名称" DataIndex="EQUIP_NAME" Width="120" />
                            <ext:Column ID="SHIFT_NAME" runat="server" Text="班次" DataIndex="SHIFT_NAME" Width="100" />
                            <ext:Column ID="CALSS_NAME" runat="server" Text="班组" DataIndex="CALSS_NAME" Width="100" />
                            <ext:Column ID="MASTER_MATERIAL_NAME" runat="server" Text="规格" DataIndex="MATERIAL_NAME" Width="160" />
                            <ext:Column ID="MASTER_RECORD_TIME" runat="server" Text="时间" DataIndex="RECORD_TIME" Width="120" />
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
                            <Plugins>
                                <ext:ProgressBarPager ID="ProgressBarPager" runat="server" />
                            </Plugins>
                        </ext:PagingToolbar>
                    </BottomBar>
                </ext:GridPanel>
                <ext:Panel ID="pnlSouth" runat="server" Region="South" Title="明细数据" Height="200" Icon="Basket" Layout="Fit" Collapsible="true"
                    Split="true" MarginsSummary="0 5 5 5">
                    <Items>
                        <ext:GridPanel ID="pnlDetailList" runat="server" MarginsSummary="0 5 5 5">
                            <Store>
                                <ext:Store ID="storeDetail" runat="server" PageSize="30" OnReadData="RowSelect">
                                    <Model>
                                        <ext:Model ID="modelDetail" runat="server" IDProperty="TECH_ITEM_ID,TECH_MASTER_ID">
                                            <Fields>
                                                <ext:ModelField Name="OBJID" />
                                                <ext:ModelField Name="TECH_ITEM_ID" />
                                                <ext:ModelField Name="TECH_MASTER_ID" />
                                                <ext:ModelField Name="TECH_ITEM_VALUE" />
                                                <ext:ModelField Name="TECH_PARAM_NAME" />
                                            </Fields>
                                        </ext:Model>
                                    </Model>
                                    <Parameters>
                                        <ext:StoreParameter Name="TECH_MASTER_ID" Mode="Raw" Value="#{pnlList}.getSelectionModel().hasSelection() ? #{pnlList}.getSelectionModel().getSelection()[0].data.OBJID : -1" />
                                    </Parameters>
                                </ext:Store>
                            </Store>
                            <ColumnModel ID="ColumnModelDetail" runat="server">
                                <Columns>
                                    <ext:RowNumbererColumn ID="rowNumCol1" runat="server" Width="35" />
                                    <ext:Column ID="TECH_ITEM_ID" runat="server" Text="编号" DataIndex="TECH_ITEM_ID" Width="80" />
                                    <ext:Column ID="TECH_PARAM_NAME" runat="server" Text="参数名称" DataIndex="TECH_PARAM_NAME" Width="80" />
                                    <ext:Column ID="TECH_ITEM_VALUE" runat="server" Text="值" DataIndex="TECH_ITEM_VALUE" Width="160" />
                                </Columns>
                            </ColumnModel>
                            <BottomBar>
                                <ext:PagingToolbar ID="PagingToolbar1" runat="server">
                                    <Items>
                                    </Items>
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
