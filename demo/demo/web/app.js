angular
    .module('app', ['ngUIWebView'])
    .controller('MyController', function (UIWebView) {

        var self = this;
        self.data = {};

        self.save = function (form) {

            UIWebView
                .send('save', self.data)
                .then(function () {

                    form.$setPristine();
                })
                .catch(function (error) {

                    alert('error...');
                });
        };

        self.load = function () {

            UIWebView
                .send('load')
                .then(function (data) {

                    angular.extend(self.data, data);
                })
                .catch(function (error) {

                    alert('error...');
                });
        };

        self.notify = function () {

            UIWebView
                .send('notify')
                .catch(function (error) {

                    alert('error...');
                });
        };
    });