<%@ Page Language="C#" AutoEventWireup="true" CodeFile="StorageScrollSearch.aspx.cs" Inherits="Plugins_Semis_StorageInfo_StorageScrollSearch" %>

<%@ Register Assembly="Ext.Net" Namespace="Ext.Net" TagPrefix="ext" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link rel="Stylesheet" type="text/css" href="<%= Page.ResolveUrl("~/") %>resources/css/ext-chinese-font.css" />
    <link rel="Stylesheet" type="text/css" href="<%= Page.ResolveUrl("~/") %>resources/css/main.css" />
    <script type="text/javascript" src="<%= Page.ResolveUrl("~/") %>resources/js/jquery-1.7.1.js"></script>
    <script type="text/javascript">
        var pnlListFresh = function () {
            window.open("StorageScroll.aspx?StorageID=" + App.cbxStore.getValue() + "&&MaterCode=" + App.hiddenMaterCode.getValue() + "&&MaterName=" + App.txtMaterialName.getValue(), "_blank");
            //alert(App.hiddenStorageID.getValue() + ";" + App.hiddenStoragePlaceID.getValue() + ";" + App.hiddenMaterCode.getValue());
            //return false;
        }
        var thisRootUrl = "<%= Page.ResolveUrl("~/") %>";
        var AddStorage = function (field, trigger, index) {//库房添加
            switch (index) {
                case 0:
                    field.getTrigger(0).hide();
                    field.setValue('');
                    App.hiddenStorageID.setValue("");
                    field.getEl().down('input.x-form-text').setStyle('background', "white");
                    break;
                case 1:
                    var queryWindow = App.Plugins_Semis_BasicInfo_CommonPage_QueryBasStorage_Window;
                    var html = "<iframe src='../../BasicInfo/CommonPage/QueryBasStorage.aspx?Used_Flag=1' width=100% height=100% scrolling=no  frameborder=0></iframe>";
                    if (queryWindow.getBody()) {
                        queryWindow.getBody().update(html);
                    } else {
                        queryWindow.html = html;
                    }
                    queryWindow.show();
                    break;
            }
        }

        var QueryMaterial = function (field, trigger, index) {//物料查询
            switch (index) {
                case 0:
                    field.getTrigger(0).hide();
                    field.setValue('');
                    App.hiddenMaterCode.setValue("");
                    field.getEl().down('input.x-form-text').setStyle('background', "white");
                    break;
                case 1:
                    debugger;
                    App.McUI_SearchBox_SearchBoxHbmMaterial_Window.show();
                    break;
            }
        }

        Ext.create("Ext.window.Window", {//库房查询带窗体
            id: "Plugins_Semis_BasicInfo_CommonPage_QueryBasStorage_Window",
            height: 460,
            hidden: true,
            width: 360,
            html: "<iframe src='../../BasicInfo/CommonPage/QueryBasStorage.aspx' width=100% height=100% scrolling=no  frameborder=0></iframe>",
            bodyStyle: "background-color: #fff;",
            closable: true,
            title: "请选择库房",
            modal: true
        })


        Ext.create("Ext.window.Window", {//物料查询带回窗体
            id: "McUI_SearchBox_SearchBoxHbmMaterial_Window",
            height: 430,
            hidden: true,
            width: 360,
            html: "<iframe src='" + thisRootUrl + "McUI/SearchBox/SearchBoxHbmMaterial.aspx' width=100% height=100% scrolling=no  frameborder=0></iframe>",
            bodyStyle: "background-color: #fff;",
            closable: true,
            title: "请选择物料",
            modal: true
        });

        var Plugins_Semis_BasicInfo_CommonPage_QueryBasStorage_Request = function (record) {//库房信息返回值处理
            App.txtStorageName.getTrigger(0).show();
            App.txtStorageName.setValue(record.data.STORE_NAME);
            App.hiddenStorageID.setValue(record.data.OBJID);
        }

        var McUI_SearchBox_SearchBoxHbmMaterial_Request = function (record) {
            App.txtMaterName.getTrigger(0).show();
            App.txtMaterName.setValue(record.data.MATERIAL_NAME);
            App.hiddenMaterCode.setValue(record.data.OBJID);
        }
    </script>
</head>
<body>
    <form id="form1" runat="server">
        <ext:ResourceManager ID="rmAutoScroll" runat="server" />
        <ext:Panel ID="pnStorage" runat="server" Region="North" Height="90">
            <TopBar>
                <ext:Toolbar runat="server" ID="tbStorage">
                    <Items>
                        <ext:ToolbarSeparator ID="tsBegin" />
                        <ext:Button runat="server" Icon="Find" Text="查询" ID="btnSearch">
                            <Listeners>
                                <Click Fn="pnlListFresh" />
                            </Listeners>
                        </ext:Button>
                        <ext:ToolbarSeparator ID="tsEnd" />
                        <ext:ToolbarSpacer runat="server" ID="tspacerEnd" />
                        <ext:ToolbarFill ID="tfEnd" />
                    </Items>
                </ext:Toolbar>
            </TopBar>
            <Items>
                <ext:FormPanel ID="container_top" runat="server" Layout="ColumnLayout" AutoHeight="true">
                    <Items>
                        <ext:Container ID="container1" runat="server" Layout="FormLayout" ColumnWidth=".33"
                            Padding="5">
                            <Items>
                                <ext:ComboBox ID="cbxStore" runat="server" FieldLabel="仓库" LabelAlign="Right" Editable="false" MultiSelect="true">
                                    <Triggers>
                                        <ext:FieldTrigger Icon="Clear" Qtip="清空" />
                                    </Triggers>
                                    <Listeners>
                                        <TriggerClick Handler="this.setValue('');" />
                                    </Listeners>

                                </ext:ComboBox>
                            </Items>
                        </ext:Container>
                        <ext:Container ID="container2" runat="server" Layout="FormLayout" ColumnWidth=".3"
                            Padding="5">
                            <Items>
                                <ext:TextField ID="txtMaterialName" runat="server" FieldLabel="规格" LabelAlign="Right" Editable="false"></ext:TextField>
                            </Items>
                        </ext:Container>
                        <ext:Container ID="container3" runat="server" Layout="FormLayout" ColumnWidth=".34"
                            Padding="5">
                            <Items>
                                <ext:TriggerField ID="txtMaterName" runat="server" FieldLabel="物料名称" LabelAlign="Left"
                                    Editable="false">
                                    <Triggers>
                                        <ext:FieldTrigger Icon="Clear" HideTrigger="true" />
                                        <ext:FieldTrigger Icon="Search" />
                                    </Triggers>
                                    <Listeners>
                                        <TriggerClick Fn="QueryMaterial" />
                                    </Listeners>
                                </ext:TriggerField>
                            </Items>
                        </ext:Container>
                    </Items>
                    <Listeners>
                        <ValidityChange Handler="#{btnSearch}.setDisabled(!valid);" />
                    </Listeners>
                </ext:FormPanel>
            </Items>
        </ext:Panel>
        <ext:Hidden ID="hiddenStorageID" runat="server"></ext:Hidden>
        <ext:Hidden ID="hiddenMaterCode" runat="server"></ext:Hidden>
    </form>
</body>
</html>

