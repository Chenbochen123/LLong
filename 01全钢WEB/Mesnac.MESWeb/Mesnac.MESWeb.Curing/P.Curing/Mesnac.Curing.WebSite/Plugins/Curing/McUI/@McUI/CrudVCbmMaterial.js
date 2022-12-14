var winAddAfterRender = function () {
    App.ui_i_BRAND_ID.onChange = set_ui_i_MATERIAL_NAME;
    App.ui_i_SIZE_ID.onChange = set_ui_i_MATERIAL_NAME;
    App.ui_i_PLYRATING_ID.onChange = set_ui_i_MATERIAL_NAME;
    App.ui_i_PATTERN_ID.onChange = set_ui_i_MATERIAL_NAME;
    App.ui_i_LOAD_INDEX_ID.onChange = set_ui_i_MATERIAL_NAME;
    App.ui_i_SPEED_LEVEL_ID.onChange = set_ui_i_MATERIAL_NAME;
};

var set_ui_i_MATERIAL_NAME = function () {
    // 品牌 规格 层级 花纹 负荷指数速度级别
    var value = "";
    value = value + App.ui_i_BRAND_ID.getDisplayValue();
    value = value + " ";
    value = value + App.ui_i_SIZE_ID.getDisplayValue();
    value = value + " ";
    value = value + App.ui_i_PLYRATING_ID.getDisplayValue();
    value = value + " ";
    value = value + App.ui_i_PATTERN_ID.getDisplayValue();
    if (App.ui_i_LOAD_INDEX_ID.getDisplayValue() != "" || App.ui_i_SPEED_LEVEL_ID.getDisplayValue() != "")
    {
        value = value + " ";
        value = value + App.ui_i_LOAD_INDEX_ID.getDisplayValue();
        value = value + App.ui_i_SPEED_LEVEL_ID.getDisplayValue();
    }
    App.ui_i_MATERIAL_NAME.setValue(value);
};

var winUpdateAfterRender = function () {
    App.ui_u_BRAND_ID.onChange = set_ui_u_MATERIAL_NAME;
    App.ui_u_SIZE_ID.onChange = set_ui_u_MATERIAL_NAME;
    App.ui_u_PLYRATING_ID.onChange = set_ui_u_MATERIAL_NAME;
    App.ui_u_PATTERN_ID.onChange = set_ui_u_MATERIAL_NAME;
    App.ui_u_LOAD_INDEX_ID.onChange = set_ui_u_MATERIAL_NAME;
    App.ui_u_SPEED_LEVEL_ID.onChange = set_ui_u_MATERIAL_NAME;
};

var set_ui_u_MATERIAL_NAME = function () {
    // 品牌 规格 层级 花纹 负荷指数速度级别
    var value = "";
    value = value + App.ui_u_BRAND_ID.getDisplayValue();
    value = value + " ";
    value = value + App.ui_u_SIZE_ID.getDisplayValue();
    value = value + " ";
    value = value + App.ui_u_PLYRATING_ID.getDisplayValue();
    value = value + " ";
    value = value + App.ui_u_PATTERN_ID.getDisplayValue();
    if (App.ui_u_LOAD_INDEX_ID.getDisplayValue() != "" || App.ui_u_SPEED_LEVEL_ID.getDisplayValue() != "") {
        value = value + " ";
        value = value + App.ui_u_LOAD_INDEX_ID.getDisplayValue();
        value = value + App.ui_u_SPEED_LEVEL_ID.getDisplayValue();
    }
    App.ui_u_MATERIAL_NAME.setValue(value);
};

var viewportAfterRender = function () {
    App.ui_i_MAJOR_TYPE_ID.onChange = set_ui_i_MAJOR_TYPE_ID;
};

var set_ui_i_MAJOR_TYPE_ID = function () {
    if (App.ui_i_MAJOR_TYPE_ID.getStore().data.length > 0) {
        var majorTypeId = App.ui_i_MAJOR_TYPE_ID.getStore().data.items[0].data.field1;
        App.ui_i_MAJOR_TYPE_ID.setValue(majorTypeId);
    }
    else {
        App.ui_i_MAJOR_TYPE_ID.setValue('');
    }
};