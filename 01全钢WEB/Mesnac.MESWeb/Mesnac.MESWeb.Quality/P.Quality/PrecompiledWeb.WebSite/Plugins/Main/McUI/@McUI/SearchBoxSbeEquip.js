var viewportAfterRender = function () {
    App.ui_s_MAJOR_TYPE_ID.onChange = set_ui_s_MINOR_TYPE_ID;
};

var set_ui_s_MINOR_TYPE_ID = function (majorTypeId) {
    var ui_s_MINOR_TYPE_ID = App.ui_s_MINOR_TYPE_ID;
    ui_s_MINOR_TYPE_ID.setValue('');

    var minorStore = ui_s_MINOR_TYPE_ID.getStore();
    minorStore.filterBy(function (record) {
        if (majorTypeId == null || majorTypeId == '') {
            return true;
        }
        return record.getData().field1.substr(0, 2) == majorTypeId;
    });
};
