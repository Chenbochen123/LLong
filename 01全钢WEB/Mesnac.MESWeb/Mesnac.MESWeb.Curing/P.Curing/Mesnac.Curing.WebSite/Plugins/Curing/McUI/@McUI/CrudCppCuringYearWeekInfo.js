var viewportAfterRender = function () {
    App.ui_s_EndTime_Date.setValue(Ext.Date.add(new Date(), Ext.Date.DAY, 1));

};

//-------硫化机台信息-----查询带回弹出框--BEGIN
var McUI_SearchBox_SearchBoxCbeCuringEquip_Request = function (record) {
    App.ui_s_EQUIP_ID_TriggerField.setValue(record.data.EQUIP_NAME);
    App.ui_s_EQUIP_ID.setValue(record.data.OBJID);
}

var get_EQUIP_ID_TriggerField = function (field, trigger, index) {//硫化机台查询
    if (index == 1) {
        App.McUI_SearchBox_SearchBoxCbeCuringEquip_Window.show();
    }
    else if (index == 0) {
        this.clear();
        App.ui_s_EQUIP_ID.clear();
    }
}

Ext.create("Ext.window.Window", {//硫化机台查询带回窗体
    id: "McUI_SearchBox_SearchBoxCbeCuringEquip_Window",
    height: 460,
    hidden: true,
    width: 360,
    html: "<iframe src='../../McUI/SearchBox/SearchBoxCbeCuringEquip.aspx' width=100% height=100% scrolling=no  frameborder=0></iframe>",
    bodyStyle: "background-color: #fff;",
    closable: true,
    title: "请选择硫化机台",
    modal: true
})
//------------查询带回弹出框--END 
