<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ExceedRubberTimeInfo.aspx.cs" Inherits="Plugins_Semis_Quality_ExceedRubberTimeInfo" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>A区胶料超期处理</title>
    <script type="text/javascript" src="<%= Page.ResolveUrl("~/") %>resources/js/jquery-1.7.1.js"></script>
    <link rel="Stylesheet" type="text/css" href="<%= Page.ResolveUrl("~/") %>resources/css/ext-chinese-font.css" />
    <link rel="Stylesheet" type="text/css" href="<%= Page.ResolveUrl("~/") %>resources/css/main.css" />
    <script language="javascript" type="text/javascript">
        var Barcode_Renderer = function (value, metadata, record, rowIndex, colIndex, store, view) {
            if (record.data.PASS_FLAG == "放行") {
                metadata.style = "color: Blue;";
            }
            return value;
        };

        //列表刷新数据重载方法
        var pnlListFresh = function () {
            App.CheckboxSelectionModel1.deselectAll();
            return false;
        }
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
                                    <Click OnEvent="ButtonNorthQuery_Click">
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

                            <ext:Button runat="server" ID="ButtonHistroy" Text="查询历史放行" Icon="Find">
                                <DirectEvents>
                                    <Click OnEvent="ButtonHistroy_Click">
                                        <EventMask ShowMask="true" />
                                    </Click>
                                </DirectEvents>
                            </ext:Button>
                            <ext:Button runat="server" Icon="PageExcel" Text="导出" ID="btnExport">
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
                            <ext:DateField runat="server" ID="DateFieldQueryBeginDate" LabelAlign="Right" FieldLabel="开始日期"
                                AllowBlank="false" Editable="false" Format="yyyy-MM-dd" LabelWidht="80" InputWidth="110"
                                Padding="2">
                            </ext:DateField>
                            <ext:DateField runat="server" ID="DateFieldQueryEndDate" LabelAlign="Right" FieldLabel="截止日期"
                                AllowBlank="false" Editable="false" Format="yyyy-MM-dd" LabelWidht="80" InputWidth="110"
                                Padding="2">
                            </ext:DateField>
                            <ext:TextField runat="server" ID="TextFieldQueryBarcode" LabelAlign="Right" FieldLabel="胶料条码"
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
                            <%--AutoLoad="false"--%>
                            <ext:Store runat="server" ID="StoreMain"  PageSize="20">
                                <Model>
                                    <ext:Model runat="server" ID="ModelMain" IDProperty="BARCODE">
                                        <Fields>
                                            <ext:ModelField Name="OBJID" />
                                            <ext:ModelField Name="PASS_FLAG" />
                                            <ext:ModelField Name="BARCODE" />
                                            <ext:ModelField Name="MATERIAL_NAME" />
                                            <ext:ModelField Name="OPER_NAME" />
                                            <ext:ModelField Name="EQUIP_NAME" />
                                            <ext:ModelField Name="PRODUCE_TIME" Type="Date" />
                                            <ext:ModelField Name="END_TIME" Type="Date" />
                                            <ext:ModelField Name="MIN_TIME" />
                                            <ext:ModelField Name="VALID_TIME" />
                                            <ext:ModelField Name="YA_TIME" Type="Date"  />
                                            <ext:ModelField Name="DUMMY_6" />
                                            <ext:ModelField Name="PASS_USER" />
                                            <ext:ModelField Name="PASS_MEMO" />
                                            <ext:ModelField Name="FX_TIME" Type="Date" />
                                        </Fields>
                                    </ext:Model>
                                </Model>
                            </ext:Store>
                        </Store>
                        <ColumnModel>
                  
                            <Columns>
                               <ext:RowNumbererColumn ID="rowNumCol" runat="server" Width="35" />
                               <ext:Column DataIndex="OBJID" Text="OBJID" Visible="false" Width="100" >
                                </ext:Column>
                                <ext:Column DataIndex="PASS_FLAG" Text="处理" Width="150" > 
                                    <Renderer Fn="Barcode_Renderer" />
                                </ext:Column>
                                <ext:Column DataIndex="BARCODE" Text="半制品卡号" Width="200">
                                   <Renderer Fn="Barcode_Renderer" />  
                                </ext:Column>
                                <ext:Column DataIndex="MATERIAL_NAME" Text="物料名称" Width="260">
                                </ext:Column>
                                <ext:Column DataIndex="OPER_NAME" Text="主机手" Width="100">
                                </ext:Column>
                                <ext:Column DataIndex="EQUIP_NAME" Text="生产机台">
                                </ext:Column>
                                <ext:DateColumn DataIndex="END_TIME" Text="生产日期" Width="160" Format="yyyy-MM-dd HH:mm:ss">
                                </ext:DateColumn>
                                <ext:DateColumn DataIndex="YA_TIME" Text="有效日期"  Width="160" Format="yyyy-MM-dd HH:mm:ss">
                                </ext:DateColumn>
                                <ext:Column DataIndex="DUMMY_6" Text="延长时间"  Width="80" >
                                </ext:Column>
                                <ext:Column DataIndex="PASS_USER" Text="放行人"  Width="80" >
                                </ext:Column>
                                <ext:DateColumn DataIndex="FX_TIME" Text="放行时间"  Width="160" Format="yyyy-MM-dd HH:mm:ss">
                                </ext:DateColumn>
                                <ext:Column DataIndex="PASS_MEMO" Text="放行类型"  Width="150" >
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

        <ext:Window runat="server" ID="WindowPass" Title="放行处理" Width="360" Height="380"
            Hidden="true" Modal="false">
            <Items>
                <ext:FormPanel runat="server" ShadowMode="Frame">
                    <Items>
                        <ext:ComboBox runat="server" ID="CboPassMemo" LabelAlign="Right" FieldLabel="备注"
                                Editable="false" LabelWidth="80" InputWidth="260" Padding="2">
                                <Items>
                                    <ext:ListItem Mode="Value" Value="1" Text="超期使用放行">
                                    </ext:ListItem>
                                    <ext:ListItem Mode="Value" Value="2" Text="提前使用放行">
                                    </ext:ListItem>
                                </Items>
                            </ext:ComboBox>
                        <ext:TextField runat="server" ID="txtTime" LabelAlign="Right" FieldLabel="延长时间"
                            EmptyText="小时" Padding="2">
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
            <Listeners>
                <Show Handler="Ext.fly('form1').mask();" />
                <Hide Handler="Ext.fly('form1').unmask();" />
            </Listeners>
        </ext:Window>

    </form>
</body>
</html>
