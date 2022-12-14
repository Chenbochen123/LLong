//点击修改按钮
var commandcolumn_direct_edit = function (record) {
    var ObjID = record.data.OBJID;
    App.direct.commandcolumn_direct_edit(ObjID, {
        success: function (result) {
        },
        failure: function (errorMsg) {
            Ext.Msg.alert('操作', errorMsg);
        }
    });
}

//点击删除按钮
var commandcolumn_direct_delete = function (btn, record) {
    if (btn != "yes") {
        return;
    }
    var ObjID = record.data.OBJID;
    debugger;
    App.direct.commandcolumn_direct_delete(ObjID, {
        success: function (result) {
            Ext.Msg.alert('操作', result);
        },

        failure: function (errorMsg) {
            Ext.Msg.alert('操作', errorMsg);
        }
    });
}

var SetRowClass = function (record, rowIndex, rowParams, store) {
    debugger;
    if (record.get("CONFIRM_DATE") != null && record.get("DELETE_FLAG") == "0") {//确认没关闭
        
        return "x-grid-row-collapsedGreen";
    }
    else if (record.get("CONFIRM_DATE") != null && record.get("DELETE_FLAG") == "1") {//确认关闭
        
        return "x-grid-row-collapsedGreen";
    }
    else {//没关闭并且超期
        debugger;
        var myDate = new Date();
        var now = myDate.getTime();
        var repairDate = Date.parse(record.get("REPAIR_DATE"));
        if ((repairDate - now) < 172800000) {
            return "x-grid-row-deleted";
        }
    }
}

//区分删除操作，并进行二次确认操作
var commandcolumn_click_confirm = function (command, record) {
    if (command.toLowerCase() == "edit") {
        commandcolumn_direct_edit(record);
    }
    if (command.toLowerCase() == "delete") {
        Ext.Msg.confirm("提示", '您确定需要关闭此条信息？', function (btn) { commandcolumn_direct_delete(btn, record) });
    }
    return false;
};

//根据按钮类别进行删除和编辑操作
var commandcolumn_click = function (command, record) {
    commandcolumn_click_confirm(command, record);
    return false;
};

Ext.apply(Ext.form.VTypes, {
    integer: function (val, field) {
        if (!val) {
            return true;
        }
        try {
            if (/^[\d]+$/.test(val)) {
                return true;
            }
            else {
                return false;
            }
        }
        catch (e) {
            return false;
        }
    },
    integerText: "此填入项格式为正整数"
});


//列表刷新数据重载方法
var pnlListFresh = function () {
    App.store.currentPage = 1;
    App.pageToolBar.doRefresh();
    return false;
}

var cellDblClick = function (grid, td, tdindex, record, tr, trindex, e, fn) {
    var ObjID = record.data.OBJID;
    App.direct.commandcolumn_direct_detail(ObjID, {
        success: function (result) {
        },
        failure: function (errorMsg) {
            Ext.Msg.alert('操作', errorMsg);
        }
    });
}

//-------人员绑定-----查询带回弹出框--BEGIN
var Plugins_Equip_BasicInfo_QueryBasUser_Request = function (record) {//人员绑定
    var userType = App.hidden_user_type.value;
    if (!App.winModify.hidden) {
        switch (userType) {
            case "1":
                App.modify_response_user.setValue(record.data.USER_NAME);
                App.hidden_modify_response_user.setValue(record.data.OBJID);
                break;
            case "2":
                App.modify_finish_user.setValue(record.data.USER_NAME);
                App.hidden_modify_finish_user.setValue(record.data.OBJID);
                break;
            case "3":
                App.modify_confirm_user.setValue(record.data.USER_NAME);
                App.hidden_modify_confirm_user.setValue(record.data.OBJID);
                break;
            default:
        }
    }
    if (!App.winAdd.hidden) {
        switch (userType) {
            case "1":
                App.add_response_user.setValue(record.data.USER_NAME);
                App.hidden_add_response_user.setValue(record.data.OBJID);
                break;
            case "2":
                App.add_finish_user.setValue(record.data.USER_NAME);
                App.hidden_add_finish_user.setValue(record.data.OBJID);
                break;
            case "3":
                App.add_confirm_user.setValue(record.data.USER_NAME);
                App.hidden_add_confirm_user.setValue(record.data.OBJID);
                break;
            default:
        }
    }
    if (!App.winFinish.hidden) {
        switch (userType) {
            case "1":
                App.modify_response_user.setValue(record.data.USER_NAME);
                App.hidden_modify_response_user.setValue(record.data.OBJID);
                break;
            case "2":
                App.modify_finish_user.setValue(record.data.USER_NAME);
                App.hidden_modify_finish_user.setValue(record.data.OBJID);
                break;
            case "3":
                App.modify_confirm_user.setValue(record.data.USER_NAME);
                App.hidden_modify_confirm_user.setValue(record.data.OBJID);
                break;
            default:
        }
    }
    if (App.winModify.hidden && App.winAdd.hidden && App.winFinish.hidden) {
        switch (userType) {
            case "1":
                App.txt_response_user.setValue(record.data.USER_NAME);
                App.hidden_txt_response_user.setValue(record.data.OBJID);
                break;
            case "2":
                App.txt_finish_user.setValue(record.data.USER_NAME);
                App.hidden_txt_finish_user.setValue(record.data.OBJID);
                break;
            case "3":
                App.txt_confirm_user.setValue(record.data.USER_NAME);
                App.hidden_txt_confirm_user.setValue(record.data.OBJID);
                break;
            default:

        }
    }
}

var SelectUserCode = function (field, trigger, index, userType, hiddenId) {//人员绑定查询
    switch (index) {
        case 0:
            field.setValue('');
            document.getElementById(hiddenId).value = '';
            break;
        case 1:
            App.hidden_user_type.setValue(userType);
            App.Plugins_Equip_BasicInfo_QueryBasUser_Window.show();
            break;
    }
}

Ext.create("Ext.window.Window", {//人员绑定查询带回窗体
    id: "Plugins_Equip_BasicInfo_QueryBasUser_Window",
    height: 460,
    hidden: true,
    width: 360,
    html: "<iframe src='../BasicInfo/QueryBasUser.aspx' width=100% height=100% scrolling=no  frameborder=0></iframe>",
    bodyStyle: "background-color: #fff;",
    closable: true,
    title: "请选择人员",
    modal: true
})
//------------查询带回弹出框--END 

//-------机台代码-----查询带回弹出框--BEGIN
var Plugins_Equip_BasicInfo_QueryEquipment_Request = function (record) {//机台代码返回值处理
    debugger;
    if (!App.winAdd.hidden) {
        
        App.add_equip_name.setValue(record.data.EQUIP_NAME);
        App.hidden_equip_code.setValue(record.data.OBJID);
        App.direct.get_repair_user_by_equip(record.data.OBJID, "ADD", {
            success: function (result) {
            },
            failure: function (errorMsg) {
                Ext.Msg.alert('操作', errorMsg);
            }
        });
    }
    else if (!App.winModify.hidden) {
        App.modify_equip_name.setValue(record.data.EQUIP_NAME);
        App.hidden_equip_code.setValue(record.data.OBJID);
        App.direct.get_repair_user_by_equip(record.data.OBJID, "MODIFY", {
            success: function (result) {
            },
            failure: function (errorMsg) {
                Ext.Msg.alert('操作', errorMsg);
            }
        });
    }
    else {
        App.txt_equip_code.setValue(record.data.EQUIP_NAME);
        App.txt_equip_code.getTrigger(0).show();
        App.hidden_select_equip_code.setValue(record.data.OBJID);
    }
}

var SelectEquipInfo = function (field, trigger, index) {
    debugger;
    switch (index) {
        case 0:
            field.getTrigger(0).hide();
            field.setValue('');
            if (App.winAdd.hidden && App.winModify.hidden) {
                App.hidden_select_equip_code.setValue("");
            }
            else {
                App.hidden_equip_code.setValue("");
            }
            field.getEl().down('input.x-form-text').setStyle('background', "white");
            break;
        case 1:
            App.Plugins_Equip_BasicInfo_QueryEquipment_Window.show();
            break;
    }
}

Ext.create("Ext.window.Window", {//机台代码查询带回窗体
    id: "Plugins_Equip_BasicInfo_QueryEquipment_Window",
    height: 460,
    hidden: true,
    width: 360,
    html: "<iframe src='../BasicInfo/QueryEquipment.aspx' width=100% height=100% scrolling=no  frameborder=0></iframe>",
    bodyStyle: "background-color: #fff;",
    closable: true,
    title: "请选择机台名称",
    modal: true
})
//------------查询带回弹出框--END 


//历史查询的每行按钮准备加载
var prepareToolbar = function (grid, toolbar, rowIndex, record) {
    if (record.get("DeleteFlag") == "是") {
        toolbar.items.getAt(0).hide();
        toolbar.items.getAt(1).hide();
        toolbar.items.getAt(2).hide();
    }
};

//点击导入计划触发事件
var btnImportClick = function (sender, e, fn) {
    var url = "Equipment/EquipRepairProtectPlan/ImportRepairProtectPlan.aspx";
    var tabid = "Manager_Equipment_EquipRepairProtectPlan_ImportRepairProtectPlan";
    var tabp = parent.App.mainTabPanel;
    var tab = tabp.getComponent("id=" + tabid);
    if (tab) {
        tab.close();
    }
    parent.addTab(tabid, "设备维护保养计划导入", url, true);
}