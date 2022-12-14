var viewportAfterRender = function () {
    App.winAdd.afterShow = afterShow_winAdd;
};

var afterShow_winAdd = function () {
    var ui_i_STORE_TYPE = App.ui_i_STORE_TYPE;
    if (ui_i_STORE_TYPE.store.data.length == 1) {
        var storeType = ui_i_STORE_TYPE.store.data.getAt(0).data.field1;
        ui_i_STORE_TYPE.select(storeType);
    }
};

