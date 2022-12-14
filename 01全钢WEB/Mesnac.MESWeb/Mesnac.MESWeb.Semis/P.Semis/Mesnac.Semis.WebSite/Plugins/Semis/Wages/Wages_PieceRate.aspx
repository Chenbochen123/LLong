<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Wages_PieceRate.aspx.cs" Inherits="Plugins_Semis_Wages_Wages_PieceRate" %>

<%@ Register Assembly="Ext.Net" Namespace="Ext.Net" TagPrefix="ext" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml"> 
<head runat="server">
    
    <title>复合工资计算明细</title>
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
        //仅合计一行显示
        var formt = function (value, rowIndex,record) {
            let result ="";
            if (record.data["WORK_DATE"] == "合计")
                result = value;
            return result
        }
        var SetRowClass = function (record, rowIndex, rowParams, store) {
            if (record.get("WORK_DATE") == "合计") {
               
                return "x-grid-row-green";
            }
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
                <ext:Panel ID="prStorage" runat="server" Region="North"  AutoHeight="true">
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
                                        <ext:DateField ID="begindate" runat="server" FieldLabel="开始日期" LabelAlign="Right" Editable="true">
                                        </ext:DateField>
                                    </Items>
                                </ext:Container>
                                <ext:Container ID="container4" runat="server" Layout="FormLayout" ColumnWidth=".20"
                                    Padding="5">
                                    <Items>
                                        <ext:DateField ID="enddate" runat="server" FieldLabel="结束日期" LabelAlign="Right" Editable="true">
                                        </ext:DateField>
                                    </Items>
                                </ext:Container>
                                <ext:Container ID="container3" runat="server" Layout="FormLayout" ColumnWidth=".20"
                                    Padding="5">
                                    <Items>
                                        <ext:ComboBox ID="cbxEquipname" runat="server" FieldLabel="产线" LabelAlign="Right" Editable="false">
                                        </ext:ComboBox>
                                    </Items>
                                </ext:Container>
                                <ext:Container ID="container2" runat="server" Layout="FormLayout" ColumnWidth=".20"
                                    Padding="5">
                                    <Items>
                                        <ext:ComboBox ID="cbxclass" runat="server" FieldLabel="班组" LabelAlign="Right"
                                            Editable="false">
                                            <Items>
                                                
                                                <ext:ListItem Text="甲" Value="甲">
                                                </ext:ListItem>
                                                <ext:ListItem Text="乙" Value="乙">
                                                </ext:ListItem>
                                                <ext:ListItem Text="丙" Value="丙">
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
                                  
                                  <ext:Container ID="container7" runat="server" Layout="FormLayout" ColumnWidth=".20"
                                    Padding="5" Hidden="false">
                                    <Items>
                                        <ext:ComboBox ID="cbxbom" runat="server" FieldLabel="型号" LabelAlign="Right" Editable="false">
                                        </ext:ComboBox>
                                    </Items>
                                </ext:Container>
                                <ext:Container ID="container6" runat="server" Layout="FormLayout" ColumnWidth=".20"
                                    Padding="5" Hidden="false">
                                    <Items>
                                        <ext:ComboBox ID="cbxtype" runat="server" FieldLabel="物料细类" LabelAlign="Right" Editable="false">
                                        </ext:ComboBox>
                                    </Items>
                                </ext:Container>
                              <ext:Container ID="container5" runat="server" Layout="FormLayout" ColumnWidth=".20"
                                    Padding="5" Hidden="false">
                                    <Items>
                                        <ext:TextField ID="txtUsername" runat="server" FieldLabel="人员名称" LabelAlign="Right" Editable="false">
                                        </ext:TextField>
                                    </Items>
                                </ext:Container>
                            </Items>
                        </ext:FormPanel>
                    </Items>
                </ext:Panel>
              
                <ext:Panel ID="pnlDetail" runat="server" Title="复合工资计算报表"  Height="500" Region="Center" Frame="true" Layout="Fit" MarginsSummary="0 5 5 5">
                    <Items>
                        <ext:GridPanel ID="pnlList" runat="server" >
                            <Store>
                                <ext:Store runat="server" ID="store" PageSize="10">
                                    <Proxy>
                                        <ext:PageProxy DirectFn="App.direct.GetSelectData" />
                                    </Proxy>
                                    <Model>
                                        <ext:Model runat="server">
                                            <Fields>
                                                <ext:ModelField Name="WORK_DATE" />
                                                <ext:ModelField Name="USER_NAME" />
                                                <ext:ModelField Name="CLASS" />
                                                <ext:ModelField Name="WORK_NAME" />
                                                <ext:ModelField Name="ONDUTY_HOUR" />
                                                <ext:ModelField Name="USER_COUNT" />
                                                <ext:ModelField Name="EQUIP_NAME" />
                                                <ext:ModelField Name="ONDUTY_DAY" />
                                                <ext:ModelField Name="8点出勤" />
                                                <ext:ModelField Name="12点出勤" />
                                                <ext:ModelField Name="REALNUM" />
                                                <ext:ModelField Name="MATERIAL_TYPE" />
                                                <ext:ModelField Name="MINOR_TYPE_NAME" />
                                                <ext:ModelField Name="新台账重量" />
                                                <ext:ModelField Name="STANDARD_INFO" />
                                                <ext:ModelField Name="折算定额" />
                                                <ext:ModelField Name="换胶料20min/次" />
                                                <ext:ModelField Name="换预口型4min/次" />
                                                <ext:ModelField Name="换口型板2min/次" />
                                               
                                                <ext:ModelField Name="更换流道20min/次" />
                                                <ext:ModelField Name="试制20min/次" />
                                                <ext:ModelField Name="清理总耗时" />
                                                <ext:ModelField Name="完成工时" />
                                                <ext:ModelField Name="定额完成率" />
                                                <ext:ModelField Name="SKILL_BASE" />
                                                <ext:ModelField Name="BONUS_BASE" />
                                                <ext:ModelField Name="折合技能工资基础" />
                                                <ext:ModelField Name="折合奖金基数" />
                                                <ext:ModelField Name="折合奖金基数" />
                                                <ext:ModelField Name="实际技能奖金" />
                                                <ext:ModelField Name="实际奖金" />
                                                  <ext:ModelField Name="8点奖金" />
                                                <ext:ModelField Name="加班奖金" />
                                                <ext:ModelField Name="8点技能" />
                                                <ext:ModelField Name="加班技能" />
                                                <ext:ModelField Name="标准岗位工资" />
                                                <ext:ModelField Name="8点岗位工资" />
                                                <ext:ModelField Name="加班岗位工资" />
                                            </Fields>
                                        </ext:Model>
                                    </Model>
                                </ext:Store>
                            </Store>
                            <ColumnModel>
                                <Columns>
                                  <%--<ext:RowNumbererColumn ID="rowNumCol1" runat="server" Width="35" />--%>
                                    <ext:Column ID="DateColumn1" runat="server" Text="实际日期" DataIndex="WORK_DATE"  />
                                    <ext:Column ID="Column1" runat="server" Text="姓名" DataIndex="USER_NAME" />
                                    <ext:Column ID="Column2" runat="server" Text="班组" DataIndex="CLASS" />
                                    <ext:Column ID="Column3" runat="server" Text="岗位" DataIndex="WORK_NAME" />
                                    <ext:Column ID="Column4" runat="server" Text="总工时" DataIndex="ONDUTY_HOUR" Flex="1"/>
                                    <ext:Column ID="Column5" runat="server" Text="定岗人数" DataIndex="USER_COUNT"  />
                                    <ext:Column ID="Column6" runat="server" Text="生产线" DataIndex="EQUIP_NAME"  />
                                    <ext:Column ID="Column7" runat="server" Text="出勤" DataIndex="ONDUTY_DAY" />
                                    <ext:Column ID="Column8" runat="server" Text="8点出勤" DataIndex="8点出勤" />
                                    <ext:Column ID="Column9" runat="server" Text="12点出勤" DataIndex="12点出勤" />
                                    <ext:Column ID="Column10" runat="server" Text="实有人数" DataIndex="REALNUM" >
                                        <Renderer Fn="formt" />
                                    </ext:Column>
                                    <ext:Column ID="Column11" runat="server" Text="型号" DataIndex="MATERIAL_TYPE" />
                                    <ext:Column ID="Column12" runat="server" Text="半部件" DataIndex="MINOR_TYPE_NAME" />
                                    <ext:Column ID="Column13" runat="server" Text="新台账重量" DataIndex="新台账重量" />
                                    <ext:Column ID="Column14" runat="server" Text="定额" DataIndex="STANDARD_INFO" />
                                    <ext:Column ID="Column15" runat="server" Text="折算定额" DataIndex="折算定额" />
                                    <ext:Column ID="Column16" runat="server" Text="换胶料20min/次" DataIndex="换胶料20min/次" >
                                         <Renderer Fn="formt" />
                                    </ext:Column>
                                    <ext:Column ID="Column17" runat="server" Text="换预口型4min/次" DataIndex="换预口型4min/次" >
                                         <Renderer Fn="formt" />
                                    </ext:Column>
                                    <ext:Column ID="Column18" runat="server" Text="换口型板2min/次" DataIndex="换口型板2min/次" >
                                         <Renderer Fn="formt" />
                                    </ext:Column>
                                    <ext:Column ID="Column19" runat="server" Text="更换流道20min/次" DataIndex="更换流道20min/次" Flex="1">
                                         <Renderer Fn="formt" />
                                    </ext:Column>
                                    <ext:Column ID="Column20" runat="server" Text="试制20min/次" DataIndex="试制20min/次" >
                                         <Renderer Fn="formt" />
                                    </ext:Column>
                                    <ext:Column ID="Column21" runat="server" Text="清理耗时" DataIndex="清理总耗时" Flex="1">
                                         <Renderer Fn="formt" />
                                    </ext:Column>
                                    <ext:Column ID="Column22" runat="server" Text="完成工时" DataIndex="完成工时" />
                                    <ext:Column ID="Column23" runat="server" Text="定额完成率" DataIndex="定额完成率" />
                                    <ext:Column ID="Column24" runat="server" Text="技能工资基数" DataIndex="SKILL_BASE" />
                                    <ext:Column ID="Column25" runat="server" Text="奖金基数" DataIndex="BONUS_BASE" />
                                    <ext:Column ID="Column26" runat="server" Text="折合技能基数" DataIndex="折合技能工资基础" />
                                    <ext:Column ID="Column27" runat="server" Text="折合奖金基数" DataIndex="折合奖金基数" />
                                    <ext:Column ID="Column28" runat="server" Text="实际技能奖金" DataIndex="实际技能奖金" />
                                    <ext:Column ID="Column29" runat="server" Text="实际奖金" DataIndex="实际奖金" />
                                    <ext:Column ID="Column30" runat="server" Text="8点技能" DataIndex="8点技能" />
                                    <ext:Column ID="Column31" runat="server" Text="加班技能" DataIndex="加班技能" />
                                    <ext:Column ID="Column32" runat="server" Text="8点奖金" DataIndex="8点奖金" />
                                    <ext:Column ID="Column33" runat="server" Text="加班奖金" DataIndex="加班奖金" />
                                    <ext:Column ID="Column34" runat="server" Text="标准岗位工资" DataIndex="标准岗位工资" />
                                    <ext:Column ID="Column35" runat="server" Text="8点岗位工资" DataIndex="8点岗位工资" />
                                    <ext:Column ID="Column36" runat="server" Text="加班岗位工资" DataIndex="加班岗位工资" />
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
                </ext:Panel>
            </Items>
        </ext:Viewport>
    </form>
</body>
</html>
