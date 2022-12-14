var viewportAfterRender = function () {
    App.winAdd.afterShow = afterShow_winAdd;
    App.winUpdate.afterShow = afterShow_winUpdate;
};

var afterShow_winAdd = function () {
    var ui_i_STORE_ID = App.ui_i_STORE_ID;
    if (ui_i_STORE_ID.store.data.length == 1) {
        var storeId = ui_i_STORE_ID.store.data.getAt(0).data.field1;
        ui_i_STORE_ID.select(storeId);
    }
    var ui_i_STORE_PLACE_TYPE = App.ui_i_STORE_PLACE_TYPE;
    if (ui_i_STORE_PLACE_TYPE.store.data.length == 1) {
        var storePlaceType = ui_i_STORE_PLACE_TYPE.store.data.getAt(0).data.field1;
        ui_i_STORE_PLACE_TYPE.select(storePlaceType);
    }
};

var afterShow_winUpdate = function () {
    var objId = App._ui_u_OBJID_state.getValue();
    var data = App.gridPanelMainStore.data;
    var items = data.items;
    var i = 0;
    var len = items.length;
    var item;
    for (; i < len; i++)
    {
        item = items[i];
        if (item.data.OBJID.toString() == objId)
        {
            App.ui_u_MATERIAL_ID_TriggerField.setValue(item.data.MATERIAL_NAME);
            break;
        }
    }
};

var get_MATERIAL_ID_TriggerField = function (field, trigger, index) {//物料查询

    if (index == 0)
    {
        App.ui_u_MATERIAL_ID.setValue("0");
        App.ui_u_MATERIAL_ID_TriggerField.setValue(null);
    }
    else if (index == 1)
    {
        App.McUI_SearchBox_SearchBoxSbmMaterialMolding_Window.show();
    }
};

//-------物料-----查询带回弹出框--BEGIN
var McUI_SearchBox_SearchBoxSbmMaterialMolding_Request = function (record) {//物料返回值处理
    App.hidden_month_material_id.setValue(record.data.OBJID);
    App.txt_month_material.setValue(record.data.MATERIAL_NAME);
};

Ext.create("Ext.window.Window", {//物料查询带回窗体
    id: "McUI_SearchBox_SearchBoxSbmMaterialMolding_Window",
    height: 430,
    hidden: true,
    width: 360,
    html: "<iframe src='../../McUI/SearchBox/SearchBoxSbmMaterialMolding.aspx' width=100% height=100% scrolling=no  frameborder=0></iframe>",
    bodyStyle: "background-color: #fff;",
    closable: true,
    title: "请选择物料",
    modal: true
});

var McUI_SearchBox_SearchBoxSbmMaterialMolding_Request = function (record) {
    if (!App.winAdd.hidden) {
    }
    else if (!App.winUpdate.hidden) {
        App.ui_u_MATERIAL_ID_TriggerField.setValue(record.data.MATERIAL_NAME);
        App.ui_u_MATERIAL_ID.setValue(record.data.OBJID);
    }
};

//------------查询带回弹出框--END 
