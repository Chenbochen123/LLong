var viewportAfterRender = function () {
    App.ui_s_BeginTime_Date.setValue(null);
    App.ui_s_BeginTime_Time.setValue(null);
    App.ui_s_EndTime_Date.setValue(null);
    App.ui_s_EndTime_Time.setValue(null);
    App.ui_s_BeginOutDate.setValue(null);
    App.ui_s_EndOutDate.setValue(null);

    App.ui_s_SearchType.onChange = set_ui_s_SearchType;

    App.ui_s_LastSearchType.text = "1";

    var beginDate = App.ui_s_BeginDate.getValue();
    var endDate = beginDate;
    App.ui_s_BeginDate.setValue(beginDate);
    App.ui_s_EndDate.setValue(endDate);

    App.ui_s_BeginTime.hide();
    App.ui_s_EndTime.hide();
    App.ui_s_BeginOutDate.hide();
    App.ui_s_EndOutDate.hide();
};

//-------切换查询类型-----
var set_ui_s_SearchType = function (value) {
    var lastSearchType = App.ui_s_LastSearchType.text;
    debugger;
    if (value == "1") {
        // 按凭证日期
        var beginDate = null;
        var endDate = null;
        if (lastSearchType == "2")
        {
            // 之前是按确认时间
            beginDate = Ext.Date.parse(App.ui_s_BeginTime_Date.rawValue + " " + App.ui_s_BeginTime_Time.rawValue, 'Y-m-d H:i:s', true);
            endDate = Ext.Date.parse(App.ui_s_EndTime_Date.rawValue + " " + App.ui_s_EndTime_Time.rawValue, 'Y-m-d H:i:s', true);

            beginDate = Ext.Date.add(beginDate, Ext.Date.HOUR, 4);
            endDate = Ext.Date.add(endDate, Ext.Date.HOUR, -20);

            // 结束日期按生产时间减1天
            if (beginDate > endDate) {
                endDate = beginDate;
            }
        }
        else
        {
            // 之前是按出库日期
            beginDate = Ext.Date.parse(App.ui_s_BeginOutDate.rawValue);
            endDate = Ext.Date.parse(App.ui_s_EndOutDate.rawValue);
        }

        App.ui_s_BeginDate.setValue(beginDate);
        App.ui_s_EndDate.setValue(endDate);
        App.ui_s_BeginTime_Date.setValue(null);
        App.ui_s_BeginTime_Time.setValue(null);
        App.ui_s_EndTime_Date.setValue(null);
        App.ui_s_EndTime_Time.setValue(null);
        App.ui_s_BeginOutDate.setValue(null);
        App.ui_s_EndOutDate.setValue(null);

        App.ui_s_BeginTime.hide();
        App.ui_s_EndTime.hide();
        App.ui_s_BeginOutDate.hide();
        App.ui_s_EndOutDate.hide();
        App.ui_s_BeginDate.show();
        App.ui_s_EndDate.show();
    }
    else if (value == "2") {
        // 按生产时间
        var beginDate = null;
        var endDate = null;
        var beginTime = null;
        var endTime = null;
        if (lastSearchType == "1") {
            // 之前是按凭证日期
            beginDate = App.ui_s_BeginDate.value;
            endDate = App.ui_s_EndDate.value;
        }
        else
        {
            // 之前是按出库日期
            beginDate = App.ui_s_BeginOutDate.value;
            endDate = App.ui_s_EndOutDate.value;
        }
        // 结束日期按接班日期加1天
        endDate = Ext.Date.add(endDate, Ext.Date.DAY, 1);

        beginTime = Ext.Date.add(beginDate, Ext.Date.HOUR, -4);
        endTime = Ext.Date.add(endDate, Ext.Date.HOUR, -4);

        App.ui_s_BeginDate.setValue(null);
        App.ui_s_EndDate.setValue(null);
        App.ui_s_BeginOutDate.setValue(null);
        App.ui_s_EndOutDate.setValue(null);
        App.ui_s_BeginTime_Date.setValue(beginTime);
        App.ui_s_EndTime_Date.setValue(endTime);
        App.ui_s_BeginTime_Time.setValue(beginTime);
        App.ui_s_EndTime_Time.setValue(endTime);

        App.ui_s_BeginDate.hide();
        App.ui_s_EndDate.hide();
        App.ui_s_BeginOutDate.hide();
        App.ui_s_EndOutDate.hide();
        App.ui_s_BeginTime.show();
        App.ui_s_EndTime.show();
    }
    else if (value == "3") {
        // 按凭证日期
        var beginDate = null;
        var endDate = null;
        if (lastSearchType == "2") {
            // 之前是按确认时间
            beginDate = Ext.Date.parse(App.ui_s_BeginTime_Date.rawValue + " " + App.ui_s_BeginTime_Time.rawValue, 'Y-m-d H:i:s', true);
            endDate = Ext.Date.parse(App.ui_s_EndTime_Date.rawValue + " " + App.ui_s_EndTime_Time.rawValue, 'Y-m-d H:i:s', true);

            beginDate = Ext.Date.add(beginDate, Ext.Date.HOUR, 4);
            endDate = Ext.Date.add(endDate, Ext.Date.HOUR, -20);

            // 结束日期按生产时间减1天
            if (beginDate > endDate) {
                endDate = beginDate;
            }
        }
        else {
            // 之前是按出库日期
            beginDate = Ext.Date.parse(App.ui_s_BeginDate.rawValue);
            endDate = Ext.Date.parse(App.ui_s_EndDate.rawValue);
        }

        App.ui_s_BeginOutDate.setValue(beginDate);
        App.ui_s_EndOutDate.setValue(endDate);
        App.ui_s_BeginTime_Date.setValue(null);
        App.ui_s_BeginTime_Time.setValue(null);
        App.ui_s_EndTime_Date.setValue(null);
        App.ui_s_EndTime_Time.setValue(null);
        App.ui_s_BeginDate.setValue(null);
        App.ui_s_EndDate.setValue(null);

        App.ui_s_BeginTime.hide();
        App.ui_s_EndTime.hide();
        App.ui_s_BeginDate.hide();
        App.ui_s_EndDate.hide();
        App.ui_s_BeginOutDate.show();
        App.ui_s_EndOutDate.show();
    }

    App.ui_s_LastSearchType.text = value;
};
