<%@ Page Language="C#" AutoEventWireup="true" CodeFile="OutStorageMonth.aspx.cs" Inherits="Plugins_Storage_Report_OutStorageMonth" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
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
                                <ext:ComboBox runat="server" ID="outStoreType" FieldLabel="出库类型" LabelAlign="Right">
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
                            <View>
                                <ext:GridView EnableTextSelection="true"></ext:GridView>
                            </View>
                            <Store>
                                <ext:Store ID="store" runat="server">
                                    <Model>
                                        <ext:Model ID="model" runat="server" IDProperty="PlanInfo">
                                            <Fields>
                                                <ext:ModelField Name="material" />
                                                <ext:ModelField Name="outqty" />
                                                <%--<ext:ModelField Name="customer" />                                                
                                                <ext:ModelField Name="affirm" />--%>
                                                <ext:ModelField Name="X01" />
                                                <ext:ModelField Name="X02" />
                                                <ext:ModelField Name="X03" />
                                                <ext:ModelField Name="X04" />
                                                <ext:ModelField Name="X05" />
                                                <ext:ModelField Name="X06" />
                                                <ext:ModelField Name="X07" />
                                                <ext:ModelField Name="X08" />
                                                <ext:ModelField Name="X09" />
                                                <ext:ModelField Name="X10" />
                                                <ext:ModelField Name="X11" />
                                                <ext:ModelField Name="X12" />
                                                <ext:ModelField Name="X13" />
                                                <ext:ModelField Name="X14" />
                                                <ext:ModelField Name="X15" />
                                                <ext:ModelField Name="X16" />
                                                <ext:ModelField Name="X17" />
                                                <ext:ModelField Name="X18" />
                                                <ext:ModelField Name="X10" />
                                                <ext:ModelField Name="X11" />
                                                <ext:ModelField Name="X12" />
                                                <ext:ModelField Name="X13" />
                                                <ext:ModelField Name="X14" />
                                                <ext:ModelField Name="X15" />
                                                <ext:ModelField Name="X16" />
                                                <ext:ModelField Name="X17" />
                                                <ext:ModelField Name="X18" />
                                                <ext:ModelField Name="X19" />
                                                <ext:ModelField Name="X20" />
                                                <ext:ModelField Name="X21" />
                                                <ext:ModelField Name="X22" />
                                                <ext:ModelField Name="X23" />
                                                <ext:ModelField Name="X24" />
                                                <ext:ModelField Name="X25" />
                                                <ext:ModelField Name="X26" />
                                                <ext:ModelField Name="X27" />
                                                <ext:ModelField Name="X28" />
                                                <ext:ModelField Name="X29" />
                                                <ext:ModelField Name="X30" />
                                                <ext:ModelField Name="X31" />
                                            </Fields>
                                        </ext:Model>
                                    </Model>
                                </ext:Store>
                            </Store>
                            <ColumnModel ID="colModel" runat="server">
                                <Columns>
                                    <ext:Column runat="server" Text="规格" DataIndex="material" Width="280" />
                                    <ext:Column runat="server" Text="实际出库" DataIndex="outqty" Width="60" Hidden="false" />
                                   <%-- <ext:Column runat="server" Text="客户名称" DataIndex="customer" Width="60" Hidden="false" />
                                    <ext:Column runat="server" Text="确认人" DataIndex="affirm" Width="60" Hidden="false" />--%>                                 
                                    <ext:Column runat="server" Text="1日" DataIndex="X01" Width="60"/>                                     
                                    <ext:Column runat="server" Text="2日" DataIndex="X02" Width="60">
                                    </ext:Column>
                                    <ext:Column runat="server" Text="3日" DataIndex="X03" Width="60">
                                       
                                    </ext:Column>
                                    <ext:Column runat="server" Text="4日" DataIndex="X04" Width="60">
                                       
                                    </ext:Column>
                                    <ext:Column runat="server" Text="5日" DataIndex="X05" Width="60">
                                      
                                    </ext:Column>
                                    <ext:Column runat="server" Text="6日" DataIndex="X06" Width="60">
                                       
                                    </ext:Column>
                                    <ext:Column runat="server" Text="7日" DataIndex="X07" Width="60">
                                       
                                    </ext:Column>
                                    <ext:Column runat="server" Text="8日" DataIndex="X08" Width="60">
                                       
                                    </ext:Column>
                                    <ext:Column runat="server" Text="9日" DataIndex="X09" Width="60">
                                        
                                    </ext:Column>
                                    <ext:Column runat="server" Text="10日" DataIndex="X10" Width="60">
                                       
                                    </ext:Column>
                                    <ext:Column runat="server" Text="11日" DataIndex="X11" Width="60">
                                      
                                    </ext:Column>
                                    <ext:Column runat="server" Text="12日" DataIndex="X12" Width="60">
                                       
                                    </ext:Column>
                                    <ext:Column runat="server" Text="13日" DataIndex="X13" Width="60">
                                       
                                    </ext:Column>
                                    <ext:Column runat="server" Text="14日" DataIndex="X14" Width="60">
                                        
                                    </ext:Column>
                                    <ext:Column runat="server" Text="15日" DataIndex="X15" Width="60">
                                       
                                    </ext:Column>
                                    <ext:Column runat="server" Text="16日" DataIndex="X16" Width="60">
                                       
                                    </ext:Column>
                                    <ext:Column runat="server" Text="17日" DataIndex="X17" Width="60">
                                       
                                    </ext:Column>
                                    <ext:Column runat="server" Text="18日" DataIndex="X18" Width="60">
                                       
                                    </ext:Column>
                                    <ext:Column runat="server" Text="19日" DataIndex="X19" Width="60">
                                        
                                    </ext:Column>
                                    <ext:Column runat="server" Text="20日" DataIndex="X20" Width="60">
                                       
                                    </ext:Column>
                                    <ext:Column runat="server" Text="21日" DataIndex="X21" Width="60">
                                       
                                    </ext:Column>
                                    <ext:Column runat="server" Text="22日" DataIndex="X22" Width="60">
                                       
                                    </ext:Column>
                                    <ext:Column runat="server" Text="23日" DataIndex="X23" Width="60">
                                       
                                    </ext:Column>
                                    <ext:Column runat="server" Text="24日" DataIndex="X24" Width="60">
                                       
                                    </ext:Column>
                                    <ext:Column runat="server" Text="25日" DataIndex="X25" Width="60">
                                       
                                    </ext:Column>
                                    <ext:Column runat="server" Text="26日" DataIndex="X26" Width="60">
                                        
                                    </ext:Column>
                                    <ext:Column runat="server" Text="27日" DataIndex="X27" Width="60">
                                       
                                    </ext:Column>
                                    <ext:Column runat="server" Text="28日" DataIndex="X28" Width="60">
                                       
                                    </ext:Column>
                                    <ext:Column runat="server" Text="29日" DataIndex="X29" Width="60">
                                       
                                    </ext:Column>
                                    <ext:Column runat="server" Text="30日" DataIndex="X30" Width="60">
                                      
                                    </ext:Column>
                                    <ext:Column runat="server" Text="31日" DataIndex="X31" Width="60">
                                        
                                    </ext:Column>
                                </Columns>
                            </ColumnModel>
                             <%--<BottomBar>
                                  <ext:PagingToolbar runat="server" HideRefresh="false" />
                              </BottomBar>--%>
                        </ext:GridPanel>
                    </Items>
                </ext:Panel>
            </Items>
        </ext:Viewport>
    </form>
</body>
</html>
