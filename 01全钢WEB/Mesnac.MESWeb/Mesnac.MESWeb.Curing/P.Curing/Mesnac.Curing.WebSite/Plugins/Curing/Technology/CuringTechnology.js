// 列表刷新数据重载方法
var gridPanelMainRefresh = function () {
    App.gridPanelMainStore.currentPage = 1;
    App.gridPanelMainPagingToolbar.doRefresh();
    return false;
}
var search = function () {
    gridPanelMainRefresh();
    return false;
}

var getSelectedRecord = function () {
    var selectRows = App.gridPanelMainCheckboxSelectionModel.getSelection();
    if (selectRows.length == 0) {
        return null;
    }
    return selectRows[0];
};

// 点击查看按钮
var btnView_Click = function () {
    var record = getSelectedRecord();
    if (record == null) {
        X.Msg.alert("提示", "请选择要查看的数据");
        return false;
    }
    command_direct_view(record);
    return true;
};


// 点击修改按钮
var btnEdit_Click = function () {
    var record = getSelectedRecord();
    if (record == null) {
        X.Msg.alert("提示", "请选择要修改的数据");
        return false;
    }
    command_direct_edit(record);
    return true;
};

// 点击删除按钮
var btnDelete_Click = function () {
    var record = getSelectedRecord();
    if (record == null) {
        X.Msg.alert("提示", "请选择要删除的数据");
        return false;
    }

    X.Msg.confirm('提示', '您确定需要删除此条信息？', function (btn) {
        command_direct_delete(btn, record)
    });

    return false;
};

// 点击提交按钮
var btnSubmit_Click = function () {
    var record = getSelectedRecord();
    if (record == null) {
        X.Msg.alert("提示", "请选择要提交的数据");
        return false;
    }

    X.Msg.confirm('提示', '您确定需要提交此条信息？', function (btn) {
        command_direct_submit(btn, record)
    });

    return false;
};

// 点击审核按钮
var btnAudit_Click = function () {
    var record = getSelectedRecord();
    if (record == null) {
        X.Msg.alert("提示", "请选择要审核的数据");
        return false;
    }
    command_direct_audit(record);
    return true;
};

// 点击下发按钮
var btnSend_Click = function () {
    var record = getSelectedRecord();
    if (record == null) {
        X.Msg.alert("提示", "请选择要下发的数据");
        return false;
    }

    X.Msg.confirm('提示', '您确定需要下发此条信息？', function (btn) {
        command_direct_send(btn, record)
    });

    return false;
};

// 点击复制按钮
var btnCopy_Click = function () {
    var record = getSelectedRecord();
    if (record == null) {
        X.Msg.alert("提示", "请选择要复制的数据");
        return false;
    }
    command_direct_copy(record);
    return true;
};

// 根据按钮类别进行删除和编辑操作
var commandcolumn_click = function (command, record) {
    commandcolumn_click_confirm(command, record);
    return false;
};

// 区分删除操作，并进行二次确认操作
var commandcolumn_click_confirm = function (command, record) {
    if (command.toLowerCase() == 'view') {
        command_direct_view(record);
    }
    if (command.toLowerCase() == 'submit') {
        Ext.Msg.confirm('提示', '您确定需要提交此条信息？', function (btn) {
            command_direct_submit(btn, record)
        });
    }
    if (command.toLowerCase() == 'edit') {
        command_direct_edit(record);
    }
    if (command.toLowerCase() == 'delete') {
        Ext.Msg.confirm('提示', '您确定需要删除此条信息？', function (btn) {
            command_direct_delete(btn, record)
        });
    }
    if (command.toLowerCase() == 'audit') {
        command_direct_audit(record);
    }
    if (command.toLowerCase() == 'send') {
        Ext.Msg.confirm('提示', '您确定需要下发此条信息？', function (btn) {
            command_direct_send(btn, record)
        });
    }
    return false;
};

// 点击查看按钮
var command_direct_view = function (record) {
    var objId = record.data.OBJID;
    App.direct.command_direct_view(objId, {
        success: function (result) {
        },

        failure: function (errorMsg) {
            Ext.Msg.alert('操作', errorMsg);
        }
    });
};

// 点击提交按钮
var command_direct_submit = function (btn, record) {
    if (btn != 'yes') {
        return;
    }
    var objId = record.data.OBJID;
    App.direct.command_direct_submit(objId, {
        success: function (result) {
            Ext.Msg.alert('操作', result);
        },

        failure: function (errorMsg) {
            Ext.Msg.alert('操作', errorMsg);
        }
    });
};

// 点击修改按钮
var command_direct_edit = function (record) {
    var objId = record.data.OBJID;
    App.direct.command_direct_edit(objId, {
        success: function (result) {
        },

        failure: function (errorMsg) {
            Ext.Msg.alert('操作', errorMsg);
        }
    });
};

// 点击删除按钮
var command_direct_delete = function (btn, record) {
    if (btn != 'yes') {
        return;
    }
    var objId = record.data.OBJID;
    App.direct.command_direct_delete(objId, {
        success: function (result) {
            Ext.Msg.alert('操作', result);
        },

        failure: function (errorMsg) {
            Ext.Msg.alert('操作', errorMsg);
        }
    });
};

// 点击审核按钮
var command_direct_audit = function (record) {
    var objId = record.data.OBJID;
    App.direct.command_direct_audit(objId, {
        success: function (result) {
        },

        failure: function (errorMsg) {
            Ext.Msg.alert('操作', errorMsg);
        }
    });
};

// 点击下发按钮
var command_direct_send = function (btn, record) {
    if (btn != 'yes') {
        return;
    }
    var objId = record.data.OBJID;
    App.direct.command_direct_send(objId, {
        success: function (result) {
            Ext.Msg.alert('操作', result);
        },

        failure: function (errorMsg) {
            Ext.Msg.alert('操作', errorMsg);
        }
    });
};

// 点击复制按钮
var command_direct_copy = function (record) {
    var objId = record.data.OBJID;
    App.direct.command_direct_copy(objId, {
        success: function (result) {
        },

        failure: function (errorMsg) {
            Ext.Msg.alert('操作', errorMsg);
        }
    });
};


// 更换硫化机类型
var cboMainMinorTypeId_Change = function (item, newValue, oldValue) {
    var majorTypeId = App.cboMainMajorTypeId.getValue();
    var minorTypeId = App.cboMainMinorTypeId.getValue();

    App.direct.equipminortype_change(majorTypeId, minorTypeId, {
        success: function (result) {
        },

        failure: function (errorMsg) {
            Ext.Msg.alert('操作', errorMsg);
        }
    });
};

// 更换胶囊型号
var cboMainBladderTypeId_Change = function (item, newValue, oldValue) {
    App.direct.bladdertype_change(newValue, {
        success: function (result) {
        },

        failure: function (errorMsg) {
            Ext.Msg.alert('操作', errorMsg);
        }
    });

};


// 列表刷新数据重载方法
var gridPanelDetailRefresh = function () {
    App.gridPanelDetailStore.currentPage = 1;
    App.gridPanelDetailPagingToolbar.doRefresh();
    return false;
}

// 点击修改明细按钮
var btnDetailEdit_Click = function () {
    var selectRows = App.gridPanelDetailCheckboxSelectionModel.getSelection();
    if (selectRows.length == 0) {
        X.Msg.alert("提示", "请选择要修改的数据");
        return false;
    }
    var record = selectRows[0];
    detailcommand_direct_edit(record);
    return true;
};

// 点击删除明细按钮
var btnDetailDelete_Click = function () {
    var selectRows = App.gridPanelDetailCheckboxSelectionModel.getSelection();
    if (selectRows.length == 0) {
        X.Msg.alert("提示", "请选择要删除的数据");
        return false;
    }

    X.Msg.confirm('提示', '您确定需要删除此条信息？', function (btn) {
        var record = selectRows[0];
        detailcommand_direct_delete(btn, record)
    });

    return false;
};

// 根据按钮类别进行删除和编辑操作
var detailcommandcolumn_click = function (command, record) {
    detailcommandcolumn_click_confirm(command, record);
    return false;
};

// 区分删除操作，并进行二次确认操作
var detailcommandcolumn_click_confirm = function (command, record) {
    if (command.toLowerCase() == 'edit') {
        detailcommand_direct_edit(record);
    }
    if (command.toLowerCase() == 'delete') {
        Ext.Msg.confirm('提示', '您确定需要删除此条信息？', function (btn) {
            detailcommand_direct_delete(btn, record)
        });
    }
    return false;
};

// 点击修改明细按钮
var detailcommand_direct_edit = function (record) {

    var objId = record.data.OBJID;
    App.direct.detailcommand_direct_edit(objId, {
        success: function (result) {
        },

        failure: function (errorMsg) {
            Ext.Msg.alert('操作', errorMsg);
        }
    });
}

// 点击删除明细按钮
var detailcommand_direct_delete = function (btn, record) {
    if (btn != 'yes') {
        return;
    }
    var objId = record.data.OBJID;
    App.direct.detailcommand_direct_delete(objId, {
        success: function (result) {
            Ext.Msg.alert('操作', result);
        },

        failure: function (errorMsg) {
            Ext.Msg.alert('操作', errorMsg);
        }
    });
};


// -------物料信息-----查询带回弹出框--BEGIN
var McUI_SearchBox_SearchBoxVCbmMaterial_Request = function (record) {
    if (!App.winMain.hidden) {
        App.tgrMainMaterialName.setValue(record.data.MATERIAL_NAME + "|" + record.data.MATERIAL_CODE);
        App.hdnMainMaterialId.setValue(record.data.OBJID);
    } else {
        App.tgrSearchMaterialName.setValue(record.data.MATERIAL_NAME + "|" + record.data.MATERIAL_CODE);
        App.hdnSearchMaterialId.setValue(record.data.OBJID);
    }
}

var searchMaterial = function (item, trigger, index) {// 物料查询
    if (index == 1) {
        App.McUI_SearchBox_SearchBoxVCbmMaterial_Window.show();
    }
    else if (index == 0) {
        if (!App.winMain.hidden) {

        }
        else {
            App.tgrSearchMaterialName.setValue("");
            App.hdnSearchMaterialId.setValue("");
        }
    }
}

Ext.create("Ext.window.Window", {// 物料查询带回窗体
    id: "McUI_SearchBox_SearchBoxVCbmMaterial_Window",
    height: 460,
    hidden: true,
    width: 600,
    html: "<iframe src='../../../McUI/SearchBox/SearchBoxVCbmMaterial.aspx' width=100% height=100% scrolling=no  frameborder=0></iframe>",
    bodyStyle: "background-color: #fff;",
    closable: true,
    title: "请选择物料",
    modal: true
})
//------------查询带回弹出框--END 


var clearAuditUsers = function () {
    var chks = App.cbgMainAuditUser.getChecked();
    for (var i = 0; i < chks.length; i++) {
        var chk = chks[i];
        // chk.checked = false;
    }
};

var cbgMainAuditUser_Change = function (item) {
    var auditSelects = getAuditSelects(item);
    App.hdnMainAuditSelects.setValue(auditSelects);
    var auditSelectNames = getAuditSelectNames(item);
    App.hdnMainAuditSelectNames.setValue(auditSelectNames);
};

var getAuditSelects = function (item) {
    var auditSelects = "";
    var chks = item.getChecked();
    for (var i = 0; i < chks.length; i++) {
        var auditUserId = chks[i].inputValue;
        if (auditSelects == "") {
            auditSelects = auditUserId;
        }
        else {
            auditSelects = auditSelects + "," + auditUserId;
        }
    }
    return auditSelects;
};

var getAuditSelectNames = function (item) {
    var auditSelectNames = "";
    var chks = item.getChecked();
    for (var i = 0; i < chks.length; i++) {
        var auditUserName = chks[i].boxLabel;
        if (auditSelectNames == "") {
            auditSelectNames = auditUserName;
        }
        else {
            auditSelectNames = auditSelectNames + "," + auditUserName;
        }
    }
    return auditSelectNames;
};


var setAuditSelects = function (auditSelects) {
    // var auditSelects = App.hdnMainAuditSelects.getValue();
    auditSelects = "," + auditSelects + ",";
    var item = App.cbgMainAuditUser;
    var chks = item.items;
    for (var i = 0; i < chks.length; i++) {
        var chk = chks.get(i);
        var auditUserId = chk.inputValue;
        auditUserId = "," + auditUserId + ",";
        if (auditSelects.indexOf(chk.inputValue) >= 0) {
            chk.setValue(true);
        }
    }

};

var gridPanelMainView_GetRowClass = function (record, index, rowParams, store) {
    return "row_" + record.data.STATE;
};

var numMainAllCuringTime_Change = function (allCuringTime) {
    App.txtMainAllCuringTimeShow.setValue(getShowTime(allCuringTime));
};

var tabPanelMain_Click = function (newTab) {
    if (newTab.tab.card.activeItem == 2 && App.hdnMainRefreshDetailFlag.getValue() == '1') {
        App.hdnMainRefreshDetailFlag.setValue('');
        App.gridPanelDetailPagingToolbar.doRefresh();
        App.gridPanelWinterPagingToolbar.doRefresh();
    }
    if (newTab.tab.card.activeItem == 2 && App.hdnMainVisitCuringTimeFlag.getValue() == '') {
        App.hdnMainVisitCuringTimeFlag.setValue('1');
    }
    if (newTab.tab.card.activeItem == 3 && App.hdnMainVisitParams1Flag.getValue() == '') {
        App.hdnMainVisitParams1Flag.setValue('1');
    }
};

var getShowTime = function (seconds) {
    if (seconds == null || seconds == "") {
        return "";
    }
    if (Ext.isNumber(seconds) == false) {
        return "";
    }
    var ss = Math.floor(seconds % 60);
    var mm = Math.floor(seconds % 3600 / 60);
    var hh = Math.floor(seconds / 3600);

    return hh + ":" + mm + ":" + ss;
};
