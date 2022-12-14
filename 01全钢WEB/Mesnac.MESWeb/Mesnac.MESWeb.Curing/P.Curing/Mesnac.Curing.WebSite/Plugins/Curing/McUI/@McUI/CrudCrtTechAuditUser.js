//-------人员信息-----查询带回弹出框--BEGIN
var McUI_SearchBox_SearchBoxSsbUser_Request = function (record) {
    if (!App.winAdd.hidden) {
        App.ui_i_AUDIT_USER_ID_TriggerField.setValue(record.data.USER_NAME);
        App.ui_i_AUDIT_USER_ID.setValue(record.data.OBJID);
    }
    else if (!App.winUpdate.hidden) {
        App.ui_u_AUDIT_USER_ID_TriggerField.setValue(record.data.USER_NAME);
        App.ui_u_AUDIT_USER_ID.setValue(record.data.OBJID);
    }
}

var get_AUDIT_USER_ID_TriggerField = function (field, trigger, index) {//人员查询
    App.McUI_SearchBox_SearchBoxSsbUser_Window.show();
}

Ext.create("Ext.window.Window", {//人员查询带回窗体
    id: "McUI_SearchBox_SearchBoxSsbUser_Window",
    height: 460,
    hidden: true,
    width: 360,
    html: "<iframe src='../../McUI/SearchBox/SearchBoxSsbUser.aspx' width=100% height=100% scrolling=no  frameborder=0></iframe>",
    bodyStyle: "background-color: #fff;",
    closable: true,
    title: "请选择硫化操作工",
    modal: true
})
//------------查询带回弹出框--END 

var winUpdateAfterRender = function () {
};
var viewportAfterRender = function () {
    App.ui_s_AUDIT_USER_ID.hide();
};
var winUpdateShow = function () {
    var auditUserId = App.ui_u_AUDIT_USER_ID.getValue();
    if (auditUserId == null || auditUserId == "") {
        return false;
    }
    var items = App.ui_s_AUDIT_USER_ID.getStore().data.items;
    for (var i = 0; i < items.length; i++) {
        if (items[i].data.field1 == auditUserId) {
            App.ui_u_AUDIT_USER_ID_TriggerField.setValue(items[i].data.field2);
            return true;
        }
    }
    return true;
};

