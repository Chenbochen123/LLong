<%@ Page Language="C#" AutoEventWireup="true" CodeFile="RepairCheckRecords.aspx.cs" Inherits="Plugins_Quality_Fcheck_RepairCheckRecords" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title></title>
    <script type="text/javascript" src="<%= Page.ResolveUrl("~/") %>resources/js/jquery-1.7.1.js"></script>
    <link rel="Stylesheet" type="text/css" href="<%= Page.ResolveUrl("~/") %>resources/css/ext-chinese-font.css" />
    <link rel="Stylesheet" type="text/css" href="<%= Page.ResolveUrl("~/") %>resources/css/main.css" />
    <style type="text/css">
        .x-grid-row-collapsed .x-grid-cell
        {
            background-color: #B0FFBA !important;
        }
    </style>
    <script type="text/javascript">

        var pnlListFresh = function () {
            if (App.txtBeginDate.getValue() > App.txtEndDate.getValue()) {
                Ext.Msg.alert('操作', '开始时间不能大于结束时间！');
                return false;
            }
            else if (App.txtBeginDate.getValue() == App.txtEndDate.getValue()) 
            {
                if (App.txtBeginTime.getValue() > App.txtEndTime.getValue()) {
                    Ext.Msg.alert('操作', '开始时间不能大于结束时间！');
                    return false;
                }
            }
            App.store.currentPage = 1;
            App.pageToolBar.doRefresh();
            return false;
        }

        var prepareToolbar = function (grid, toolbar, rowIndex, record) {

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
                            <ext:ToolbarSeparator ID="tsMiddle" />
                            <ext:Button runat="server" Icon="PageExcel" Text="导出Excel" ID="btnExport">
                                <ToolTips>
                                    <ext:ToolTip ID="ToolTip2" runat="server" Html="点击将查询结果导出到Excel中" />
                                </ToolTips>
                                <Listeners>
                                    <Click Handler="$('#btnExportSubmit').click();">
                                    </Click>
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
                                      <ext:FieldContainer runat="server" FieldLabel="首检开始时间" Layout="HBoxLayout" LabelAlign="Right">
                                            <Items>
                                                <ext:DateField ID="txtBeginDate" runat="server" Flex="1" Editable="false" />
                                                <ext:TimeField ID="txtBeginTime" runat="server" width="80" Editable="true" />
                                            </Items>
                                        </ext:FieldContainer>
                                    <ext:TextField ID="txtGreenTyreNo" runat="server" FieldLabel="胎胚号" LabelAlign="Right" />
                                        <ext:ComboBox ID="cbxliuhua" runat="server" FieldLabel="硫化机台" LabelAlign="Right" Editable="false"></ext:ComboBox>
                                </Items>
                            </ext:Container>
                            <ext:Container ID="container2" runat="server" Layout="FormLayout" ColumnWidth=".25"
                                Padding="5">
                                <Items>
                                    <ext:FieldContainer runat="server" FieldLabel="首检结束时间" Layout="HBoxLayout" LabelAlign="Right">
                                            <Items>
                                                <ext:DateField ID="txtEndDate" runat="server" Flex="1" Editable="false" />
                                                <ext:TimeField ID="txtEndTime" runat="server" width="80" Editable="true" />
                                            </Items>
                                        </ext:FieldContainer>
                                    <ext:TextField ID="txtTyreNo" runat="server" FieldLabel="硫化号" LabelAlign="Right" />
                                    <ext:TextField ID="txtzhujishou" runat="server" FieldLabel="主机手" LabelAlign="Right" />
                                </Items>
                            </ext:Container>
                            <ext:Container ID="container3" runat="server" Layout="FormLayout" ColumnWidth=".25"
                                Padding="5">
                                <Items>
                                    <ext:TextField ID="txtMaterialName" runat="server" FieldLabel="规格" LabelAlign="Right" Editable="false"></ext:TextField>
                                    <ext:ComboBox ID="cbxGrade" runat="server" FieldLabel="复检品级" LabelAlign="Right" Editable="false"></ext:ComboBox>
                                </Items>
                            </ext:Container>
                               <ext:Container ID="container4" runat="server" Layout="FormLayout" ColumnWidth=".25"
                                Padding="5">
                                <Items>
                                    <ext:ComboBox ID="cbxDefect" runat="server" FieldLabel="首检病疵" LabelAlign="Right" Editable="false">
                                    </ext:ComboBox>
                                </Items>
                            </ext:Container>
                        </Items>
                    </ext:FormPanel>
                </Items>
            </ext:Panel>
            <ext:Panel ID="Panel2" runat="server" Region="Center" Frame="true" Layout="Fit" MarginsSummary="0 5 0 5 "
                Title="成品胎返修记录">
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
                                            <ext:ModelField Name="TYREID" />
                                            <ext:ModelField Name="TYRE_NO"/>
                                            <ext:ModelField Name="DEFECTNAME1" />
                                            <ext:ModelField Name="SHIFTNAME1" />
                                            <ext:ModelField Name="USERNAME1" />
                                            <ext:ModelField Name="MATERIAL_NAME" />
                                            <ext:ModelField Name="RECORDTIME1" Type="Date"/>
                                            <ext:ModelField Name="GRADENAME" />
                                            <ext:ModelField Name="USERNAME2" />
                                            <ext:ModelField Name="SHIFTNAME2" />
                                            <ext:ModelField Name="DEFECTNAME2" />
                                            <ext:ModelField Name="ZUOYOUMO" />
                                            <ext:ModelField Name="WORKER_NAME" />
                                            <ext:ModelField Name="C_EQUIP_NAME" />
                                            <ext:ModelField Name="RECORDTIME2" Type="Date"/>
                                            <ext:ModelField Name="BEGIN_TIME" Type="Date"/>
                                            <ext:ModelField Name="END_TIME" Type="Date"/>
                                            <ext:ModelField Name="EQUIP_NAME" />
                                            <ext:ModelField Name="EMP1" />
                                            <ext:ModelField Name="EMP2" />
                                            <ext:ModelField Name="EMP3" />
                                            <ext:ModelField Name="MODINGPROTIME" Type="Date"/>
                                        </Fields>
                                    </ext:Model>
                                </Model>
                            </ext:Store>
                        </Store>
                        <ColumnModel ID="colModel" runat="server">
                            <Columns>
                                <ext:RowNumbererColumn ID="rowNumCol1" runat="server" Width="35" />
                                <ext:Column ID="TYREID" runat="server" Text="胎胚号" DataIndex="TYREID" Width="160" />
                                <ext:Column ID="TYRE_NO" runat="server" Text="硫化号" DataIndex="TYRE_NO" Width="160" />
                                <ext:Column ID="Column1" runat="server" Text="硫化机台" DataIndex="C_EQUIP_NAME" Width="160" />
                                <ext:DateColumn ID="Time3" runat="server" Text="硫化开始时间" DataIndex="BEGIN_TIME" Width="160" Format="yyyy-MM-dd HH:mm:ss"/>
                                <ext:DateColumn ID="Time4" runat="server" Text="硫化结束时间" DataIndex="END_TIME" Width="160" Format="yyyy-MM-dd HH:mm:ss"/>
                                <ext:Column ID="Column2" runat="server" Text="左右模" DataIndex="ZUOYOUMO" Width="160" />
                                <ext:Column ID="Column3" runat="server" Text="主机手" DataIndex="WORKER_NAME" Width="160" />
                                <ext:Column ID="MaterialName" runat="server" Text="规格" DataIndex="MATERIAL_NAME" Width="260"/>
                                <ext:Column ID="DefectName1" runat="server" Text="首检病疵" DataIndex="DEFECTNAME1" Width="160" />
                                <ext:Column ID="ShiftName1" runat="server" Text="首检班次" DataIndex="SHIFTNAME1" Width="60" />
                                <ext:Column ID="User1" runat="server" Text="首检人" DataIndex="USERNAME1" Width="100" />
                                <ext:DateColumn ID="Time1" runat="server" Text="首检时间" DataIndex="RECORDTIME1" Width="160" Format="yyyy-MM-dd HH:mm:ss"/>
                                <ext:Column ID="GradeName" runat="server" Text="复检等级" DataIndex="GRADENAME" Width="100" />
                                <ext:Column ID="DefectName2" runat="server" Text="复检病疵" DataIndex="DEFECTNAME2" Width="160"/>  
                                <ext:Column ID="ShiftName2" runat="server" Text="复检班次" DataIndex="SHIFTNAME2" Width="60"/>
                                <ext:Column ID="User2" runat="server" Text="复检人" DataIndex="USERNAME2" Width="100" />
                                <ext:DateColumn ID="Time2" runat="server" Text="复检时间" DataIndex="RECORDTIME2" Width="160"  Format="yyyy-MM-dd HH:mm:ss"/>
                                <ext:Column ID="Column4" runat="server" Text="成型机台" DataIndex="EQUIP_NAME" Width="100" />
                                <ext:Column ID="Column5" runat="server" Text="主机" DataIndex="EMP1" Width="100" />
                                <ext:Column ID="Column6" runat="server" Text="辅机" DataIndex="EMP2" Width="100" />
                                <ext:Column ID="Column7" runat="server" Text="帮车" DataIndex="EMP3" Width="100" />
                                <ext:DateColumn ID="ModingProTime" runat="server" Text="生产时间" DataIndex="MODINGPROTIME" Width="160"  Format="yyyy-MM-dd HH:mm:ss"/>
                            </Columns>
                        </ColumnModel>
                        <BottomBar>
                            <ext:PagingToolbar ID="pageToolBar" runat="server">
                                <Items>
                                    <ext:Label ID="Label1" runat="server" Text="每页条数:" Hidden="true"/>
                                    <ext:ToolbarSpacer ID="ToolbarSpacer1" runat="server" Width="10" />
                                    <ext:ComboBox ID="ComboBox1" runat="server" Width="80" Hidden="true">
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
                                            <Select Handler="#{pnlList}.store.pageSize = parseInt(this.getValue(), 10); #{pageToolBar}.doRefresh(); return false;" />
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
