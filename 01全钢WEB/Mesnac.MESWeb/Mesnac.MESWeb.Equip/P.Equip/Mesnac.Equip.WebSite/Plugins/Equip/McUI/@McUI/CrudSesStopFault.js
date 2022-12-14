var viewportAfterRender = function () {
    App.ui_s_MajorStopType.hide();
    App.ui_s_MajorTypeId.addListener('change', function (target, newValue, oldValue) {
        filterStopType(newValue, App.ui_s_StopTypeId);
    });

    App.ui_i_MAJOR_TYPE_ID.addListener('change', function (target, newValue, oldValue) {
        filterStopType(newValue, App.ui_i_STOP_TYPE_ID);
    });
    App.ui_u_MAJOR_TYPE_ID.addListener('change', function (target, newValue, oldValue) {
        filterStopType(newValue, App.ui_u_STOP_TYPE_ID);
    });

};

var filterStopType = function (majorTypeId, cboStopType) {
    cboStopType.setValue(null);

    var storeStopType = cboStopType.getStore();

    if (majorTypeId == null || majorTypeId == '') {
        storeStopType.clearFilter();
    }
    else {
        var storeMajorStopType = App.ui_s_MajorStopType.getStore();

        var recordsValues = storeMajorStopType.getRecordsValues();
        var stopTypeIds = getStopTypeIds(majorTypeId, recordsValues);

        storeStopType.filterBy(function (record, id) {
            return stopTypeIds.indexOf('|' + record.get("field1") + '|') >= 0;
        });
    }
};

var getStopTypeIds = function (majorTypeId, recordsValues) {
    var stopTypeIds = "|";

    Ext.each(recordsValues, function (value, index) {
        if (majorTypeId == value.field1)
        {
            stopTypeIds = stopTypeIds + value.field2 + "|";
        }
    });

    //var len = recordsValues.length;
    //for (var i = 0; i < len; i++) {
    //    if (majorTypeId == recordsValues[i].field1) {
    //        stopTypeIds = stopTypeIds + recordsValues[i].field2 + "|";
    //    }
    //}

    return stopTypeIds;
};


