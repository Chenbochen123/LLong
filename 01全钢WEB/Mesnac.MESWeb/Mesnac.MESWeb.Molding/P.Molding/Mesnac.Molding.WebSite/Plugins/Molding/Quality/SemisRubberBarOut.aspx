<%@ Page Language="C#" AutoEventWireup="true" CodeFile="SemisRubberBarOut.aspx.cs" Inherits="Plugins_Molding_Quality_SemisRubberBarOut" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>线边库先入先出放行</title>
    <script type="text/javascript" src="<%= Page.ResolveUrl("~/") %>resources/js/jquery-1.7.1.js"></script>
    <link rel="Stylesheet" type="text/css" href="<%= Page.ResolveUrl("~/") %>resources/css/ext-chinese-font.css" />
    <link rel="Stylesheet" type="text/css" href="<%= Page.ResolveUrl("~/") %>resources/css/main.css" />
    <script language="javascript" type="text/javascript">
        var Barcode_Renderer = function (value, metadata, record, rowIndex, colIndex, store, view) {
            if (record.data.STATE == "放行") {
                metadata.style = "color: Blue;";
            }
            return value;
        };
    </script>
</head>
<body>
    <form id="form1" runat="server">
    <asp:Button ID="btnExportSubmit" Style="display: none" runat="server" Text="Button"
            OnClick="btnExportSubmit_Click" />
    <ext:ResourceManager runat="server" DirectMethodNamespace="ExceedTimeInfo" />
    <ext:Viewport runat="server" Layout="BorderLayout">
        <Items>
            <ext:Panel runat="server" Region="North">
                <TopBar>
                    <ext:Toolbar runat="server">
                        <Items>
                            <ext:Button runat="server" ID="ButtonNorthQuery" Text="查询" Icon="Find">
                                <DirectEvents>
                                    <Click OnEvent="ButtonNorthQuery_Click" Timeout ="300000">
                                        <EventMask ShowMask="true" />
                                    </Click>
                                </DirectEvents>
                            </ext:Button>
               
                            <ext:Button runat="server" ID="ButtonReturn" Text="放行" Icon="Reload">
                                 <DirectEvents>
                                    <Click OnEvent="ButtonReturn_Click">
                                        <EventMask ShowMask="true" />
                                    </Click>
                                </DirectEvents>
                            </ext:Button>
                            <ext:Button runat="server" Icon="PageExcel" Text="导出" ID="btnExport" >
                                    <ToolTips>
                                        <ext:ToolTip ID="ToolTip2" runat="server" Html="点击将放行记录导出到Excel中" />
                                    </ToolTips>
                                    <Listeners>
                                        <Click Handler="$('#btnExportSubmit').click();">
                                        </Click>
                                    </Listeners>
                                </ext:Button>
                        </Items>
                    </ext:Toolbar>
                </TopBar>
                <Items>
                    <ext:Panel runat="server" Layout="ColumnLayout">
                        <Items>
                            <ext:Container ID="container1" runat="server" Layout="FormLayout" ColumnWidth=".25"
                                Padding="5">
                                <Items>
                                    <ext:FieldContainer runat="server" FieldLabel="开始日期" Layout="HBoxLayout" LabelAlign="Right">
                                        <Items>
                                            <ext:DateField ID="txtBeginDate" runat="server" Flex="1" Editable="false" />
                                            <ext:TimeField ID="txtBeginTime" runat="server" Width="80" Editable="true" />
                                        </Items>
                                    </ext:FieldContainer>
                                </Items>
                            </ext:Container>
                            <ext:Container ID="container2" runat="server" Layout="FormLayout" ColumnWidth=".25"
                                Padding="5">
                                <Items>
                                    <ext:FieldContainer runat="server" FieldLabel="截止日期" Layout="HBoxLayout" LabelAlign="Right">
                                        <Items>
                                            <ext:DateField ID="txtEndDate" runat="server" Flex="1" Editable="false" />
                                            <ext:TimeField ID="txtEndTime" runat="server" Width="80" Editable="true" />
                                        </Items>
                                    </ext:FieldContainer>
                                </Items>
                            </ext:Container>
                            <ext:Container ID="container3" runat="server" Layout="FormLayout" ColumnWidth=".25"
                                Padding="5">
                                <Items>
                                    <ext:TextField runat="server" ID="TextFieldQueryBarcode" LabelAlign="Right" FieldLabel="半部件条码"
                                        EmptyText="条码号..." Padding="2">
                                    </ext:TextField>
                                </Items>
                            </ext:Container>
                        </Items>
                    </ext:Panel>
                </Items>
            </ext:Panel>
            <ext:Panel runat="server" Region="Center" Layout="FitLayout">
                
                <Items>
                    <ext:GridPanel runat="server" ID="GridPanelMain" Region="Center">
                       <View>
                           <ext:GridView EnableTextSelection="true"></ext:GridView>
                       </View>
                       <BottomBar>
                        <ext:PagingToolbar ID="pageToolBar" runat="server">
                            <Plugins>
                                <ext:ProgressBarPager ID="ProgressBarPager" runat="server" />
                            </Plugins>
                        </ext:PagingToolbar>
                        </BottomBar>
                        <Store>
                            <ext:Store runat="server" ID="StoreMain" AutoLoad="false" PageSize="50">
                                <Model>
                                    <ext:Model runat="server" ID="ModelMain" IDProperty="CARD_NO">
                                        <Fields>
                                            <ext:ModelField Name="OBJID" />
                                            <ext:ModelField Name="STATE" />
                                            <ext:ModelField Name="CARD_NO" />
                                            <ext:ModelField Name="MATERIAL_NAME" />
                                            <ext:ModelField Name="END_TIME" Type="Date" />
                                            <ext:ModelField Name="USER_NAME" />
                                            <ext:ModelField Name="BACKUP_TIME" Type="Date"/>
                                            <ext:ModelField Name="STORE_PLACE_NAME" />
                                        </Fields>
                                    </ext:Model>
                                </Model>
                            </ext:Store>
                        </Store>
                        <ColumnModel>
                            <Columns>
                                <ext:Column DataIndex="STATE" Text="状态" Width="100" > 
                                </ext:Column>
                                <ext:Column DataIndex="CARD_NO" Text="半部件条码" Width="200">
                                    <Renderer Fn="Barcode_Renderer" />
                                </ext:Column>
                                <ext:Column DataIndex="MATERIAL_NAME" Text="物料名称" Width="260">
                                </ext:Column>
                                <ext:Column DataIndex="STORE_PLACE_NAME" Text="库位" Width="260">
                                </ext:Column>
                                <ext:DateColumn DataIndex="END_TIME" Text="生产日期" Width="160" Format="yyyy-MM-dd HH:mm:ss">
                                </ext:DateColumn>
                                <ext:Column DataIndex="USER_NAME" Text="放行人"  Width="80" >
                                </ext:Column>
                                <ext:DateColumn DataIndex="BACKUP_TIME" Text="放行时间"  Width="160" Format="yyyy-MM-dd HH:mm:ss">
                                </ext:DateColumn>
                            </Columns>   
                        </ColumnModel>
                        <SelectionModel>
                           <ext:RowSelectionModel runat="server" ID="SelectionModelMain" Mode="Single" 
                                AllowDeselect="true">   
                           </ext:RowSelectionModel>
                        </SelectionModel>
                    </ext:GridPanel>
                </Items>
            </ext:Panel>
        </Items>
    </ext:Viewport>
        <ext:Window runat="server" ID="WindowPass" Title="放行处理" Width="360" Height="120"
            Hidden="true" Modal="false">
            <Items>                    
                <ext:FormPanel runat="server" ShadowMode="Frame">
                    <Items>
                        <ext:TextField runat="server" ID="txtbarcode" LabelAlign="Right" FieldLabel="条码" ReadOnly="true">
                        </ext:TextField>
                    </Items>
                </ext:FormPanel>
            </Items>
            <Buttons>
                <ext:Button runat="server" ID="ButtonEditAccept" Icon="Accept" Text="确定">
                    <DirectEvents>
                        <Click OnEvent="ButtonEditAccept_Click">
                            <Confirmation Title="提示" Message="确定要放行吗" ConfirmRequest="true" />
                        </Click>
                    </DirectEvents>
                </ext:Button>
                <ext:Button runat="server" ID="ButtonEditCancel" Icon="Cancel" Text="取消">
                    <Listeners>
                        <Click Handler="#{WindowPass}.close();" />
                    </Listeners>
                </ext:Button>
            </Buttons>
        </ext:Window>
    </form>
</body>
</html>
