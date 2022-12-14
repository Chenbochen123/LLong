<%@ Page Language="C#" AutoEventWireup="true" CodeFile="HppGetMatertosap.aspx.cs" Inherits="Plugins_Semis_Production_HppGetMatertosap" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>半制品机台领料传SAP数据</title>
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

    <script type="text/javascript">
        //进行二次确认操作
        var upload_product_qty_confirm = function (isall) {
            Ext.Msg.confirm("提示", '您确认要重传已选数据吗？', function (btn) {
                if (btn != "yes") {
                    return;
                }
                var box = App.CheckboxSelectionModel1.selected.items;
                var e = new Array();
                for (var i = 0 ; i < box.length; i++) {
                    if (box[i].data.MSTYP == "S") {
                        Ext.Msg.alert("提示", "所选数据包含已上传成功信息！");
                        return;
                    }
                    e.push(box[i].data.BUSID);
                }
                var arr = Ext.encode(e);
                App.direct.upload_product_qty(isall, arr);
            });

        };
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
                                <ext:Button runat="server" Icon="Find" Text="查询" Enabled="false" ID="btnSearch">
                                    <ToolTips>
                                        <ext:ToolTip ID="ToolTip2" runat="server" Html="查询" />
                                    </ToolTips>
                                    <Listeners>
                                        <Click Fn="pnlListFresh" />
                                    </Listeners>
                                </ext:Button>
                                <ext:ToolbarSeparator />
                                <ext:Button runat="server" Icon="ShapesManySelect" Text="数据SAP重传" ID="btnCheckProductionState">
                                    <ToolTips>
                                        <ext:ToolTip ID="ttSearch" runat="server" Html="数据SAP重传" />
                                    </ToolTips>
                                    <Listeners>
                                        <Click Handler="upload_product_qty_confirm(0);" />
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
                                <ext:ToolbarSeparator />
                            </Items>
                        </ext:Toolbar>
                    </TopBar>
                    <Items>
                        <ext:FormPanel ID="container_top" runat="server" Layout="ColumnLayout" AutoHeight="true">
                            <Items>
                                <ext:Container ID="container_1" runat="server" Layout="FormLayout" ColumnWidth=".3"
                                    Padding="5">
                                    <Items>
                                        <ext:FieldContainer runat="server" FieldLabel="开始时间" Layout="HBoxLayout" LabelAlign="Right">
                                            <Items>
                                                <ext:DateField ID="txtBeginDate" runat="server" Flex="1" Editable="false" />
                                                <ext:TimeField ID="txtBeginTime" runat="server" Editable="true" />
                                            </Items>
                                        </ext:FieldContainer>
                                    </Items>
                                </ext:Container>
                                <ext:Container ID="container_2" runat="server" Layout="FormLayout" ColumnWidth=".3"
                                    Padding="5">
                                    <Items>
                                        <ext:FieldContainer runat="server" FieldLabel="结束时间" Layout="HBoxLayout" LabelAlign="Right">
                                            <Items>
                                                <ext:DateField ID="txtEndDate" runat="server" Flex="1" Editable="false" />
                                                <ext:TimeField ID="txtEndTime" runat="server" Editable="true" />
                                            </Items>
                                        </ext:FieldContainer>
                                    </Items>
                                </ext:Container>
                                <ext:Container ID="container1" runat="server" Layout="FormLayout" ColumnWidth=".3"
                                    Padding="5">
                                    <Items>
                                        <ext:ComboBox ID="cbxtype" runat="server" FieldLabel="接收状态" LabelAlign="left"
                                            Editable="false">
                                            <Items>
                                                <ext:ListItem Text="S" Value="S">
                                                </ext:ListItem>
                                                <ext:ListItem Text="E" Value="E">
                                                </ext:ListItem>
                                            </Items>
                                            <Triggers>
                                                <ext:FieldTrigger Icon="Clear" Qtip="清空">
                                                </ext:FieldTrigger>
                                            </Triggers>
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
                                <ext:Model ID="model" runat="server">
                                    <Fields>
                                        <ext:ModelField Name="OBJID" />
                                        <ext:ModelField Name="BUSID" />
                                        <ext:ModelField Name="BUSTYP" />
                                        <ext:ModelField Name="TLDID" />
                                        <ext:ModelField Name="DTSEND" />
                                        <ext:ModelField Name="SENDER" />
                                        <ext:ModelField Name="DOCDATE" />
                                        <ext:ModelField Name="POSTDATE" />
                                        <ext:ModelField Name="MOVTYPE" />
                                        <ext:ModelField Name="MATERIAL_NAME" />
                                        <ext:ModelField Name="PLANTFROM" />
                                        <ext:ModelField Name="STORAGELOC" />
                                        <ext:ModelField Name="QTY" />
                                        <ext:ModelField Name="UNIT" />
                                        <ext:ModelField Name="PROCESSCODE" />
                                        <ext:ModelField Name="TLGNAM" />
                                        <ext:ModelField Name="MSTYP" />
                                        <ext:ModelField Name="ERRDES" />
                                        <ext:ModelField Name="DUMMY1" />
                                        <ext:ModelField Name="DUMMY2" />
                                    </Fields>
                                </ext:Model>
                            </Model>
                        </ext:Store>
                    </Store>
                    <ColumnModel ID="colModel" runat="server">
                        <Columns>
                            <ext:RowNumbererColumn runat="server" />
                            <ext:Column ID="OBJID" runat="server" Hidden="true"></ext:Column>
                            <ext:Column ID="SUCCESS_FLAG" runat="server" Text="流水号" DataIndex="BUSID" Width="100"/>
                            <ext:Column ID="STATE_FLAG" runat="server" Text="业务类型" DataIndex="BUSTYP" Width="120"/>
                            <ext:Column ID="POSTDATE" runat="server" Text="接口ID" DataIndex="TLDID" Hidden="true"/>
                            <ext:Column ID="DOCDATE" runat="server" Text="发送日期" DataIndex="DTSEND"  Width="120"/>
                            <ext:Column ID="SHIFT_NAME" runat="server" Text="发送方" DataIndex="SENDER"   Hidden="true"/>
                            <ext:Column ID="SAPCODE" runat="server" Text="凭证日期" DataIndex="DOCDATE"  Width="100"/>
                            <ext:Column ID="PROVERSION" runat="server" Text="过账日期" DataIndex="POSTDATE"  Width="100"/>
                            <ext:Column ID="MATERIALCODE" runat="server" Text="移动类型" DataIndex="MOVTYPE"  Width="80"/>
                            <ext:Column ID="MINOR_TYPE_NAME" runat="server" Text="物料规格" DataIndex="MATERIAL_NAME"  Width="200" />
                            <ext:Column ID="MESQTY" runat="server" Text="工厂" DataIndex="PLANTFROM"   Hidden="true"/>
                            <ext:Column ID="SAPQTY" runat="server" Text="发出地点" DataIndex="STORAGELOC"  Width="80"/>
                            <ext:Column ID="Column1" runat="server" Text="接受地点" DataIndex="DUMMY1"  Width="80"/>
                            <ext:Column ID="Column2" runat="server" Text="班次" DataIndex="DUMMY2"  Width="80"/>
                            <ext:Column ID="QTY" runat="server" Text="调拨数量" DataIndex="QTY"  Width="80"/>
                            <ext:Column ID="MESREJECTQTY" runat="server" Text="基本计量单位" DataIndex="UNIT" Hidden="true"/>
                            <ext:Column ID="SAPREJECTQTY" runat="server" Text="处理类型" DataIndex="PROCESSCODE" Hidden="true"/>
                            <ext:Column ID="REJECTQTY" runat="server" Text="接口名" DataIndex="TLGNAM" Hidden="true"/>
                            <ext:Column ID="REMARK" runat="server" Text="处理状态" DataIndex="MSTYP"  Width="80"/>
                            <ext:Column ID="RETURN_MSG" runat="server" Text="错误描述" DataIndex="ERRDES"  Width="240"/>
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
            </Items>
        </ext:Viewport>
    </form>
</body>
</html>
