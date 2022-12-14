var filterMinorType = function (majorTypeId, cboMinorType) {
    cboMinorType.setValue(null);

    var storeMinorType = cboMinorType.getStore();
    if (majorTypeId == null || majorTypeId == '') {
        storeMinorType.clearFilter();
    }
    else {
        storeMinorType.filterBy(function (record, id) {
            return record.get("field1").substr(0, majorTypeId.length) == majorTypeId;
        });
    }
};


var viewportAfterRender = function () {
    App.ui_s_MajorTypeId.addListener('change', function (target, newValue, oldValue) {
        filterMinorType(newValue, App.ui_s_MajorTypeId);
    });
    App.ui_i_MAJOR_TYPE_ID.addListener('change', function (target, newValue, oldValue) {
        filterMinorType(newValue, App.ui_s_MajorTypeId);
    });
    App.ui_u_MAJOR_TYPE_ID.addListener('change', function (target, newValue, oldValue) {
        filterMinorType(newValue, App.ui_u_MINOR_TYPE_ID);
    });
};

//-------库房信息-----查询带回弹出框--BEGIN
var McUI_SearchBox_SearchBoxSebStore_Request = function (record) {
    if (!App.winAdd.hidden) {
        App.ui_i_STORE_ID_TriggerField.setValue(record.data.STORE_NAME);
        App.ui_i_STORE_ID.setValue(record.data.OBJID);
    }
    else if (!App.winUpdate.hidden) {
        App.ui_u_STORE_ID_TriggerField.setValue(record.data.STORE_NAME);
        App.ui_u_STORE_ID.setValue(record.data.OBJID);
    }
    else {
        App.ui_s_StoreId_TriggerField.setValue(record.data.STORE_NAME);
        App.ui_s_StoreId.setValue(record.data.OBJID);
    }
};

var get_STORE_ID_TriggerField = function (field, trigger, index) {//库房查询
    var window = App.McUI_SearchBox_SearchBoxSebStore_Window;
    window.show();
};

var get_StoreId_TriggerField = function (field, trigger, index) {//库房查询
    if (index == 0) {
        App.ui_s_StoreId_TriggerField.setValue(null);
        App.ui_s_StoreId.setValue(null);
    }
    else {
        var window = App.McUI_SearchBox_SearchBoxSebStore_Window;
        var html = "<iframe src='../../McUI/SearchBox/SearchBoxSebStore.aspx?action=s' width=100% height=100% scrolling=no  frameborder=0></iframe>";
        if (window.getBody()) {
            window.getBody().update(html);
        } else {
            window.html = html;
        }
        window.show();
    }
};

Ext.create("Ext.window.Window", {//库房查询带回窗体
    id: "McUI_SearchBox_SearchBoxSebStore_Window",
    height: 460,
    hidden: true,
    width: 560,
    html: "<iframe src='../../McUI/SearchBox/SearchBoxSebStore.aspx' width=100% height=100% scrolling=no  frameborder=0></iframe>",
    bodyStyle: "background-color: #fff;",
    closable: true,
    title: "请选择库房",
    modal: true
});
//------------查询带回弹出框--END 

/*

//-------设备信息-----查询带回弹出框--BEGIN
var McUI_SearchBox_SearchBoxSbeEquip_Request = function (record) {
    if (!App.winAdd.hidden) {
        App.ui_i_EQUIP_ID_TriggerField.setValue(record.data.EQUIP_NAME);
        App.ui_i_EQUIP_ID.setValue(record.data.OBJID);
    }
    else if (!App.winUpdate.hidden) {
        App.ui_u_EQUIP_ID_TriggerField.setValue(record.data.EQUIP_NAME);
        App.ui_u_EQUIP_ID.setValue(record.data.OBJID);
    }
    else {
        App.ui_s_EquipId_TriggerField.setValue(record.data.EQUIP_NAME);
        App.ui_s_EquipId.setValue(record.data.OBJID);
    }
}

var get_EquipId_TriggerField = function (field, trigger, index) {//设备查询
    App.McUI_SearchBox_SearchBoxSbeEquip_Window.html = "<iframe src='../../McUI/SearchBox/SearchBoxSbeEquip.aspx?action=s' width=100% height=100% scrolling=no  frameborder=0></iframe>";
    App.McUI_SearchBox_SearchBoxSbeEquip_Window.show();
}

var get_EQUIP_ID_TriggerField = function (field, trigger, index) {//设备查询
    App.McUI_SearchBox_SearchBoxSbeEquip_Window.html = "<iframe src='../../McUI/SearchBox/SearchBoxSbeEquip.aspx?action=i' width=100% height=100% scrolling=no  frameborder=0></iframe>";
    App.McUI_SearchBox_SearchBoxSbeEquip_Window.show();
}

Ext.create("Ext.window.Window", {//设备查询带回窗体
    id: "McUI_SearchBox_SearchBoxSbeEquip_Window",
    height: 460,
    hidden: true,
    width: 660,
    html: "<iframe src='../../McUI/SearchBox/SearchBoxSbeEquip.aspx' width=100% height=100% scrolling=no  frameborder=0></iframe>",
    bodyStyle: "background-color: #fff;",
    closable: true,
    title: "请选择设备",
    modal: true
})
//------------查询带回弹出框--END 

*/
