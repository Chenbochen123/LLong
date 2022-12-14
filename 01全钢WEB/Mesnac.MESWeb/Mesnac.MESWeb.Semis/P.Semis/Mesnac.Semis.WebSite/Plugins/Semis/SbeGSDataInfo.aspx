<%@ Page Language="C#" AutoEventWireup="true" CodeFile="SbeGSDataInfo.aspx.cs" Inherits="Plugins_Semis_SbeGSDataInfo" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>钢丝圈测量报表</title>
    <script type="text/javascript" src="<%= Page.ResolveUrl("~/") %>resources/js/jquery-1.7.1.js"></script>
    <link rel="Stylesheet" type="text/css" href="<%= Page.ResolveUrl("~/") %>resources/css/ext-chinese-font.css" />
    <link rel="Stylesheet" type="text/css" href="<%= Page.ResolveUrl("~/") %>resources/css/main.css" />

    <script type="text/javascript">

        var pnlListFresh = function () {
            //App.pnlList.store.reload();
            App.pageToolbar.doRefresh();
            return false;
        }
    </script>
</head>
<body>
    <form id="form1" runat="server">
        <asp:Button ID="btnExportSubmit" Style="display: none" runat="server" Text="Button"
            OnClick="btnExportSubmit_Click" />
        <ext:ResourceManager ID="rmDefect" runat="server" />
        <ext:Viewport ID="vpDefect" runat="server" Layout="border">
            <Items>
                <ext:Panel ID="pnDefect" runat="server" Region="North">
                    <TopBar>
                        <ext:Toolbar runat="server" ID="tbDefect">
                            <Items>
                                <ext:Button runat="server" Icon="Find" Text="查询" ID="btnSearch">
                                    <Listeners>
                                        <Click Fn="pnlListFresh" />
                                    </Listeners>
                                </ext:Button>

                                <ext:Hidden runat="server" ID="hiddenName"></ext:Hidden>
                                <ext:ToolbarSeparator ID="tsEnd" />
                                <ext:Button runat="server" Icon="PageWhiteExcel" Text="导出" ID="btnExport">
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
                        <ext:Panel ID="pnlQuery" runat="server" AutoHeight="true">
                            <Items>
                                <ext:FormPanel ID="container_top" runat="server" Layout="ColumnLayout" AutoHeight="true">
                                    <Items>
                                        <ext:Container ID="container_1" runat="server" Layout="FormLayout" ColumnWidth=".33"
                                            Padding="5">
                                            <Items>
                                                <ext:DateField runat="server" ID="Begintime" FieldLabel="开始日期" LabelAlign="Right" Format="yyyy-MM-dd">
                                                </ext:DateField>
                                                <%-- <ext:ComboBox ID="cbxEquip" runat="server" FieldLabel="计划机台" LabelAlign="Right" Editable="false"></ext:ComboBox>--%>
                                            </Items>
                                        </ext:Container>
                                        <ext:Container ID="container_2" runat="server" Layout="FormLayout" ColumnWidth=".33"
                                            Padding="5">
                                            <Items>
                                                <ext:DateField runat="server" ID="Endtime" FieldLabel="结束日期" LabelAlign="Right" Format="yyyy-MM-dd">
                                                </ext:DateField>
                                            </Items>
                                        </ext:Container>
                                 <%--       <ext:Container ID="container_3" runat="server" Layout="FormLayout" ColumnWidth=".33"
                                            Padding="5">
                                            <Items>
                                                <ext:ComboBox ID="cbxshift" runat="server" FieldLabel="班次" LabelAlign="left"
                                                    Editable="false">
                                                    <Items>
                                                        <ext:ListItem Text="早" Value="早">
                                                        </ext:ListItem>
                                                        <ext:ListItem Text="中" Value="中">
                                                        </ext:ListItem>
                                                        <ext:ListItem Text="晚" Value="晚">
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
                                        </ext:Container>--%>
                                    </Items>
                                </ext:FormPanel>
                            </Items>
                        </ext:Panel>
                    </Items>
                </ext:Panel>
                <ext:Panel ID="Panel2" runat="server" Region="Center" Frame="true" Layout="Fit" MarginsSummary="0 5 0 5 "
                    Title="">
                    <Items>
                        <ext:GridPanel ID="pnlList" runat="server">
                            <Store>
                                <ext:Store ID="store" runat="server" PageSize="50">
                                    <Proxy>
                                        <ext:PageProxy DirectFn="App.direct.GridPanelBindData" />
                                    </Proxy>
                                    <Model>
                                        <ext:Model ID="model" runat="server" IDProperty="OBJID">
                                            <Fields>
                                                <ext:ModelField Name="OBJID" />
                                                <ext:ModelField Name="EQUIP_NAME" />
                                                <ext:ModelField Name="RECORD_TIME" />
                                                <ext:ModelField Name="MATERIAL_CODE" />
                                                <ext:ModelField Name="STANDARDPERIMETER" />
                                                <ext:ModelField Name="ACTUALPERIMETER" />
                                                <ext:ModelField Name="ACTUALDIAMETER" />
                                                <ext:ModelField Name="ACTUALDIFFERENCE"/>
                                                <ext:ModelField Name="WEIGHT" />
                                                <ext:ModelField Name="PLAN_DETAILID" />
                                                <ext:ModelField Name="MEASUREDATE" />
                                                <ext:ModelField Name="STANDARDDIAMETER" />
                                                <ext:ModelField Name="ERRORDIAMETER" />
                                                <ext:ModelField Name="STANDARDWEIGHT" />
                                                <ext:ModelField Name="ACTUALWEIGHT" />
                                                <ext:ModelField Name="DIFFERENCE" />
                                                <ext:ModelField Name="AVGDIFFERENCE" />
                                                <ext:ModelField Name="BATCH" />
                                               <%-- <ext:ModelField Name="MATERIAL_NAME" />--%>
                                                <ext:ModelField Name="ZHIJING" />
                                                <ext:ModelField Name="ZHONGLIANG" />
                                            </Fields>
                                        </ext:Model>
                                    </Model>
                                </ext:Store>
                            </Store>
                            <ColumnModel ID="colModel" runat="server">
                                <Columns>
                                    <ext:RowNumbererColumn ID="rowNumCol1" runat="server" Width="35" />
                                    <ext:Column ID="DefectCode" runat="server" Text="主键" DataIndex="OBJID" Width="60" Visible="false" />
                                    <ext:Column ID="Column1" runat="server" Text="设备名称" DataIndex="EQUIP_NAME" Width="100" />
                                    <ext:DateColumn ID="Column2" runat="server" Text="测量时间" DataIndex="MEASUREDATE" Width="150" Format="yyyy-MM-dd HH:mm:ss"  />
                                    <ext:Column ID="Column33" runat="server" Text="物料" DataIndex="MATERIAL_CODE" Width="100" />
                                   <%-- <ext:Column ID="Column13" runat="server" Text="物料规格" DataIndex="MATERIAL_NAME" Width="250" Hidden="true"/>--%>
                                    <%--  <ext:Column ID="Column4" runat="server" Text="标准周长" DataIndex="STANDARDPERIMETER" Width="100" />--%>
                                    <%--<ext:Column ID="Column5" runat="server" Text="测量周长" DataIndex="ACTUALPERIMETER" Width="100" />--%>
                                    <ext:Column ID="Column6" runat="server" Text="测量直径" DataIndex="ACTUALDIAMETER" Width="100" />
                                    <ext:Column ID="Column3" runat="server" Text="标准直径" DataIndex="STANDARDDIAMETER" Width="100" />
                                    <ext:Column ID="Column14" runat="server" Text="直径等级" DataIndex="ZHIJING" Width="100" />
                                    <ext:Column ID="Column7" runat="server" Text="直径差值" DataIndex="ACTUALDIFFERENCE" Width="100" Hidden="true"/>
                                    <ext:Column ID="Column4" runat="server" Text="直径误差" DataIndex="ERRORDIAMETER" Width="100" />
                                    <ext:Column ID="Column5" runat="server" Text="标准重量" DataIndex="STANDARDWEIGHT" Width="100" />
                                    <ext:Column ID="Column8" runat="server" Text="实际重量" DataIndex="ACTUALWEIGHT" Width="100" />
                                    <ext:Column ID="Column15" runat="server" Text="重量等级" DataIndex="ZHONGLIANG" Width="100" />
                                    <ext:Column ID="Column10" runat="server" Text="直径极差值" DataIndex="DIFFERENCE" Width="100" />
                                    <ext:Column ID="Column11" runat="server" Text="直径平均差值" DataIndex="AVGDIFFERENCE" Width="100" />
                                    <ext:Column ID="Column12" runat="server" Text="批次号" DataIndex="BATCH" Width="200" />
                                    <%--<ext:Column ID="Column8" runat="server" Text="重量" DataIndex="WEIGHT" Width="100" />--%>
                                    <ext:Column ID="Column9" runat="server" Text="计划明细号" DataIndex="PLAN_DETAILID" Width="100" />
                                </Columns>
                            </ColumnModel>
                            <BottomBar>
                                <ext:PagingToolbar ID="pageToolbar" runat="server">
                                    <Items>
                                        <ext:Label ID="Label2" runat="server" Text="每页条数:" />
                                        <ext:ToolbarSpacer ID="ToolbarSpacer2" runat="server" Width="10" />
                                        <ext:ComboBox ID="ComboBox2" runat="server" Width="80">
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
                                                <Select Handler="#{pnlList}.store.pageSize = parseInt(this.getValue(), 10); #{pageToolbar}.doRefresh(); return false;" />
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
