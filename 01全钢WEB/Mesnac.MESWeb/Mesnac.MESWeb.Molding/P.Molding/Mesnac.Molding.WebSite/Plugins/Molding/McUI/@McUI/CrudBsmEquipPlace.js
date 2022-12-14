
var viewportAfterRender = function () {
   // App.winUpdate.afterShow = afterShow_winUpdate;
    
};


var afterShow_winUpdate = function () {
    var objId = App._ui_u_OBJID_state.getValue();
    var data = App.gridPanelMainStore.data;
    var items = data.items;
    var i = 0;
    var len = items.length;
    var item;
    for (; i < len; i++) {
        item = items[i];
        if (item.data.OBJID.toString() == objId) {
            App.ui_u_MATERIAL_ID_TriggerField.setValue(item.data.MATERIAL_NAME);
            break;
        }
    }
};


//-------接班信息-----查询带回弹出框--BEGIN
var McUI_SearchBox_SearchBoxSbmMaterialMolding_Request = function (record) {

    if (!App.winAdd.hidden) {
        App.ui_i_MATERIAL_ID_TriggerField.setValue(record.data.MATERIAL_NAME);
        App.ui_i_MATERIAL_ID.setValue(record.data.OBJID);
        
    }
    else if (!App.winUpdate.hidden) {
        App.ui_u_MATERIAL_ID_TriggerField.setValue(record.data.MATERIAL_NAME);
        App.ui_u_MATERIAL_ID.setValue(record.data.OBJID);
    }
    else {
        App.ui_s_MATERIAL_ID_TriggerField.setValue(record.data.MATERIAL_NAME);
        App.ui_s_MATERIAL_ID.setValue(record.data.OBJID);
    }
}

var get_MATERIAL_ID_TriggerField = function (field, trigger, index) {//

   
    if (index == 0) {
        if (!App.winAdd.hidden) {
            App.ui_i_MATERIAL_ID.setValue(null);
            App.ui_i_MATERIAL_ID_TriggerField.setValue(null);
        }
        else if (!App.winUpdate.hidden) {
            App.ui_u_MATERIAL_ID.setValue(null);
            App.ui_u_MATERIAL_ID_TriggerField.setValue(null);
        }
        else {
            App.ui_s_MATERIAL_ID.setValue(null);
            App.ui_s_MATERIAL_ID_TriggerField.setValue(null);
        }
       
    }
    else if (index == 1) {
        App.McUI_SearchBox_SearchBoxSbmMaterialMolding_Window.show();
    }
    //App.McUI_SearchBox_SearchBoxSbmMaterialMolding_Window.show();
}


Ext.create("Ext.window.Window", {//物料查询带回窗体
    id: "McUI_SearchBox_SearchBoxSbmMaterialMolding_Window",
    height: 460,
    hidden: true,
    width: 560,
    html: "<iframe src='../../McUI/SearchBox/SearchBoxSbmMaterialMolding.aspx' width=100% height=100% scrolling=no  frameborder=0></iframe>",
    bodyStyle: "background-color: #fff;",
    closable: true,
    title: "请选择物料",
    modal: true
})

//------------查询带回弹出框--END 


//SearchBoxSbmMaterialMolding

