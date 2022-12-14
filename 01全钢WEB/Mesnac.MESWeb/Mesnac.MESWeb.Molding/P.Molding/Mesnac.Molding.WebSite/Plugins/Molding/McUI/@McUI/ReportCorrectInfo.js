var viewportAfterRender = function () {
    var beginDate = App.ui_s_BEGIN_DATE.getValue();
    var endDate = Ext.Date.add(beginDate, Ext.Date.DAY, 1);
    App.ui_s_END_DATE.setValue(endDate);
};
