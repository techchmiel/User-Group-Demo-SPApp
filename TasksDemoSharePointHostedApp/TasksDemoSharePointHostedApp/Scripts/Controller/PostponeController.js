myApp.controller('DropdownCtrl', ['$scope', function ($scope) {
    var d = moment();
    $scope.items = [
       { text: "Tomorrow", date: moment(d).add(1, 'd').format() },
       { text: "Tomorrow +1", date: moment(d).add(2, 'd').format() },
       { text: "Tomorrow +3", date: moment(d).add(3, 'd').format() },
       { text: "Next Monday", date: moment(d).day(8).format() },// next Monday,
       { text: "Next Friday", date: moment(d).day(12).format() },// next Friday,
       { text: "Two Weeks", date: moment(d).add(2, 'w').format() },// two weeks
       { text: "Three Weeks", date: moment(d).add(3, 'w').format() },// three weeks
       { text: "Four Weeks", date: moment(d).add(4, 'w').format() },// four weeks
       { text: "Forget about it (+ 6 months)", date: moment(d).add(6, 'M').format() },
       { text: "I'll make you an offer you can't refuse (+ 1 year)", date: moment(d).add(1, 'y').format() }
    ];
}]);