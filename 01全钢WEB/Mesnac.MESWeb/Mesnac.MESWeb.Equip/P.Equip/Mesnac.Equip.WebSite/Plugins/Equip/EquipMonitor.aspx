<%@ Page Language="C#" AutoEventWireup="true" CodeFile="EquipMonitor.aspx.cs" Inherits="Plugins_Equip_EquipMonitor" %>

<%@ Register Assembly="Ext.Net" Namespace="Ext.Net" TagPrefix="ext" %>
<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title></title>
    <script type="text/javascript">
        var btnSearch_Click = function () {
            if (timSearchBeginTime == null) {
                Ext.Msg.alert("错误", "请选择时间");
                return false;
            }
            return true;
        };
        var cboSearchShiftId_Change = function (newValue) {
            if (newValue == null || newValue == "") {
                return false;
            }
            App.direct.setSearchTime(newValue, {
                success: function (result) {
                    if (result != "") {
                        Ext.Msg.alert("提示", result);
                        return false;
                    }
                },
                failure: function (errorMsg) {
                    Ext.Msg.alert("提示", errorMsg);
                    return false;
                },
                eventMask: {
                    showMask: true
                }
            });
            return true;
        };

        var cgpSearchPressTempLine_Change = function (item) {
            var selectValues = "";

            var chks = item.getChecked();

            for (var i = 0; i < chks.length; i++) {
                var auditUserId = chks[i].inputValue;
                if (selectValues == "") {
                    selectValues = auditUserId;
                }
                else {
                    selectValues = selectValues + "," + auditUserId;
                }
            }
            App.hdnSearchPressTempLine.setValue(selectValues);
        };
        var cgpSearchPressTempLine_Load = function (id) {
            var selectValues = "";

            // var chks = CitiesStore
            var chks = ComboBox2.CitiesStore.getAt(0).get('id');
            for (var i = 0; i < chks.length; i++) {
                var auditUserId = chks[i];
                if (selectValues == "") {
                    selectValues = auditUserId;
                }
                else {
                    selectValues = selectValues + "," + auditUserId;
                }
            }
            App.hdnSearchPressTempLine.setValue(selectValues);
        };

        //区分删除操作，并进行二次确认操作
        var commandcolumn_click_confirm = function (command, record) {
            if (command.toLowerCase() == "search") {
                commandcolumn_direct_search(record);
            }
          
            return false;
        };
        //点击查看历史按钮
        var commandcolumn_direct_search = function (record) {
            debugger;
            var equipId = record.data.EQUIP_ID;
            App.direct.commandcolumn_direct_search(equipId,{
                success: function (result) {
                 
                },

                failure: function (errorMsg) {
                    Ext.Msg.alert('操作', errorMsg);
                }
            });
        }
        //根据按钮类别进行删除和编辑操作
        var commandcolumn_click = function (command, record) {
            debugger;
            commandcolumn_click_confirm(command, record);
            return false;
        };

        
    </script>

</head>

<body>
    <form id="form1" runat="server">
        <ext:ResourceManager runat="server" ID="ResourceManager1" />
        <ext:Viewport runat="server" ID="Viewport1" Layout="BorderLayout">
            <Items>
                <ext:Panel runat="server" Region="North" AutoScroll="true">
                    <TopBar>
                        <ext:Toolbar runat="server">
                            <Items>
                                <ext:Button runat="server" ID="btnSearch" Icon="Find" Text="查询" OnDirectClick="updateAllEquipState">
                                   
                                </ext:Button>
                            </Items>
                        </ext:Toolbar>
                    </TopBar>
                    <Items>
                        <ext:Panel runat="server" Width="700" Border="false">
                            <Items>
                                <ext:FieldSet runat="server" Layout="ColumnLayout" ColumnWidth="1" Title="设备类型"  >
                                    <Items>
                                        <ext:ComboBox runat="server" ID="txt_procedure" 
                                           Editable="false"
                                           ValueField="value"
                                           DisplayField="text" >
                                          </ext:ComboBox>
                                    </Items>
                                </ext:FieldSet>
                            </Items>
                        </ext:Panel>
                    </Items>
                </ext:Panel>
                <ext:TabPanel runat="server" ID="tabPanelMain" Region="Center" Layout="FitLayout">
                    <Items>
                    </Items>
                </ext:TabPanel>

                <ext:Panel runat="server" Region="Center" Layout="FitLayout">
                    <Items>
                        <ext:GridPanel ID="gridPanelMain" runat="server" Region="Center" SelectionMemoryEvents="true" Selectable="true">
                            <View>
                                <ext:GridView EnableTextSelection="true"></ext:GridView>
                            </View>
                            <Store>
                                <ext:Store ID="store" runat="server">
                                    <Model>
                                        <ext:Model ID="model" runat="server">
                                            <Fields>
                                                <ext:ModelField Name="EQUIP_NAME" />
                                                <ext:ModelField Name="EQUIP_STATE" />
                                                <ext:ModelField Name="EQUIP_ID" />
                                            </Fields>
                                        </ext:Model>
                                    </Model>
                                </ext:Store>
                            </Store>
                            <ColumnModel ID="colModel" runat="server">
                                <Columns>
                                    <ext:Column runat="server" Text="设备" DataIndex="EQUIP_NAME" Width="280" />
                                    <ext:Column runat="server" Text="状态" DataIndex="EQUIP_STATE" Width="280"/>
                                    <ext:Column runat="server" Text="设备ID" DataIndex="EQUIP_ID" Width="280" Hidden="true"/>
                                     <ext:CommandColumn ID="commandCol" runat="server" Width="120" Text="查看" Align="Center">
                                           <Commands>
                                                <ext:GridCommand Icon="Report" CommandName="Search" Text="查看历史">
                                                    <ToolTip Text="查看历史状态" />
                                                </ext:GridCommand>
                                           </Commands>
                                         <%-- <PrepareToolbar Fn="prepareToolbar" />--%>
                                            <Listeners>
                                                <Command Handler="return commandcolumn_click(command, record);" />
                                            </Listeners>
                                     </ext:CommandColumn>
                                </Columns>
                            </ColumnModel>
                        </ext:GridPanel>
                    </Items>
                </ext:Panel>

                <ext:Window ID="winSearch" runat="server" Icon="Monitor" Closable="true" Region="Center"
                    Title="设备历史故障信息" Width="700" Height="360" Resizable="false" Hidden="true" Modal="true"
                    BodyStyle="background-color:#fff;" BodyPadding="5" Layout="BorderLayout">
                    <Items>
                        <ext:GridPanel ID="gridPanel1" runat="server" Region="Center">
                        <Store>
                            <ext:Store ID="Store1" runat="server" PageSize="10">
                                <Model>
                                    <ext:Model ID="Model1" runat="server">
                                        <Fields>
                                             <ext:ModelField Name="RECORD_TIME" />
                                              <ext:ModelField Name="EQUIP_STATE" />
                                        </Fields>
                                    </ext:Model>
                                </Model>
                            </ext:Store>
                        </Store>
                       <ColumnModel ID="ColumnModel1" runat="server">
                                <Columns>
                                    <ext:Column runat="server" Text="时间" DataIndex="RECORD_TIME" Width="280" />
                                    <ext:Column runat="server" Text="状态" DataIndex="EQUIP_STATE" Width="280"/>
                                </Columns>
                       </ColumnModel>
                    </ext:GridPanel>
                    </Items>
                </ext:Window>
            </Items>
        </ext:Viewport>
        <ext:TaskManager runat="server">
            <Tasks>
                <%--实时曲线任务--%>
                <ext:Task TaskID="DataTask" AutoRun="true" Interval="10000">
                    <DirectEvents>
                        <Update OnEvent="updateAllEquipState" />
                    </DirectEvents>
                </ext:Task>
            </Tasks>
        </ext:TaskManager>
                
    </form>
</body>
</html>
