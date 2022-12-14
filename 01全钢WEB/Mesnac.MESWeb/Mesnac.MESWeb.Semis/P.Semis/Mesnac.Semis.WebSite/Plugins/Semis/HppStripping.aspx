<%@ Page Language="C#" AutoEventWireup="true" CodeFile="HppStripping.aspx.cs" Inherits="Plugins_Semis_HppStripping" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>剥离力合格维护</title>
    <script type="text/javascript" src="<%= Page.ResolveUrl("~/") %>resources/js/jquery-1.7.1.js"></script>
    <link rel="Stylesheet" type="text/css" href="<%= Page.ResolveUrl("~/") %>resources/css/ext-chinese-font.css" />
    <link rel="Stylesheet" type="text/css" href="<%= Page.ResolveUrl("~/") %>resources/css/main.css" />
    <script language="javascript" type="text/javascript">

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
               
                            <ext:Button runat="server" ID="ButtonOK" Text="合格" Icon="NoteEdit">
                                 <DirectEvents>
                                    <Click OnEvent="ButtonReturn_Click">
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
                                    
                                    <ext:TextField runat="server" ID="txtmater" FieldLabel="物料名称" LabelAlign="Right" />
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
                                    <ext:ComboBox runat="server" ID="cboshift" FieldLabel="班次" LabelAlign="Right" />
                                </Items>
                            </ext:Container>
                            <ext:Container ID="container4" runat="server" Layout="FormLayout" ColumnWidth=".25"
                                Padding="5">
                                <Items>
                                    <ext:ComboBox ID="cboOK" runat="server" FieldLabel="合格标志" LabelAlign="Right">
                                        <Items>
                                            <ext:ListItem Text="====全部====" Value=" " AutoDataBind="true"></ext:ListItem>
                                            <ext:ListItem Text="合格" Value="1"></ext:ListItem>
                                            <ext:ListItem Text="不合格" Value="2"></ext:ListItem>
                                            <ext:ListItem Text="待检" Value="0"></ext:ListItem>
                                        </Items>
                                    </ext:ComboBox>
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
                                            <ext:ModelField Name="PLANDETAILID" />
                                            <ext:ModelField Name="MATERIAL_NAME" />
                                            <ext:ModelField Name="SHIFT_NAME" />
                                            <ext:ModelField Name="CLASS_NAME" />
                                            <ext:ModelField Name="PLANDATE" Type="Date" />
                                            <ext:ModelField Name="RECORD_USER_NAME" />
                                            <ext:ModelField Name="RECORDTIME" Type="Date" />
                                            <ext:ModelField Name="OKOK" />
                                            <ext:ModelField Name="CONFIRM_USER_NAME" />
                                            <ext:ModelField Name="CONFIRM_TIME" Type="Date"  />
                                            <ext:ModelField Name="BATCH" />
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
                                <ext:Column DataIndex="PLANDETAILID" Text="计划明细号" Width="100" > 
                                </ext:Column>
                                <ext:Column DataIndex="MATERIAL_NAME" Text="物料名称" Width="200">
                                </ext:Column>
                                <ext:Column DataIndex="SHIFT_NAME" Text="班次" Width="80">
                                </ext:Column>
                                <ext:Column DataIndex="CLASS_NAME" Text="班组" Width="80">
                                </ext:Column>
                                <ext:Column DataIndex="BATCH" Text="批次号" Width="100">
                                </ext:Column>
                                <ext:DateColumn DataIndex="PLANDATE" Text="计划日期" Width="160" Format="yyyy-MM-dd HH:mm:ss">
                                </ext:DateColumn>
                                <ext:Column DataIndex="RECORD_USER_NAME" Text="送检人" Width="100">
                                </ext:Column>
                                <ext:DateColumn DataIndex="RECORDTIME" Text="送检时间"  Width="160" Format="yyyy-MM-dd HH:mm:ss">
                                </ext:DateColumn>
                                <ext:Column DataIndex="OKOK" Text="合格标志"  Width="80" >
                                </ext:Column>
                                <ext:Column DataIndex="CONFIRM_USER_NAME" Text="放行人"  Width="80" >
                                </ext:Column>
                                <ext:DateColumn DataIndex="CONFIRM_TIME" Text="放行时间"  Width="160" Format="yyyy-MM-dd HH:mm:ss">
                                </ext:DateColumn>
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

        <ext:Window runat="server" ID="WindowPass" Title="编辑合格标志" Width="360" Height="380"
            Hidden="true" Modal="false">
            <Items>
                <ext:FormPanel runat="server" ShadowMode="Frame">
                    <Items>
                        <ext:ComboBox runat="server" ID="cbxokflag" LabelAlign="Right" FieldLabel="合格标志"
                                Editable="false" LabelWidth="80" InputWidth="260" Padding="2">
                                <Items>
                                    <ext:ListItem Mode="Value" Value="1" Text="合格">
                                    </ext:ListItem>
                                    <ext:ListItem Mode="Value" Value="2" Text="不合格">
                                    </ext:ListItem>
                                </Items>
                            </ext:ComboBox>
                    </Items>
                </ext:FormPanel>
            </Items>
            <Buttons>
                <ext:Button runat="server" ID="ButtonEditAccept" Icon="Accept" Text="确定">
                    <DirectEvents>
                        <Click OnEvent="ButtonEditAccept_Click">
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
