<%@ Page Language="C#" AutoEventWireup="true" CodeFile="VerifyMaterialMessage.aspx.cs" Inherits="VerifyMaterialManager" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <script type="text/javascript" src="<%= Page.ResolveUrl("~/") %>resources/js/jquery-1.7.1.js"></script>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>物料验证信息</title>
    <script type="text/javascript">
        //确定按钮
        var btn_click = function (a) {
            console.log(a.findParentByType("fieldset").title);
            App.hidden_objid.setValue(a.findParentByType("fieldset").title)
            App.direct.commandcolumn_direct_edit();
        }
        /// 硫化生产扫描时验证硫化车间库
        //var CuringStorageControl_click = function () {

        //    Ext.Msg.confirm('提示', "你确定要修改吗？", function (btn) {
        //        if (btn != "yes") {
        //            return false;
        //        }
        //        // Ext.Msg.wait('修改中...','修改中');
        //        App.direct.CuringStorageControlUpdate();
        //    });

        //}
        //
        //var isVerityTime_click = function () {

        //    Ext.Msg.confirm('提示', "你确定要修改吗？", function (btn) {
        //        if (btn != "yes") {
        //            return false;
        //        }
        //        // Ext.Msg.wait('修改中...','修改中');
        //        App.direct.isVerityTimeUpdate();
        //    });

        //}
        //半制品最小停放
        //var isTFTime_click = function () {

        //    Ext.Msg.confirm('提示', "你确定要修改吗？", function (btn) {
        //        if (btn != "yes") {
        //            return false;
        //        }
        //        // Ext.Msg.wait('修改中...','修改中');
        //        App.direct.isTFTimeUpdate();
        //    });

        //}
        //半制品胶料最小停放
        //var SemisIsTFTime_click = function () {

        //    Ext.Msg.confirm('提示', "你确定要修改吗？", function (btn) {
        //        if (btn != "yes") {
        //            return false;
        //        }
        //        // Ext.Msg.wait('修改中...','修改中');
        //        App.direct.SemisIsTFTimeUpdate();
        //    });

        //}
        //半制品胶料
        //var SemisisVerityTime_click = function () {

        //    Ext.Msg.confirm('提示', "你确定要修改吗？", function (btn) {
        //        if (btn != "yes") {
        //            return false;
        //        }
        //        // Ext.Msg.wait('修改中...','修改中');
        //        App.direct.SemisisVerityTimeUpdate();
        //    });

        //}

        //胎胚超期验证
        //var MoldingisVerityTime_click = function () {

        //    Ext.Msg.confirm('提示', "你确定要修改吗？", function (btn) {
        //        if (btn != "yes") {
        //            return false;
        //        }
        //        // Ext.Msg.wait('修改中...','修改中');
        //        App.direct.MoldingisVerityTimeUpdate();
        //    });

        //}
        //成型最小停放
        //var MoldingIsTFTime_click = function () {

        //    Ext.Msg.confirm('提示', "你确定要修改吗？", function (btn) {
        //        if (btn != "yes") {
        //            return false;
        //        }
        //        // Ext.Msg.wait('修改中...','修改中');
        //        App.direct.MoldingIsTFTimeUpdate();
        //    });

        //}

        //var ScanCuringStorageControl_click = function () {

        //    Ext.Msg.confirm('提示', "你确定要修改吗？", function (btn) {
        //        if (btn != "yes") {
        //            return false;
        //        }
        //        // Ext.Msg.wait('修改中...','修改中');
        //        App.direct.ScanCuringStorageControlUpdate();
        //    });

        //}

        /// 硫化领料时验证物料
        //var CuringMaterialControl_click = function () {

        //    Ext.Msg.confirm('提示', "你确定要修改吗？", function (btn) {
        //        if (btn != "yes") {
        //            return false;
        //        }
        //        // Ext.Msg.wait('修改中...','修改中');
        //        App.direct.CuringMaterialControlUpdate();
        //    });

        //}

        ///半部件领胶料是否控制数量
        //var SemisRubberControlQty_Click = function () {

        //    Ext.Msg.confirm('提示', "你确定要修改吗？", function (btn) {
        //        if (btn != "yes") {
        //            return false;
        //        }
        //        // Ext.Msg.wait('修改中...','修改中');
        //        App.direct.SemisRubberControlQtyUpdate();
        //    });

        //}
        ///半部件领胶料是否控制物料规格
        //var SemisRubberControlMater_Click = function () {

        //    Ext.Msg.confirm('提示', "你确定要修改吗？", function (btn) {
        //        if (btn != "yes") {
        //            return false;
        //        }
        //        // Ext.Msg.wait('修改中...','修改成功');
        //        App.direct.SemisRubberControlMaterUpdate();
        //    });

        //}
        ///成型领半部件是否控制数量
        //var MolidngSemisControlQty_Click = function () {

        //    Ext.Msg.confirm('提示', "你确定要修改吗？", function (btn) {
        //        if (btn != "yes") {
        //            return false;
        //        }
        //        // Ext.Msg.wait('修改中...','修改成功');
        //        App.direct.MolidngSemisControlQtyUpdate();
        //    });

        //}
        ///成型领半部件是否控制物料规格
        //var MolidngSemisControlMater_Click = function () {

        //    Ext.Msg.confirm('提示', "你确定要修改吗？", function (btn) {
        //        if (btn != "yes") {
        //            return false;
        //        }
        //        // Ext.Msg.wait('修改中...','修改中');
        //        App.direct.MolidngSemisControlMaterUpdate();
        //    });

        //}

        ///硫化生产是否验证年周号
        //var YanzhengWeek_Click = function () {

        //    Ext.Msg.confirm('提示', "你确定要修改吗？", function (btn) {
        //        if (btn != "yes") {
        //            return false;
        //        }
        //        App.direct.YanzhengWeekUpdate();
        //    });

        //}
        ///硫化领胎胚推荐胎胚车数量
        //var MoldingStorageTopNum_click = function () {

        //    Ext.Msg.confirm('提示', "你确定要修改吗？", function (btn) {
        //        if (btn != "yes") {
        //            return false;
        //        }
        //        // Ext.Msg.wait('修改中...','修改成功');
        //        App.direct.MoldingStorageTopNumUpdate();
        //    });

        //}
        ///硫化领胎胚先入先出时间设置
        //var MoldingStorageFIFOTime_Click = function () {

        //    Ext.Msg.confirm('提示', "你确定要修改吗？", function (btn) {
        //        if (btn != "yes") {
        //            return false;
        //        }
        //        // Ext.Msg.wait('修改中...','修改成功');
        //        App.direct.MoldingStorageFIFOTimeUpdate();
        //    });

        //}
        ///半部件领胶料先入先出时间设置
        //var SemisRubberFIFOTime_Click = function () {

        //    Ext.Msg.confirm('提示', "你确定要修改吗？", function (btn) {
        //        if (btn != "yes") {
        //            return false;
        //        }
        //        // Ext.Msg.wait('修改中...','修改成功');
        //        App.direct.SemisRubberFIFOTimeUpdate();
        //    });

        //}
        ///半部件领半部件先入先出时间设置
        //var SemisBZPFIFOTime_Click = function () {

        //    Ext.Msg.confirm('提示', "你确定要修改吗？", function (btn) {
        //        if (btn != "yes") {
        //            return false;
        //        }
        //        // Ext.Msg.wait('修改中...','修改成功');
        //        App.direct.SemisBZPFIFOTimeUpdate();
        //    });

        //}
        ///成型领半部件先入先出时间设置
        //var MoldingSemisFIFOTime_Click = function () {

        //    Ext.Msg.confirm('提示', "你确定要修改吗？", function (btn) {
        //        if (btn != "yes") {
        //            return false;
        //        }
        //        // Ext.Msg.wait('修改中...','修改成功');
        //        App.direct.MoldingSemisFIFOTimeUpdate();
        //    });

        //}
        ///硫化第十步内压差值判级标准
        //var CuringTenPress_Click = function () {

        //    Ext.Msg.confirm('提示', "你确定要修改吗？", function (btn) {
        //        if (btn != "yes") {
        //            return false;
        //        }
        //        // Ext.Msg.wait('修改中...','修改成功');
        //        App.direct.CuringTenPressUpdate();
        //    });

        //}
        /// 硫化生产扫描时验证胎胚超期
        //var CuringGreenTimeControl_click = function () {

        //    Ext.Msg.confirm('提示', "你确定要修改吗？", function (btn) {
        //        if (btn != "yes") {
        //            return false;
        //        }
        //        // Ext.Msg.wait('修改中...','修改中');
        //        App.direct.CuringGreenTimeControlUpdate();
        //    });

        //}

        /// 成型机台线边库先入先出控制
        //var MoldingEquipStorageXRXCControl_click = function () {

        //    Ext.Msg.confirm('提示', "你确定要修改吗？", function (btn) {
        //        if (btn != "yes") {
        //            return false;
        //        }
        //        // Ext.Msg.wait('修改中...','修改中');
        //        App.direct.MoldingEquipStorageXRXCControlUpdate();
        //    });

        //}

        /// 半部件机台线边库先入先出控制
        //var SemisEquipStorageXRXCControl_click = function () {

        //    Ext.Msg.confirm('提示', "你确定要修改吗？", function (btn) {
        //        if (btn != "yes") {
        //            return false;
        //        }
        //        // Ext.Msg.wait('修改中...','修改中');
        //        App.direct.SemisEquipStorageXRXCControlUpdate();
        //    });

        //}
        /// 半部件(胶料)机台线边库先入先出控制
        //var SemisRubberEquipStorageXRXCControl_click = function () {

        //    Ext.Msg.confirm('提示', "你确定要修改吗？", function (btn) {
        //        if (btn != "yes") {
        //            return false;
        //        }
        //        // Ext.Msg.wait('修改中...','修改中');
        //        App.direct.SemisRubberEquipStorageXRXCControlUpdate();
        //    });

        //}
        /// 半部件(钢压大卷)机台线边库先入先出控制
        //var SemisGYEquipStorageXRXCControl_click = function () {

        //    Ext.Msg.confirm('提示', "你确定要修改吗？", function (btn) {
        //        if (btn != "yes") {
        //            return false;
        //        }
        //        // Ext.Msg.wait('修改中...','修改中');
        //        App.direct.SemisGYEquipStorageXRXCControlUpdate();
        //    });

        //}

        //硫化换模首件胎验证次数
        //var FirstTyreMaxTime_Click = function () {

        //    Ext.Msg.confirm('提示', "你确定要修改吗？", function (btn) {
        //        if (btn != "yes") {
        //            return false;
        //        }
        //        App.direct.FirstTyreMaxTimeUpdate();
        //    });

        //}
        //异常停机PLC管控时间(min)
        //var CuringStopErrorTime_Click = function () {

        //    Ext.Msg.confirm('提示', "你确定要修改吗？", function (btn) {
        //        if (btn != "yes") {
        //            return false;
        //        }
        //        App.direct.CuringStopErrorTimeUpdate();
        //    });

        //}
        //异常停机记录首末件时间(min)
        //var CuringStopErrorInsertTime_Click = function () {

        //    Ext.Msg.confirm('提示', "你确定要修改吗？", function (btn) {
        //        if (btn != "yes") {
        //            return false;
        //        }
        //        App.direct.CuringStopErrorInsertTimeUpdate();
        //    });

        //}

        //默认值
        var CuringStorageControl_Change = function (item, oldValue, newValue) {
            var dateType = item.getChecked()[0].inputValue;
            App.CuringStorageControl.setValue(dateType);
        };

        var isVerityTime_Change = function (item, oldValue, newValue) {
            var dateType = item.getChecked()[0].inputValue;
            App.isVerityTime.setValue(dateType);
        };

        var isTFTime_Change = function (item, oldValue, newValue) {
            var dateType = item.getChecked()[0].inputValue;
            App.isTFTime.setValue(dateType);
        };

        var SemisIsTFTime_Change = function (item, oldValue, newValue) {
            var dateType = item.getChecked()[0].inputValue;
            App.SemisIsTFTime.setValue(dateType);
        };

        var MoldingIsTFTime_Change = function (item, oldValue, newValue) {
            var dateType = item.getChecked()[0].inputValue;
            App.MoldingIsTFTime.setValue(dateType);
        };

        var SemisisVerityTime_Change = function (item, oldValue, newValue) {
            var dateType = item.getChecked()[0].inputValue;
            App.SemisisVerityTime.setValue(dateType);
        };


        var MoldingisVerityTime_Change = function (item, oldValue, newValue) {
            var dateType = item.getChecked()[0].inputValue;
            App.MoldingisVerityTime.setValue(dateType);
        };

        var CuringMaterialControl_Change = function (item, oldValue, newValue) {
            var dateType = item.getChecked()[0].inputValue;
            App.CuringMaterialControl.setValue(dateType);
        };

        var ScanCuringStorageControl_Change = function (item, oldValue, newValue) {
            var dateType = item.getChecked()[0].inputValue;
            App.ScanCuringStorageControl.setValue(dateType);
        };

        var SemisRubberControlQty_Change = function (item, oldValue, newValue) {
            var dateType = item.getChecked()[0].inputValue;
            App.SemisRubberControlQty.setValue(dateType);
        };

        var SemisRubberControlMater_Change = function (item, oldValue, newValue) {
            var dateType = item.getChecked()[0].inputValue;
            App.SemisRubberControlMater.setValue(dateType);
        };

        var MolidngSemisControlQty_Change = function (item, oldValue, newValue) {
            var dateType = item.getChecked()[0].inputValue;
            App.MolidngSemisControlQty.setValue(dateType);
        };

        var MolidngSemisControlMater_Change = function (item, oldValue, newValue) {
            var dateType = item.getChecked()[0].inputValue;
            App.MolidngSemisControlMater.setValue(dateType);
        };
        var YanzhengWeek_Change = function (item, oldValue, newValue) {
            var dateType = item.getChecked()[0].inputValue;
            App.YanzhengWeek.setValue(dateType);
        };

        var CuringGreenTimeControl_Change = function (item, oldValue, newValue) {
            var dateType = item.getChecked()[0].inputValue;
            App.CuringGreenTimeControl.setValue(dateType);
        };

        var MoldingEquipStorageXRXCControl_Change = function (item, oldValue, newValue) {
            var dateType = item.getChecked()[0].inputValue;
            App.MoldingEquipStorageXRXCControl.setValue(dateType);
        };

        var SemisEquipStorageXRXCControl_Change = function (item, oldValue, newValue) {
            var dateType = item.getChecked()[0].inputValue;
            App.SemisEquipStorageXRXCControl.setValue(dateType);
        }; 
        var SemisRubberEquipStorageXRXCControl_Change = function (item, oldValue, newValue) {
            var dateType = item.getChecked()[0].inputValue;
            App.SemisRubberEquipStorageXRXCControl.setValue(dateType);
        };
        var SemisGYEquipStorageXRXCControl_Change = function (item, oldValue, newValue) {
            var dateType = item.getChecked()[0].inputValue;
            App.SemisGYEquipStorageXRXCControl.setValue(dateType);
        };
        var CuringScanXRXC_Change = function (item, oldValue, newValue) {
            var dateType = item.getChecked()[0].inputValue;
            App.CuringScanXRXC.setValue(dateType);
        };

    </script>
</head>
<body>
    <form id="form1" runat="server">

        <ext:ResourceManager runat="server" ID="ResourceManager1" />

        <ext:Viewport runat="server" ID="Viewport1" Layout="FitLayout">
            <Items>
                <ext:Panel runat="server" ID="pnlSearch" Layout="BorderLayout" ActiveIndex="1" ActiveItem="1" Title="验证信息" AutoScroll="true">
                    <Items>
                        <ext:Panel runat="server" Region="North" >
                            <Items>
                                
                                <ext:Panel runat="server" Layout="FormLayout" MaxWidth="620">
                                    <Items>

                                        <ext:FieldSet runat="server" Title="硫化生产扫描时验证硫化车间库">
                                            <Items>
                                                
                                                <ext:Hidden runat="server" ID="CuringStorageControl" />
                                                <ext:RadioGroup runat="server" ID="RadioGroup1" Layout="ColumnLayout">
                                                    <Items>
                                                        <ext:Radio ID="Radio1" runat="server" InputValue="1" BoxLabelAlign="After" BoxLabel="是" ColumnWidth="0.3" />
                                                        <ext:Radio ID="Radio2" runat="server" InputValue="0" BoxLabelAlign="After" BoxLabel="否" ColumnWidth="0.3" />
                                                        <ext:Button runat="server" ID="Button1" Text="确定1">
                                                            <Listeners>
                                                                <Click Handler=" return btn_click(this)" />
                                                            </Listeners>
                                                        </ext:Button>
                                                    </Items>
                                                    <Listeners>
                                                        <Change Handler="return CuringStorageControl_Change(item, oldValue, newValue);" />
                                                    </Listeners>
                                                </ext:RadioGroup>
                                            </Items>
                                        </ext:FieldSet>

                                        
                                        <ext:FieldSet runat="server" Title="半部件超期验证">
                                            <Items>
                                                
                                                <ext:Hidden runat="server" ID="isVerityTime" />
                                                <ext:RadioGroup runat="server" ID="RadioGroup8" Layout="ColumnLayout">
                                                    <Items>
                                                        <ext:Radio ID="Radio15" runat="server" InputValue="1" BoxLabelAlign="After" BoxLabel="是" ColumnWidth="0.3" />
                                                        <ext:Radio ID="Radio16" runat="server" InputValue="0" BoxLabelAlign="After" BoxLabel="否" ColumnWidth="0.3" />
                                                        <ext:Button runat="server" ID="Button12" Text="确定12">
                                                            <Listeners>
                                                                <%--<Click Handler=" return isVerityTime_click()" />--%>
                                                                <Click Handler=" return btn_click(this)" />
                                                            </Listeners>
                                                        </ext:Button>
                                                    </Items>
                                                    <Listeners>
                                                        <Change Handler="return isVerityTime_Change(item, oldValue, newValue);" />
                                                    </Listeners>
                                                </ext:RadioGroup>
                                            </Items>
                                        </ext:FieldSet>

                                        <ext:FieldSet runat="server" Title="半部件停放时间验证">
                                            <Items>
                                                
                                                <ext:Hidden runat="server" ID="isTFTime" />
                                                <ext:RadioGroup runat="server" ID="RadioGroup11" Layout="ColumnLayout">
                                                    <Items>
                                                        <ext:Radio ID="Radio21" runat="server" InputValue="1" BoxLabelAlign="After" BoxLabel="是" ColumnWidth="0.3" />
                                                        <ext:Radio ID="Radio22" runat="server" InputValue="0" BoxLabelAlign="After" BoxLabel="否" ColumnWidth="0.3" />
                                                        <ext:Button runat="server" ID="Button15" Text="确定15">
                                                            <Listeners>
                                                                <%--<Click Handler=" return isTFTime_click()" />--%>
                                                                <Click Handler=" return btn_click(this)" />
                                                            </Listeners>
                                                        </ext:Button>
                                                    </Items>
                                                    <Listeners>
                                                        <Change Handler="return isTFTime_Change(item, oldValue, newValue);" />
                                                    </Listeners>
                                                </ext:RadioGroup>
                                            </Items>
                                        </ext:FieldSet>

                                        <ext:FieldSet runat="server" Title="半制品胶料停放时间验证">
                                            <Items>
                                                
                                                <ext:Hidden runat="server" ID="SemisIsTFTime" />
                                                <ext:RadioGroup runat="server" ID="RadioGroup12" Layout="ColumnLayout">
                                                    <Items>
                                                        <ext:Radio ID="Radio23" runat="server" InputValue="1" BoxLabelAlign="After" BoxLabel="是" ColumnWidth="0.3" />
                                                        <ext:Radio ID="Radio24" runat="server" InputValue="0" BoxLabelAlign="After" BoxLabel="否" ColumnWidth="0.3" />
                                                        <ext:Button runat="server" ID="Button16" Text="确定16">
                                                            <Listeners>
                                                                <%--<Click Handler=" return SemisIsTFTime_click()" />--%>
                                                                <Click Handler=" return btn_click(this)" />
                                                            </Listeners>
                                                        </ext:Button>
                                                    </Items>
                                                    <Listeners>
                                                        <Change Handler="return SemisIsTFTime_Change(item, oldValue, newValue);" />
                                                    </Listeners>
                                                </ext:RadioGroup>
                                            </Items>
                                        </ext:FieldSet>

                                        <ext:FieldSet runat="server" Title="胎胚停放时间验证">
                                            <Items>
                                                
                                                <ext:Hidden runat="server" ID="MoldingIsTFTime" />
                                                <ext:RadioGroup runat="server" ID="RadioGroup13" Layout="ColumnLayout">
                                                    <Items>
                                                        <ext:Radio ID="Radio25" runat="server" InputValue="1" BoxLabelAlign="After" BoxLabel="是" ColumnWidth="0.3" />
                                                        <ext:Radio ID="Radio26" runat="server" InputValue="0" BoxLabelAlign="After" BoxLabel="否" ColumnWidth="0.3" />
                                                        <ext:Button runat="server" ID="Button17" Text="确定17">
                                                            <Listeners>
                                                                <%--<Click Handler=" return MoldingIsTFTime_click()" />--%>
                                                                <Click Handler=" return btn_click(this)" />
                                                            </Listeners>
                                                        </ext:Button>
                                                    </Items>
                                                    <Listeners>
                                                        <Change Handler="return MoldingIsTFTime_Change(item, oldValue, newValue);" />
                                                    </Listeners>
                                                </ext:RadioGroup>
                                            </Items>
                                        </ext:FieldSet>

                                        <ext:FieldSet runat="server" Title="半制品胶料超期验证">
                                            <Items>
                                                
                                                <ext:Hidden runat="server" ID="SemisisVerityTime" />
                                                <ext:RadioGroup runat="server" ID="RadioGroup10" Layout="ColumnLayout">
                                                    <Items>
                                                        <ext:Radio ID="Radio19" runat="server" InputValue="1" BoxLabelAlign="After" BoxLabel="是" ColumnWidth="0.3" />
                                                        <ext:Radio ID="Radio20" runat="server" InputValue="0" BoxLabelAlign="After" BoxLabel="否" ColumnWidth="0.3" />
                                                        <ext:Button runat="server" ID="Button14" Text="确定14">
                                                            <Listeners>
                                                                <%--<Click Handler=" return SemisisVerityTime_click()" />--%>
                                                                <Click Handler=" return btn_click(this)" />
                                                            </Listeners>
                                                        </ext:Button>
                                                    </Items>
                                                    <Listeners>
                                                        <Change Handler="return SemisisVerityTime_Change(item, oldValue, newValue);" />
                                                    </Listeners>
                                                </ext:RadioGroup>
                                            </Items>
                                        </ext:FieldSet>

                                         <ext:FieldSet runat="server" Title="胎胚领料超期验证">
                                            <Items>
                                                
                                                <ext:Hidden runat="server" ID="MoldingisVerityTime" />
                                                <ext:RadioGroup runat="server" ID="RadioGroup9" Layout="ColumnLayout">
                                                    <Items>
                                                        <ext:Radio ID="Radio17" runat="server" InputValue="1" BoxLabelAlign="After" BoxLabel="是" ColumnWidth="0.3" />
                                                        <ext:Radio ID="Radio18" runat="server" InputValue="0" BoxLabelAlign="After" BoxLabel="否" ColumnWidth="0.3" />
                                                        <ext:Button runat="server" ID="Button13" Text="确定13">
                                                            <Listeners>
                                                                <%--<Click Handler=" return MoldingisVerityTime_click()" />--%>
                                                                <Click Handler=" return btn_click(this)" />
                                                            </Listeners>
                                                        </ext:Button>
                                                    </Items>
                                                    <Listeners>
                                                        <Change Handler="return MoldingisVerityTime_Change(item, oldValue, newValue);" />
                                                    </Listeners>
                                                </ext:RadioGroup>
                                            </Items>
                                        </ext:FieldSet>

                                        <ext:FieldSet runat="server" Title="硫化领料时验证物料">
                                            <Items>
                                                <ext:Hidden runat="server" ID="CuringMaterialControl" />
                                                <ext:RadioGroup runat="server" ID="RadioGroup6" Layout="ColumnLayout">
                                                    <Items>
                                                        <ext:Radio ID="Radio11" runat="server" InputValue="1" BoxLabelAlign="After" BoxLabel="是" ColumnWidth="0.3" />
                                                        <ext:Radio ID="Radio12" runat="server" InputValue="0" BoxLabelAlign="After" BoxLabel="否" ColumnWidth="0.3" />
                                                        <ext:Button runat="server" ID="Button10" Text="确定10">
                                                            <Listeners>
                                                                <%--<Click Handler=" return CuringMaterialControl_click()" />--%>
                                                                <Click Handler=" return btn_click(this)" />
                                                            </Listeners>
                                                        </ext:Button>
                                                    </Items>
                                                    <Listeners>
                                                        <Change Handler="return CuringMaterialControl_Change(item, oldValue, newValue);" />
                                                    </Listeners>
                                                </ext:RadioGroup>
                                            </Items>
                                        </ext:FieldSet>

                                           <ext:FieldSet runat="server" Title="硫化生产扫描验证硫化机台库位">
                                            <Items>
                                                <ext:Hidden runat="server" ID="ScanCuringStorageControl" />
                                                <ext:RadioGroup runat="server" ID="RadioGroup7" Layout="ColumnLayout">
                                                    <Items>
                                                        <ext:Radio ID="Radio13" runat="server" InputValue="1" BoxLabelAlign="After" BoxLabel="是" ColumnWidth="0.3" />
                                                        <ext:Radio ID="Radio14" runat="server" InputValue="0" BoxLabelAlign="After" BoxLabel="否" ColumnWidth="0.3" />
                                                        <ext:Button runat="server" ID="Button11" Text="确定11">
                                                            <Listeners>
                                                                <%--<Click Handler=" return ScanCuringStorageControl_click()" />--%>
                                                                <Click Handler=" return btn_click(this)" />
                                                            </Listeners>
                                                        </ext:Button>
                                                    </Items>
                                                    <Listeners>
                                                        <Change Handler="return ScanCuringStorageControl_Change(item, oldValue, newValue);" />
                                                    </Listeners>
                                                </ext:RadioGroup>
                                            </Items>
                                        </ext:FieldSet>

                                        <ext:FieldSet runat="server" Title="半部件领胶料是否控制数量">
                                            <Items>
                                                <ext:Hidden runat="server" ID="SemisRubberControlQty" />
                                                <ext:RadioGroup runat="server" ID="RadioGroup2" Layout="ColumnLayout">
                                                    <Items>
                                                        <ext:Radio ID="Radio3" runat="server" InputValue="1" BoxLabelAlign="After" BoxLabel="是" ColumnWidth="0.3" />
                                                        <ext:Radio ID="Radio4" runat="server" InputValue="0" BoxLabelAlign="After" BoxLabel="否" ColumnWidth="0.3" />
                                                        <ext:Button runat="server" ID="Button2" Text="确定2">
                                                            <Listeners>
                                                                <%--<Click Handler="return SemisRubberControlQty_Click();" />--%>
                                                                <Click Handler=" return btn_click(this)" />
                                                            </Listeners>
                                                        </ext:Button>
                                                    </Items>
                                                    <Listeners>
                                                        <Change Handler="return SemisRubberControlQty_Change(item, oldValue, newValue);" />
                                                    </Listeners>
                                                </ext:RadioGroup>
                                            </Items>
                                        </ext:FieldSet>

                                        <ext:FieldSet runat="server" Title="半部件领胶料是否控制物料规格">
                                            <Items>
                                                <ext:Hidden runat="server" ID="SemisRubberControlMater" />
                                                <ext:RadioGroup runat="server" ID="RadioGroup3" Layout="ColumnLayout">
                                                    <Items>
                                                        <ext:Radio ID="Radio5" runat="server" InputValue="1" BoxLabelAlign="After" BoxLabel="是" ColumnWidth="0.3" />
                                                        <ext:Radio ID="Radio6" runat="server" InputValue="0" BoxLabelAlign="After" BoxLabel="否" ColumnWidth="0.3" />
                                                        <ext:Button runat="server" ID="Button3" Text="确定3">
                                                            <Listeners>
                                                                <%--<Click Handler=" return SemisRubberControlMater_Click();" />--%>
                                                                <Click Handler=" return btn_click(this)" />
                                                            </Listeners>
                                                        </ext:Button>
                                                    </Items>
                                                    <Listeners>
                                                        <Change Handler="return SemisRubberControlMater_Change(item, oldValue, newValue);" />
                                                    </Listeners>
                                                </ext:RadioGroup>
                                            </Items>
                                        </ext:FieldSet>

                                        <ext:FieldSet runat="server" Title="成型领半部件是否控制数量">
                                            <Items>
                                                <ext:Hidden runat="server" ID="MolidngSemisControlQty" />
                                                <ext:RadioGroup runat="server" ID="RadioGroup4" Layout="ColumnLayout">
                                                    <Items>
                                                        <ext:Radio ID="Radio7" runat="server" InputValue="1" BoxLabelAlign="After" BoxLabel="是" ColumnWidth="0.3" />
                                                        <ext:Radio ID="Radio8" runat="server" InputValue="0" BoxLabelAlign="After" BoxLabel="否" ColumnWidth="0.3" />
                                                        <ext:Button runat="server" ID="Button4" Text="确定4">
                                                            <Listeners>
                                                                <%--<Click Handler="return MolidngSemisControlQty_Click()" />--%>
                                                                <Click Handler=" return btn_click(this)" />
                                                            </Listeners>
                                                        </ext:Button>
                                                    </Items>
                                                    <Listeners>
                                                        <Change Handler="return MolidngSemisControlQty_Change(item, oldValue, newValue);" />
                                                    </Listeners>
                                                </ext:RadioGroup>
                                            </Items>
                                        </ext:FieldSet>

                                        <ext:FieldSet runat="server" Title="成型领半部件是否控制物料规格">
                                            <Items>
                                                <ext:Hidden runat="server" ID="MolidngSemisControlMater" />
                                                <ext:RadioGroup runat="server" ID="RadioGroup5" Layout="ColumnLayout">
                                                    <Items>
                                                        <ext:Radio ID="Radio9" runat="server" InputValue="1" BoxLabelAlign="After" BoxLabel="是" ColumnWidth="0.3" />
                                                        <ext:Radio ID="Radio10" runat="server" InputValue="0" BoxLabelAlign="After" BoxLabel="否" ColumnWidth="0.3" />
                                                        <ext:Button runat="server" ID="Button5" Text="确定5">
                                                            <Listeners>
                                                                <%--<Click Handler=" return MolidngSemisControlMater_Click();" />--%>
                                                                <Click Handler=" return btn_click(this)" />
                                                            </Listeners>
                                                        </ext:Button>
                                                    </Items>
                                                    <Listeners>
                                                        <Change Handler="return MolidngSemisControlMater_Change(item, oldValue, newValue);" />
                                                    </Listeners>
                                                </ext:RadioGroup>
                                            </Items>
                                        </ext:FieldSet>
                                        <ext:FieldSet runat="server" Title="硫化生产是否验证年周号">
                                            <Items>
                                                <ext:Hidden runat="server" ID="YanzhengWeek" />
                                                <ext:RadioGroup runat="server" ID="RadioGroup19" Layout="ColumnLayout">
                                                    <Items>
                                                        <ext:Radio ID="Radio37" runat="server" InputValue="1" BoxLabelAlign="After" BoxLabel="是" ColumnWidth="0.3" />
                                                        <ext:Radio ID="Radio38" runat="server" InputValue="0" BoxLabelAlign="After" BoxLabel="否" ColumnWidth="0.3" />
                                                        <ext:Button runat="server" ID="Button28" Text="确定28">
                                                            <Listeners>
                                                                <%--<Click Handler=" return YanzhengWeek_Click();" />--%>
                                                                <Click Handler=" return btn_click(this)" />
                                                            </Listeners>
                                                        </ext:Button>
                                                    </Items>
                                                    <Listeners>
                                                        <Change Handler="return YanzhengWeek_Change(item, oldValue, newValue);" />
                                                    </Listeners>
                                                </ext:RadioGroup>
                                            </Items>
                                        </ext:FieldSet>




                                        <ext:FieldSet runat="server" Title="硫化领胎胚推荐胎胚车数量" Layout="ColumnLayout">
                                            <Items>

                                                <ext:TextField runat="server" ID="MoldingStorageTopNum" FieldLabel="硫化领胎胚推荐胎胚车数量" LabelAlign="Right" Width="500" LabelWidth="190" InputWidth="120" ColumnWidth="0.6" Padding="2" />
                                                <ext:Button runat="server" ID="Button6" Text="确定6">
                                                    <Listeners>
                                                        <%--<Click Handler="MoldingStorageTopNum_click();" />--%>
                                                                <Click Handler=" return btn_click(this)" />
                                                    </Listeners>
                                                </ext:Button>

                                            </Items>
                                        </ext:FieldSet>

                                        <ext:FieldSet runat="server" Title="硫化领胎胚先入先出时间设置" Layout="ColumnLayout">
                                            <Items>
                                                <ext:TextField runat="server" ID="MoldingStorageFIFOTime" FieldLabel="硫化领胎胚先入先出时间设置" LabelAlign="Right" Width="300" LabelWidth="190" InputWidth="120" ColumnWidth="0.6" Padding="2" />
                                                <ext:Button runat="server" ID="Button7" Text="确定7">
                                                    <Listeners>
                                                        <%--<Click Handler=" return MoldingStorageFIFOTime_Click();" />--%>
                                                                <Click Handler=" return btn_click(this)" />
                                                    </Listeners>
                                                </ext:Button>
                                            </Items>
                                        </ext:FieldSet>

                                        <ext:FieldSet runat="server" Title="半部件领胶料先入先出时间设置" Layout="ColumnLayout">
                                            <Items>
                                                <ext:TextField runat="server" ID="SemisRubberFIFOTime" FieldLabel="半部件领胶料先入先出时间设置" LabelAlign="Right" Width="300" LabelWidth="190" InputWidth="120" ColumnWidth="0.6" Padding="2" />
                                                <ext:Button runat="server" ID="Button8" Text="确定8">
                                                    <Listeners>
                                                        <%--<Click Handler=" return SemisRubberFIFOTime_Click();" />--%>
                                                                <Click Handler=" return btn_click(this)" />
                                                    </Listeners>
                                                </ext:Button>
                                            </Items>
                                        </ext:FieldSet>

                                        <ext:FieldSet runat="server" Title="成型领半部件先入先出时间设置" Layout="ColumnLayout">
                                            <Items>

                                                <ext:TextField runat="server" ID="MoldingSemisFIFOTime" FieldLabel="成型领半部件先入先出时间设置" LabelAlign="Right" Width="300" LabelWidth="190" InputWidth="120" ColumnWidth="0.6" Padding="2" />
                                                <ext:Button runat="server" ID="Button9" Text="确定9">
                                                    <Listeners>
                                                        <%--<Click Handler=" return MoldingSemisFIFOTime_Click();" />--%>
                                                                <Click Handler=" return btn_click(this)" />
                                                    </Listeners>
                                                </ext:Button>
                                            </Items>
                                        </ext:FieldSet>

                                         <ext:FieldSet runat="server" Title="半部件领半部件先入先出时间设置" Layout="ColumnLayout">
                                            <Items>
                                                <ext:TextField runat="server" ID="SemisBZPFIFOTime" FieldLabel="半部件领半部件先入先出时间设置" LabelAlign="Right" Width="300" LabelWidth="190" InputWidth="120" ColumnWidth="0.6" Padding="2" />
                                                <ext:Button runat="server" ID="Button18" Text="确定18">
                                                    <Listeners>
                                                        <%--<Click Handler=" return SemisBZPFIFOTime_Click();" />--%>
                                                                <Click Handler=" return btn_click(this)" />
                                                    </Listeners>
                                                </ext:Button>
                                            </Items>
                                        </ext:FieldSet>

                                        <ext:FieldSet runat="server" Title="硫化第十步报警判级标准" Layout="ColumnLayout">
                                            <Items>
                                                <ext:TextField runat="server" ID="tenPressBJStart" FieldLabel="报警范围开始(大于)" LabelAlign="Right" Width="150" LabelWidth="190" InputWidth="120" ColumnWidth="0.6" Padding="2" />
                                                <ext:TextField runat="server" ID="tenPressBJEnd" FieldLabel="报警范围结束(小于等于)" LabelAlign="Right" Width="150" LabelWidth="190" InputWidth="120" ColumnWidth="0.6" Padding="2" />
                                                <ext:TextField runat="server" ID="tenPressPJStart" FieldLabel="判级范围(大于)" LabelAlign="Right" Width="150" LabelWidth="190" InputWidth="120" ColumnWidth="0.6" Padding="2" />
                                                <ext:Button runat="server" ID="Button19" Text="确定19">
                                                    <Listeners>
                                                        <%--<Click Handler=" return CuringTenPress_Click();" />--%>
                                                                <Click Handler=" return btn_click(this)" />
                                                    </Listeners>
                                                </ext:Button>
                                            </Items>
                                        </ext:FieldSet>

                                        <ext:FieldSet runat="server" Title="硫化生产扫描时验证胎胚超期">
                                            <Items>
                                                
                                                <ext:Hidden runat="server" ID="CuringGreenTimeControl" />
                                                <ext:RadioGroup runat="server" ID="RadioGroup14" Layout="ColumnLayout">
                                                    <Items>
                                                        <ext:Radio ID="Radio27" runat="server" InputValue="1" BoxLabelAlign="After" BoxLabel="是" ColumnWidth="0.3" />
                                                        <ext:Radio ID="Radio28" runat="server" InputValue="0" BoxLabelAlign="After" BoxLabel="否" ColumnWidth="0.3" />
                                                        <ext:Button runat="server" ID="Button20" Text="确定20">
                                                            <Listeners>
                                                                <%--<Click Handler=" return CuringGreenTimeControl_click()" />--%>
                                                                <Click Handler=" return btn_click(this)" />
                                                            </Listeners>
                                                        </ext:Button>
                                                    </Items>
                                                    <Listeners>
                                                        <Change Handler="return CuringGreenTimeControl_Change(item, oldValue, newValue);" />
                                                    </Listeners>
                                                </ext:RadioGroup>
                                            </Items>
                                        </ext:FieldSet>

                                        <ext:FieldSet runat="server" Title="成型机台线边库先入先出控制">
                                            <Items>
                                                
                                                <ext:Hidden runat="server" ID="MoldingEquipStorageXRXCControl" />
                                                <ext:RadioGroup runat="server" ID="RadioGroup15" Layout="ColumnLayout">
                                                    <Items>
                                                        <ext:Radio ID="Radio29" runat="server" InputValue="1" BoxLabelAlign="After" BoxLabel="是" ColumnWidth="0.3" />
                                                        <ext:Radio ID="Radio30" runat="server" InputValue="0" BoxLabelAlign="After" BoxLabel="否" ColumnWidth="0.3" />
                                                        <ext:TextField runat="server" ID="MoldingEquipStorageXRXCTime" FieldLabel="时间设置" LabelAlign="Right" Width="300" LabelWidth="190" InputWidth="120" ColumnWidth="0.6" Padding="2" />
                                                        <ext:Button runat="server" ID="Button21" Text="确定21">
                                                            <Listeners>
                                                                <%--<Click Handler=" return MoldingEquipStorageXRXCControl_click()" />--%>
                                                                <Click Handler=" return btn_click(this)" />
                                                            </Listeners>
                                                        </ext:Button>
                                                    </Items>
                                                    <Listeners>
                                                        <Change Handler="return MoldingEquipStorageXRXCControl_Change(item, oldValue, newValue);" />
                                                    </Listeners>
                                                </ext:RadioGroup>
                                            </Items>
                                        </ext:FieldSet>

                                        <ext:FieldSet runat="server" Title="半部件机台线边库先入先出控制">
                                            <Items>
                                                
                                                <ext:Hidden runat="server" ID="SemisEquipStorageXRXCControl" />
                                                <ext:RadioGroup runat="server" ID="RadioGroup16" Layout="ColumnLayout">
                                                    <Items>
                                                        <ext:Radio ID="Radio31" runat="server" InputValue="1" BoxLabelAlign="After" BoxLabel="是" ColumnWidth="0.3" />
                                                        <ext:Radio ID="Radio32" runat="server" InputValue="0" BoxLabelAlign="After" BoxLabel="否" ColumnWidth="0.3" />
                                                        <ext:TextField runat="server" ID="SemisEquipStorageXRXCTime" FieldLabel="时间设置" LabelAlign="Right" Width="300" LabelWidth="190" InputWidth="120" ColumnWidth="0.6" Padding="2" />
                                                        <ext:Button runat="server" ID="Button22" Text="确定22">
                                                            <Listeners>
                                                                <%--<Click Handler=" return SemisEquipStorageXRXCControl_click()" />--%>
                                                                <Click Handler=" return btn_click(this)" />
                                                            </Listeners>
                                                        </ext:Button>
                                                    </Items>
                                                    <Listeners>
                                                        <Change Handler="return SemisEquipStorageXRXCControl_Change(item, oldValue, newValue);" />
                                                    </Listeners>
                                                </ext:RadioGroup>
                                            </Items>
                                        </ext:FieldSet>
                                        
                                        <ext:FieldSet runat="server" Title="半部件（胶料）线边库先入先出控制">
                                            <Items>
                                                
                                                <ext:Hidden runat="server" ID="SemisRubberEquipStorageXRXCControl" />
                                                <ext:RadioGroup runat="server" ID="RadioGroup17" Layout="ColumnLayout">
                                                    <Items>
                                                        <ext:Radio ID="Radio33" runat="server" InputValue="1" BoxLabelAlign="After" BoxLabel="是" ColumnWidth="0.3" />
                                                        <ext:Radio ID="Radio34" runat="server" InputValue="0" BoxLabelAlign="After" BoxLabel="否" ColumnWidth="0.3" />
                                                        <ext:TextField runat="server" ID="SemisRubberEquipStorageXRXCTime" FieldLabel="时间设置" LabelAlign="Right" Width="300" LabelWidth="190" InputWidth="120" ColumnWidth="0.6" Padding="2" />
                                                        <ext:Button runat="server" ID="Button24" Text="确定24">
                                                            <Listeners>
                                                                <%--<Click Handler=" return SemisRubberEquipStorageXRXCControl_click()" />--%>
                                                                <Click Handler=" return btn_click(this)" />
                                                            </Listeners>
                                                        </ext:Button>
                                                    </Items>
                                                    <Listeners>
                                                        <Change Handler="return SemisRubberEquipStorageXRXCControl_Change(item, oldValue, newValue);" />
                                                    </Listeners>
                                                </ext:RadioGroup>
                                            </Items>
                                        </ext:FieldSet>

                                          <ext:FieldSet runat="server" Title="半部件（钢压大卷）线边库先入先出控制">
                                            <Items>
                                                
                                                <ext:Hidden runat="server" ID="SemisGYEquipStorageXRXCControl" />
                                                <ext:RadioGroup runat="server" ID="RadioGroup18" Layout="ColumnLayout">
                                                    <Items>
                                                        <ext:Radio ID="Radio35" runat="server" InputValue="1" BoxLabelAlign="After" BoxLabel="是" ColumnWidth="0.3" />
                                                        <ext:Radio ID="Radio36" runat="server" InputValue="0" BoxLabelAlign="After" BoxLabel="否" ColumnWidth="0.3" />
                                                        <ext:TextField runat="server" ID="SemisGYEquipStorageXRXCTime" FieldLabel="时间设置" LabelAlign="Right" Width="300" LabelWidth="190" InputWidth="120" ColumnWidth="0.6" Padding="2" />
                                                        <ext:Button runat="server" ID="Button25" Text="确定25">
                                                            <Listeners>
                                                                <%--<Click Handler=" return SemisGYEquipStorageXRXCControl_click()" />--%>
                                                                <Click Handler=" return btn_click(this)" />
                                                            </Listeners>
                                                        </ext:Button>
                                                    </Items>
                                                    <Listeners>
                                                        <Change Handler="return SemisGYEquipStorageXRXCControl_Change(item, oldValue, newValue);" />
                                                    </Listeners>
                                                </ext:RadioGroup>
                                            </Items>
                                        </ext:FieldSet>

                                        <ext:FieldSet runat="server" Title="硫化换模首件胎验证次数" Layout="ColumnLayout">
                                            <Items>
                                                <ext:TextField runat="server" ID="FirstTyreMaxTime" FieldLabel="硫化换模首件胎验证次数" LabelAlign="Right" Width="300" LabelWidth="190" InputWidth="120" ColumnWidth="0.6" Padding="2" />
                                                <ext:Button runat="server" ID="Button23" Text="确定23">
                                                    <Listeners>
                                                        <%--<Click Handler=" return FirstTyreMaxTime_Click();" />--%>
                                                        <Click Handler=" return btn_click(this)" />
                                                    </Listeners>
                                                </ext:Button>
                                            </Items>
                                        </ext:FieldSet>

                                        <ext:FieldSet runat="server" Title="异常停机PLC管控时间(min)" Layout="ColumnLayout">
                                            <Items>
                                                <ext:TextField runat="server" ID="CuringStopErrorTime" FieldLabel="异常停机PLC管控时间(min)" LabelAlign="Right" Width="300" LabelWidth="190" InputWidth="120" ColumnWidth="0.6" Padding="2" />
                                                <ext:Button runat="server" ID="Button26" Text="确定26">
                                                    <Listeners>
                                                        <%--<Click Handler=" return CuringStopErrorTime_Click();" />--%>
                                                        <Click Handler=" return btn_click(this)" />
                                                    </Listeners>
                                                </ext:Button>
                                            </Items>
                                        </ext:FieldSet>
                                        
                                        <ext:FieldSet runat="server" Title="异常停机记录首末件时间(min)" Layout="ColumnLayout">
                                            <Items>
                                                <ext:TextField runat="server" ID="CuringStopErrorInsertTime" FieldLabel="异常停机记录首末件时间(min)" LabelAlign="Right" Width="300" LabelWidth="190" InputWidth="120" ColumnWidth="0.6" Padding="2" />
                                                <ext:Button runat="server" ID="Button27" Text="确定27">
                                                    <Listeners>
                                                        <%--<Click Handler=" return CuringStopErrorInsertTime_Click();" />--%>
                                                        <Click Handler=" return btn_click(this)" />
                                                    </Listeners>
                                                </ext:Button>
                                            </Items>
                                        </ext:FieldSet>
                                        
                                        <ext:FieldSet runat="server" Title="硫化生产扫描先入先出控制">
                                            <Items>
                                                <ext:Hidden runat="server" ID="CuringScanXRXC" />
                                                <ext:RadioGroup runat="server" ID="RadioGroup20" Layout="ColumnLayout">
                                                    <Items>
                                                        <ext:Radio ID="Radio39" runat="server" InputValue="1" BoxLabelAlign="After" BoxLabel="是" ColumnWidth="0.3" />
                                                        <ext:Radio ID="Radio40" runat="server" InputValue="0" BoxLabelAlign="After" BoxLabel="否" ColumnWidth="0.3" />
                                                        <ext:Button runat="server" ID="Button29" Text="确定29">
                                                            <Listeners>
                                                                <Click Handler=" return btn_click(this)" />
                                                            </Listeners>
                                                        </ext:Button>
                                                    </Items>
                                                    <Listeners>
                                                        <Change Handler="return CuringScanXRXC_Change(item, oldValue, newValue);" />
                                                    </Listeners>
                                                </ext:RadioGroup>
                                            </Items>
                                        </ext:FieldSet>
                                        <ext:FieldSet runat="server" Title="胎胚领待硫区先入先出时间控制(h)" Layout="ColumnLayout">
                                            <Items>
                                                <ext:TextField runat="server" ID="CuringGetTyreXRXC" FieldLabel="胎胚领待硫区先入先出时间控制(h)" LabelAlign="Right" Width="300" LabelWidth="190" InputWidth="120" ColumnWidth="0.6" Padding="2" />
                                                <ext:Button runat="server" ID="Button30" Text="确定30">
                                                    <Listeners>
                                                        <Click Handler=" return btn_click(this)" />
                                                    </Listeners>
                                                </ext:Button>
                                            </Items>
                                        </ext:FieldSet>
                                        
                                        <ext:FieldSet runat="server" Title="成型余料验证(米-百分比)" Layout="ColumnLayout">
                                            <Items>
                                                <ext:TextField runat="server" ID="MoldSYMi" FieldLabel="成型余料验证(米-百分比)" LabelAlign="Right" Width="300" LabelWidth="190" InputWidth="120" ColumnWidth="0.6" Padding="2" />
                                                <ext:Button runat="server" ID="Button31" Text="确定31">
                                                    <Listeners>
                                                                <Click Handler=" return btn_click(this)" />
                                                    </Listeners>
                                                </ext:Button>
                                            </Items>
                                        </ext:FieldSet>
                                        <ext:FieldSet runat="server" Title="成型余料验证(个/条-数量)" Layout="ColumnLayout">
                                            <Items>
                                                <ext:TextField runat="server" ID="MoldSYGe" FieldLabel="成型余料验证(个/条-数量)" LabelAlign="Right" Width="300" LabelWidth="190" InputWidth="120" ColumnWidth="0.6" Padding="2" />
                                                <ext:Button runat="server" ID="Button32" Text="确定32">
                                                    <Listeners>
                                                                <Click Handler=" return btn_click(this)" />
                                                    </Listeners>
                                                </ext:Button>
                                            </Items>
                                        </ext:FieldSet>
                                        <ext:FieldSet runat="server" Title="半制品领超期预警时间-天" Layout="ColumnLayout">
                                            <Items>
                                                <ext:TextField runat="server" ID="GetSemisYJ" FieldLabel="半制品领超期预警时间-天" LabelAlign="Right" Width="300" LabelWidth="190" InputWidth="120" ColumnWidth="0.6" Padding="2" />
                                                <ext:Button runat="server" ID="Button37" Text="确定37">
                                                    <Listeners>
                                                                <Click Handler=" return btn_click(this)" />
                                                    </Listeners>
                                                </ext:Button>
                                            </Items>
                                        </ext:FieldSet>
                                        <ext:FieldSet runat="server" Title="成型领超期预警时间-天" Layout="ColumnLayout">
                                            <Items>
                                                <ext:TextField runat="server" ID="GetMoldYJ" FieldLabel="成型领超期预警时间-天" LabelAlign="Right" Width="300" LabelWidth="190" InputWidth="120" ColumnWidth="0.6" Padding="2" />
                                                <ext:Button runat="server" ID="Button38" Text="确定38">
                                                    <Listeners>
                                                                <Click Handler=" return btn_click(this)" />
                                                    </Listeners>
                                                </ext:Button>
                                            </Items>
                                        </ext:FieldSet>
                                        <ext:FieldSet runat="server" Title="硫化领超期预警时间-天" Layout="ColumnLayout">
                                            <Items>
                                                <ext:TextField runat="server" ID="GetCppYJ" FieldLabel="硫化领超期预警时间-天" LabelAlign="Right" Width="300" LabelWidth="190" InputWidth="120" ColumnWidth="0.6" Padding="2" />
                                                <ext:Button runat="server" ID="Button39" Text="确定39">
                                                    <Listeners>
                                                                <Click Handler=" return btn_click(this)" />
                                                    </Listeners>
                                                </ext:Button>
                                            </Items>
                                        </ext:FieldSet>
                                        <ext:FieldSet runat="server" Title="半制品领超期强制时间-天" Layout="ColumnLayout">
                                            <Items>
                                                <ext:TextField runat="server" ID="GetSemisQZ" FieldLabel="半制品领超期强制时间-天" LabelAlign="Right" Width="300" LabelWidth="190" InputWidth="120" ColumnWidth="0.6" Padding="2" />
                                                <ext:Button runat="server" ID="Button40" Text="确定40">
                                                    <Listeners>
                                                                <Click Handler=" return btn_click(this)" />
                                                    </Listeners>
                                                </ext:Button>
                                            </Items>
                                        </ext:FieldSet>
                                        <ext:FieldSet runat="server" Title="成型领超期强制时间-天" Layout="ColumnLayout">
                                            <Items>
                                                <ext:TextField runat="server" ID="GetMoldQZ" FieldLabel="成型领超期强制时间-天" LabelAlign="Right" Width="300" LabelWidth="190" InputWidth="120" ColumnWidth="0.6" Padding="2" />
                                                <ext:Button runat="server" ID="Button41" Text="确定41">
                                                    <Listeners>
                                                                <Click Handler=" return btn_click(this)" />
                                                    </Listeners>
                                                </ext:Button>
                                            </Items>
                                        </ext:FieldSet>
                                        <ext:FieldSet runat="server" Title="硫化领超期强制时间-天" Layout="ColumnLayout">
                                            <Items>
                                                <ext:TextField runat="server" ID="GetCppQZ" FieldLabel="硫化领超期强制时间-天" LabelAlign="Right" Width="300" LabelWidth="190" InputWidth="120" ColumnWidth="0.6" Padding="2" />
                                                <ext:Button runat="server" ID="Button42" Text="确定42">
                                                    <Listeners>
                                                                <Click Handler=" return btn_click(this)" />
                                                    </Listeners>
                                                </ext:Button>
                                            </Items>
                                        </ext:FieldSet>

                                    </Items>
                                </ext:Panel>

                            </Items>
                        </ext:Panel>
                    </Items>
                </ext:Panel>

                <ext:Window ID="winModify" runat="server" Icon="MonitorEdit" Closable="false" Layout="Form" Modal="true" Title="解控信息"
                    Height="200" Width="600" Hidden="true" BodyStyle="background-color:#fff;"
                    BodyPadding="5" >
                    <Items>
                        <ext:FormPanel ID="pnlAdd" runat="server" BodyPadding="5" Layout="FormLayout">
                            <FieldDefaults>
                                <CustomConfig>
                                    <ext:ConfigItem Name="LabelWidth" Value="200" Mode="Raw" />
                                    <ext:ConfigItem Name="PreserveIndicatorIcon" Value="true" Mode="Raw" />
                                </CustomConfig>
                            </FieldDefaults>
                            <Items> 
                                <ext:ComboBox ID="cbxDecontrolReason" runat="server" FieldLabel="解控原因" Width="500" LabelAlign="Left" Editable="true" EnableKeyEvents="true">
                                </ext:ComboBox>
                                <ext:TextField ID="txtbeizhu" runat="server" FieldLabel="说明" Editable="true" AllowBlank="false" Width="500">
                                </ext:TextField>
                            </Items>
                        </ext:FormPanel>
                    </Items>
                    <Buttons>
                        <ext:Button ID="btnAddSave" runat="server" Text="确定" Icon="Accept">
                            <DirectEvents>
                                <Click OnEvent="btnAddSave_Click">
                                    <EventMask ShowMask="true" Msg="保存中..." MinDelay="50" />
                                </Click>
                            </DirectEvents>
                        </ext:Button>
                        <ext:Button ID="btnAddCancel" runat="server" Text="取消" Icon="Cancel">
                            <DirectEvents>
                                <Click OnEvent="btnCancel_Click">
                                </Click>
                            </DirectEvents>
                        </ext:Button>
                    </Buttons>
                </ext:Window>
                <ext:Hidden ID="hidden_objid" runat="server"></ext:Hidden>
            </Items>
        </ext:Viewport>
    </form>
</body>
</html>
