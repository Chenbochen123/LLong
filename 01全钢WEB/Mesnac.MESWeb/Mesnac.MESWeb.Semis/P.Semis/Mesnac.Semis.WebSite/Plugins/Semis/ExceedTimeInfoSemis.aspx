<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ExceedTimeInfoSemis.aspx.cs" Inherits="Plugins_Semis_ExceedTimeInfoSemis" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>半制品超期处理</title>
    <script language="javascript" type="text/javascript">
        var Barcode_Renderer = function (value, metadata, record, rowIndex, colIndex, store, view) {
            if (record.data.PASS_FLAG == "放行") {
                metadata.style = "color: Blue;";
            }
            return value;
        };
    </script>
</head>
<body>
    <form id="form1" runat="server">
    <ext:ResourceManager runat="server" DirectMethodNamespace="ExceedTimeInfo" />
    <ext:Viewport runat="server" Layout="BorderLayout">
        <Items>
            <ext:Panel runat="server" Region="North">
                <TopBar>
                    <ext:Toolbar runat="server">
                        <Items>
                            <ext:Button runat="server" ID="ButtonNorthQuery" Text="查询" Icon="Find">
                                <DirectEvents>
                                    <Click OnEvent="ButtonNorthQuery_Click">
                                        <EventMask ShowMask="true" />
                                    </Click>
                                </DirectEvents>
                            </ext:Button>
               
                            <ext:Button runat="server" ID="ButtonReturn" Text="返车" Icon="Reload">
                                 <DirectEvents>
                                    <Click OnEvent="ButtonReturn_Click">
                                        <EventMask ShowMask="true" />
                                    </Click>
                                </DirectEvents>
                            </ext:Button>
                        </Items>
                    </ext:Toolbar>
                </TopBar>
                <Items>
                    <ext:Panel runat="server" Layout="ColumnLayout">
                        <Items>
                            <ext:DateField runat="server" ID="DateFieldQueryBeginDate" LabelAlign="Right" FieldLabel="开始日期"
                                AllowBlank="false" Editable="false" Format="yyyy-MM-dd" LabelWidht="80" InputWidth="110"
                                Padding="2">
                            </ext:DateField>
                            <ext:DateField runat="server" ID="DateFieldQueryEndDate" LabelAlign="Right" FieldLabel="截止日期"
                                AllowBlank="false" Editable="false" Format="yyyy-MM-dd" LabelWidht="80" InputWidth="110"
                                Padding="2">
                            </ext:DateField>
                            <ext:TextField runat="server" ID="TextFieldQueryBarcode" LabelAlign="Right" FieldLabel="半制品卡号"
                                LabelWidth="80" InputWidth="130" EmptyText="条码号..." Padding="2">
                            </ext:TextField>
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
                            <ext:Store runat="server" ID="StoreMain" AutoLoad="false" PageSize="10">
                                <Model>
                                    <ext:Model runat="server" ID="ModelMain" IDProperty="OBJID">
                                        <Fields>
                                            <ext:ModelField Name="OBJID" />
                                            <ext:ModelField Name="PASS_FLAG" />
                                            <ext:ModelField Name="BARCODE" />
                                            <ext:ModelField Name="MATERIAL_NAME" />
                                            <ext:ModelField Name="SAP_CODE" />
                                            <ext:ModelField Name="RECORD_TIME" Type="Date" />
                                            <ext:ModelField Name="YOUXIAO_TIME" Type="Date" />
                                 
                                        </Fields>
                                    </ext:Model>
                                </Model>
                            </ext:Store>
                        </Store>
                        <ColumnModel>
                            <Columns>
                               <ext:Column DataIndex="OBJID" Text="OBJID" Width="100"  Visible="false">
                                </ext:Column>
                                <ext:Column DataIndex="PASS_FLAG" Text="处理" Width="150" > 
                                </ext:Column>
                                <ext:Column DataIndex="BARCODE" Text="半制品卡号" Width="200">
                                    <Renderer Fn="Barcode_Renderer" />
                                </ext:Column>
                                <ext:Column  DataIndex="MATERIAL_NAME" Text="物料名称" Width="260">
                                </ext:Column>
                                <ext:Column DataIndex="SAP_CODE" Text="sap_号">
                                </ext:Column>
                                <ext:DateColumn DataIndex="RECORD_TIME" Text="生产日期" Width="260" Format="yyyy-MM-dd HH:mm:ss">
                                </ext:DateColumn>
                                <ext:DateColumn DataIndex="YOUXIAO_TIME" Text="有效日期"  Width="260" Format="yyyy-MM-dd HH:mm:ss">
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
    </form>
</body>
</html>
