<%@ Page Language="C#" AutoEventWireup="true" CodeFile="EquipPrint.aspx.cs" Inherits="Plugins_Main_BaseInfo_EquipPrint" %>
<%@ Register Assembly="FastReport.Web" Namespace="FastReport.Web" TagPrefix="cc1" %>
<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <cc1:WebReport ID="WebReport1" runat="server" BackColor="White" Font-Bold="False" 
             OnStartReport="WebReport1_StartReport" Width="100%" Zoom="1" 
            Padding="3, 3, 3, 3" ToolbarColor="Lavender" PrintInPdf="True" PdfEmbeddingFonts="True" Layers="False" />
    </div>
    </form>
</body>
</html>
