<%@ Page Language="C#" AutoEventWireup="true" CodeFile="DSCJBPicture.aspx.cs" Inherits="Plugins_SemisBG_Shigong_DSCJBPicture" %>

<%@ Register Assembly="Ext.Net" Namespace="Ext.Net" TagPrefix="ext" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>带束层胶边示意图</title>
    <script type="text/javascript" src="<%= Page.ResolveUrl("~/") %>resources/js/jquery-1.7.1.js"></script>
    <link rel="Stylesheet" type="text/css" href="<%= Page.ResolveUrl("~/") %>resources/css/ext-chinese-font.css" />
    <link rel="Stylesheet" type="text/css" href="<%= Page.ResolveUrl("~/") %>resources/css/main.css" />
    <style type="text/css">
        .x-grid-row-collapsed .x-grid-cell {
            background-color: #B0FFBA !important;
        }
    </style>
    <script type="text/javascript">
       
    </script>
</head>
<body>
    <form id="form1" runat="server">
        <ext:ResourceManager ID="rmMoldingStorage" runat="server" />

        <ext:Viewport ID="vpMoldingStorage" runat="server" Layout="border">
            <Items>
                <ext:Panel runat="server" Region="Center" ID="panelid" AutoScroll="true">
                    <Items>
                        <ext:Image ID="Image1" runat="server" XDelta="-4555"
                            YDelta="-3286" AllowPan="true" ImageUrl="./DSCJB.png"/>
                    </Items>
                </ext:Panel>
            </Items>
        </ext:Viewport>
    </form>
</body>
</html>
