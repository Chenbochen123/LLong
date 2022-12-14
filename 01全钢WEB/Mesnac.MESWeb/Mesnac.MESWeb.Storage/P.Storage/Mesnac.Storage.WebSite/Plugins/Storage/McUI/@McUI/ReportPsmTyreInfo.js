var viewportAfterRender = function () {

    App.ui_s_CuringBeginTime_Time.setValue(null);
    App.ui_s_CuringBeginTime_Date.setValue(null);
    App.ui_s_CuringEndTime_Time.setValue(null);
    App.ui_s_CuringEndTime_Date.setValue(null);
    App.ui_s_SearchType.onChange = set_ui_s_SearchType;
    var beginDate = Ext.Date.parse(App.ui_s_InStockBeginTime_Date.rawValue + " " + App.ui_s_InStockBeginTime_Time.rawValue, 'Y-m-d H:i:s', true);
    var endDate = Ext.Date.parse(App.ui_s_InStockEndTime_Date.rawValue + " " + App.ui_s_InStockEndTime_Time.rawValue, 'Y-m-d H:i:s', true);
    endDate = Ext.Date.add(endDate, Ext.Date.HOUR, +4);
    App.ui_s_InStockEndTime_Time.setValue(endDate);
    App.ui_s_CuringBeginTime.hide();
    App.ui_s_CuringEndTime.hide();
};

//-------切换查询类型-----
var set_ui_s_SearchType = function (value) {
    if (value == "1") {
        // 按入库时间
       
        App.ui_s_CuringBeginTime_Time.setValue(null);
        App.ui_s_CuringBeginTime_Date.setValue(null);
        App.ui_s_CuringEndTime_Time.setValue(null);
        App.ui_s_CuringEndTime_Date.setValue(null);

        App.ui_s_CuringBeginTime.hide();
        App.ui_s_CuringEndTime.hide();
        App.ui_s_InStockBeginTime.show();
        App.ui_s_InStockEndTime.show();
    }
    else if (value == "2") {
        // 按硫化时间
        App.ui_s_InStockBeginTime_Time.setValue(null);
        App.ui_s_InStockBeginTime_Date.setValue(null);
        App.ui_s_InStockEndTime_Time.setValue(null);
        App.ui_s_InStockEndTime_Date.setValue(null);
        var beginDate = ui_s_CuringBeginTime_Date.value;
        var endDate = ui_s_CuringEndTime_Date.value;

        App.ui_s_CuringBeginTime_Date.setValue(beginDate);
        App.ui_s_CuringEndTime_Date.setValue(endDate);
        
        App.ui_s_InStockBeginTime.hide();
        App.ui_s_InStockEndTime.hide();
        App.ui_s_CuringBeginTime.show();
        App.ui_s_CuringEndTime.show();
    }
};
