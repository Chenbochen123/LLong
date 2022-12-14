<%@ page language="C#" autoeventwireup="true" inherits="Plugins_Storage_Report_InStorageMonth, Mesnac.Storage.WebSite" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>成品胎入库月报表</title>
</head>
<body>
    <form id="form1" runat="server">
        <ext:ResourceManager runat="server" />
        <ext:Viewport runat="server" Layout="BorderLayout">
            <Items>
                <ext:Panel runat="server" Region="North" Layout="FitLayout">
                    <Items>
                        <ext:Toolbar runat="server">
                            <Items>
                                <ext:DateField  runat="server" Type="Month" ID="txtDate" FieldLabel="日期" LabelAlign="Right" ForceSelection="true" LabelWidth="50">
                                </ext:DateField>
                                <ext:ComboBox runat="server" ID="storeName" FieldLabel="仓库" LabelAlign="Right">
                                    <Triggers>
                                   <ext:FieldTrigger Icon="Clear" Qtip="Remove selected" />
                                    </Triggers>
                                        <Listeners>
                                        <TriggerClick Handler="this.clearValue();" />
                                        </Listeners>
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
                                    <DirectEvents>
                                        <Click IsUpload="true" OnEvent="btnExportSubmit_Click"></Click>
                                    </DirectEvents>
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
                                                <ext:ModelField Name="shijiwancheng" />
                                                <ext:ModelField Name="甲01" />
                                                <ext:ModelField Name="乙01" />
                                                <ext:ModelField Name="丙01" />
                                                <ext:ModelField Name="甲02" />
                                                <ext:ModelField Name="乙02" />
                                                <ext:ModelField Name="丙02" />
                                                <ext:ModelField Name="甲03" />
                                                <ext:ModelField Name="乙03" />
                                                <ext:ModelField Name="丙03" />
                                                <ext:ModelField Name="甲04" />
                                                <ext:ModelField Name="乙04" />
                                                <ext:ModelField Name="丙04" />
                                                <ext:ModelField Name="甲05" />
                                                <ext:ModelField Name="乙05" />
                                                <ext:ModelField Name="丙05" />
                                                <ext:ModelField Name="甲06" />
                                                <ext:ModelField Name="乙06" />
                                                <ext:ModelField Name="丙06" />
                                                <ext:ModelField Name="甲07" />
                                                <ext:ModelField Name="乙07" />
                                                <ext:ModelField Name="丙07" />
                                                <ext:ModelField Name="甲08" />
                                                <ext:ModelField Name="乙08" />
                                                <ext:ModelField Name="丙08" />
                                                <ext:ModelField Name="甲09" />
                                                <ext:ModelField Name="乙09" />
                                                <ext:ModelField Name="丙09" />
                                                <ext:ModelField Name="甲10" />
                                                <ext:ModelField Name="乙10" />
                                                <ext:ModelField Name="丙10" />
                                                <ext:ModelField Name="甲11" />
                                                <ext:ModelField Name="乙11" />
                                                <ext:ModelField Name="丙11" />
                                                <ext:ModelField Name="甲12" />
                                                <ext:ModelField Name="乙12" />
                                                <ext:ModelField Name="丙12" />
                                                <ext:ModelField Name="甲13" />
                                                <ext:ModelField Name="乙13" />
                                                <ext:ModelField Name="丙13" />
                                                <ext:ModelField Name="甲14" />
                                                <ext:ModelField Name="乙14" />
                                                <ext:ModelField Name="丙14" />
                                                <ext:ModelField Name="甲15" />
                                                <ext:ModelField Name="乙15" />
                                                <ext:ModelField Name="丙15" />
                                                <ext:ModelField Name="甲16" />
                                                <ext:ModelField Name="乙16" />
                                                <ext:ModelField Name="丙16" />
                                                <ext:ModelField Name="甲17" />
                                                <ext:ModelField Name="乙17" />
                                                <ext:ModelField Name="丙17" />
                                                <ext:ModelField Name="甲18" />
                                                <ext:ModelField Name="乙18" />
                                                <ext:ModelField Name="丙18" />
                                                <ext:ModelField Name="甲19" />
                                                <ext:ModelField Name="乙19" />
                                                <ext:ModelField Name="丙19" />
                                                <ext:ModelField Name="甲20" />
                                                <ext:ModelField Name="乙20" />
                                                <ext:ModelField Name="丙20" />
                                                <ext:ModelField Name="甲21" />
                                                <ext:ModelField Name="乙21" />
                                                <ext:ModelField Name="丙21" />
                                                <ext:ModelField Name="甲22" />
                                                <ext:ModelField Name="乙22" />
                                                <ext:ModelField Name="丙22" />
                                                <ext:ModelField Name="甲23" />
                                                <ext:ModelField Name="乙23" />
                                                <ext:ModelField Name="丙23" />
                                                <ext:ModelField Name="甲24" />
                                                <ext:ModelField Name="乙24" />
                                                <ext:ModelField Name="丙24" />
                                                <ext:ModelField Name="甲25" />
                                                <ext:ModelField Name="乙25" />
                                                <ext:ModelField Name="丙25" />
                                                <ext:ModelField Name="甲26" />
                                                <ext:ModelField Name="乙26" />
                                                <ext:ModelField Name="丙26" />
                                                <ext:ModelField Name="甲27" />
                                                <ext:ModelField Name="乙27" />
                                                <ext:ModelField Name="丙27" />
                                                <ext:ModelField Name="甲28" />
                                                <ext:ModelField Name="乙28" />
                                                <ext:ModelField Name="丙28" />
                                                <ext:ModelField Name="甲29" />
                                                <ext:ModelField Name="乙29" />
                                                <ext:ModelField Name="丙29" />
                                                <ext:ModelField Name="甲30" />
                                                <ext:ModelField Name="乙30" />
                                                <ext:ModelField Name="丙30" />
                                                <ext:ModelField Name="甲31" />
                                                <ext:ModelField Name="乙31" />
                                                <ext:ModelField Name="丙31" />
                                            </Fields>
                                        </ext:Model>
                                    </Model>
                                </ext:Store>
                            </Store>
                            <ColumnModel ID="colModel" runat="server">
                                <Columns>
                                    <ext:Column runat="server" Text="规格" DataIndex="guige" Width="280" />
                                    <ext:Column runat="server" Text="实际完成" DataIndex="shijiwancheng" Width="60" Hidden="false" />
                                    <ext:Column runat="server" Text="1日">
                                        <Columns>
                                            <ext:Column runat="server" Text="甲" DataIndex="甲01" Width="40" />
                                            <ext:Column runat="server" Text="乙" DataIndex="乙01" Width="40" />
                                            <ext:Column runat="server" Text="丙" DataIndex="丙01" Width="40" />
                                        </Columns>
                                    </ext:Column>
                                    <ext:Column runat="server" Text="2日">
                                        <Columns>
                                            <ext:Column runat="server" Text="甲" DataIndex="甲02" Width="40" />
                                            <ext:Column runat="server" Text="乙" DataIndex="乙02" Width="40" />
                                            <ext:Column runat="server" Text="丙" DataIndex="丙02" Width="40" />
                                        </Columns>
                                    </ext:Column>
                                    <ext:Column runat="server" Text="3日">
                                        <Columns>
                                            <ext:Column runat="server" Text="甲" DataIndex="甲03" Width="40" />
                                            <ext:Column runat="server" Text="乙" DataIndex="乙03" Width="40" />
                                            <ext:Column runat="server" Text="丙" DataIndex="丙03" Width="40" />
                                        </Columns>
                                    </ext:Column>
                                    <ext:Column runat="server" Text="4日">
                                        <Columns>
                                            <ext:Column runat="server" Text="甲" DataIndex="甲04" Width="40" />
                                            <ext:Column runat="server" Text="乙" DataIndex="乙04" Width="40" />
                                            <ext:Column runat="server" Text="丙" DataIndex="丙04" Width="40" />
                                        </Columns>
                                    </ext:Column>
                                    <ext:Column runat="server" Text="5日">
                                        <Columns>
                                            <ext:Column runat="server" Text="甲" DataIndex="甲05" Width="40" />
                                            <ext:Column runat="server" Text="乙" DataIndex="乙05" Width="40" />
                                            <ext:Column runat="server" Text="丙" DataIndex="丙05" Width="40" />
                                        </Columns>
                                    </ext:Column>
                                    <ext:Column runat="server" Text="6日">
                                        <Columns>
                                            <ext:Column runat="server" Text="甲" DataIndex="甲06" Width="40" />
                                            <ext:Column runat="server" Text="乙" DataIndex="乙06" Width="40" />
                                            <ext:Column runat="server" Text="丙" DataIndex="丙06" Width="40" />
                                        </Columns>
                                    </ext:Column>
                                    <ext:Column runat="server" Text="7日">
                                        <Columns>
                                            <ext:Column runat="server" Text="甲" DataIndex="甲07" Width="40" />
                                            <ext:Column runat="server" Text="乙" DataIndex="乙07" Width="40" />
                                            <ext:Column runat="server" Text="丙" DataIndex="丙07" Width="40" />
                                        </Columns>
                                    </ext:Column>
                                    <ext:Column runat="server" Text="8日">
                                        <Columns>
                                            <ext:Column runat="server" Text="甲" DataIndex="甲08" Width="40" />
                                            <ext:Column runat="server" Text="乙" DataIndex="乙08" Width="40" />
                                            <ext:Column runat="server" Text="丙" DataIndex="丙08" Width="40" />
                                        </Columns>
                                    </ext:Column>
                                    <ext:Column runat="server" Text="9日">
                                        <Columns>
                                            <ext:Column runat="server" Text="甲" DataIndex="甲09" Width="40" />
                                            <ext:Column runat="server" Text="乙" DataIndex="乙09" Width="40" />
                                            <ext:Column runat="server" Text="丙" DataIndex="丙09" Width="40" />
                                        </Columns>
                                    </ext:Column>
                                    <ext:Column runat="server" Text="10日">
                                        <Columns>
                                            <ext:Column runat="server" Text="甲" DataIndex="甲10" Width="40" />
                                            <ext:Column runat="server" Text="乙" DataIndex="乙10" Width="40" />
                                            <ext:Column runat="server" Text="丙" DataIndex="丙10" Width="40" />
                                        </Columns>
                                    </ext:Column>
                                    <ext:Column runat="server" Text="11日">
                                        <Columns>
                                            <ext:Column runat="server" Text="甲" DataIndex="甲11" Width="40" />
                                            <ext:Column runat="server" Text="乙" DataIndex="乙11" Width="40" />
                                            <ext:Column runat="server" Text="丙" DataIndex="丙11" Width="40" />
                                        </Columns>
                                    </ext:Column>
                                    <ext:Column runat="server" Text="12日">
                                        <Columns>
                                            <ext:Column runat="server" Text="甲" DataIndex="甲12" Width="40" />
                                            <ext:Column runat="server" Text="乙" DataIndex="乙12" Width="40" />
                                            <ext:Column runat="server" Text="丙" DataIndex="丙12" Width="40" />
                                        </Columns>
                                    </ext:Column>
                                    <ext:Column runat="server" Text="13日">
                                        <Columns>
                                            <ext:Column runat="server" Text="甲" DataIndex="甲13" Width="40" />
                                            <ext:Column runat="server" Text="乙" DataIndex="乙13" Width="40" />
                                            <ext:Column runat="server" Text="丙" DataIndex="丙13" Width="40" />
                                        </Columns>
                                    </ext:Column>
                                    <ext:Column runat="server" Text="14日">
                                        <Columns>
                                            <ext:Column runat="server" Text="甲" DataIndex="甲14" Width="40" />
                                            <ext:Column runat="server" Text="乙" DataIndex="乙14" Width="40" />
                                            <ext:Column runat="server" Text="丙" DataIndex="丙14" Width="40" />
                                        </Columns>
                                    </ext:Column>
                                    <ext:Column runat="server" Text="15日">
                                        <Columns>
                                            <ext:Column runat="server" Text="甲" DataIndex="甲15" Width="40" />
                                            <ext:Column runat="server" Text="乙" DataIndex="乙15" Width="40" />
                                            <ext:Column runat="server" Text="丙" DataIndex="丙15" Width="40" />
                                        </Columns>
                                    </ext:Column>
                                    <ext:Column runat="server" Text="16日">
                                        <Columns>
                                            <ext:Column runat="server" Text="甲" DataIndex="甲16" Width="40" />
                                            <ext:Column runat="server" Text="乙" DataIndex="乙16" Width="40" />
                                            <ext:Column runat="server" Text="丙" DataIndex="丙16" Width="40" />
                                        </Columns>
                                    </ext:Column>
                                    <ext:Column runat="server" Text="17日">
                                        <Columns>
                                            <ext:Column runat="server" Text="甲" DataIndex="甲17" Width="40" />
                                            <ext:Column runat="server" Text="乙" DataIndex="乙17" Width="40" />
                                            <ext:Column runat="server" Text="丙" DataIndex="丙17" Width="40" />
                                        </Columns>
                                    </ext:Column>
                                    <ext:Column runat="server" Text="18日">
                                        <Columns>
                                            <ext:Column runat="server" Text="甲" DataIndex="甲18" Width="40" />
                                            <ext:Column runat="server" Text="乙" DataIndex="乙18" Width="40" />
                                            <ext:Column runat="server" Text="丙" DataIndex="丙18" Width="40" />
                                        </Columns>
                                    </ext:Column>
                                    <ext:Column runat="server" Text="19日">
                                        <Columns>
                                            <ext:Column runat="server" Text="甲" DataIndex="甲19" Width="40" />
                                            <ext:Column runat="server" Text="乙" DataIndex="乙19" Width="40" />
                                            <ext:Column runat="server" Text="丙" DataIndex="丙19" Width="40" />
                                        </Columns>
                                    </ext:Column>
                                    <ext:Column runat="server" Text="20日">
                                        <Columns>
                                            <ext:Column runat="server" Text="甲" DataIndex="甲20" Width="40" />
                                            <ext:Column runat="server" Text="乙" DataIndex="乙20" Width="40" />
                                            <ext:Column runat="server" Text="丙" DataIndex="丙20" Width="40" />
                                        </Columns>
                                    </ext:Column>
                                    <ext:Column runat="server" Text="21日">
                                        <Columns>
                                            <ext:Column runat="server" Text="甲" DataIndex="甲21" Width="40" />
                                            <ext:Column runat="server" Text="乙" DataIndex="乙21" Width="40" />
                                            <ext:Column runat="server" Text="丙" DataIndex="丙21" Width="40" />
                                        </Columns>
                                    </ext:Column>
                                    <ext:Column runat="server" Text="22日">
                                        <Columns>
                                            <ext:Column runat="server" Text="甲" DataIndex="甲22" Width="40" />
                                            <ext:Column runat="server" Text="乙" DataIndex="乙22" Width="40" />
                                            <ext:Column runat="server" Text="丙" DataIndex="丙22" Width="40" />
                                        </Columns>
                                    </ext:Column>
                                    <ext:Column runat="server" Text="23日">
                                        <Columns>
                                            <ext:Column runat="server" Text="甲" DataIndex="甲23" Width="40" />
                                            <ext:Column runat="server" Text="乙" DataIndex="乙23" Width="40" />
                                            <ext:Column runat="server" Text="丙" DataIndex="丙23" Width="40" />
                                        </Columns>
                                    </ext:Column>
                                    <ext:Column runat="server" Text="24日">
                                        <Columns>
                                            <ext:Column runat="server" Text="甲" DataIndex="甲24" Width="40" />
                                            <ext:Column runat="server" Text="乙" DataIndex="乙24" Width="40" />
                                            <ext:Column runat="server" Text="丙" DataIndex="丙24" Width="40" />
                                        </Columns>
                                    </ext:Column>
                                    <ext:Column runat="server" Text="25日">
                                        <Columns>
                                            <ext:Column runat="server" Text="甲" DataIndex="甲25" Width="40" />
                                            <ext:Column runat="server" Text="乙" DataIndex="乙25" Width="40" />
                                            <ext:Column runat="server" Text="丙" DataIndex="丙25" Width="40" />
                                        </Columns>
                                    </ext:Column>
                                    <ext:Column runat="server" Text="26日">
                                        <Columns>
                                            <ext:Column runat="server" Text="甲" DataIndex="甲26" Width="40" />
                                            <ext:Column runat="server" Text="乙" DataIndex="乙26" Width="40" />
                                            <ext:Column runat="server" Text="丙" DataIndex="丙26" Width="40" />
                                        </Columns>
                                    </ext:Column>
                                    <ext:Column runat="server" Text="27日">
                                        <Columns>
                                            <ext:Column runat="server" Text="甲" DataIndex="甲27" Width="40" />
                                            <ext:Column runat="server" Text="乙" DataIndex="乙27" Width="40" />
                                            <ext:Column runat="server" Text="丙" DataIndex="丙27" Width="40" />
                                        </Columns>
                                    </ext:Column>
                                    <ext:Column runat="server" Text="28日">
                                        <Columns>
                                            <ext:Column runat="server" Text="甲" DataIndex="甲28" Width="40" />
                                            <ext:Column runat="server" Text="乙" DataIndex="乙28" Width="40" />
                                            <ext:Column runat="server" Text="丙" DataIndex="丙28" Width="40" />
                                        </Columns>
                                    </ext:Column>
                                    <ext:Column runat="server" Text="29日">
                                        <Columns>
                                            <ext:Column runat="server" Text="甲" DataIndex="甲29" Width="40" />
                                            <ext:Column runat="server" Text="乙" DataIndex="乙29" Width="40" />
                                            <ext:Column runat="server" Text="丙" DataIndex="丙29" Width="40" />
                                        </Columns>
                                    </ext:Column>
                                    <ext:Column runat="server" Text="30日">
                                        <Columns>
                                            <ext:Column runat="server" Text="甲" DataIndex="甲30" Width="40" />
                                            <ext:Column runat="server" Text="乙" DataIndex="乙30" Width="40" />
                                            <ext:Column runat="server" Text="丙" DataIndex="丙30" Width="40" />
                                        </Columns>
                                    </ext:Column>
                                    <ext:Column runat="server" Text="31日">
                                        <Columns>
                                            <ext:Column runat="server" Text="甲" DataIndex="甲31" Width="40" />
                                            <ext:Column runat="server" Text="乙" DataIndex="乙31" Width="40" />
                                            <ext:Column runat="server" Text="丙" DataIndex="丙31" Width="40" />
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
