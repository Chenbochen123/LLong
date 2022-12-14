<%@ Page Language="C#" AutoEventWireup="true" CodeFile="FastReportPage.aspx.cs" Inherits="Plugins_Semis_Shigong_FastReportPage" %>

<%@ Register Assembly="FastReport.Web" Namespace="FastReport.Web" TagPrefix="cc1" %>
<%@ Register Assembly="Ext.Net" Namespace="Ext.Net" TagPrefix="ext" %>
<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title></title>
</head>
<body>
    <form id="form1" runat="server" >
        <div style="margin:0 auto; overflow-x:auto;overflow-y:auto">
            <cc1:WebReport ID="WebReport1" runat="server" BackColor="White" Font-Bold="False"
                Width="100%" Height="100%" Zoom="1.3" Padding="3, 3, 3, 3" ToolbarColor="Lavender"
                PrintInPdf="True" Layers="False" PdfEmbeddingFonts="false" ShowExports="false"
                ShowRefreshButton="false" ShowToolbar="true" BorderColor="White" ShowXmlExcelExport="false"  ShowExcel2007Export="false" />
        </div>
    </form>
</body>
</html>
