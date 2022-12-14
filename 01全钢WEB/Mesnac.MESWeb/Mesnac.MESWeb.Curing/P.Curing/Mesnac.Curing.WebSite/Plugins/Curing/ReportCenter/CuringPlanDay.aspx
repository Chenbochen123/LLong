<%@ Page Language="C#" AutoEventWireup="true" CodeFile="CuringPlanDay.aspx.cs" Inherits="Plugins_Curing_ReportCenter_CuringPlanDay" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>日计划完成率</title>
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
                                <ext:DateField runat="server" ID="txtDate" FieldLabel="日期" LabelAlign="Right" ForceSelection="true" LabelWidth="50">
                                </ext:DateField>
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
                                                <ext:ModelField Name="guige" />
                                                <ext:ModelField Name="sap" />
                                                <ext:ModelField Name="jitai" />
                                                <ext:ModelField Name="jitaishu" />
                                                <ext:ModelField Name="rijihua" />
                                                <ext:ModelField Name="riwancheng" />
                                                <ext:ModelField Name="riwanchenglv" />
                                                <ext:ModelField Name="zhjihua" />
                                                <ext:ModelField Name="zhwancheng" />
                                                <ext:ModelField Name="zhwanchenglv" />
                                                <ext:ModelField Name="yejihua" />
                                                <ext:ModelField Name="yewancheng" />
                                                <ext:ModelField Name="yewanchenglv" />
                                                <ext:ModelField Name="zaojihua" />
                                                <ext:ModelField Name="zaowancheng" />
                                                <ext:ModelField Name="zaowanchenglv" />
                                            </Fields>
                                        </ext:Model>
                                    </Model>
                                </ext:Store>
                            </Store>
                            <ColumnModel ID="colModel" runat="server">
                                <Columns>
                                    <ext:Column runat="server" Text="规格" DataIndex="guige" Width="180" />
                                    <ext:Column runat="server" Text="sap" DataIndex="sap" Width="100" />
                                    <ext:Column runat="server" Text="机台" DataIndex="jitai" Width="60" Hidden="false" />
                                    <ext:Column runat="server" Text="机台数" DataIndex="jitaishu" Width="60" Hidden="false" />
                                    <ext:Column runat="server" Text="日计划" DataIndex="rijihua" Width="60" Hidden="false" />
                                    <ext:Column runat="server" Text="日完成" DataIndex="riwancheng" Width="60" Hidden="false" />
                                    <ext:Column runat="server" Text="日完成率" DataIndex="riwanchenglv" Width="60" Hidden="false" />
                                    <ext:Column runat="server" Text="中班">
                                        <Columns>
                                            <ext:Column runat="server" Text="计划" DataIndex="zhjihua" Width="40" />
                                            <ext:Column runat="server" Text="完成" DataIndex="zhwancheng" Width="40" />
                                            <ext:Column runat="server" Text="完成率" DataIndex="zhwanchenglv" Width="60" />
                                        </Columns>
                                    </ext:Column>
                                    <ext:Column runat="server" Text="夜班">
                                        <Columns>
                                             <ext:Column runat="server" Text="计划" DataIndex="yejihua" Width="40" />
                                            <ext:Column runat="server" Text="完成" DataIndex="yewancheng" Width="40" />
                                            <ext:Column runat="server" Text="完成率" DataIndex="yewanchenglv" Width="60" />
                                        </Columns>
                                    </ext:Column>
                                    <ext:Column runat="server" Text="早班">
                                        <Columns>
                                            <ext:Column runat="server" Text="计划" DataIndex="zaojihua" Width="40" />
                                            <ext:Column runat="server" Text="完成" DataIndex="zaowancheng" Width="40" />
                                            <ext:Column runat="server" Text="完成率" DataIndex="zaowanchenglv" Width="60" />
                                        </Columns>
                                    </ext:Column>
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
