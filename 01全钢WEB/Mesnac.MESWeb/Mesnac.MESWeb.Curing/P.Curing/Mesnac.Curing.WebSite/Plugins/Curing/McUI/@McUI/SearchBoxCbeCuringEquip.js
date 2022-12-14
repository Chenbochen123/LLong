var viewportAfterRender = function () {
    var params = this.location.search.replace('?', '').split('&');
    var len = params.length;
    for (var index = 0; index < params.length; index++) {
        if (params[0].startsWith('MINOR_TYPE_ID')) {
            var minorTypeId = params[0].replace('MINOR_TYPE_ID=', '');
            if (minorTypeId != '')
            {
                App.ui_s_MINOR_TYPE_ID.readOnly = true;
                App.ui_s_MINOR_TYPE_ID.setValue(minorTypeId);
            }
        }
    }
};
