angular
    .module('app', ['ngUIWebView'])
    .controller('MyController', function (UIWebView) {

        var self = this;
        self.data = {};

        var error = function (error) {

            alert(error.message);
        };

        self.save = function (form) {

            UIWebView
                .send('save', self.data)
                .then(function () {

                    form.$setPristine();
                })
                .catch(error);
        };

        self.load = function () {

            UIWebView
                .send('load')
                .then(function (data) {

                    angular.extend(self.data, data);
                })
                .catch(error);
        };

        self.notify = function () {

            UIWebView
                .send('notify')
                .catch(error);
        };
    });