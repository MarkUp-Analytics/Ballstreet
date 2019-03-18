var commonController = {};
commonController.buildImageURL = function(req, relativeUrl){
        return req.protocol + "://" + req.headers.host + '/' + relativeUrl;
    };

module.exports = commonController;
