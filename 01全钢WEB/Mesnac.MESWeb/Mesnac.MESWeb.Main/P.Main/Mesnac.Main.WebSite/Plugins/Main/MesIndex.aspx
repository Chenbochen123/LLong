<%@ Page Language="C#" AutoEventWireup="true" CodeFile="MesIndex.aspx.cs" Inherits="Plugins_Main_MesIndex" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
       <%=getUserNameLoginTime()%>
    </div>
    </form>
     <script type="text/javascript">
         function iniWindow() {
             setTimeout("reloadThisPage()", 1000 * 60);
         }
         function reloadThisPage() {
             window.location.replace(window.location.href);
         }
         iniWindow();
    </script>
</body>
</html>
