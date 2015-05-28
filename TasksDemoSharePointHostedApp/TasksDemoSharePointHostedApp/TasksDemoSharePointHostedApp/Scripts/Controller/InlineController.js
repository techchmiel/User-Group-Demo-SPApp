myApp.directive('inlineEdit', ['$timeout', '$compile', '$http', '$templateCache', 'SharePointJSOMService', function ($timeout, $compile, $http, $templateCache, SharePointJSOMService) {
    return {
        scope: {
            todo: '=inlineEdit',
            handleSave: '&onSave',
            handleCancel: '&onCancel'
        },
        compile: function compile(tElement, tAttrs) {
            JSRequest.EnsureSetup();
            var tplUrl = '../Scripts/Controller/InlineTemplate.html';
            templateLoader = $http.get(tplUrl, { cache: $templateCache })
                .success(function (html) {
                    tElement.html(html);
                });
            return {
                //have to return link: here because when using compile: ignores link: in directive
                pre: function preLink(scope, iElement, iAttrs, controller) {
                    //this is required to load the template HTML as using compile
                    templateLoader.then(function (templateText) {
                        iElement.html($compile(tElement.html())(scope));
                    });

                    var previousValue;

                    scope.edit = function () {
                        scope.editMode = true;
                        previousValue = scope.todo;
                        initializePeoplePicker('peoplePickerDiv' + scope.todo.id, scope.todo.assignedTo, scope.todo.assignedToName);
                    };
                    scope.save = function () {
                        $.when(SharePointJSOMService.saveTask(scope, TaskListName))
                        .done(function (jsonObject) {
                        })
                        .fail(function (err) {
                            console.info(JSON.stringify(err));
                        });
                        scope.editMode = false;
                        scope.handleSave({ value: scope.todo });
                    };
                    scope.delete = function () {
                        $.when(SharePointJSOMService.deleteTask(scope, TaskListName))
                        .done(function (jsonObject) {
                        })
                        .fail(function (err) {
                            console.info(JSON.stringify(err));
                        });
                        scope.isDeleted = true;
                        scope.handleSave({ value: scope.todo });
                    };
                    scope.cancel = function () {
                        scope.editMode = false;
                        scope.todo = previousValue;
                        scope.handleCancel({ value: scope.todo });
                    };
                    scope.postpone = function (date) {
                        scope.editMode = false;
                        scope.todo.dueDate = date;

                        $.when(SharePointJSOMService.postponeTask(scope, TaskListName))
                        .done(function (jsonObject) {
                        })
                        .fail(function (err) {
                            console.info(JSON.stringify(err));
                        });

                        //$scope is not updating so force with this command
                        if (!$scope.$$phase) { $scope.$apply(); }
                        scope.handleSave({ value: scope.todo });
                    };
                }
            };
         }
    }
}]);