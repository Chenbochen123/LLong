<%@ Page Language="C#" AutoEventWireup="true" CodeFile="CuringProductMonth.aspx.cs" Inherits="Plugins_Curing_ReportCenter_CuringProductMonth" %>

<%@ Register Assembly="FastReport.Web" Namespace="FastReport.Web" TagPrefix="cc1" %>
<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>日生产报表</title>
    <script type="text/javascript" src="<%= Page.ResolveUrl("~/") %>resources/js/jquery-1.7.1.js"></script>
</head>
<body>
    <form id="form1" runat="server">
         <asp:Button ID="btnExportSubmit" Style="display: none" runat="server" Text="Button"
            OnClick="btnExportSubmit_Click" />
        <ext:ResourceManager runat="server" />
        <ext:Viewport runat="server" Layout="BorderLayout">
            <Items>
                <ext:Panel runat="server" Region="North" Layout="FitLayout">
                    <Items>
                        <ext:Toolbar runat="server">
                            <Items>
                                <ext:ComboBox runat="server" ID="cboYear" FieldLabel="年" LabelAlign="Right" ForceSelection="true" LabelWidth="50">
                                </ext:ComboBox>
                                <ext:ComboBox runat="server" ID="cboMonth" FieldLabel="月" LabelAlign="Right" ForceSelection="true" LabelWidth="50">
                                </ext:ComboBox>
                                <ext:Button runat="server" ID="btnSearch" Text="查询" Icon="Find">
                                    <DirectEvents>
                                        <Click IsUpload="true" OnEvent="btnSearch_Event" />
                                    </DirectEvents>
                                </ext:Button>
                                <ext:Button runat="server" Icon="PageWhiteExcel" Text="导出" ID="btnExport">
                                    <ToolTips>
                                        <ext:ToolTip ID="ToolTip2" runat="server" Html="点击将查询结果导出到Excel中" />
                                    </ToolTips>
                                    <Listeners>
                                        <Click Handler="$('#btnExportSubmit').click();">
                                        </Click>
                                    </Listeners>
                                </ext:Button>
                            </Items>
                        </ext:Toolbar>
                    </Items>
                </ext:Panel>
                <ext:Panel runat="server" Region="Center" Layout="FitLayout">
                    <Items>
                        <ext:GridPanel ID="gridPanelMain" runat="server" Region="Center">
                            <Store>
                                <ext:Store ID="store" runat="server">
                                    <Model>
                                        <ext:Model ID="model" runat="server" IDProperty="PlanInfo">
                                            <Fields>
                                                <ext:ModelField Name="jitai" />
                                                <ext:ModelField Name="guige" />
                                                <ext:ModelField Name="shijiwancheng" />
                                                <ext:ModelField Name="早01" />
                                                <ext:ModelField Name="中01" />
                                                <ext:ModelField Name="晚01" />
                                                <ext:ModelField Name="早02" />
                                                <ext:ModelField Name="中02" />
                                                <ext:ModelField Name="晚02" />
                                                <ext:ModelField Name="早03" />
                                                <ext:ModelField Name="中03" />
                                                <ext:ModelField Name="晚03" />
                                                <ext:ModelField Name="早04" />
                                                <ext:ModelField Name="中04" />
                                                <ext:ModelField Name="晚04" />
                                                <ext:ModelField Name="早05" />
                                                <ext:ModelField Name="中05" />
                                                <ext:ModelField Name="晚05" />
                                                <ext:ModelField Name="早06" />
                                                <ext:ModelField Name="中06" />
                                                <ext:ModelField Name="晚06" />
                                                <ext:ModelField Name="早07" />
                                                <ext:ModelField Name="中07" />
                                                <ext:ModelField Name="晚07" />
                                                <ext:ModelField Name="早08" />
                                                <ext:ModelField Name="中08" />
                                                <ext:ModelField Name="晚08" />
                                                <ext:ModelField Name="早09" />
                                                <ext:ModelField Name="中09" />
                                                <ext:ModelField Name="晚09" />
                                                <ext:ModelField Name="早10" />
                                                <ext:ModelField Name="中10" />
                                                <ext:ModelField Name="晚10" />
                                                <ext:ModelField Name="早11" />
                                                <ext:ModelField Name="中11" />
                                                <ext:ModelField Name="晚11" />
                                                <ext:ModelField Name="早12" />
                                                <ext:ModelField Name="中12" />
                                                <ext:ModelField Name="晚12" />
                                                <ext:ModelField Name="早13" />
                                                <ext:ModelField Name="中13" />
                                                <ext:ModelField Name="晚13" />
                                                <ext:ModelField Name="早14" />
                                                <ext:ModelField Name="中14" />
                                                <ext:ModelField Name="晚14" />
                                                <ext:ModelField Name="早15" />
                                                <ext:ModelField Name="中15" />
                                                <ext:ModelField Name="晚15" />
                                                <ext:ModelField Name="早16" />
                                                <ext:ModelField Name="中16" />
                                                <ext:ModelField Name="晚16" />
                                                <ext:ModelField Name="早17" />
                                                <ext:ModelField Name="中17" />
                                                <ext:ModelField Name="晚17" />
                                                <ext:ModelField Name="早18" />
                                                <ext:ModelField Name="中18" />
                                                <ext:ModelField Name="晚18" />
                                                <ext:ModelField Name="早19" />
                                                <ext:ModelField Name="中19" />
                                                <ext:ModelField Name="晚19" />
                                                <ext:ModelField Name="早20" />
                                                <ext:ModelField Name="中20" />
                                                <ext:ModelField Name="晚20" />
                                                <ext:ModelField Name="早21" />
                                                <ext:ModelField Name="中21" />
                                                <ext:ModelField Name="晚21" />
                                                <ext:ModelField Name="早22" />
                                                <ext:ModelField Name="中22" />
                                                <ext:ModelField Name="晚22" />
                                                <ext:ModelField Name="早23" />
                                                <ext:ModelField Name="中23" />
                                                <ext:ModelField Name="晚23" />
                                                <ext:ModelField Name="早24" />
                                                <ext:ModelField Name="中24" />
                                                <ext:ModelField Name="晚24" />
                                                <ext:ModelField Name="早25" />
                                                <ext:ModelField Name="中25" />
                                                <ext:ModelField Name="晚25" />
                                                <ext:ModelField Name="早26" />
                                                <ext:ModelField Name="中26" />
                                                <ext:ModelField Name="晚26" />
                                                <ext:ModelField Name="早27" />
                                                <ext:ModelField Name="中27" />
                                                <ext:ModelField Name="晚27" />
                                                <ext:ModelField Name="早28" />
                                                <ext:ModelField Name="中28" />
                                                <ext:ModelField Name="晚28" />
                                                <ext:ModelField Name="早29" />
                                                <ext:ModelField Name="中29" />
                                                <ext:ModelField Name="晚29" />
                                                <ext:ModelField Name="早30" />
                                                <ext:ModelField Name="中30" />
                                                <ext:ModelField Name="晚30" />
                                                <ext:ModelField Name="早31" />
                                                <ext:ModelField Name="中31" />
                                                <ext:ModelField Name="晚31" />
                                            </Fields>
                                        </ext:Model>
                                    </Model>
                                </ext:Store>
                            </Store>
                            <ColumnModel ID="colModel" runat="server">
                                <Columns>
                                    <ext:Column runat="server" Text="机台" DataIndex="jitai" Width="60" />
                                    <ext:Column runat="server" Text="规格" DataIndex="guige" Width="60" />
                                    <ext:Column runat="server" Text="实际完成" DataIndex="shijiwancheng" Width="60" Hidden="false" />
                                    <ext:Column runat="server" Text="1日">
                                        <Columns>
                                            <ext:Column runat="server" Text="早" DataIndex="早01" Width="40" />
                                            <ext:Column runat="server" Text="中" DataIndex="中01" Width="40" />
                                            <ext:Column runat="server" Text="晚" DataIndex="晚01" Width="40" />
                                        </Columns>
                                    </ext:Column>
                                    <ext:Column runat="server" Text="2日">
                                        <Columns>
                                            <ext:Column runat="server" Text="早" DataIndex="早02" Width="40" />
                                            <ext:Column runat="server" Text="中" DataIndex="中02" Width="40" />
                                            <ext:Column runat="server" Text="晚" DataIndex="晚02" Width="40" />
                                        </Columns>
                                    </ext:Column>
                                    <ext:Column runat="server" Text="3日">
                                        <Columns>
                                            <ext:Column runat="server" Text="早" DataIndex="早03" Width="40" />
                                            <ext:Column runat="server" Text="中" DataIndex="中03" Width="40" />
                                            <ext:Column runat="server" Text="晚" DataIndex="晚03" Width="40" />
                                        </Columns>
                                    </ext:Column>
                                    <ext:Column runat="server" Text="4日">
                                        <Columns>
                                            <ext:Column runat="server" Text="早" DataIndex="早04" Width="40" />
                                            <ext:Column runat="server" Text="中" DataIndex="中04" Width="40" />
                                            <ext:Column runat="server" Text="晚" DataIndex="晚04" Width="40" />
                                        </Columns>
                                    </ext:Column>
                                    <ext:Column runat="server" Text="5日">
                                        <Columns>
                                            <ext:Column runat="server" Text="早" DataIndex="早05" Width="40" />
                                            <ext:Column runat="server" Text="中" DataIndex="中05" Width="40" />
                                            <ext:Column runat="server" Text="晚" DataIndex="晚05" Width="40" />
                                        </Columns>
                                    </ext:Column>
                                    <ext:Column runat="server" Text="6日">
                                        <Columns>
                                            <ext:Column runat="server" Text="早" DataIndex="早06" Width="40" />
                                            <ext:Column runat="server" Text="中" DataIndex="中06" Width="40" />
                                            <ext:Column runat="server" Text="晚" DataIndex="晚06" Width="40" />
                                        </Columns>
                                    </ext:Column>
                                    <ext:Column runat="server" Text="7日">
                                        <Columns>
                                            <ext:Column runat="server" Text="早" DataIndex="早07" Width="40" />
                                            <ext:Column runat="server" Text="中" DataIndex="中07" Width="40" />
                                            <ext:Column runat="server" Text="晚" DataIndex="晚07" Width="40" />
                                        </Columns>
                                    </ext:Column>
                                    <ext:Column runat="server" Text="8日">
                                        <Columns>
                                            <ext:Column runat="server" Text="早" DataIndex="早08" Width="40" />
                                            <ext:Column runat="server" Text="中" DataIndex="中08" Width="40" />
                                            <ext:Column runat="server" Text="晚" DataIndex="晚08" Width="40" />
                                        </Columns>
                                    </ext:Column>
                                    <ext:Column runat="server" Text="9日">
                                        <Columns>
                                            <ext:Column runat="server" Text="早" DataIndex="早09" Width="40" />
                                            <ext:Column runat="server" Text="中" DataIndex="中09" Width="40" />
                                            <ext:Column runat="server" Text="晚" DataIndex="晚09" Width="40" />
                                        </Columns>
                                    </ext:Column>
                                    <ext:Column runat="server" Text="10日">
                                        <Columns>
                                            <ext:Column runat="server" Text="早" DataIndex="早10" Width="40" />
                                            <ext:Column runat="server" Text="中" DataIndex="中10" Width="40" />
                                            <ext:Column runat="server" Text="晚" DataIndex="晚10" Width="40" />
                                        </Columns>
                                    </ext:Column>
                                    <ext:Column runat="server" Text="11日">
                                        <Columns>
                                            <ext:Column runat="server" Text="早" DataIndex="早11" Width="40" />
                                            <ext:Column runat="server" Text="中" DataIndex="中11" Width="40" />
                                            <ext:Column runat="server" Text="晚" DataIndex="晚11" Width="40" />
                                        </Columns>
                                    </ext:Column>
                                    <ext:Column runat="server" Text="12日">
                                        <Columns>
                                            <ext:Column runat="server" Text="早" DataIndex="早12" Width="40" />
                                            <ext:Column runat="server" Text="中" DataIndex="中12" Width="40" />
                                            <ext:Column runat="server" Text="晚" DataIndex="晚12" Width="40" />
                                        </Columns>
                                    </ext:Column>
                                    <ext:Column runat="server" Text="13日">
                                        <Columns>
                                            <ext:Column runat="server" Text="早" DataIndex="早13" Width="40" />
                                            <ext:Column runat="server" Text="中" DataIndex="中13" Width="40" />
                                            <ext:Column runat="server" Text="晚" DataIndex="晚13" Width="40" />
                                        </Columns>
                                    </ext:Column>
                                    <ext:Column runat="server" Text="14日">
                                        <Columns>
                                            <ext:Column runat="server" Text="早" DataIndex="早14" Width="40" />
                                            <ext:Column runat="server" Text="中" DataIndex="中14" Width="40" />
                                            <ext:Column runat="server" Text="晚" DataIndex="晚14" Width="40" />
                                        </Columns>
                                    </ext:Column>
                                    <ext:Column runat="server" Text="15日">
                                        <Columns>
                                            <ext:Column runat="server" Text="早" DataIndex="早15" Width="40" />
                                            <ext:Column runat="server" Text="中" DataIndex="中15" Width="40" />
                                            <ext:Column runat="server" Text="晚" DataIndex="晚15" Width="40" />
                                        </Columns>
                                    </ext:Column>
                                    <ext:Column runat="server" Text="16日">
                                        <Columns>
                                            <ext:Column runat="server" Text="早" DataIndex="早16" Width="40" />
                                            <ext:Column runat="server" Text="中" DataIndex="中16" Width="40" />
                                            <ext:Column runat="server" Text="晚" DataIndex="晚16" Width="40" />
                                        </Columns>
                                    </ext:Column>
                                    <ext:Column runat="server" Text="17日">
                                        <Columns>
                                            <ext:Column runat="server" Text="早" DataIndex="早17" Width="40" />
                                            <ext:Column runat="server" Text="中" DataIndex="中17" Width="40" />
                                            <ext:Column runat="server" Text="晚" DataIndex="晚17" Width="40" />
                                        </Columns>
                                    </ext:Column>
                                    <ext:Column runat="server" Text="18日">
                                        <Columns>
                                            <ext:Column runat="server" Text="早" DataIndex="早18" Width="40" />
                                            <ext:Column runat="server" Text="中" DataIndex="中18" Width="40" />
                                            <ext:Column runat="server" Text="晚" DataIndex="晚18" Width="40" />
                                        </Columns>
                                    </ext:Column>
                                    <ext:Column runat="server" Text="19日">
                                        <Columns>
                                            <ext:Column runat="server" Text="早" DataIndex="早19" Width="40" />
                                            <ext:Column runat="server" Text="中" DataIndex="中19" Width="40" />
                                            <ext:Column runat="server" Text="晚" DataIndex="晚19" Width="40" />
                                        </Columns>
                                    </ext:Column>
                                    <ext:Column runat="server" Text="20日">
                                        <Columns>
                                            <ext:Column runat="server" Text="早" DataIndex="早20" Width="40" />
                                            <ext:Column runat="server" Text="中" DataIndex="中20" Width="40" />
                                            <ext:Column runat="server" Text="晚" DataIndex="晚20" Width="40" />
                                        </Columns>
                                    </ext:Column>
                                    <ext:Column runat="server" Text="21日">
                                        <Columns>
                                            <ext:Column runat="server" Text="早" DataIndex="早21" Width="40" />
                                            <ext:Column runat="server" Text="中" DataIndex="中21" Width="40" />
                                            <ext:Column runat="server" Text="晚" DataIndex="晚21" Width="40" />
                                        </Columns>
                                    </ext:Column>
                                    <ext:Column runat="server" Text="22日">
                                        <Columns>
                                            <ext:Column runat="server" Text="早" DataIndex="早22" Width="40" />
                                            <ext:Column runat="server" Text="中" DataIndex="中22" Width="40" />
                                            <ext:Column runat="server" Text="晚" DataIndex="晚22" Width="40" />
                                        </Columns>
                                    </ext:Column>
                                    <ext:Column runat="server" Text="23日">
                                        <Columns>
                                            <ext:Column runat="server" Text="早" DataIndex="早23" Width="40" />
                                            <ext:Column runat="server" Text="中" DataIndex="中23" Width="40" />
                                            <ext:Column runat="server" Text="晚" DataIndex="晚23" Width="40" />
                                        </Columns>
                                    </ext:Column>
                                    <ext:Column runat="server" Text="24日">
                                        <Columns>
                                            <ext:Column runat="server" Text="早" DataIndex="早24" Width="40" />
                                            <ext:Column runat="server" Text="中" DataIndex="中24" Width="40" />
                                            <ext:Column runat="server" Text="晚" DataIndex="晚24" Width="40" />
                                        </Columns>
                                    </ext:Column>
                                    <ext:Column runat="server" Text="25日">
                                        <Columns>
                                            <ext:Column runat="server" Text="早" DataIndex="早25" Width="40" />
                                            <ext:Column runat="server" Text="中" DataIndex="中25" Width="40" />
                                            <ext:Column runat="server" Text="晚" DataIndex="晚25" Width="40" />
                                        </Columns>
                                    </ext:Column>
                                    <ext:Column runat="server" Text="26日">
                                        <Columns>
                                            <ext:Column runat="server" Text="早" DataIndex="早26" Width="40" />
                                            <ext:Column runat="server" Text="中" DataIndex="中26" Width="40" />
                                            <ext:Column runat="server" Text="晚" DataIndex="晚26" Width="40" />
                                        </Columns>
                                    </ext:Column>
                                    <ext:Column runat="server" Text="27日">
                                        <Columns>
                                            <ext:Column runat="server" Text="早" DataIndex="早27" Width="40" />
                                            <ext:Column runat="server" Text="中" DataIndex="中27" Width="40" />
                                            <ext:Column runat="server" Text="晚" DataIndex="晚27" Width="40" />
                                        </Columns>
                                    </ext:Column>
                                    <ext:Column runat="server" Text="28日">
                                        <Columns>
                                            <ext:Column runat="server" Text="早" DataIndex="早28" Width="40" />
                                            <ext:Column runat="server" Text="中" DataIndex="中28" Width="40" />
                                            <ext:Column runat="server" Text="晚" DataIndex="晚28" Width="40" />
                                        </Columns>
                                    </ext:Column>
                                    <ext:Column runat="server" Text="29日">
                                        <Columns>
                                            <ext:Column runat="server" Text="早" DataIndex="早29" Width="40" />
                                            <ext:Column runat="server" Text="中" DataIndex="中29" Width="40" />
                                            <ext:Column runat="server" Text="晚" DataIndex="晚29" Width="40" />
                                        </Columns>
                                    </ext:Column>
                                    <ext:Column runat="server" Text="30日">
                                        <Columns>
                                            <ext:Column runat="server" Text="早" DataIndex="早30" Width="40" />
                                            <ext:Column runat="server" Text="中" DataIndex="中30" Width="40" />
                                            <ext:Column runat="server" Text="晚" DataIndex="晚30" Width="40" />
                                        </Columns>
                                    </ext:Column>
                                    <ext:Column runat="server" Text="31日">
                                        <Columns>
                                            <ext:Column runat="server" Text="早" DataIndex="早31" Width="40" />
                                            <ext:Column runat="server" Text="中" DataIndex="中31" Width="40" />
                                            <ext:Column runat="server" Text="晚" DataIndex="晚31" Width="40" />
                                        </Columns>
                                    </ext:Column>
                                </Columns>
                            </ColumnModel>
                            <SelectionModel>
                                <ext:CheckboxSelectionModel ID="CheckboxSelectionModel1" runat="server" Mode="Multi" />
                            </SelectionModel>
                        </ext:GridPanel>
                    </Items>
                </ext:Panel>
            </Items>
        </ext:Viewport>
    </form>
</body>
</html>
