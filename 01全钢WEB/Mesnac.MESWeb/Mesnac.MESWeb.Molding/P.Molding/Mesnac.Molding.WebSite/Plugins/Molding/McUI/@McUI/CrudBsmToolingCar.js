var viewportAfterRender = function () {
    Ext.getCmp('btnAddSave').on('click', checkInfo);
    Ext.getCmp('btnModifySave').on('click', checkInfo);
};

var checkInfo = function () {
    var maxLoadAmount = null;
    if (!App.winAdd.hidden) {
        maxLoadAmount = App.ui_i_MAX_LOAD_AMOUNT.getValue();
    }
    else if (!App.winUpdate.hidden) {
        maxLoadAmount = App.ui_u_MAX_LOAD_AMOUNT.getValue();
    }
    if (maxLoadAmount != null && isInteger(maxLoadAmount) == false) {
        Ext.Msg.alert('提示', '最大装载数量必须是整数');
        return false;
    }

};

// 不支持字符型
var isInteger = function (obj) {
    return (obj | 0) === obj;
};
