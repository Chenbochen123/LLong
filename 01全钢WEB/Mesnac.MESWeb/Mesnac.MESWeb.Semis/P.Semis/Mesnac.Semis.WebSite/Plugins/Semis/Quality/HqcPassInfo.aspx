<%@ Page Language="C#" AutoEventWireup="true" CodeFile="HqcPassInfo.aspx.cs" Inherits="Plugins_Semis_HqcPassInfo" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>半制品不合格处理</title>
    <script src="../../../resources/js/jquery-1.7.1.js" type="text/javascript"></script>
    <script language="javascript" type="text/javascript">
        var Barcode_Renderer = function (value, metadata, record, rowIndex, colIndex, store, view) {
            if (record.data.PASS_FLAG == "放行") {
                metadata.style = "color: Green;"; 
            }
            if (record.data.PASS_FLAG == "报废") {
                metadata.style = "color: Red;";
            }
            if (record.data.PASS_FLAG == "返车") {
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
    <ext:ResourceManager runat="server" DirectMethodNamespace="HqcPass" />
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
                            <ext:Button runat="server" ID="ButtonNorthPass" Text="放行" Icon="Accept">
                                <DirectEvents>
                                    <Click OnEvent="ButtonNorthPass_Click">
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
                            <ext:Button runat="server" ID="ButtonBad" Text="报废" Icon="Cross">
                                 <DirectEvents>
                                    <Click OnEvent="ButtonBad_Click">
                                        <EventMask ShowMask="true" />
                                    </Click>
                                </DirectEvents>
                            </ext:Button>
                            <ext:Button runat="server" Icon="PageExcel" Text="导出" ID="btnExport">
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
                </TopBar>
                <Items>
                    <ext:Panel runat="server" Layout="ColumnLayout">
                        <Items>
                            <ext:RadioGroup runat="server" ID="RadioGroupQuerySearchType">
                                <Items>
                                    <ext:Radio InputValue="1" FieldLabel="按质检日期" LabelAlign="Right" LabelWidth="70" Checked="true" />
                                    <ext:Radio InputValue="2" FieldLabel="按生产日期" LabelAlign="Right" LabelWidth="70" />
                                </Items>
                            </ext:RadioGroup>
                            <ext:DateField runat="server" ID="DateFieldQueryBeginDate" LabelAlign="Right" FieldLabel="开始日期"
                                AllowBlank="false" Editable="false" Format="yyyy-MM-dd" LabelWidht="80" InputWidth="110"
                                Padding="2">
                            </ext:DateField>
                            <ext:DateField runat="server" ID="DateFieldQueryEndDate" LabelAlign="Right" FieldLabel="截止日期"
                                AllowBlank="false" Editable="false" Format="yyyy-MM-dd" LabelWidht="80" InputWidth="110"
                                Padding="2">
                            </ext:DateField>
                            <ext:ComboBox runat="server" ID="ComboBoxQueryPassFlag" LabelAlign="Right" FieldLabel="处理状态"
                                Editable="false" LabelWidth="80" InputWidth="70" EmptyText="全部" Padding="2">
                                <Items>
                                    <ext:ListItem Mode="Value" Value="0" Text="首检未处理">
                                    </ext:ListItem>
                                    <ext:ListItem Mode="Value" Value="1" Text="复检未处理">
                                    </ext:ListItem>
                                    <ext:ListItem Mode="Value" Value="2" Text="放行">
                                    </ext:ListItem>
                                    <ext:ListItem Mode="Value" Value="3" Text="返车">
                                    </ext:ListItem>
                                    <ext:ListItem Mode="Value" Value="4" Text="报废">
                                    </ext:ListItem>
                                </Items>
                                <Triggers>
                                    <ext:FieldTrigger Icon="Clear" Qtip="清空" />
                                </Triggers>
                                <Listeners>
                                    <TriggerClick Handler="this.setValue('');" />
                                </Listeners>
                            </ext:ComboBox>
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
                                            <ext:ModelField Name="CARD_NO" />
                                            <ext:ModelField Name="MATERIAL_NAME" />
                                            <ext:ModelField Name="PRODUCTION_TIME" Type="Date" />
                                            <ext:ModelField Name="CHECK_TIME" Type="Date" />
                                            <ext:ModelField Name="EQUIP_NAME" />
                                            <ext:ModelField Name="QTY" />
                                            <ext:ModelField Name="AMOUNT" />
                                            <ext:ModelField Name="TotalWeight" />
                                            <ext:ModelField Name="ShelfNum" />
                                            <ext:ModelField Name="CheckFlag" />
                                            <ext:ModelField Name="CHECK_USER" />
                                            <ext:ModelField Name="PASS_FLAG" />
                                            <ext:ModelField Name="PASS_USER" />
                                            <ext:ModelField Name="PASS_TIME" Type="Date" />
                                            <ext:ModelField Name="PASS_MEMO" />
                                            <ext:ModelField Name="PASS_REASON" />
                                            <ext:ModelField Name="DUMMY1" />
                                            <ext:ModelField Name="CHECK_DEFECT1" />
                                        </Fields>
                                    </ext:Model>
                                </Model>
                            </ext:Store>
                        </Store>
                        <ColumnModel>
                            <Columns>
                                <ext:Column DataIndex="OBJID" Text="OBJID" Width="150" Visible="false">
                                </ext:Column>
                                <ext:Column DataIndex="CARD_NO" Text="半制品卡号" Width="150">
                                    <Renderer Fn="Barcode_Renderer" />
                                </ext:Column>
                                <ext:Column DataIndex="MATERIAL_NAME" Text="规格" Width="190">
                                    <Renderer Fn="Barcode_Renderer" />
                                </ext:Column>
                                <ext:Column DataIndex="PASS_FLAG" Text="处理意见" Width="90">
                                    <Renderer Fn="Barcode_Renderer" />
                                </ext:Column>
                                <ext:Column DataIndex="PASS_USER" Text="处理人">
                                </ext:Column>
                                <ext:DateColumn DataIndex="PASS_TIME" Text="处理时间" Format="Y-m-d H:i:s" Width="130">
                                </ext:DateColumn>
                                <ext:Column DataIndex="PASS_MEMO" Text="备注" Hidden="true" >
                                </ext:Column>
                                <ext:Column DataIndex="PASS_REASON" Text="放行原因">
                                </ext:Column>
                                <ext:Column DataIndex="CHECK_DEFECT1" Text="病疵">
                                </ext:Column>
                                <ext:DateColumn DataIndex="PRODUCTION_TIME" Text="生产日期" Format="yyyy-MM-dd">
                                </ext:DateColumn>
                                <ext:DateColumn DataIndex="CHECK_TIME" Text="质检日期" Format="yyyy-MM-dd">
                                </ext:DateColumn>
                                <ext:Column DataIndex="EQUIP_NAME" Text="生产机台">
                                </ext:Column>
                                <ext:Column DataIndex="QTY" Text="质检数量">
                                </ext:Column>
                                <ext:Column DataIndex="AMOUNT" Text="不合格数量">
                                </ext:Column>
                                <ext:Column DataIndex="CHECK_USER" Text="质检员">
                                </ext:Column>
                            </Columns>
                            
                        </ColumnModel>
                        
                        <SelectionModel>
                            <ext:CheckboxSelectionModel ID="CheckboxSelectionModel1" runat="server" Mode="Multi" />
                        </SelectionModel>

<%--                        <SelectionModel>
                            
                           <ext:RowSelectionModel runat="server" ID="SelectionModelMain" Mode="Single" 
                                AllowDeselect="true">   
                               <Listeners>
                                   <SelectionChange Handler="this.style()"></SelectionChange>
                               </Listeners>
                           </ext:RowSelectionModel>
                        </SelectionModel>--%>
                    </ext:GridPanel>
                </Items>
            </ext:Panel>
        </Items>
    </ext:Viewport>
    <ext:Window runat="server" ID="WindowPass" Title="放行处理" Width="600" Height="350"
        Hidden="true" Modal="false">
        <Items>
            <ext:FormPanel runat="server" ShadowMode="Frame">
                <Items>
                    <%--<ext:TextField runat="server" ID="TextFieldEditBarcode" FieldLabel="条码号" LabelAlign="Right"
                        ReadOnly="true" />--%>
                    <ext:TextField runat="server" ID="TextFieldEditPassMemo" FieldLabel="备注" LabelAlign="Right"
                        Width="550" Hidden="true"/>
                    <ext:ComboBox runat="server" ID="cbxReason" FieldLabel="原因" LabelAlign="Right" Editable="false"></ext:ComboBox>
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
