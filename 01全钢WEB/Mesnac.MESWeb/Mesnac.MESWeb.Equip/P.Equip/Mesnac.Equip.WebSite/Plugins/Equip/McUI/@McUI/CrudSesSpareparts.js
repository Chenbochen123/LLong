var viewportAfterRender = function () {
    //App.ui_s_MajorStopType.hide();
    App.ui_s_MajorTypeId.addListener('change', function (target, newValue, oldValue) {
        filterMinorType(newValue, App.ui_s_MinorTypeId);
    });

    App.ui_i_MAJOR_TYPE_ID.addListener('change', function (target, newValue, oldValue) {
        filterMinorType(newValue, App.ui_i_MINOR_TYPE_ID);
    });
    App.ui_u_MAJOR_TYPE_ID.addListener('change', function (target, newValue, oldValue) {
        filterMinorType(newValue, App.ui_u_MINOR_TYPE_ID);
    });

};

var filterMinorType = function (majorTypeId, cboMinorType) {
    cboMinorType.setValue(null);

    var storeMinorType = cboMinorType.getStore();

    if (majorTypeId == null || majorTypeId == '') {
        storeMinorType.clearFilter();
    }
    else {
        var storeMajorType = App.ui_s_MajorType.getStore();

        var recordsValues = storeMajorType.getRecordsValues();
        var minorTypeIds = getMinorTypeIds(majorTypeId, recordsValues);

        storeMinorType.filterBy(function (record, id) {
            return minorTypeIds.indexOf('|' + record.get("field1") + '|') >= 0;
        });
    }
};

var getMinorTypeIds = function (majorTypeId, recordsValues) {
    var minorTypeIds = "|";

    Ext.each(recordsValues, function (value, index) {
        if (majorTypeId == value.field1) {
            minorTypeIds = minorTypeIds + value.field2 + "|";
        }
    });

    //var len = recordsValues.length;
    //for (var i = 0; i < len; i++) {
    //    if (majorTypeId == recordsValues[i].field1) {
    //        stopTypeIds = stopTypeIds + recordsValues[i].field2 + "|";
    //    }
    //}

    return minorTypeIds;
};


