var viewportAfterRender = function () {
    App.ui_s_MajorType.addListener('change', function (target, newValue, oldValue) {
        var s_MajorType = App.ui_s_MajorType;
        var s_MinorType = App.ui_s_MinorType;
        s_MinorType.setValue(null);

        var storeMinorType = s_MinorType.getStore();
        if (newValue == null) {
            storeMinorType.clearFilter();
        }
        else {
            storeMinorType.filterBy(function (record, id) {
                var majorType = s_MajorType.getValue();
                return record.get("field1").substr(0, majorType.length) == majorType;
            });

        }
    });
};