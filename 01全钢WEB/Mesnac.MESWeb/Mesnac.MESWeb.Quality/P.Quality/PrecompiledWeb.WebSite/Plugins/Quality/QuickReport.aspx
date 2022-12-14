<%@ page language="C#" autoeventwireup="true" inherits="Plugins_Quality_QuickReport, Mesnac.Quality.WebSite" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>质检速报</title>
    <script type="text/javascript" src="<%= Page.ResolveUrl("~/") %>resources/js/jquery-1.7.1.js"></script>
    <link rel="Stylesheet" type="text/css" href="<%= Page.ResolveUrl("~/") %>resources/css/ext-chinese-font.css" />
    <link rel="Stylesheet" type="text/css" href="<%= Page.ResolveUrl("~/") %>resources/css/main.css" />
    <style type="text/css">
        .x-grid-row-collapsed .x-grid-cell {
            background-color: #B0FFBA !important;
        }
    </style>
    <script type="text/javascript">

        var pnlListFresh = function () {
            App.pnlList.store.reload();
            return false;
        }

        var prepareToolbar = function (grid, toolbar, rowIndex, record) {

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
                                        <Click Fn="pnlListFresh" />
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
                                <ext:Container ID="container1" runat="server" Layout="FormLayout" ColumnWidth=".25"
                                    Padding="5">
                                    <Items>
                                        <ext:FieldContainer runat="server" FieldLabel="开始时间" Layout="HBoxLayout" LabelAlign="Right">
                                            <Items>
                                                <ext:DateField ID="txtBeginDate" runat="server" Flex="1" Editable="false" />
                                                <ext:TimeField ID="txtBeginTime" runat="server" Width="80" Editable="true" />
                                            </Items>
                                        </ext:FieldContainer>
                                        <ext:ComboBox runat="server" ID="cbxCuringEquip" FieldLabel="硫化机台" MaxLength="25" LabelAlign="Right" />
                                    </Items>
                                </ext:Container>
                                <ext:Container ID="container4" runat="server" Layout="FormLayout" ColumnWidth=".25"
                                    Padding="5">
                                    <Items>
                                        <ext:FieldContainer runat="server" FieldLabel="结束时间" Layout="HBoxLayout" LabelAlign="Right">
                                            <Items>
                                                <ext:DateField ID="txtEndDate" runat="server" Flex="1" Editable="false" />
                                                <ext:TimeField ID="txtEndTime" runat="server" Width="80" Editable="true" />
                                            </Items>
                                        </ext:FieldContainer>
                                        <ext:ComboBox runat="server" ID="cbxMoldingEquip" FieldLabel="成型机台" MaxLength="25" LabelAlign="Right" />
                                    </Items>
                                </ext:Container>
                                <ext:Container ID="container2" runat="server" Layout="FormLayout" ColumnWidth=".25"
                                    Padding="5">
                                    <Items>
                                        <ext:ComboBox ID="cbxXGrade" runat="server" FieldLabel="X光品级" MaxLength="25"
                                            LabelAlign="Right" />
                                        <ext:ComboBox ID="cbxFGrade" runat="server" FieldLabel="外观品级" MaxLength="25"
                                            LabelAlign="Right" />
                                    </Items>
                                </ext:Container>
                                <ext:Container ID="container3" runat="server" Layout="FormLayout" ColumnWidth=".25"
                                    Padding="5">
                                    <Items>
                                        <ext:TextField ID="txtMaterialName" runat="server" FieldLabel="轮胎规格" MaxLength="25"
                                            LabelAlign="Right" />
                                    </Items>
                                </ext:Container>
                            </Items>
                        </ext:FormPanel>
                    </Items>
                </ext:Panel>
                <ext:Panel ID="Panel2" runat="server" Region="Center" Frame="true" Layout="Fit" MarginsSummary="0 5 0 5 "
                    Title="质检速报">
                    <Items>
                        <ext:GridPanel ID="pnlList" runat="server">
                            <Store>
                                <ext:Store ID="store" runat="server" PageSize="10">
                                    <Proxy>
                                        <ext:PageProxy DirectFn="App.direct.GridPanelBindData" />
                                    </Proxy>
                                    <Model>
                                        <ext:Model ID="model" runat="server" IDProperty="OBJID">
                                            <Fields>
                                                <ext:ModelField Name="TYRE_NO" />
                                                <ext:ModelField Name="GREEN_TYRE_NO" />
                                                <ext:ModelField Name="MATERIAL_NAME" />
                                                <ext:ModelField Name="MOLDING_EQUIP_NAME" />
                                                <ext:ModelField Name="MOLDING_SHIFT_DATE" />
                                                <ext:ModelField Name="MOLDING_SHIFT_NAME" />
                                                <ext:ModelField Name="MOLDING_CLASS_NAME" />
                                                <ext:ModelField Name="MOLDING_RECORD_TIME" />
                                                <ext:ModelField Name="CURING_EQUIP_NAME" />
                                                <ext:ModelField Name="CURING_SHIFT_DATE" />
                                                <ext:ModelField Name="CURING_SHIFT_NAME" />
                                                <ext:ModelField Name="CURING_CLASS_NAME" />
                                                <ext:ModelField Name="CURING_RECORD_TIME" />
                                                <ext:ModelField Name="X_GRADE_NAME" />
                                                <ext:ModelField Name="X_DEFECT_NAME" />
                                                <ext:ModelField Name="F_GRADE_NAME" />
                                                <ext:ModelField Name="F_DEFECT_NAME" />
                                                <ext:ModelField Name="X_RECORD_TIME" />
                                                <ext:ModelField Name="F_RECORD_TIME" />
                                            </Fields>
                                        </ext:Model>
                                    </Model>
                                </ext:Store>
                            </Store>
                            <ColumnModel ID="colModel" runat="server">
                                <Columns>
                                    <ext:RowNumbererColumn runat="server"></ext:RowNumbererColumn>
                                    <ext:Column ID="MOLDING_EQUIP_NAME" runat="server" Text="成型机台" DataIndex="MOLDING_EQUIP_NAME" Width="60" />
                                    <ext:Column ID="CURING_EQUIP_NAME" runat="server" Text="硫化机台" DataIndex="CURING_EQUIP_NAME" Width="60" />
                                    <ext:Column ID="TYRE_NO" runat="server" Text="硫化号" DataIndex="TYRE_NO" Width="100" />
                                    <ext:Column ID="GREEN_TYRE_NO" runat="server" Text="成型号" DataIndex="GREEN_TYRE_NO" Width="100" />
                                    <ext:Column ID="MATERIAL_NAME" runat="server" Text="轮胎规格" DataIndex="MATERIAL_NAME" Width="260" />
                                    <ext:DateColumn ID="MOLDING_SHIFT_DATE" runat="server" Text="成型日期" DataIndex="MOLDING_SHIFT_DATE" Format="yyyy-MM-dd" Width="100" />
                                    <ext:Column ID="MOLDING_SHIFT_NAME" runat="server" Text="成型班次" DataIndex="MOLDING_SHIFT_NAME" Width="60" />
                                    <ext:Column ID="MOLDING_CLASS_NAME" runat="server" Text="成型班组" DataIndex="MOLDING_CLASS_NAME" Width="60" />
                                    <ext:DateColumn ID="MOLDING_RECORD_TIME" runat="server" Text="成型时间" Format="yyyy-MM-dd HH:mm:ss" DataIndex="MOLDING_RECORD_TIME" Width="100" />
                                    <ext:DateColumn ID="CURING_SHIFT_DATE" runat="server" Text="硫化日期" DataIndex="CURING_SHIFT_DATE" Format="yyyy-MM-dd" Width="100" />
                                    <ext:Column ID="CURING_SHIFT_NAME" runat="server" Text="硫化班次" DataIndex="CURING_SHIFT_NAME" Width="60" />
                                    <ext:Column ID="CURING_CLASS_NAME" runat="server" Text="硫化班组" DataIndex="CURING_CLASS_NAME" Width="60" />
                                    <ext:DateColumn ID="CURING_RECORD_TIME" runat="server" Text="硫化时间" DataIndex="CURING_RECORD_TIME" Format="yyyy-MM-dd HH:mm:ss" Width="100" />
                                    <ext:Column ID="X_GRADE_NAME" runat="server" Text="X光品级" DataIndex="X_GRADE_NAME" Width="60" />
                                    <ext:Column ID="X_DEFECT_NAME" runat="server" Text="X光病疵" DataIndex="X_DEFECT_NAME" Width="60" />
                                    <ext:DateColumn ID="X_RECORD_TIME" runat="server" Text="X光质检时间" DataIndex="X_RECORD_TIME" Format="yyyy-MM-dd HH:mm:ss" Width="100" />
                                    <ext:Column ID="F_GRADE_NAME" runat="server" Text="外观品级" DataIndex="F_GRADE_NAME" Width="60" />
                                    <ext:Column ID="F_DEFECT_NAME" runat="server" Text="外观病疵" DataIndex="F_DEFECT_NAME" Width="60" />
                                    <ext:DateColumn ID="F_RECORD_TIME" runat="server" Text="外观质检时间" DataIndex="F_RECORD_TIME" Format="yyyy-MM-dd HH:mm:ss" Width="100" />
                                </Columns>
                            </ColumnModel>
                        </ext:GridPanel>
                    </Items>
                </ext:Panel>
            </Items>
        </ext:Viewport>
    </form>
</body>
</html>
