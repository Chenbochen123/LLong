<%@ Page Language="C#" AutoEventWireup="true" CodeFile="FqxXcheckCharts.aspx.cs" Inherits="Plugins_Quality_Xcheck_FqxXcheckCharts" %>
<%@ Register assembly="Ext.Net" namespace="Ext.Net" tagprefix="ext" %>
<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
    <script src="../../../resources/js/jquery-1.7.1.js" type="text/javascript"></script>
    <script>

        var xdata0;
        var ydata1;
        var $div = $('<div></div>');
        var resultStr;
        var exportData = function () {
            debugger;
            prompt('正在导出...');
            App.direct.ExportData({
                success: function (result) {
                    debugger;
                    $div.remove();
                    Ext.Msg.alert("提示", "导出Excel成功！");
                },
                failure: function (errorMsg) {
                    $div.remove();
                    Ext.Msg.alert("提示", "导出Excel失败！");
                    return false;
                }
            });
            return false;
        }
        var refreshChart = function () {
            debugger;
            prompt('正在统计...');
            App.direct.chartMainBindData({
                success: function (result) {
                    debugger;
                    if (result.length == 0) {
                        $div.remove();
                        Ext.Msg.alert("提示", "未检索到数据！");
                        return false;
                    }
                    resultStr = result;
                    result = JSON.parse(result);
                    refreshData(result);

                    $div.remove();
                },
                failure: function (errorMsg) {
                    $div.remove();
                    Ext.Msg.alert("提示", "查询超时，建议缩短查询时间尝试！");
                    return false;
                }});
            return false;
        }
        var refreshData = function (data) {
            debugger;
            xdata0 = [];
            for (var i = 0; i < data.length; i++) {
                xdata0.push(data[i]["TIME"]);
            }

            ydata1 = [];
            for (var i = 0; i < data.length; i++) {
                ydata1.push(data[i]["TRU"]);
                //if (data[i]["TRU"].length == 0) {
                //    ydata1.push(0);
                //}
                //else
                //{
                //    ydata1.push(data[i]["TRU"]);
                //}
            }
            App.SemisTechFhx.getBody().update("<iframe src='FqxXcheckChart.html' width=100% height=100% scrolling=no  frameborder=0></iframe>");
        }
        function prompt(newName) {
            $div.css({
                'position': 'fixed',
                'top': 0,
                'left': 0,
                'width': '100%',
                'height': '100%',
                'z-index': '200',
                'background-color': 'rgba(0,0,0,0.4)',
                // 'background-color':'#000',
            });
            var $contentDiv = $('<div>' + newName + '</div>');
            $contentDiv.css({
                'position': 'absolute',
                'top': '50%',
                'left': '50%',
                'font-size': '15px',
                'padding': '50px 100px',
                'border-radius': '5px',
                'background-color': '#fff',
                'color': '#000'
            });
            $div.append($contentDiv);
            $('body').append($div);

            // 获取创建的大小
            var newW = (parseInt($contentDiv.css('width')) + 200) / 2;
            var newH = (parseInt($contentDiv.css('height')) + 100) / 2;
            $contentDiv.css({
                'margin-top': -newH + 'px',
                'margin-left': -newW + 'px',
            })
        }

    </script>
</head>
<body>
    <form id="form1" runat="server">
        <asp:Button ID="btnExportSubmit" Style="display: none" runat="server" Text="Button"
            OnClick="btnExportSubmit_Click" />
        <ext:ResourceManager runat="server" ID="ResourceManager1" />
        <ext:Viewport runat="server" ID="Viewport1" Layout="BorderLayout">
            <Items>
                <ext:Panel runat="server" Region="North" AutoScroll="true">
                    <TopBar>
                        <ext:Toolbar runat="server">
                            <Items>
                                <ext:Button runat="server" ID="btnSearch" Icon="Find" Text="查询" >
                                     <Listeners>
                                        <Click Handler="refreshChart(false); return false;" />
                                    </Listeners>
                                </ext:Button>
                                <ext:Button runat="server" Icon="PageExcel" Text="导出Excel" ID="btnExport">
                                    <ToolTips>
                                        <ext:ToolTip ID="ToolTip2" runat="server" Html="点击将查询结果导出到Excel中" />
                                    </ToolTips>
                                    <Listeners>
                                        <%--<Click Handler="exportData(false); return false;" />--%>
                                        <Click Handler="$('#btnExportSubmit').click();">
                                        </Click>
                                    </Listeners>
                                </ext:Button>
                            </Items>
                        </ext:Toolbar>
                    </TopBar>
                    <Items>
                        
                        <ext:FormPanel ID="container_top" runat="server" Layout="ColumnLayout" AutoHeight="true">
                            <Items>
                                <ext:Container ID="container1" runat="server" Layout="FormLayout" ColumnWidth=".20"
                                    Padding="3">
                                    <Items>
                                        <ext:FieldContainer runat="server" FieldLabel="开始时间" Layout="HBoxLayout" LabelAlign="Right">
                                            <Items>
                                                <ext:DateField ID="txtBeginDate" runat="server" Flex="1" Editable="false" />
                                                <ext:TimeField ID="txtBeginTime" runat="server" width="70" Editable="true" />
                                            </Items>
                                        </ext:FieldContainer>
                                    </Items>
                                </ext:Container>
                                <ext:Container ID="container2" runat="server" Layout="FormLayout" ColumnWidth=".20"
                                    Padding="3">
                                    <Items>
                                        <ext:FieldContainer runat="server" FieldLabel="结束时间" Layout="HBoxLayout" LabelAlign="Right">
                                            <Items>
                                                <ext:DateField ID="txtEndDate" runat="server" Flex="1" Editable="false" />
                                                <ext:TimeField ID="txtEndTime" runat="server" width="70" Editable="true" />
                                            </Items>
                                        </ext:FieldContainer>
                                    </Items>
                                </ext:Container>
                                <ext:Container ID="container3" runat="server" Layout="FormLayout" ColumnWidth=".20"
                                    Padding="3">
                                    <Items>
                                         <ext:TextField ID="txtMaterialName" runat="server" FieldLabel="规格" LabelAlign="Right" Editable="false"></ext:TextField>
                                    </Items>
                                </ext:Container>
                                   <ext:Container ID="container4" runat="server" Layout="FormLayout" ColumnWidth=".20"
                                    Padding="3">
                                    <Items>
                                        <ext:ComboBox ID="cbxchengxing" runat="server" FieldLabel="成型机台" LabelAlign="Right" Editable="false"></ext:ComboBox>
                                    </Items>
                                </ext:Container>
                                
                                   <ext:Container ID="container5" runat="server" Layout="FormLayout" ColumnWidth=".20"
                                    Padding="3">
                                    <Items>
                                        <ext:ComboBox ID="cbxDefect" runat="server" FieldLabel="病疵" LabelAlign="Right" Editable="false">
                                        </ext:ComboBox>
                                    </Items>
                                </ext:Container>
                            </Items>
                            <Listeners>
                                <ValidityChange Handler="#{btnSearch}.setDisabled(!valid);" />
                            </Listeners>
                        </ext:FormPanel>
                    </Items>
                </ext:Panel>
                <ext:Panel runat="server" Region="Center" AutoScroll="true" ID="SemisTechFhx">
                </ext:Panel>
            </Items>
        </ext:Viewport>
        <ext:TaskManager runat="server">
            <Tasks>
            </Tasks>
        </ext:TaskManager>
        </form>
</body>
</html>
