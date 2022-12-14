var viewportAfterRender = function () {
    var beginDate = App.ui_s_BeginTime_Date.getValue();
    var endDate = Ext.Date.add(beginDate, Ext.Date.DAY, 1);
    App.ui_s_EndTime_Date.setValue(endDate);
};
