var app = angular.module("resumeApp", []);

app.controller("resumeCtrl", function($scope, $http) {
	$http.get("data/profile.json")
		.then(function (req) {
			angular.extend($scope, req.data);
		})
		.catch(function (req) {
			alert("Error when loading the profile");
		});
});
