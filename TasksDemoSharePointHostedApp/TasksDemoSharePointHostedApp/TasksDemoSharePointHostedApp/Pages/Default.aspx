<%-- The following 4 lines are ASP.NET directives needed when using SharePoint components --%>

<%@ Page Inherits="Microsoft.SharePoint.WebPartPages.WebPartPage, Microsoft.SharePoint, Version=15.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" MasterPageFile="~masterurl/default.master" Language="C#" %>

<%@ Register TagPrefix="Utilities" Namespace="Microsoft.SharePoint.Utilities" Assembly="Microsoft.SharePoint, Version=15.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<%@ Register TagPrefix="WebPartPages" Namespace="Microsoft.SharePoint.WebPartPages" Assembly="Microsoft.SharePoint, Version=15.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<%@ Register TagPrefix="SharePoint" Namespace="Microsoft.SharePoint.WebControls" Assembly="Microsoft.SharePoint, Version=15.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>

<%-- The markup and script in the following Content element will be placed in the <head> of the page --%>
<asp:Content ContentPlaceHolderID="PlaceHolderAdditionalPageHead" runat="server">
    <script type="text/javascript" src="../Scripts/jquery-2.1.4.min.js"></script>
    <script type="text/javascript" src="../Scripts/angular.min.js"></script>
    <script type="text/javascript" src="../Scripts/bootstrap.min.js"></script>
    <script type="text/javascript" src="../Scripts/ui-bootstrap-tpls-0.13.0.min.js"></script>
    <script type="text/javascript" src="../Scripts/moment.min.js"></script>

    <meta name="WebPartPageExpansion" content="full" />

    <!-- Custom CSS -->
    <link rel="stylesheet" type="text/css" href="../Content/bootstrap.min.css" />
    <link rel="stylesheet" type="text/css" href="../Content/bootstrap-theme.min.css" />
    <link rel="Stylesheet" type="text/css" href="../Content/App.css" />
    <!-- My App's JavaScript -->
    <script type="text/javascript" src="../Scripts/App.js"></script>
    <script type="text/javascript" src="../Scripts/Services/SharePointService.js"></script>
    <script type="text/javascript" src="../Scripts/Controller/InlineController.js"></script>
    <script type="text/javascript" src="../Scripts/Controller/PostponeController.js"></script>
    <script type="text/javascript" src="../Scripts/Controller/TodoController.js"></script>
</asp:Content>

<%-- The markup in the following Content element will be placed in the TitleArea of the page --%>
<asp:Content ContentPlaceHolderID="PlaceHolderPageTitleInTitleArea" runat="server">
    Quick Tasks Demo App
</asp:Content>

<%-- The markup and script in the following Content element will be placed in the <body> of the page --%>
<asp:Content ContentPlaceHolderID="PlaceHolderMain" runat="server">
    <%-- Scripts needed for SharePoint people picker elements --%>
    <SharePoint:ScriptLink name="clienttemplates.js" runat="server" LoadAfterUI="true" Localizable="false" />
    <SharePoint:ScriptLink name="clientforms.js" runat="server" LoadAfterUI="true" Localizable="false" />
    <SharePoint:ScriptLink name="clientpeoplepicker.js" runat="server" LoadAfterUI="true" Localizable="false" />
    <SharePoint:ScriptLink name="autofill.js" runat="server" LoadAfterUI="true" Localizable="false" />
    <SharePoint:ScriptLink name="sp.RequestExecutor.js" runat="server" LoadAfterUI="true" Localizable="false" />
    <SharePoint:ScriptLink name="sp.js" runat="server" LoadAfterUI="true" Localizable="false" />
    <SharePoint:ScriptLink name="SP.UserProfiles.js" runat="server" LoadAfterUI="true" Localizable="false" />
    <SharePoint:ScriptLink name="sp.runtime.js" runat="server" LoadAfterUI="true" Localizable="false" />
    <SharePoint:ScriptLink name="sp.core.js" runat="server" LoadAfterUI="true" Localizable="false" />
    <br/>
    <div class="container" data-ng-app="myApp">
        <div data-ng-controller="TodoCtrl">
            <div class="row"></div>
            <div class="row">
                <div class="col-md-4">
                    <strong>Task Count: </strong><span>{{remaining()}} of {{todos.length}} remaining</span>
                </div>
                <div class="col-md-4">
                </div>
                <div class="col-md-4">
                    <input type="text" data-ng-model="search" class="form-control search-query input-sm" placeholder="Search tasks">
                </div>
            </div>
            <div class="row">
                <div class="container todoRows">
                    <div class="row" data-ng-repeat="todo in todos | orderBy:'dueDate' | filter:search" inline-edit="todo"></div>
                </div>
            </div>
            <div class="row">
                <div class="col-md-12">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            <strong>New Task</strong>
                        </div>
                        <div class="panel-body">
                            <div class="form-horizontal" role="form">
                                <div class="form-group">
                                    <label class="control-label col-sm-2" for="TaskTitle">Title:</label>
                                    <div class="col-sm-6">
                                        <input type="text" id="TaskTitle" class="form-control" data-ng-model="todoText" data-ng-required="true" placeholder="Task Title" />
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="control-label col-sm-2" for="DueDate">Due Date:</label>
                                    <div class="col-sm-6">
                                        <div class="input-group">
                                            <input type="text" id="DueDate" class="form-control" datepicker-popup="{{format}}" ng-model="dt" is-open="opened" min-date="minDate" max-date="'2016-06-22'" datepicker-options="dateOptions" date-disabled="disabled(date, mode)" data-ng-required="true" close-text="Close" />
                                            <span class="input-group-btn">
                                                <a href="#" class="btn btn-default" data-ng-click="open($event)"><i class="glyphicon glyphicon-calendar"></i></a>
                                            </span>
                                        </div>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <div class="col-sm-2"></div>
                                    <div class="col-sm-6">
                                        <input class="btn-primary btn-sm active" type="submit" value="Add Task" data-ng-click="addTask($event)" />
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
