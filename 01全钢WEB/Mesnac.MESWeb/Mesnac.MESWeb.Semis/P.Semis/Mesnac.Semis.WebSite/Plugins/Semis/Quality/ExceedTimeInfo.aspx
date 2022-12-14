<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ExceedTimeInfo.aspx.cs" Inherits="Plugins_Semis_ExceedTimeInfo" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>半部件超期处理</title>
    <script type="text/javascript" src="<%= Page.ResolveUrl("~/") %>resources/js/jquery-1.7.1.js"></script>
    <link rel="Stylesheet" type="text/css" href="<%= Page.ResolveUrl("~/") %>resources/css/ext-chinese-font.css" />
    <link rel="Stylesheet" type="text/css" href="<%= Page.ResolveUrl("~/") %>resources/css/main.css" />
    <script language="javascript" type="text/javascript">
        var Barcode_Renderer = function (value, metadata, record, rowIndex, colIndex, store, view) {
            if (record.data.PASS_FLAG == "放行") {
                metadata.style = "color: Blue;";
            }
            if (record.data.PASS_FLAG != "放行" && record.data.YA_TIME < new Date().getTime()) {
                metadata.style = "color: Red;";
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
                                    <Click OnEvent="ButtonNorthQuery_Click" Timeout ="300000">
                                        <EventMask ShowMask="true" />
                                    </Click>
                                </DirectEvents>
                            </ext:Button>
               
                            <ext:Button runat="server" ID="ButtonApply" Text="申请放行" Icon="TableEdit">
                                 <DirectEvents>
                                    <Click OnEvent="ButtonApplyReturn_Click">
                                        <EventMask ShowMask="true" />
                                    </Click>
                                </DirectEvents>
                            </ext:Button>

                            <ext:Button runat="server" ID="ButtonCancelApply" Text="撤销申请放行" Icon="TableDelete">
                                 <DirectEvents>
                                    <Click OnEvent="ButtonCancelApplyReturn_Click">
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
                                    <Click OnEvent="ButtonHistroy_Click" Timeout ="300000">
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
                            <ext:Container ID="container1" runat="server" Layout="FormLayout" ColumnWidth=".25"
                                Padding="5">
                                <Items>
                                    <ext:FieldContainer runat="server" FieldLabel="开始日期" Layout="HBoxLayout" LabelAlign="Right">
                                        <Items>
                                            <ext:DateField ID="txtBeginDate" runat="server" Flex="1" Editable="false" />
                                            <ext:TimeField ID="txtBeginTime" runat="server" Width="80" Editable="true" />
                                        </Items>
                                    </ext:FieldContainer>
                                    <ext:ComboBox runat="server" ID="cbxType" FieldLabel="申请放行" LabelAlign="Right" Editable="false">
                                                    <Items>
                                                        <ext:ListItem Text="是" Value="1" />
                                                        <ext:ListItem Text="否" Value="0" />
                                                    </Items>
                                                    <Triggers>
                                                        <ext:FieldTrigger Icon="Clear" Qtip="清空" />
                                                    </Triggers>
                                                    <Listeners>
                                                        <TriggerClick Handler="this.setValue('');" />
                                                    </Listeners>
                                                </ext:ComboBox>
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
                                    <ext:TextField runat="server" ID="TextFieldQueryBarcode" LabelAlign="Right" FieldLabel="半制品卡号"
                                        EmptyText="条码号..." Padding="2">
                                    </ext:TextField>
                                </Items>
                            </ext:Container>
                            <ext:Container ID="container4" runat="server" Layout="FormLayout" ColumnWidth=".25"
                                Padding="5">
                                <Items>
                                    <ext:ComboBox runat="server" ID="cbxEquip" FieldLabel="机台" LabelAlign="Right" Editable="false"></ext:ComboBox>
                                </Items>
                            </ext:Container>
                        </Items>
                    </ext:Panel>
                </Items>
            </ext:Panel>
            <ext:Panel runat="server" Region="Center" Layout="FitLayout">
                
                <Items>
                    <ext:GridPanel runat="server" ID="GridPanelMain" Region="Center" >
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
                            <ext:Store runat="server" ID="store"  PageSize="20">
                                <Model>
                                    <ext:Model runat="server" ID="ModelMain" IDProperty="OBJID">
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
                                            <ext:ModelField Name="DUMMY9" />
                                            <ext:ModelField Name="PASS_USER" />
                                            <ext:ModelField Name="PASS_MEMO" />
                                            <ext:ModelField Name="FX_TIME" Type="Date" />
                                            <ext:ModelField Name="APPLY_FLAG" />
                                            <ext:ModelField Name="APPLY_FLAG_NAME" />
                                            <ext:ModelField Name="APPLY_USERID" />
                                            <ext:ModelField Name="APPLY_NAME" />
                                            <ext:ModelField Name="APPLY_TIME" />
                                        </Fields>
                                    </ext:Model>
                                </Model>
                            </ext:Store>
                        </Store>
                        <ColumnModel>
                  
                            <Columns>
                               <ext:RowNumbererColumn ID="rowNumCol" runat="server" Width="35" />
                               <ext:Column DataIndex="OBJID" runat="server" Text="OBJID" Visible="false" Width="100" >
                                </ext:Column>
                                <ext:Column DataIndex="PASS_FLAG" runat="server" Text="处理" Width="100" > 
                                    <Renderer Fn="Barcode_Renderer" />
                                </ext:Column>
                                <ext:Column DataIndex="BARCODE" runat="server" Text="半制品卡号" Width="200">
                                   <Renderer Fn="Barcode_Renderer" />  
                                </ext:Column>
                                <ext:Column DataIndex="MATERIAL_NAME" runat="server" Text="物料名称" Width="260">
                                </ext:Column>
                                <ext:Column DataIndex="OPER_NAME" runat="server" Text="主机手" Width="100">
                                </ext:Column>
                                <ext:Column DataIndex="EQUIP_NAME" runat="server" Text="生产机台" Width="100">
                                </ext:Column>
                                <ext:DateColumn DataIndex="END_TIME" runat="server" Text="生产日期" Width="160" Format="yyyy-MM-dd HH:mm:ss">
                                </ext:DateColumn>
                                <ext:DateColumn DataIndex="YA_TIME" runat="server" Text="有效日期"  Width="160" Format="yyyy-MM-dd HH:mm:ss">
                                </ext:DateColumn>
                                <ext:Column DataIndex="DUMMY9" runat="server" Text="延长时间"  Width="80" >
                                </ext:Column>
                                <ext:Column DataIndex="PASS_USER" runat="server" Text="放行人"  Width="80" >
                                </ext:Column>
                                <ext:DateColumn DataIndex="FX_TIME" runat="server" Text="放行时间"  Width="160" Format="yyyy-MM-dd HH:mm:ss">
                                </ext:DateColumn>
                                <ext:Column DataIndex="PASS_MEMO" runat="server" Text="放行类型"  Width="150" >
                                </ext:Column>
                                <ext:Column DataIndex="APPLY_FLAG_NAME" runat="server" Text="申请放行"  Width="100" >
                                </ext:Column>
                                <ext:Column DataIndex="APPLY_NAME" runat="server" Text="申请放行人"  Width="100" >
                                </ext:Column>
                                <ext:Column DataIndex="APPLY_TIME" runat="server" Text="申请放行时间"  Width="180" >
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
                                    <ext:ListItem Mode="Value" Value="3" Text="先入先出放行">
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
