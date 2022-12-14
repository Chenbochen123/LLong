var viewportAfterRender = function () {
    App.ui_s_BeginTime_Date.setValue(null);
    App.ui_s_BeginTime_Time.setValue(null);
    App.ui_s_EndTime_Date.setValue(null);
    App.ui_s_EndTime_Time.setValue(null);

    App.ui_s_SearchType.onChange = set_ui_s_SearchType;

    var beginDate = App.ui_s_BeginDate.getValue();
    var endDate = beginDate;
    App.ui_s_BeginDate.setValue(beginDate);
    App.ui_s_EndDate.setValue(endDate);

    App.ui_s_BeginTime.hide();
    App.ui_s_EndTime.hide();
};

//-------切换查询类型-----
var set_ui_s_SearchType = function (value) {
    if (value == "1") {
        // 按接班日期
        var beginDate = Ext.Date.parse(App.ui_s_BeginTime_Date.rawValue + " " + App.ui_s_BeginTime_Time.rawValue, 'Y-m-d H:i:s', true);
        var endDate = Ext.Date.parse(App.ui_s_EndTime_Date.rawValue + " " + App.ui_s_EndTime_Time.rawValue, 'Y-m-d H:i:s', true);

        beginDate = Ext.Date.add(beginDate, Ext.Date.HOUR, 4);
        endDate = Ext.Date.add(endDate, Ext.Date.HOUR, -20);

        // 结束日期按生产时间减1天
        if (beginDate > endDate) {
            endDate = beginDate;
        }

        App.ui_s_BeginDate.setValue(beginDate);
        App.ui_s_EndDate.setValue(endDate);
        App.ui_s_BeginTime_Date.setValue(null);
        App.ui_s_BeginTime_Time.setValue(null);
        App.ui_s_EndTime_Date.setValue(null);
        App.ui_s_EndTime_Time.setValue(null);

        App.ui_s_BeginTime.hide();
        App.ui_s_EndTime.hide();
        App.ui_s_BeginDate.show();
        App.ui_s_EndDate.show();
    }
    else /*if (value == "2")*/ {
        // 按生产时间
        var beginDate = App.ui_s_BeginDate.value;
        var endDate = App.ui_s_EndDate.value;
        // 结束日期按接班日期加1天
        endDate = Ext.Date.add(endDate, Ext.Date.DAY, 1);

        var beginTime = Ext.Date.add(beginDate, Ext.Date.HOUR, -4);
        var endTime = Ext.Date.add(endDate, Ext.Date.HOUR, -4);

        App.ui_s_BeginDate.setValue(null);
        App.ui_s_EndDate.setValue(null);
        App.ui_s_BeginTime_Date.setValue(beginTime);
        App.ui_s_EndTime_Date.setValue(endTime);
        App.ui_s_BeginTime_Time.setValue(beginTime);
        App.ui_s_EndTime_Time.setValue(endTime);

        App.ui_s_BeginDate.hide();
        App.ui_s_EndDate.hide();
        App.ui_s_BeginTime.show();
        App.ui_s_EndTime.show();
    }
};
