<%@ page language="C#" autoeventwireup="true" inherits="Plugins_Storage_Manage_ReloadOutStockBillToSap, Mesnac.Storage.WebSite" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <ext:ResourceManager runat="server" />
        <ext:Viewport runat="server" Layout="BorderLayout">
            <Items>
                <ext:Panel runat="server" Region="North">
                    <TopBar>
                        <ext:Toolbar runat="server">
                            <Items>
                                <ext:Button runat="server" ID="btnReload" Text="重传">
                                    <DirectEvents>
                                        
                                    </DirectEvents>
                                </ext:Button>
                            </Items>
                        </ext:Toolbar>
                    </TopBar>
                    <Items>
                        <ext:Panel runat="server" Layout="ColumnLayout">
                            <Items>
                                <ext:TextField runat="server" ID="txtSNNo" FieldLabel="出货单号"></ext:TextField>
                            </Items>
                        </ext:Panel>
                    </Items>
                </ext:Panel>
                <ext:Panel runat="server" Region="Center">
                    <Items>
                        <ext:GridPanel runat="server" ID="gpInfo">
                            <Store>
                                <ext:Store runat="server" AutoLoad="false">
                                    <Proxy>
                                        <ext:PageProxy />
                                    </Proxy>
                                    <Model>
                                        <ext:Model runat="server">
                                            <Fields>

                                            </Fields>
                                        </ext:Model>
                                    </Model>
                                </ext:Store>
                            </Store>
                        </ext:GridPanel>
                    </Items>
                </ext:Panel>
            </Items>

        </ext:Viewport>
    </form>
</body>
</html>
