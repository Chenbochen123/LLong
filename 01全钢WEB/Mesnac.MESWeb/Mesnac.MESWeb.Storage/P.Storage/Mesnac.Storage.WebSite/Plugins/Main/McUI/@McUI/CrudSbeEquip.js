Ext.create("Ext.Button", {// 打印按钮
    id: "btnPrint",
    tooltips: [
        {
            html: "打印硫化机左右模条码", xtype: "tooltip"
        }
    ],
    iconCls: "#PageExcel",
    text: "打印条码",
    handler: function () {
        if (App.gridPanelMain.getSelectionModel().getSelection().length == 0) {
            Ext.Msg.alert('提示', '请选择一条记录');
            return false;
        }

        var selection = App.gridPanelMain.getSelectionModel().getSelection()[0];
        EquipPrint_Window_Creat(selection.data.OBJID, selection.data.EQUIP_NAME);
        App.EquipPrint_Window.show();
        return true;
    },
});
var EquipPrint_Window_Creat = function (objId, equipName) {

    Ext.create("Ext.window.Window", {// 物料查询带回窗体
        id: "EquipPrint_Window",
        height: 460,
        hidden: true,
        width: 680,
        html: "<iframe src='../../PLUGINS/MAIN/BASEINFO/EQUIPPRINT.ASPX?OBJID=" + objId + "&EQUIP_NAME=" + equipName + "' width=100% height=100% scrolling=no  frameborder=0></iframe>",
        bodyStyle: "background-color: #fff;",
        closable: true,
        title: "设备条码打印",
        modal: true
    });
};

var viewportAfterRender = function () {
    App.ui_s_MAJOR_TYPE_ID.onChange = set_ui_s_MINOR_TYPE_ID;
    App.northToolbar.add(App.btnPrint);
};

var set_ui_s_MINOR_TYPE_ID = function (majorTypeId) {
    var ui_s_MINOR_TYPE_ID = App.ui_s_MINOR_TYPE_ID;
    ui_s_MINOR_TYPE_ID.setValue('');

    var minorStore = ui_s_MINOR_TYPE_ID.getStore();
    minorStore.filterBy(function (record) {
        if (majorTypeId == null || majorTypeId == '')
        {
            return true;
        }
        return record.getData().field1.substr(0, 2) == majorTypeId;
    });
};

var winAddAfterRender = function () {
    App.ui_i_MAJOR_TYPE_ID.onChange = set_ui_i_MINOR_TYPE_ID;
};

var set_ui_i_MINOR_TYPE_ID = function (majorTypeId) {
    var ui_i_MINOR_TYPE_ID = App.ui_i_MINOR_TYPE_ID;
    ui_i_MINOR_TYPE_ID.setValue('');

    var minorStore = App.ui_i_MINOR_TYPE_ID.getStore();
    minorStore.filterBy(function (record) {
        if (majorTypeId == null || majorTypeId == '') {
            return true;
        }
        return record.getData().field1.substr(0, 2) == majorTypeId;
    });
};

var winUpdateAfterRender = function () {
    App.ui_u_MAJOR_TYPE_ID.onChange = set_ui_u_MINOR_TYPE_ID;
};

var set_ui_u_MINOR_TYPE_ID = function (majorTypeId) {
    var ui_u_MINOR_TYPE_ID = App.ui_u_MINOR_TYPE_ID;
    ui_u_MINOR_TYPE_ID.setValue('');

    var minorStore = App.ui_u_MINOR_TYPE_ID.getStore();
    minorStore.filterBy(function (record) {
        if (majorTypeId == null || majorTypeId == '') {
            return true;
        }
        return record.getData().field1.substr(0, 2) == majorTypeId;
    });
};



