<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Wages_PieceRateSUM.aspx.cs" Inherits="Plugins_Semis_Wages_Wages_PieceRateSUM" %>


<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>复合工资月计算</title>
    <script type="text/javascript" src="<%= Page.ResolveUrl("~/") %>resources/js/jquery-1.7.1.js"></script>
    <link rel="Stylesheet" type="text/css" href="<%= Page.ResolveUrl("~/") %>resources/css/ext-chinese-font.css" />
    <link rel="Stylesheet" type="text/css" href="<%= Page.ResolveUrl("~/") %>resources/css/main.css" />
    <script type="text/javascript">

        //查询
        var search = function () {
            App.store.currentPage = 1;
            App.pageToolBar.doRefresh();
            return false;
        }

    </script>
</head>
<body>
    <form id="form1" runat="server">
        <asp:Button ID="btnExportSubmit" Style="display: none" runat="server" Text="Button"
            OnClick="btnExportSubmit_Click" />
        <ext:ResourceManager ID="rmMoldingStorage" runat="server" />
        <ext:Viewport ID="vpMoldingStorage" runat="server" Layout="border">
            <Items>
                <ext:Panel ID="prStorage" runat="server" Region="North" AutoHeight="true">
                    <TopBar>
                        <ext:Toolbar runat="server" ID="tbMoldingStorage">
                            <Items>
                                <ext:Button runat="server" Icon="Find" Text="查询" ID="btnSearch">
                                    <Listeners>
                                        <Click Fn="search">
                                        </Click>
                                    </Listeners>
                                </ext:Button>
                                <ext:ToolbarSeparator ID="ToolbarSeparator1" />
                                <ext:Button runat="server" Icon="PageExcel" Text="导出Excel" ID="btnExport">
                                    <ToolTips>
                                        <ext:ToolTip ID="ToolTip2" runat="server" Html="点击将查询结果导出到Excel中" />
                                    </ToolTips>
                                    <Listeners>
                                        <Click Handler="$('#btnExportSubmit').click();">
                                        </Click>
                                    </Listeners>
                                </ext:Button>
                                <ext:ToolbarFill ID="tfEnd" />
                            </Items>
                        </ext:Toolbar>
                    </TopBar>
                    <Items>
                        <ext:FormPanel runat="server" ID="TextList" Layout="ColumnLayout">
                            <Items>
                                <ext:Container ID="container1" runat="server" Layout="FormLayout" ColumnWidth=".20" Padding="5">
                                    <Items>
                                        <ext:DateField ID="begindate" runat="server" FieldLabel="月份" LabelAlign="Right" Editable="true" Format="yyyy-MM">
                                        </ext:DateField>
                                    </Items>
                                </ext:Container>
                             
                                <ext:Container ID="container5" runat="server" Layout="FormLayout" ColumnWidth=".20"
                                    Padding="5">
                                    <Items>
                                        <ext:TextField ID="txtUsername" runat="server" FieldLabel="人员名称" LabelAlign="Right" Editable="false">
                                        </ext:TextField>
                                    </Items>
                                </ext:Container>
                            </Items>
                        </ext:FormPanel>
                    </Items>
                </ext:Panel>

                <ext:Panel ID="pnlDetail" runat="server" Title="复合工资计算" Height="500" Region="Center" Frame="true" Layout="Fit" MarginsSummary="0 5 5 5">
                    <Items>
                        <ext:GridPanel ID="pnlList" runat="server">
                            <Store>
                                <ext:Store runat="server" ID="store" PageSize="10">
                                    <Proxy>
                                        <ext:PageProxy DirectFn="App.direct.GetSelectData" />
                                    </Proxy>
                                    <Model>
                                        <ext:Model runat="server">
                                            <Fields>                                            
                                                <ext:ModelField Name="USER_NAME" />                                             
                                                <ext:ModelField Name="WORK_NAME" />                                                                                       
                                                <ext:ModelField Name="ONDUTY_DAY" />
                                                <ext:ModelField Name="8点出勤" />
                                                <ext:ModelField Name="12点出勤" />
                                                <ext:ModelField Name="8点奖金" />
                                                <ext:ModelField Name="加班奖金" />
                                                <ext:ModelField Name="8点技能" />
                                                <ext:ModelField Name="加班技能" />
                                                <ext:ModelField Name="8点岗位工资" />
                                                <ext:ModelField Name="加班岗位工资" />
                                                 <ext:ModelField Name="SUMPIECE" />
                                            </Fields>
                                        </ext:Model>
                                    </Model>
                                </ext:Store>
                            </Store>
                            <ColumnModel>
                                <Columns>
                             
                                    <ext:Column ID="Column1" runat="server" Text="姓名" DataIndex="USER_NAME" />
                                  
                                    <ext:Column ID="Column3" runat="server" Text="岗位" DataIndex="WORK_NAME" />
                                 
                                    <ext:Column ID="Column7" runat="server" Text="出勤" DataIndex="ONDUTY_DAY" />
                                    <ext:Column ID="Column8" runat="server" Text="8点出勤" DataIndex="8点出勤" />
                                    <ext:Column ID="Column9" runat="server" Text="12点出勤" DataIndex="12点出勤" />
                                    
                                    <ext:Column ID="Column30" runat="server" Text="8点技能" DataIndex="8点技能" />
                                    <ext:Column ID="Column31" runat="server" Text="加班技能" DataIndex="加班技能" />
                                    <ext:Column ID="Column32" runat="server" Text="8点奖金" DataIndex="8点奖金" />
                                    <ext:Column ID="Column33" runat="server" Text="加班奖金" DataIndex="加班奖金" />
                                   
                                    <ext:Column ID="Column35" runat="server" Text="8点岗位工资" DataIndex="8点岗位工资" />
                                    <ext:Column ID="Column36" runat="server" Text="加班岗位工资" DataIndex="加班岗位工资" />
                                     <ext:Column ID="Column2" runat="server" Text="工资总合计" DataIndex="SUMPIECE" />
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
                </ext:Panel>
            </Items>
        </ext:Viewport>
    </form>
</body>
</html>
