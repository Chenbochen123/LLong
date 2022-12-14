

Ext.create("Ext.window.Window", {
    id: "Manager_BasicInfo_CommonPage_QueryPmtRecipe_Window",
    hidden: true,
    width: 360,
    height: 470,
    html: "<iframe src='../../BasicInfo/CommonPage/QueryPmtRecipe.aspx' width=100% height=100% scrolling=no  frameborder=0></iframe>",
    bodyStyle: "background-color: #fff;",
    closable: true,
    title: "请选择工艺配方",
    modal: true
})

var Manager_BasicInfo_CommonPage_QueryPmtRecipe_Request = function (record) {
    App.txtPmtRecipe.getTrigger(0).show();
    App.hiddenPmtRecipeID.setValue(record.data.ObjID);
    App.txtPmtRecipe.setValue(record.data.MaterialName);
}

var QueryPmtRecipeWindowShow = function () {
    var equipName = App.txtEquipName.getValue();
    if (equipName.length == 0) {
        Ext.Msg.alert('提示', "请选择机台");
        return;
    }
    var window = App.Manager_BasicInfo_CommonPage_QueryPmtRecipe_Window;
    var html = "<iframe src='../../BasicInfo/CommonPage/QueryPmtRecipe.aspx?EquipName=" + equipName + "' width=100% height=100% scrolling=no  frameborder=0></iframe>";
    if (window.getBody()) {
        window.getBody().update(html);
    } else {
        window.html = html;
    }
    window.show();
}

var QueryPmtRecipeInfo = function (field, trigger, index) {
    switch (index) {
        case 0:
            field.getTrigger(0).hide();
            field.setValue('');
            App.hiddenPmtRecipeID.setValue('');
            field.getEl().down('input.x-form-text').setStyle('background', "white");
            break;
        case 1:
            QueryPmtRecipeWindowShow();
            break;
    }
}

    Ext.create("Ext.window.Window", {
        id: "McUI_SearchBox_SearchBoxSbeEquip_Window",
        hidden: true,
        width: 370,
        height: 470,
        html: "<iframe src='../../../McUI/SearchBox/SearchBoxSbeEquip.aspx' width=100% height=100% scrolling=no  frameborder=0></iframe>",
        bodyStyle: "background-color: #fff;",
        closable: true,
        title: "请选择机台",
        modal: true
    })

var McUI_SearchBox_SearchBoxSbeEquip_Request = function (record) {
    App.txtEquipName.getTrigger(0).show();
    App.hiddenEquipId.setValue(record.data.OBJID);
    App.txtEquipName.setValue(record.data.EQUIP_NAME);
}
var QueryEquipInfo = function (field, trigger, index) {
    switch (index) {
        case 0:
            field.getTrigger(0).hide();
            field.setValue('');
            App.hiddenEquipId.setValue('');
            field.getEl().down('input.x-form-text').setStyle('background', "white");
            break;
        case 1:
            App.McUI_SearchBox_SearchBoxSbeEquip_Window.show();
            break;
    }
}

var McUI_SearchBox_SearchBoxSbmMaterial_Window_Create = function (majorTypeId) {
    Ext.create("Ext.window.Window", {
        id: "McUI_SearchBox_SearchBoxSbmMaterial_Window",
        hidden: true,
        width: 370,
        height: 470,
        html: "<iframe src='../../../McUI/SearchBox/SearchBoxSbmMaterial.aspx?MAJOR_TYPE_ID=" + majorTypeId + "' width=100% height=100% scrolling=no  frameborder=0></iframe>",
        bodyStyle: "background-color: #fff;",
        closable: true,
        title: "请选择物料",
        modal: true
    })
};

var McUI_SearchBox_SearchBoxSbmMaterial_Request = function (record) {
    App.txtMaterialName.getTrigger(0).show();
    App.hiddenMaterialId.setValue(record.data.OBJID);
    App.txtMaterialName.setValue(record.data.MATERIAL_NAME);
}
var QueryMaterialInfo = function (field, trigger, index) {
    switch (index) {
        case 0:
            App.hiddenMaterialId.setValue('');
            field.getTrigger(0).hide();
            field.setValue('');
            field.getEl().down('input.x-form-text').setStyle('background', "white");
            break;
        case 1:
            var majorTypeId = App.hiddenMaterialMajorType.getValue();
            McUI_SearchBox_SearchBoxSbmMaterial_Window_Create(majorTypeId);
            App.McUI_SearchBox_SearchBoxSbmMaterial_Window.show();
            break;
    }
}

var ShowRptPmtLotInfo = function () {

    var barcode = App.txtShowBarcode.getValue();
    if ((!barcode) || (barcode.length == 0)) {
        Ext.Msg.alert('提示', "没有需要显示的车条码");
        return;
    }
    parent.addTab("id=RptPmtLotInfo", "车报表详细信息[" + barcode + "]", "ReportCenter/RptPmtLotInfo/RptPmtLotInfo.aspx?BarCode=" + barcode, true);

}



var showDetailWindow = function (barcode) {
    var url = "../Tracing/Tracing_forward/Search_Detail_forward.aspx?Barcode=" + barcode + "&Process=" + App.hiddenTargetProcessId.getValue();
    var tabid = "Tracing_forward_Search_Detail";
    var tabp = parent.App.mainTabPanel;
    var tab = tabp.getComponent("id=" + tabid);
    if (tab) {
        tab.close();
    }
    
    parent.addTab(tabid, "追溯明细信息（" + barcode + ")", url, true);
    
}

var mixPanelCellDblClick = function (grid, td, tdindex, record, tr, trindex, e, fn) {
  //  showDetailWindow(record.data.BARCODE);
}
var semisPanelCellDblClick = function (grid, td, tdindex, record, tr, trindex, e, fn) {
    showDetailWindow(record.data.CARD_NO);
}
var SemisHandler = function (grid, rowIndex, colIndex, actionItem, event, record, row) {
    // Ext.Msg.alert('Editing' + (record.get('done') ? ' completed task' : ''), record.get('task'));
    if (record.get('CARD_NO') == "此条码没有追溯信息！")
    {
        return;
    }
    showDetailWindow(record.get('CARD_NO'));
};
var moldingPanelCellDblClick = function (grid, td, tdindex, record, tr, trindex, e, fn) {
    showDetailWindow(record.data.成型号);
}
var curingPanelCellDblClick = function (grid, td, tdindex, record, tr, trindex, e, fn) {
    showDetailWindow(record.data.TYRE_NO);
}

var forwordSearch = function () {
    var barcode = App.gridPanelCenter.getSelectionModel().hasSelection() ? App.gridPanelCenter.getSelectionModel().getSelection()[0].data.ShelfBarcode : "";
    if ((!barcode) || (barcode.length == 0)) {
        Ext.Msg.alert('提示', "请选择一个车条码！");
        return;
    }
    showDetailWindow2(barcode);
}
var cbxBarcodeType_Change = function (item, newValue, oldValue) {

    App.direct.cbxBarcodeType_change(newValue, {
        success: function (result) {
        },

        failure: function (errorMsg) {
            Ext.Msg.alert('操作', errorMsg);
        }
    });
}
var LoadMixProduction = function () {
    //App.direct.LoadMixProduction({
    //    failure: function (errorMsg) {
    //        Ext.Msg.alert('Failure', errorMsg);
    //    }
    //});

    //return false;
};
var LoadSemisProduction = function () {
    App.direct.LoadSemisProduction({
        failure: function (errorMsg) {
            Ext.Msg.alert('Failure', errorMsg);
        }
    });

    return false;
};
var LoadMoldingProduction = function () {
    App.direct.LoadMoldingProduction({
        failure: function (errorMsg) {
            Ext.Msg.alert('Failure', errorMsg);
        }
    });

    //return false;
};
var LoadCuringProduction = function () {
    App.direct.LoadCuringProduction({
        failure: function (errorMsg) {
            //Ext.Msg.alert('Failure', errorMsg);
        }
    });

    return false;
};

var GetMoldingData = function () {
        var arr = new Array();
        var store = App.moldingStore;
        if (store.type == "store") {
            Ext.each(store.data.items, function (record) {
                arr.push(record.data);
            });
        }
        var str = Ext.encode(arr);
        App.direct.GetDataTable('41',str);
}
var SemisNodeLoad = function (store, operation, options) {
    var node = operation.node;

    App.direct.NodeLoad(node.getId(), {
        success: function (result) {
            node.set('loading', false);
            node.set('loaded', true);
            for (var i = 0; i < result.children.length; i++) {
                var data = result.children[i];
                node.appendChild(data, undefined, true);
            }
            node.expand();
        },

        failure: function (errorMsg) {
            Ext.Msg.alert('Failure', errorMsg);
        }
    });

    return false;
}

var semisCheckChange = function (node,checked,record) {
    debugger;
    var cardNo = record.data.CARD_NO;
    var selected = record.data.done;
    if(selected)
    {
        App.direct.SetSemisTrackBarcode(cardNo,0);
    }
    else
    {
        App.direct.SetSemisTrackBarcode(cardNo, 1);
    }
}