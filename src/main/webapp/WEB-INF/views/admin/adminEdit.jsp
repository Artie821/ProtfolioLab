<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<!DOCTYPE html>
<html lang="pl">

<body>
<header class="header--form-page">
    <nav class="container container--70">
        <ul class="nav--actions">

            Witaj ${username}
            <sec:authorize access="isAuthenticated()">
                <form id="myForm" action="<c:url value="/perform_logout"/>" method="post">
                    <a href="#" onclick="document.getElementById('myForm').submit();" class="btn btn-outline-danger"
                       style="padding-left: 10px; margin-left: 10px ">Wyloguj</a>
                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                </form>
            </sec:authorize>

        </ul>

        <ul>
            <li><a href="/admin/" class="btn btn--without-border btn--large" >Zarządzaj użytkownikami</a></li>
            <li><a href="/admin/admins" class="btn btn-success btn--without-border active btn--large">Zarządzaj administratorami </a></li>
            <li><a href="/admin/foundations" class="btn btn--without-border btn--large">Zarządzaj fundacjami</a></li>
        </ul>
    </nav>
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <link rel="stylesheet" href="/resources/css/style.css"/>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/tether/1.4.0/js/tether.min.js"
                integrity="sha384-DztdAPBWPRXSA/3eYEEUWrWCy7G5KFbe8fFjk5JAIxUYHKkDx6Qin1DkWx51bBrb"
                crossorigin="anonymous"></script>

        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    </head>
    <body>
    <div class="row">
        <div class="container p-3 my-3 border shadow p-1 mb-1 bg-white rounded">
            <h3 style="float:left"> Edytuj administratora: </h3>
            <a style="float:right" class="btn btn-outline-info" onclick="goBack()">Powrót</a>
            <c:if test="${param.exist}">
                <br>
                <br>
                <div class="alert alert-danger alert-dismissable">
                    <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
                    Użytkownik o takim loginie lub emailu już istnieje w bazie danych, zmiany nie zostały zachowane!
                </div>
            </c:if>
        </div>
    </div>

    <div class="container p-3 my-3 border shadow p-1 mb-1 bg-white rounded" style="width: 100%">
        <table id="table" class="display table table-striped" style="width:100%">
            <thead class="thead-dark">
            <tr>
                <th>EDYCJA ADMINISTRATORA ${admin.username}</th>
            </tr>
            </thead>
            <tbody>
            <form:form method="post" modelAttribute="admin" action="/admin/Aedit/">
                <tr>
                    <th>USERNAME:</th>
                </tr>
                <tr>
                    <td>
                        <form:input path="username" name="username" placeholder="${admin.username}" class="form-control"
                                    value="${admin.username}"/>
                    </td>
                </tr>
                <tr>
                    <th>EMAIL:</th>
                </tr>
                <tr>
                    <td>
                        <form:input path="email" name="email" placeholder="${admin.email}" class="form-control"
                                    value="${admin.email}"/>
                    </td>
                </tr>
                <tr>
                    <td>
                        <button type="submit" class="btn btn-primary">ZAPISZ</button>
                        <form:hidden path="id" name="id"  value="${admin.id}" />
                    </td>
                </tr>
            </form:form>
            </tbody>
        </table>
    </div>

</header>
<script src="/resources/js/app.js" type="text/javascript"></script>
</body>
</html>