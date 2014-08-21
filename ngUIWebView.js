angular
	.module('ngUIWebView', [])
	.factory('UIWebView', ['$q', '$document', function ($q, $document) {

	    var calls = {};
	    var count = 0;
	    var body  = $document.find('body');

	    var extract = function (id) {

	        var entry = calls[id];
	        entry.bridge.remove();
	        delete calls[id];

	        return entry;
	    };

	    var send = function (method, data) {

	        var deferred = $q.defer();
	        var bridge = angular
	            .element('<iframe style="display:none;"/>');

	        data = angular.extend({}, data);

	        body.append(bridge);
	        calls[count] = {
	            request : {
	                method: method,
	                data  : data
	            },
	            response: deferred,
	            bridge  : bridge
	        };

	        bridge.attr('src', 'nguiwv://' + count);
	        count++;

	        return deferred.promise;
	    };

	    var request = function (id) {

	        return JSON.stringify(calls[id].request);
	    };

	    var response = function (id, data) {

	        extract(id)
	            .response
	            .resolve(data ? JSON.parse(data) : null);
	    };

	    var error = function (id, message) {

	        var entry  = extract(id);
	        var method = entry.request.method;

	        entry
	            .response
	            .reject(new Error(message));
	    };

	    window.nguiwv = {
	        request : request,
	        response: response,
	        error   : error
	    };

	    return {
	        send: send
	    };
	}]);