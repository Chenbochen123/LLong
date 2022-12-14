var viewportAfterRender = function () {
    App.ui_i_MAJOR_TYPE_ID.onChange = set_ui_i_MAJOR_TYPE_ID;
};

var set_ui_i_MAJOR_TYPE_ID = function () {
    if (App.ui_i_MAJOR_TYPE_ID.getStore().data.length > 0) {
        var majorTypeId = App.ui_i_MAJOR_TYPE_ID.getStore().data.items[0].data.field1;
        App.ui_i_MAJOR_TYPE_ID.setValue(majorTypeId);
    }
    else {
        App.ui_i_MAJOR_TYPE_ID.setValue('');
    }
};