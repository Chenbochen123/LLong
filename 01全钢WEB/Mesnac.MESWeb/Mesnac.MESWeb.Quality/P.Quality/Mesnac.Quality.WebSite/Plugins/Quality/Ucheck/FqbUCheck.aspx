<%@ Page Language="C#" AutoEventWireup="true" CodeFile="FqbUCheck.aspx.cs" Inherits="Plugins_Quality_Ucheck_FqbUCheck" %>

<%@ Register Assembly="Ext.Net" Namespace="Ext.Net" TagPrefix="ext" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>均匀性数据查询</title>
    <script type="text/javascript" src="<%= Page.ResolveUrl("~/") %>resources/js/jquery-1.7.1.js"></script>
    <link rel="Stylesheet" type="text/css" href="<%= Page.ResolveUrl("~/") %>resources/css/ext-chinese-font.css" />
    <link rel="Stylesheet" type="text/css" href="<%= Page.ResolveUrl("~/") %>resources/css/main.css" />
    <style type="text/css">
        .x-grid-row-collapsed .x-grid-cell {
            background-color: #B0FFBA !important;
        }
    </style>
    <script type="text/javascript">
        var pnlListFresh = function () {
            App.storeData.currentPage = 1;
            App.pageToolBar.doRefresh();
            return false;
        }
        //var prepareToolbar = function (grid, toolbar, rowIndex, record) {
        //    if (record.get("REALDONG") != "" && record.get("REALDONG") != null) {
        //        if (record.get("REALJUN") != "" && record.get("REALJUN") != null) {
        //            if (record.get("REALDONG") > record.get("REALJUN")) {
        //                if (record.get("REALDONG") == "1") {
        //                    record.set("TOTALRANK", "A品");
        //                }
        //                else if (record.get("REALDONG") == "2") {
        //                    record.set("TOTALRANK", "B品");
        //                }
        //                else if (record.get("REALDONG") == "3") {
        //                    record.set("TOTALRANK", "C品");
        //                }
        //                else if (record.get("REALDONG") == "4") {
        //                    record.set("TOTALRANK", "D品");
        //                }
        //                else {
        //                    record.set("TOTALRANK", "");
        //                }
        //            }
        //            else {
        //                if (record.get("REALJUN") == "1") {
        //                    record.set("TOTALRANK", "A品");
        //                }
        //                else if (record.get("REALJUN") == "2") {
        //                    record.set("TOTALRANK", "B品");
        //                }
        //                else if (record.get("REALJUN") == "3") {
        //                    record.set("TOTALRANK", "C品");
        //                }
        //                else if (record.get("REALJUN") == "4") {
        //                    record.set("TOTALRANK", "D品");
        //                }
        //                else {
        //                    record.set("TOTALRANK", "");
        //                }
        //            }
        //        }
        //        else {
        //            if (record.get("REALDONG") == "1") {
        //                record.set("TOTALRANK", "A品");
        //            }
        //            else if (record.get("REALDONG") == "2") {
        //                record.set("TOTALRANK", "B品");
        //            }
        //            else if (record.get("REALDONG") == "3") {
        //                record.set("TOTALRANK", "C品");
        //            }
        //            else if (record.get("REALDONG") == "4") {
        //                record.set("TOTALRANK", "D品");
        //            }
        //            else {
        //                record.set("TOTALRANK", "");
        //            }
        //        }
        //    }
        //    else {
        //        if (record.get("REALJUN") != "" && record.get("REALJUN") != null) {
        //            if (record.get("REALJUN") == "1") {
        //                record.set("TOTALRANK", "A品");
        //            }
        //            else if (record.get("REALJUN") == "2") {
        //                record.set("TOTALRANK", "B品");
        //            }
        //            else if (record.get("REALJUN") == "3") {
        //                record.set("TOTALRANK", "C品");
        //            }
        //            else if (record.get("REALJUN") == "4") {
        //                record.set("TOTALRANK", "D品");
        //            }
        //            else {
        //                record.set("TOTALRANK", "");
        //            }
        //        }
        //        else {
        //            record.set("TOTALRANK", "");
        //        }
        //    }
        //}
    </script>
</head>
<body>
    <form id="form1" runat="server">
        <asp:Button ID="btnExportSubmit" Style="display: none" runat="server" Text="Button"
            OnClick="btnExportSubmit_Click" />
        <ext:ResourceManager ID="rmFcheckInfo" runat="server" />
        <ext:Viewport ID="vpFcheckInfo" runat="server" Layout="border">
            <Items>
                <ext:Panel ID="pnFcheckInfo" runat="server" Region="North" Height="100">
                    <TopBar>
                        <ext:Toolbar runat="server" ID="tbFcheckInfo">
                            <Items>
                                <ext:Button runat="server" Icon="Find" Text="查询" ID="btnSearch">
                                    <DirectEvents>
                                        <Click OnEvent="btnQuary_Click" Timeout="120000">
                                            <EventMask ShowMask="true" Msg="查询中..."></EventMask>
                                        </Click>
                                    </DirectEvents>
                                </ext:Button>
                                <ext:Button runat="server" Icon="PageExcel" Text="导出Excel" ID="btnExport">
                                    <ToolTips>
                                        <ext:ToolTip ID="ToolTip2" runat="server" Html="点击将查询结果导出到Excel中" />
                                    </ToolTips>
                                    <Listeners>
                                        <Click Handler="$('#btnExportSubmit').click();">
                                        </Click>
                                    </Listeners>
                                </ext:Button>
                                <ext:Hidden runat="server" ID="hiddenMaterialName" Text=" "></ext:Hidden>
                                <ext:ToolbarSeparator ID="tsEnd" />
                                <ext:ToolbarSpacer runat="server" ID="tspacerEnd" />
                                <ext:ToolbarFill ID="tfEnd" />
                            </Items>
                        </ext:Toolbar>
                    </TopBar>
                    <Items>
                        <ext:FormPanel ID="container_top" runat="server" Layout="ColumnLayout" AutoHeight="true">
                            <Items>
                                <ext:Container ID="container1" runat="server" Layout="FormLayout" ColumnWidth=".25"
                                    Padding="5">
                                    <Items>
                                        <ext:FieldContainer runat="server" FieldLabel="开始时间" Layout="HBoxLayout" LabelAlign="Right">
                                            <Items>
                                                <ext:DateField ID="txtBeginDate" runat="server" Flex="1" Editable="false" />
                                                <ext:TimeField ID="txtBeginTime" runat="server" Width="80" Editable="true" />
                                            </Items>
                                        </ext:FieldContainer>
                                        <ext:TextField ID="txtMaterialName" runat="server" FieldLabel="规格" LabelAlign="Right" Editable="false"></ext:TextField>
                                    </Items>
                                </ext:Container>
                                <ext:Container ID="container2" runat="server" Layout="FormLayout" ColumnWidth=".25"
                                    Padding="5">
                                    <Items>
                                        <ext:FieldContainer runat="server" FieldLabel="结束时间" Layout="HBoxLayout" LabelAlign="Right">
                                            <Items>
                                                <ext:DateField ID="txtEndDate" runat="server" Flex="1" Editable="false" />
                                                <ext:TimeField ID="txtEndTime" runat="server" Width="80" Editable="true" />
                                            </Items>
                                        </ext:FieldContainer>
                                        <ext:ComboBox ID="cbxEquipCuring" runat="server" FieldLabel="硫化机台" LabelAlign="Right" Editable="false"></ext:ComboBox>
                                    </Items>
                                </ext:Container>
                                <ext:Container ID="container3" runat="server" Layout="FormLayout" ColumnWidth=".25"
                                    Padding="5">
                                    <Items>
                                        <ext:TextField ID="txtTyreNo" runat="server" FieldLabel="硫化号" LabelAlign="Right" />
                                        <ext:ComboBox ID="cbxEquipMolding" runat="server" FieldLabel="成型机台" LabelAlign="Right" Editable="false"></ext:ComboBox>
                                    </Items>
                                </ext:Container>
                                <ext:Container ID="container4" runat="server" Layout="FormLayout" ColumnWidth=".25"
                                    Padding="5">
                                    <Items>
                                        <ext:ComboBox ID="cbxEquip" runat="server" FieldLabel="检测机台" LabelAlign="Right" Editable="false"></ext:ComboBox>
                                        <ext:ComboBox ID="cbxrank" runat="server" FieldLabel="总品级" LabelAlign="Right" Editable="false"></ext:ComboBox>
                                    </Items>
                                </ext:Container>

                            </Items>
                            <Listeners>
                                <ValidityChange Handler="#{btnSearch}.setDisabled(!valid);" />
                            </Listeners>
                        </ext:FormPanel>
                    </Items>
                </ext:Panel>
                <ext:Panel ID="pnlDetail" runat="server" Region="South" Title="检验数据" Height="530" Width="600" Icon="Basket" Layout="Fit"
                    Split="true" MarginsSummary="0 5 5 5" AutoScroll="true">
                    <Items>
                        <ext:GridPanel ID="pnlDetailList" runat="server" MarginsSummary="0 5 5 5">
                            <Store>
                                <ext:Store ID="storeData" runat="server" PageSize="50">

                                    <Model>
                                        <ext:Model ID="modelDetail" runat="server" IDProperty="OBJID">
                                            <Fields>
                                                <ext:ModelField Name="OBJID" />
                                                <ext:ModelField Name="TYRENO" />
                                                <ext:ModelField Name="MATERIALID" />
                                                <ext:ModelField Name="MATERIALNAME" />
                                                <ext:ModelField Name="EQUIP_NAME" />
                                                <ext:ModelField Name="UFMSTANDARD" />
                                                <ext:ModelField Name="CHECKTIME" Type="Date" />
                                                <ext:ModelField Name="TOTAL" />
                                                <ext:ModelField Name="LOAD1" />
                                                <ext:ModelField Name="CWRFVOAKGF" />
                                                <ext:ModelField Name="CWRFVOADEG" />
                                                <ext:ModelField Name="CWRFVOARANK" />
                                                <ext:ModelField Name="CWRFVOA1HKGF" />
                                                <ext:ModelField Name="CWRFVOA1HDEG" />
                                                <ext:ModelField Name="CWRFVOA1HRANK" />
                                                <ext:ModelField Name="CWRFVOA2HKGF" />
                                                <ext:ModelField Name="CWRFVOA2HDEG" />
                                                <ext:ModelField Name="CWRFVOA2HRANK" />
                                                <ext:ModelField Name="CWRFVOA8HKGF" />
                                                <ext:ModelField Name="CWRFVOA8HDEG" />
                                                <ext:ModelField Name="CWRFVOA8HRANK" />
                                                <ext:ModelField Name="CWLFVOAKGF" />
                                                <ext:ModelField Name="CWLFVOADEG" />
                                                <ext:ModelField Name="CWLFVOARANK" />
                                                <ext:ModelField Name="CWLFVOA1HKGF" />
                                                <ext:ModelField Name="CWLFVOA1HDEG" />
                                                <ext:ModelField Name="CWLFVOA1HRANK" />
                                                <ext:ModelField Name="CWLFVOA2HKGF" />
                                                <ext:ModelField Name="CWLFVOA2HDEG" />
                                                <ext:ModelField Name="CWLFVOA2HRANK" />
                                                <ext:ModelField Name="CWLFVOA8HKGF" />
                                                <ext:ModelField Name="CWLFVOA8HDEG" />
                                                <ext:ModelField Name="CWLFVOA8HRANK" />
                                                <ext:ModelField Name="CCWRFVOAKGF" />
                                                <ext:ModelField Name="CCWRFVOADEG" />
                                                <ext:ModelField Name="CCWRFVOARANK" />
                                                <ext:ModelField Name="CCWRFVOA1HKGF" />
                                                <ext:ModelField Name="CCWRFVOA1HDEG" />
                                                <ext:ModelField Name="CCWRFVOA1HRANK" />
                                                <ext:ModelField Name="CCWRFVOA2HKGF" />
                                                <ext:ModelField Name="CCWRFVOA2HDEG" />
                                                <ext:ModelField Name="CCWRFVOA2HRANK" />
                                                <ext:ModelField Name="CCWRFVOA8HKGF" />
                                                <ext:ModelField Name="CCWRFVOA8HDEG" />
                                                <ext:ModelField Name="CCWRFVOA8HRANK" />
                                                <ext:ModelField Name="CCWLFVOAKGF" />
                                                <ext:ModelField Name="CCWLFVOADEG" />
                                                <ext:ModelField Name="CCWLFVOARANK" />
                                                <ext:ModelField Name="CCWLFVOA1HKGF" />
                                                <ext:ModelField Name="CCWLFVOA1HDEG" />
                                                <ext:ModelField Name="CCWLFVOA1HRANK" />
                                                <ext:ModelField Name="CCWLFVOA2HKGF" />
                                                <ext:ModelField Name="CCWLFVOA2HDEG" />
                                                <ext:ModelField Name="CCWLFVOA2HRANK" />
                                                <ext:ModelField Name="CCWLFVOA8HKGF" />
                                                <ext:ModelField Name="CCWLFVOA8HDEG" />
                                                <ext:ModelField Name="CCWLFVOA8HRANK" />
                                                <ext:ModelField Name="CWLFDKGF" />
                                                <ext:ModelField Name="CWLFDRANK" />
                                                <ext:ModelField Name="CCWLFDKGF" />
                                                <ext:ModelField Name="CCWLFDRANK" />
                                                <ext:ModelField Name="CONKGF" />
                                                <ext:ModelField Name="CONRANK" />
                                                <ext:ModelField Name="PLYKGF" />
                                                <ext:ModelField Name="PLYRANK" />
                                                <ext:ModelField Name="UFMTOTALRANK" />
                                                <ext:ModelField Name="ROTOTALRANK" />
                                                <ext:ModelField Name="PDM_CODE" />
                                                <ext:ModelField Name="M_EQUIP_NAME" />
                                                <ext:ModelField Name="M_CLASS_NAME" />
                                                <ext:ModelField Name="MOLDINGNAME" />
                                                <ext:ModelField Name="MOLDINGNAME1" />
                                                <ext:ModelField Name="MOLDINGNAME2" />
                                                <ext:ModelField Name="C_EQUIP_NAME" />
                                                <ext:ModelField Name="SHOW_NAME" />
                                                <ext:ModelField Name="C_CLASS_NAME" />
                                                <ext:ModelField Name="CURINGNAME" />
                                                <ext:ModelField Name="BEGIN_TIME" />
                                                <ext:ModelField Name="END_TIME" />
                                                <ext:ModelField Name="C_BEGIN_TIME" />
                                                <ext:ModelField Name="C_END_TIME" />
                                                <ext:ModelField Name="REALDONG" />
                                                <ext:ModelField Name="REALJUN" />
                                                <ext:ModelField Name="UFRANK" />
                                                <ext:ModelField Name="RCOA_AMOUNT" />
                                                <ext:ModelField Name="RCOARANK" />
                                                <ext:ModelField Name="RCOADEG" />
                                                <ext:ModelField Name="STATICUNBALANCEDEG" />
                                                <ext:ModelField Name="STATICRANK" />
                                                <ext:ModelField Name="STATIC_AMOUNT" />
                                                <ext:ModelField Name="COUPLEUNBALANCEDEG" />
                                                <ext:ModelField Name="COUPLERANK" />
                                                <ext:ModelField Name="COUPLE_AMOUNT" />
                                                <ext:ModelField Name="UPRANK" />
                                                <ext:ModelField Name="UP_AMOUNT" />
                                                <ext:ModelField Name="LOWERRANK" />
                                                <ext:ModelField Name="LOWER_AMOUNT" />
                                                <ext:ModelField Name="LOWERUNBALANCEDEG" />
                                                <ext:ModelField Name="UPLOWERRANK" />
                                                <ext:ModelField Name="UPLOWER_AMOUNT" />

                                            </Fields>
                                        </ext:Model>
                                    </Model>
                                </ext:Store>
                            </Store>
                            <ColumnModel ID="ColumnModelDetail" runat="server">
                                <Columns>
                                    <ext:RowNumbererColumn ID="rowNumCol1" runat="server" Width="35" />
                                    <ext:Column ID="TYRE_ID" runat="server" Text="胎号" DataIndex="TYRENO" Width="100" />
                                    <ext:Column ID="Column62" runat="server" Text="REALJUN" DataIndex="REALJUN" Width="100" Hidden="true" />
                                    <ext:Column ID="Column63" runat="server" Text="REALDONG" DataIndex="REALDONG" Width="100" Hidden="true" />
                                    <ext:Column ID="GREEN_TYRE_NO" runat="server" Text="物料ID" DataIndex="MATERIALID" Width="100" />
                                    <ext:Column ID="MATERIAL_NAME_DETAIL" runat="server" Text="物料名" DataIndex="MATERIALNAME" Width="250" />
                                    <ext:Column ID="Column61" runat="server" Text="PDM编码" DataIndex="PDM_CODE" Width="100" />
                                    <ext:Column ID="M_EQUIP_NAME" runat="server" Text="成型机台" DataIndex="M_EQUIP_NAME" Width="100" />
                                    <ext:Column ID="M_CLASS_NAME" runat="server" Text="成型班组" DataIndex="M_CLASS_NAME" Width="60" />
                                    <ext:Column ID="MOLDINGNAME" runat="server" Text="主手" DataIndex="MOLDINGNAME" Width="60" />
                                    <ext:Column ID="MOLDINGNAME1" runat="server" Text="副手" DataIndex="MOLDINGNAME1" Width="60" />
                                    <ext:Column ID="MOLDINGNAME2" runat="server" Text="帮车" DataIndex="MOLDINGNAME2" Width="60" />

                                    <ext:Column ID="C_EQUIP_NAME" runat="server" Text="硫化机台" DataIndex="C_EQUIP_NAME" Width="100" />
                                    <ext:Column ID="SHOW_NAME" runat="server" Text="左右模" DataIndex="SHOW_NAME" Width="100" />
                                    <ext:Column ID="C_CLASS_NAME" runat="server" Text="硫化班组" DataIndex="C_CLASS_NAME" Width="60" />
                                    <ext:Column ID="CURINGNAME" runat="server" Text="硫化工" DataIndex="CURINGNAME" Width="60" />
                                    <ext:DateColumn ID="BEGIN_TIME" runat="server" Text="成型开始时间" DataIndex="BEGIN_TIME" Width="160" Format="yyyy-MM-dd HH:mm:ss" />
                                    <ext:DateColumn ID="END_TIME" runat="server" Text="成型结束时间" DataIndex="END_TIME" Width="160" Format="yyyy-MM-dd HH:mm:ss" />
                                    <ext:DateColumn ID="C_BEGIN_TIME" runat="server" Text="硫化开始时间" DataIndex="C_BEGIN_TIME" Width="160" Format="yyyy-MM-dd HH:mm:ss" />
                                    <ext:DateColumn ID="C_END_TIME" runat="server" Text="硫化结束时间" DataIndex="C_END_TIME" Width="160" Format="yyyy-MM-dd HH:mm:ss" />
                                    <ext:Column ID="Column1" runat="server" Text="检测设备" DataIndex="EQUIP_NAME" Width="100" />
                                    <ext:Column ID="EQUIP_NAME" runat="server" Text="均匀性标准" DataIndex="UFMSTANDARD" Width="100" />
                                    <ext:DateColumn ID="DateColumn1" runat="server" Text="检查时间" DataIndex="CHECKTIME" Width="160" Format="yyyy-MM-dd HH:mm:ss" />
                                    <ext:Column ID="STANDARD" runat="server" Text="最终等级" DataIndex="TOTAL" Width="100">
                                        <%--<Renderer Fn="change" />--%>
                                    </ext:Column>
                                    <ext:Column ID="Column2" runat="server" Text="荷重" DataIndex="LOAD1" Width="100" />
                                    <ext:Column ID="Column3" runat="server" Text="径向力波动值" DataIndex="CWRFVOAKGF" Width="100" />
                                    <ext:Column ID="Column4" runat="server" Text="径向力波动角度" DataIndex="CWRFVOADEG" Width="100" />
                                    <ext:Column ID="Column5" runat="server" Text="径向力波动等级" DataIndex="CWRFVOARANK" Width="100" />
                                    <ext:Column ID="Column6" runat="server" Text="径向力波动一次谐波值" DataIndex="CWRFVOA1HKGF" Width="100" />
                                    <ext:Column ID="Column7" runat="server" Text="径向力波动一次谐波角度" DataIndex="CWRFVOA1HDEG" Width="100" />
                                    <ext:Column ID="Column8" runat="server" Text="径向力波动一次谐波等级" DataIndex="CWRFVOA1HRANK" Width="100" />
                                    <ext:Column ID="Column9" runat="server" Text="径向力波动二次谐波值" DataIndex="CWRFVOA2HKGF" Width="100" />
                                    <ext:Column ID="Column10" runat="server" Text="径向力波动二次谐波角度" DataIndex="CWRFVOA2HDEG" Width="100" />
                                    <ext:Column ID="Column11" runat="server" Text="径向力波动二次谐波等级" DataIndex="CWRFVOA2HRANK" Width="100" />
                                    <ext:Column ID="Column12" runat="server" Text="径向力波动八次谐波值" DataIndex="CWRFVOA8HKGF" Width="100" />
                                    <ext:Column ID="Column13" runat="server" Text="径向力波动八次谐波角度" DataIndex="CWRFVOA8HDEG" Width="100" />
                                    <ext:Column ID="Column14" runat="server" Text="径向力波动八次谐波等级" DataIndex="CWRFVOA8HRANK" Width="100" />
                                    <ext:Column ID="Column15" runat="server" Text="侧向力波动值" DataIndex="CWLFVOAKGF" Width="100" />
                                    <ext:Column ID="Column16" runat="server" Text="侧向力波动角度" DataIndex="CWLFVOADEG" Width="100" />
                                    <ext:Column ID="Column17" runat="server" Text="侧向力波动等级" DataIndex="CWLFVOARANK" Width="100" />
                                    <ext:Column ID="Column18" runat="server" Text="侧向力波动一次谐波值" DataIndex="CWLFVOA1HKGF" Width="100" />
                                    <ext:Column ID="Column19" runat="server" Text="侧向力波动一次谐波角度" DataIndex="CWLFVOA1HDEG" Width="100" />
                                    <ext:Column ID="Column20" runat="server" Text="侧向力波动一次谐波等级" DataIndex="CWLFVOA1HRANK" Width="100" />
                                    <ext:Column ID="Column21" runat="server" Text="侧向力波动二次谐波值" DataIndex="CWLFVOA2HKGF" Width="100" />
                                    <ext:Column ID="Column22" runat="server" Text="侧向力波动二次谐波角度" DataIndex="CWLFVOA2HDEG" Width="100" />
                                    <ext:Column ID="Column23" runat="server" Text="侧向力波动二次谐波等级" DataIndex="CWLFVOA2HRANK" Width="100" />
                                    <ext:Column ID="Column24" runat="server" Text="侧向力波动八次谐波值" DataIndex="CWLFVOA8HKGF" Width="100" />
                                    <ext:Column ID="Column25" runat="server" Text="侧向力波动八次谐波角度" DataIndex="CWLFVOA8HDEG" Width="100" />
                                    <ext:Column ID="Column26" runat="server" Text="侧向力波动八次谐波等级" DataIndex="CWLFVOA8HRANK" Width="100" />
                                    <ext:Column ID="Column27" runat="server" Text="反转径向力波动值" DataIndex="CCWRFVOAKGF" Width="100" />
                                    <ext:Column ID="Column28" runat="server" Text="反转径向力波动角度" DataIndex="CCWRFVOADEG" Width="100" />
                                    <ext:Column ID="Column29" runat="server" Text="反转径向力波动等级" DataIndex="CCWRFVOARANK" Width="100" />
                                    <ext:Column ID="Column30" runat="server" Text="反转径向力波动一次谐波值" DataIndex="CCWRFVOA1HKGF" Width="100" />
                                    <ext:Column ID="Column31" runat="server" Text="反转径向力波动一次谐波角度" DataIndex="CCWRFVOA1HDEG" Width="100" />
                                    <ext:Column ID="Column32" runat="server" Text="反转径向力波动一次谐波等级" DataIndex="CCWRFVOA1HRANK" Width="100" />
                                    <ext:Column ID="Column33" runat="server" Text="反转径向力波动二次谐波值" DataIndex="CCWRFVOA2HKGF" Width="100" />
                                    <ext:Column ID="Column34" runat="server" Text="反转径向力波动二次谐波角度" DataIndex="CCWRFVOA2HDEG" Width="100" />
                                    <ext:Column ID="Column35" runat="server" Text="反转径向力波动二次谐波等级" DataIndex="CCWRFVOA2HRANK" Width="100" />
                                    <ext:Column ID="Column36" runat="server" Text="反转径向力波动八次谐波值" DataIndex="CCWRFVOA8HKGF" Width="100" />
                                    <ext:Column ID="Column37" runat="server" Text="反转径向力波动八次谐波角度" DataIndex="CCWRFVOA8HDEG" Width="100" />
                                    <ext:Column ID="Column38" runat="server" Text="反转径向力波动八次谐波等级" DataIndex="CCWRFVOA8HRANK" Width="100" />
                                    <ext:Column ID="Column39" runat="server" Text="反转侧向力波动值" DataIndex="CCWLFVOAKGF" Width="100" />
                                    <ext:Column ID="Column40" runat="server" Text="反转侧向力波动角度" DataIndex="CCWLFVOADEG" Width="100" />
                                    <ext:Column ID="Column41" runat="server" Text="反转侧向力波动等级" DataIndex="CCWLFVOARANK" Width="100" />
                                    <ext:Column ID="Column42" runat="server" Text="反转侧向力波动一次谐波值" DataIndex="CCWLFVOA1HKGF" Width="100" />
                                    <ext:Column ID="Column43" runat="server" Text="反转侧向力波动一次谐波角度" DataIndex="CCWLFVOA1HDEG" Width="100" />
                                    <ext:Column ID="Column44" runat="server" Text="反转侧向力波动一次谐波等级" DataIndex="CCWLFVOA1HRANK" Width="100" />
                                    <ext:Column ID="Column45" runat="server" Text="反转侧向力波动二次谐波值" DataIndex="CCWLFVOA2HKGF" Width="100" />
                                    <ext:Column ID="Column46" runat="server" Text="反转侧向力波动二次谐波角度" DataIndex="CCWLFVOA2HDEG" Width="100" />
                                    <ext:Column ID="Column47" runat="server" Text="反转侧向力波动二次谐波等级" DataIndex="CCWLFVOA2HRANK" Width="100" />
                                    <ext:Column ID="Column48" runat="server" Text="反转侧向力波动八次谐波值" DataIndex="CCWLFVOA8HKGF" Width="100" />
                                    <ext:Column ID="Column49" runat="server" Text="反转侧向力波动八次谐波角度" DataIndex="CCWLFVOA8HDEG" Width="100" />
                                    <ext:Column ID="Column50" runat="server" Text="反转侧向力波动八次谐波等级" DataIndex="CCWLFVOA8HRANK" Width="100" />
                                    <ext:Column ID="Column51" runat="server" Text="正转侧向力偏移值" DataIndex="CWLFDKGF" Width="100" />
                                    <ext:Column ID="Column52" runat="server" Text="正转侧向力偏移等级" DataIndex="CWLFDRANK" Width="100" />
                                    <ext:Column ID="Column53" runat="server" Text="反转侧向力偏移值" DataIndex="CCWLFDKGF" Width="100" />
                                    <ext:Column ID="Column60" runat="server" Text="反转侧向力偏移等级" DataIndex="CCWLFDRANK" Width="100" />
                                    <ext:Column ID="Column54" runat="server" Text="锥度值" DataIndex="CONKGF" Width="100" />
                                    <ext:Column ID="Column55" runat="server" Text="锥度等级" DataIndex="CONRANK" Width="100" />
                                    <ext:Column ID="Column56" runat="server" Text="帘布效应值" DataIndex="PLYKGF" Width="100" />
                                    <ext:Column ID="Column57" runat="server" Text="帘布效应等级" DataIndex="PLYRANK" Width="100" />
                                    <ext:Column ID="Column58" runat="server" Text="均匀性总等级" DataIndex="UFMTOTALRANK" Width="100" />
                                    <ext:Column ID="Column59" runat="server" Text="跳动度总等级" DataIndex="ROTOTALRANK" Width="100" />
                                    <ext:Column ID="Column64" runat="server" Text="径向跳动" DataIndex="RCOA_AMOUNT" Width="100" />
                                    <ext:Column ID="Column65" runat="server" Text="径向跳动等级" DataIndex="RCOARANK" Width="100" />
                                    <ext:Column ID="Column66" runat="server" Text="径向中间跳动角度" DataIndex="RCOADEG" Width="100" />
                                    <ext:Column ID="Column67" runat="server" Text="静合成不平衡量角度" DataIndex="STATICUNBALANCEDEG" Width="100" />
                                    <ext:Column ID="Column68" runat="server" Text="静合成等级" DataIndex="STATICRANK" Width="100" />
                                    <ext:Column ID="Column69" runat="server" Text="静合成量值" DataIndex="STATIC_AMOUNT" Width="100" />
                                    <ext:Column ID="Column70" runat="server" Text="偶不平衡量角度" DataIndex="COUPLEUNBALANCEDEG" Width="100" />
                                    <ext:Column ID="Column71" runat="server" Text="偶合成等级" DataIndex="COUPLERANK" Width="100" />
                                    <ext:Column ID="Column72" runat="server" Text="偶合成量值" DataIndex="COUPLE_AMOUNT" Width="100" />
                                    <ext:Column ID="Column73" runat="server" Text="上动平衡等级" DataIndex="UPRANK" Width="100" />
                                    <ext:Column ID="Column74" runat="server" Text="上动平衡量" DataIndex="UP_AMOUNT" Width="100" />
                                    <ext:Column ID="Column75" runat="server" Text="下动平衡等级" DataIndex="LOWERRANK" Width="100" />
                                    <ext:Column ID="Column76" runat="server" Text="下动平衡量" DataIndex="LOWER_AMOUNT" Width="100" />
                                    <ext:Column ID="Column77" runat="server" Text="下面不平衡量角度" DataIndex="LOWERUNBALANCEDEG" Width="100" />
                                    <ext:Column ID="Column78" runat="server" Text="总动平衡等级" DataIndex="UPLOWERRANK" Width="100" />
                                    <ext:Column ID="Column79" runat="server" Text="总动平衡量" DataIndex="UPLOWER_AMOUNT" Width="100" />
                                   <%-- <ext:CommandColumn ID="commandCol" runat="server" Width="120" Text="操作" Align="Center" Hidden="true">

                                        <PrepareToolbar Fn="prepareToolbar" />
                                    </ext:CommandColumn>--%>
                                </Columns>
                            </ColumnModel>
                            <SelectionModel>
                                <ext:RowSelectionModel ID="rowSelectMuti" runat="server" Mode="Single">
                                    <Listeners>
                                        <Select Handler="#{storeDetail}.reload();" Buffer="250" />
                                    </Listeners>
                                </ext:RowSelectionModel>
                            </SelectionModel>
                            <BottomBar>
                                <ext:PagingToolbar ID="pageToolBar" runat="server">
                                    <Items>
                                        <ext:Label ID="Label1" runat="server" Text="每页条数:" Hidden="true" />
                                        <ext:ToolbarSpacer ID="ToolbarSpacer1" runat="server" Width="10" />
                                        <ext:ComboBox ID="ComboBox1" runat="server" Width="80" Hidden="true">
                                            <Items>
                                                <ext:ListItem Text="10" />
                                                <ext:ListItem Text="50" />
                                                <ext:ListItem Text="100" />
                                                <ext:ListItem Text="200" />
                                            </Items>
                                            <SelectedItems>
                                                <ext:ListItem Value="10" />
                                            </SelectedItems>
                                            <Listeners>
                                                <Select Handler="#{pnlDetailList}.storeData.pageSize = parseInt(this.getValue(), 10); #{pageToolBar}.doRefresh(); return false;" />
                                            </Listeners>
                                        </ext:ComboBox>
                                    </Items>
                                    <Plugins>
                                        <ext:ProgressBarPager ID="ProgressBarPager" runat="server" />
                                    </Plugins>
                                </ext:PagingToolbar>
                            </BottomBar>
                        </ext:GridPanel>
                    </Items>
                </ext:Panel>
            </Items>
        </ext:Viewport>
    </form>
</body>
</html>
