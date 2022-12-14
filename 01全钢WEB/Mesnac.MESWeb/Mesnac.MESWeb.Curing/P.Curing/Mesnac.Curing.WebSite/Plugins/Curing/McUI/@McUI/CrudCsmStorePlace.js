var viewportAfterRender = function () {
    App.winAdd.afterShow = afterShow_winAdd;
};

var afterShow_winAdd = function () {
    var ui_i_STORE_ID = App.ui_i_STORE_ID;
    if (ui_i_STORE_ID.store.data.length == 1) {
        var storeId = ui_i_STORE_ID.store.data.getAt(0).data.field1;
        ui_i_STORE_ID.select(storeId);
    }
    debugger;
    var ui_i_STORE_PLACE_TYPE = App.ui_i_STORE_PLACE_TYPE;
    if (ui_i_STORE_PLACE_TYPE.store.data.length == 1) {
        var storePlaceType = ui_i_STORE_PLACE_TYPE.store.data.getAt(0).data.field1;
        ui_i_STORE_PLACE_TYPE.select(storePlaceType);
    }
};

