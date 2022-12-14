var viewportAfterRender = function () {

    // 设置生产时间为空
    App.ui_s_BEGIN_TIME_Date.setValue(null);
    App.ui_s_BEGIN_TIME_Time.setValue(null);
    App.ui_s_END_TIME_Date.setValue(null);
    App.ui_s_END_TIME_Time.setValue(null);

    App.ui_s_EQUIP_NAME.setEditable(true);

    // App.ui_s_BEGIN_TIME.hideMode = "display";// offsets display visibility
    App.ui_s_BEGIN_TIME.hide();
    App.ui_s_END_TIME.hide();

    App.ui_s_SearchType.onChange = set_ui_s_SearchType;

    App.winUpdate.afterShow = afterShow_winUpdate;
};

var afterShow_winUpdate = function () {
    var planDetailName = App.ui_u_PLAN_DATE.getRawValue()
        + "," + App.ui_u_PLAN_SHIFT_NAME.getRawValue()
        + "," + App.ui_u_EQUIP_NAME.getRawValue()
        + "," + App.ui_u_MATERIAL_NAME.getRawValue()
        + "," + App.ui_u_EQUIP_ID.getRawValue()
        + "," + App.ui_u_MATERIAL_ID.getRawValue();
    App.ui_u_PLAN_DETAIL_ID_TriggerField.setValue(planDetailName);

    var shiftMasterName = App.ui_u_SHIFT_DATE.getRawValue()
        + "," + App.ui_u_SHIFT_EQUIP_NAME.getRawValue()
        + "," + App.ui_u_SHIFT_ID.getRawValue()
        + "," + App.ui_u_CLASS_ID.getRawValue();

    App.ui_u_SHIFT_MASTER_ID_TriggerField.setValue(shiftMasterName);
};

//-------切换查询类型-----
var set_ui_s_SearchType = function (value) {
    if (value == "1") {
        // 按接班日期
        var beginDate = App.ui_s_BEGIN_TIME_Date.value;
        var endDate = App.ui_s_END_TIME_Date.value;
        // 结束日期按生产时间减1天
        endDate = Ext.Date.add(endDate, Ext.Date.DAY, -1);
        if (beginDate > endDate) {
            endDate = beginDate;
        }

        App.ui_s_BEGIN_DATE.setValue(beginDate);
        App.ui_s_END_DATE.setValue(endDate);
        App.ui_s_BEGIN_TIME_Date.setValue(null);
        App.ui_s_BEGIN_TIME_Time.setValue(null);
        App.ui_s_END_TIME_Date.setValue(null);
        App.ui_s_END_TIME_Time.setValue(null);

        App.ui_s_BEGIN_TIME.hide();
        App.ui_s_END_TIME.hide();
        App.ui_s_BEGIN_DATE.show();
        App.ui_s_END_DATE.show();
    }
    else if (value == "2") {
        // 按生产时间
        var beginDate = App.ui_s_BEGIN_DATE.value;
        var endDate = App.ui_s_END_DATE.value;
        // 结束日期按接班日期加1天
        endDate = Ext.Date.add(endDate, Ext.Date.DAY, 1);

        var beginTime = Ext.Date.add(beginDate, Ext.Date.HOUR, 8);
        var endTime = Ext.Date.add(endDate, Ext.Date.HOUR, 8);

        App.ui_s_BEGIN_DATE.setValue(null);
        App.ui_s_END_DATE.setValue(null);
        App.ui_s_BEGIN_TIME_Date.setValue(beginDate);
        App.ui_s_END_TIME_Date.setValue(endDate);
        App.ui_s_BEGIN_TIME_Time.setValue(beginTime);
        App.ui_s_END_TIME_Time.setValue(endTime);

        App.ui_s_BEGIN_DATE.hide();
        App.ui_s_END_DATE.hide();
        App.ui_s_BEGIN_TIME.show();
        App.ui_s_END_TIME.show();
    }
};


//-------接班信息-----查询带回弹出框--BEGIN
var McUI_SearchBox_SearchBoxHppShiftMaster_Request = function (record) {
    if (!App.winAdd.hidden) {
        App.ui_i_SHIFT_MASTER_ID_TriggerField.setValue(record.data.SHIFT_MASTER_NAME);
        App.ui_i_SHIFT_MASTER_ID.setValue(record.data.OBJID);

        App.ui_i_SHIFT_DATE.setValue(record.data.SHIFT_DATE);
        App.ui_i_SHIFT_ID.setValue(record.data.SHIFT_ID.toString());
        App.ui_i_CLASS_ID.setValue(record.data.CLASS_ID.toString());
        App.ui_i_SHIFT_EQUIP_NAME.setValue(record.data.EQUIP_NAME);
    }
    else {
        App.ui_u_SHIFT_MASTER_ID_TriggerField.setValue(record.data.SHIFT_MASTER_NAME);
        App.ui_u_SHIFT_MASTER_ID.setValue(record.data.OBJID);

        App.ui_u_SHIFT_DATE.setValue(record.data.SHIFT_DATE);
        App.ui_u_SHIFT_ID.setValue(record.data.SHIFT_ID.toString());
        App.ui_u_CLASS_ID.setValue(record.data.CLASS_ID.toString());
        App.ui_u_SHIFT_EQUIP_NAME.setValue(record.data.EQUIP_NAME);
    }
}

var get_SHIFT_MASTER_ID_TriggerField = function (field, trigger, index) {//接班查询
    App.McUI_SearchBox_SearchBoxHppShiftMaster_Window.show();
}

Ext.create("Ext.window.Window", {//接班查询带回窗体
    id: "McUI_SearchBox_SearchBoxHppShiftMaster_Window",
    height: 460,
    hidden: true,
    width: 560,
    html: "<iframe src='../../McUI/SearchBox/SearchBoxHppShiftMaster.aspx' width=100% height=100% scrolling=no  frameborder=0></iframe>",
    bodyStyle: "background-color: #fff;",
    closable: true,
    title: "请选择接班",
    modal: true
})

//------------查询带回弹出框--END 

//-------计划信息-----查询带回弹出框--BEGIN
var McUI_SearchBox_SearchBoxHppPlanDetail_Request = function (record) {
    if (!App.winAdd.hidden) {
        if (record.data.PLAN_STATE == 0) {
            Ext.Msg.alert("提示", "选择的计划明细尚未下发");
            return;
        }
        App.ui_i_PLAN_DETAIL_ID_TriggerField.setValue(record.data.PLAN_DETAIL_NAME);
        App.ui_i_PLAN_DETAIL_ID.setValue(record.data.OBJID);
        App.ui_i_PLAN_ID.setValue(record.data.PLAN_ID);
        App.ui_i_EQUIP_NAME.setValue(record.data.EQUIP_NAME);
        App.ui_i_MATERIAL_NAME.setValue(record.data.MATERIAL_NAME);
        App.ui_i_EQUIP_ID.setValue(record.data.EQUIP_ID.toString());
        App.ui_i_MATERIAL_ID.setValue(record.data.MATERIAL_ID.toString());
        App.ui_i_PLAN_DATE.setValue(record.data.PLAN_DATE);
        App.ui_i_PLAN_SHIFT_NAME.setValue(record.data.SHIFT_NAME.toString());
    }
    else {
        App.ui_u_PLAN_DETAIL_ID_TriggerField.setValue(record.data.PLAN_DETAIL_NAME);
        App.ui_u_PLAN_DETAIL_ID.setValue(record.data.OBJID);
        App.ui_u_PLAN_ID.setValue(record.data.PLAN_ID);
        App.ui_u_EQUIP_NAME.setValue(record.data.EQUIP_NAME);
        App.ui_u_MATERIAL_NAME.setValue(record.data.MATERIAL_NAME);
        App.ui_u_EQUIP_ID.setValue(record.data.EQUIP_ID.toString());
        App.ui_u_MATERIAL_ID.setValue(record.data.MATERIAL_ID.toString());
        App.ui_u_PLAN_DATE.setValue(record.data.PLAN_DATE);
        App.ui_u_PLAN_SHIFT_NAME.setValue(record.data.SHIFT_NAME.toString());
    }
}

var get_PLAN_DETAIL_ID_TriggerField = function (field, trigger, index) {//接班查询
    App.McUI_SearchBox_SearchBoxHppPlanDetail_Window.show();
}

Ext.create("Ext.window.Window", {//半制品计划查询带回窗体
    id: "McUI_SearchBox_SearchBoxHppPlanDetail_Window",
    height: 460,
    hidden: true,
    width: 560,
    html: "<iframe src='../../McUI/SearchBox/SearchBoxHppPlanDetail.aspx' width=100% height=100% scrolling=no  frameborder=0></iframe>",
    bodyStyle: "background-color: #fff;",
    closable: true,
    title: "请选择半制品计划",
    modal: true
})

//------------查询带回弹出框--END 
