<%@ Page Language="C#" AutoEventWireup="true" CodeFile="SemisLevelInfo.aspx.cs" Inherits="Plugins_Semis_Quality_SemisLevelInfo" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>半部件判级处理</title>
    <script type="text/javascript" src="<%= Page.ResolveUrl("~/") %>resources/js/jquery-1.7.1.js"></script>
    <link rel="Stylesheet" type="text/css" href="<%= Page.ResolveUrl("~/") %>resources/css/ext-chinese-font.css" />
    <link rel="Stylesheet" type="text/css" href="<%= Page.ResolveUrl("~/") %>resources/css/main.css" />
    <script type="text/javascript">

        var CboPassMemo_select = function (sender) {
            App.direct.CboPassMemo_select(sender.getValue());
        };
        var commandcolumn_click = function (command, record) {
            commandcolumn_click_confirm(command, record);
            return false;
        };
        var commandcolumn_click_confirm = function (command, record) {
            if (command.toLowerCase() == "edit") {
                commandcolumn_direct_editdefect(record);
            }
            return false;
        };

        var prepareToolbar = function (grid, toolbar, rowIndex, record) {

        }

        var commandcolumn_direct_editdefect = function (record) {
            var barCode = record.data.BARCODE;
            var materName = record.data.MATERIAL_NAME;
            var materType = record.data.MATERTYPE;
            var equipID = record.data.EQUIP_ID;
            var classID = record.data.CLASS_ID;
            var shiftID = record.data.SHIFT_ID;
            var materID = record.data.MATERIAL_ID;
            App.direct.WindowPassShow(barCode, materName, materType, equipID, classID, shiftID, materID,{
                success: function () {
                },

                failure: function (errorMsg) {
                    Ext.Msg.alert('操作', errorMsg);
                }
            });
        }
        //列表刷新数据重载方法
        var pnlListFresh = function () {
            App.CheckboxSelectionModel1.deselectAll();
            return false;
        }
    </script>
</head>
<body>
    <form id="form1" runat="server">
    <ext:ResourceManager runat="server"  />
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
                            <ext:Store runat="server" ID="store"  PageSize="20">
                                <Model>
                                    <ext:Model runat="server" ID="ModelMain" IDProperty="OBJID">
                                        <Fields>
                                            <ext:ModelField Name="OBJID" />
                                            <ext:ModelField Name="BARCODE" />
                                            <ext:ModelField Name="MATERIAL_NAME" />
                                            <ext:ModelField Name="OPER_NAME" />
                                            <ext:ModelField Name="EQUIP_NAME" />
                                            <ext:ModelField Name="PRODUCE_TIME" Type="Date" />
                                            <ext:ModelField Name="END_TIME" Type="Date" />
                                            <ext:ModelField Name="MIN_TIME" />
                                            <ext:ModelField Name="VALID_TIME" />
                                            <ext:ModelField Name="YA_TIME" Type="Date"  />
                                            <ext:ModelField Name="MATERTYPE" />
                                            <ext:ModelField Name="EQUIP_ID" />
                                            <ext:ModelField Name="SHIFT_ID" />
                                            <ext:ModelField Name="CLASS_ID" />
                                            <ext:ModelField Name="MATERIAL_ID" />
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
                                <ext:Column DataIndex="BARCODE" Text="半制品卡号" Width="200">
                                </ext:Column>
                                <ext:Column DataIndex="MATERIAL_NAME" Text="物料名称" Width="260">
                                </ext:Column>
                                <ext:Column DataIndex="OPER_NAME" Text="主机手" Width="100">
                                </ext:Column>
                                <ext:Column DataIndex="EQUIP_NAME" Text="生产机台" Width="100">
                                </ext:Column>
                                <ext:DateColumn DataIndex="END_TIME" Text="生产日期" Width="160" Format="yyyy-MM-dd HH:mm:ss">
                                </ext:DateColumn>
                                <ext:DateColumn DataIndex="YA_TIME" Text="有效日期"  Width="160" Format="yyyy-MM-dd HH:mm:ss">
                                </ext:DateColumn>
                                <ext:Column DataIndex="MATERTYPE" Text="物料细类"  Width="0">
                                </ext:Column>
                                <ext:Column DataIndex="EQUIP_ID" Text="机台号"  Width="0">
                                </ext:Column>
                                <ext:Column DataIndex="SHIFT_ID" Text="班次"  Width="0">
                                </ext:Column>
                                <ext:Column DataIndex="CLASS_ID" Text="班组"  Width="0">
                                </ext:Column>
                                <ext:Column DataIndex="MATERIAL_ID" Text="物料编码"  Width="0">
                                </ext:Column>
                                
                                <ext:CommandColumn ID="commandCol" runat="server" Width="80" Text="操作" Align="Center">
                                    <Commands>
                                        <ext:GridCommand Icon="TableEdit" CommandName="Edit" Text="判级" />
                                    </Commands>
                                    <PrepareToolbar Fn="prepareToolbar" />
                                    <Listeners>
                                        <Command Handler="return commandcolumn_click(command, record);" />
                                    </Listeners>
                                    
                                </ext:CommandColumn>
                            </Columns>   
                        </ColumnModel>
                    </ext:GridPanel>
                </Items>
            </ext:Panel>
        </Items>
    </ext:Viewport>

        <ext:Window runat="server" ID="WindowPass" Title="判级处理" Width="360" Height="210"
            Hidden="true" Modal="false">
            <Items>
                <ext:FormPanel runat="server" ShadowMode="Frame">
                    <Items>
                        <ext:Hidden ID="equipID" runat="server" Text="0" />
                        <ext:Hidden ID="classID" runat="server" Text="0" />
                        <ext:Hidden ID="shiftID" runat="server" Text="0" />
                        <ext:Hidden ID="materID" runat="server" Text="0" />
                        <ext:Hidden ID="materType" runat="server" Text="0" />
                        <ext:TextField runat="server" ID="barCode" LabelAlign="Right" FieldLabel="条码号"
                            EmptyText="" Padding="2" InputWidth="200" LabelWidth="80" >
                        </ext:TextField>
                        <ext:TextField runat="server" ID="materName" LabelAlign="Right" FieldLabel="物料名称"
                            EmptyText="" Padding="2" InputWidth="200" LabelWidth="80" >
                        </ext:TextField>
                        <ext:ComboBox ID="CboPassMemo" runat="server" FieldLabel="是否合格" LabelAlign="Right" Editable="false"
                                    ValueField="value" DisplayField="text" Hidden="false" LabelWidth="80" InputWidth="200" Padding="2">
                                    <Items>
                                    <ext:ListItem Mode="Value" Value="0" Text="合格">
                                    </ext:ListItem>
                                    <ext:ListItem Mode="Value" Value="1" Text="不合格">
                                    </ext:ListItem>
                                </Items>
                                    <Listeners>
                                        <Change Fn="CboPassMemo_select" />
                                    </Listeners>
                                </ext:ComboBox>
                        <ext:ComboBox runat="server" ID="ComboBox1" LabelAlign="Right" FieldLabel="病疵"
                                Editable="false" LabelWidth="80" InputWidth="200" Padding="2" DisplayField="DefectPos" ValueField="Objid" >
                            <Store>
                                <ext:Store runat="server" ID="storeDefectPos">
                                    <Model>
                                        <ext:Model ID="Model1" runat="server" IDProperty="ID">
                                            <Fields>
                                                <ext:ModelField Name="Objid" ></ext:ModelField>
                                                <ext:ModelField Name="DefectPos" ></ext:ModelField>
                                            </Fields>
                                        </ext:Model>
                                        </Model>
                                    </ext:Store>
                                </Store>
                        </ext:ComboBox>
                        <ext:TextField runat="server" ID="Amount" LabelAlign="Right" FieldLabel="数量"
                            EmptyText="" Padding="2" InputWidth="200" LabelWidth="80" >
                        </ext:TextField>
                    </Items>
                </ext:FormPanel>
            </Items>
            <Buttons>
                <ext:Button runat="server" ID="ButtonEditAccept" Icon="Accept" Text="确定">
                    <DirectEvents>
                        <Click OnEvent="ButtonEditAccept_Click">
                            <Confirmation Title="提示" Message="确定要保存吗" ConfirmRequest="true" />
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