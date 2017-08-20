var exec = require('cordova/exec');

var TongDun = {
    getSignature: function(success, error) {
        exec(success, error, "TongDun", "getSignature", []);
    }
}


module.exports = TongDun;
