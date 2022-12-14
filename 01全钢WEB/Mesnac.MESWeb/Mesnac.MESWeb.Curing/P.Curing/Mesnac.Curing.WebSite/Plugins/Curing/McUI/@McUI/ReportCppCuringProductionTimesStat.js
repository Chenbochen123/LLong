var viewportAfterRender = function () {
    var produceDate = App.ui_s_ProduceDate.getValue();
    var nextProduceDate = Ext.Date.add(produceDate, "d", 1);
    App.ui_s_EndTime_Date.setValue(nextProduceDate);

    App.ui_s_ProduceDate.editable = false;
    App.ui_s_ProduceDate.on('change', setSearchTime);
    App.ui_s_ShiftTime.on('change', setSearchTime);
    App.ui_s_BeginTime_Date.readOnly = true;
    App.ui_s_BeginTime_Time.readOnly = true;

    App.ui_s_EndTime_Date.readOnly = true;
    App.ui_s_EndTime_Time.readOnly = true;

    App.ui_s_BeginTime.hide();
    App.ui_s_EndTime.hide();
};

var setSearchTime = function () {
    var produceDate = App.ui_s_ProduceDate.getValue();
    var nextProduceDate = Ext.Date.add(produceDate, "d", 1);
    var shiftTime = App.ui_s_ShiftTime.getValue();
    if (shiftTime == 0) {
        App.ui_s_BeginTime_Date.setValue(produceDate);
        App.ui_s_BeginTime_Time.setValue('08:00:00');

        App.ui_s_EndTime_Date.setValue(nextProduceDate);
        App.ui_s_EndTime_Time.setValue('08:00:00');
    }
    else if (shiftTime == 1) {
        App.ui_s_BeginTime_Date.setValue(produceDate);
        App.ui_s_BeginTime_Time.setValue('08:00:00');

        App.ui_s_EndTime_Date.setValue(produceDate);
        App.ui_s_EndTime_Time.setValue('16:00:00');
    }
    else if (shiftTime == 2) {
        App.ui_s_BeginTime_Date.setValue(produceDate);
        App.ui_s_BeginTime_Time.setValue('16:00:00');

        App.ui_s_EndTime_Date.setValue(nextProduceDate);
        App.ui_s_EndTime_Time.setValue('16:00:00');
    }
};

