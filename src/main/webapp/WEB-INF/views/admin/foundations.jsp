<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<html>
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <meta http-equiv="X-UA-Compatible" content="ie=edge"/>
    <title>Document</title>
    <link rel="stylesheet" href="../resources/css/style.css"/>
</head>
<body>
<header class="header--form-page">
    <nav class="container container--70">
        <ul class="nav--actions">

            Witaj ${username}
            <sec:authorize access="isAuthenticated()">
                <form id="myForm" action="<c:url value="/perform_logout"/>" method="post">
                    <a href="#" onclick="document.getElementById('myForm').submit();" class="btn btn-outline-danger" style="padding-left: 10px; margin-left: 10px ">Wyloguj</a>
                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                </form>
            </sec:authorize>

        </ul>

        <ul>
            <li><a href="/admin/" class="btn btn--without-border btn--large" >Zarządzaj użytkownikami</a></li>
            <li><a href="/admin/admins" class="btn btn--without-border btn--large">Zarządzaj administratorami</a></li>
            <li><a href="/admin/foundations" class="btn btn-success btn--without-border active btn--large">Zarządzaj fundacjami</a></li>
        </ul>
    </nav>
    <%@ page contentType="text/html;charset=UTF-8" language="java" %>

    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
        <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/v/bs4/dt-1.10.24/datatables.min.css"/>
        <script type="text/javascript" src="https://cdn.datatables.net/v/bs4/dt-1.10.24/datatables.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/tether/1.4.0/js/tether.min.js"
                integrity="sha384-DztdAPBWPRXSA/3eYEEUWrWCy7G5KFbe8fFjk5JAIxUYHKkDx6Qin1DkWx51bBrb"
                crossorigin="anonymous"></script>
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    </head>
    <body>
    <div class="container p-3 my-3 border shadow p-1 mb-1 bg-white rounded" style="width: 100%">
        <c:if test="${param.success}">
            <div class="alert alert-success alert-dismissable">
                <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
                Gratulacje zmiany zostały zapisane!
            </div>
        </c:if>
        <table id="table" class="display table table-striped" style="width:100%">
            <thead class="thead-dark" >
            <tr>
                <th>ID</th>
                <th>NAME</th>
                <th>DESCRIPTION</th>
                <th>AKCJA</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach items="${institution}" var="institution">
                <tr>
                    <td><c:out value="${institution.id}"/></td>
                    <td><c:out value="${institution.name}"/></td>
                    <td><c:out value="${institution.description}"/>
                        <c:if test="${institution.enabled == false}">
                        <span class="badge badge-warning">Instytucja zablokowan/ jeśli chcesz przywrócić kliknij odblokuj </span>
                        </c:if>
                    </td>
                    <td>
                        <c:if test="${institution.enabled==true}">
                            <button type="button" class="btn btn-outline-danger btn-sm" data-toggle="modal"
                                    data-target="#institutionDelete" data-name="${institution.id}">
                                USUŃ
                            </button>
                        </c:if>
                        <c:if test="${institution.enabled==false}">
                            <button type="button" class="btn btn-outline-warning btn-sm" data-toggle="modal"
                                    data-target="#institutionUnblock" data-name="${institution.id}">
                                ODBLOKUJ
                            </button>
                        </c:if>
                        <a href="/admin/Fedit/${institution.id}" class="btn btn-outline-success btn-sm">EDYTUJ</a></td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
        <!-- Modal -->
        <div class="modal fade" id="institutionDelete" tabindex="-1" aria-labelledby="exampleModalLabel"
             aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="exampleModalLabel">Potwierdzenie usunięcia</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Zamknij">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <p> Uwaga!!!</p>
                        <p> Po kliknięciu usuń fundacja staje się niewidoczna dla użytkowników ale pozostaje w bazie danych.</p>
                        <p> Każdą usuniętą fundacje można odblokować.</p>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-outline-secondary" data-dismiss="modal">Anuluj</button>
                        <a href="" type="button" class="btn btn-outline-danger" id="btnname" >Usuń</a>
                    </div>
                </div>
            </div>
        </div>
        <!-- Modal -->
        <div class="modal fade" id="institutionUnblock" tabindex="-1" aria-labelledby="exampleModalLabel"
             aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="exampleModalLabel1">Potwierdzenie odblokowania</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Zamknij">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <p> Uwaga!!!</p>
                        <p> Po kliknięciu odblokuj fundacja staje się widoczna dla użytkowników!</p>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-outline-secondary" data-dismiss="modal">Anuluj</button>
                        <a href="" type="button" class="btn btn-outline-warning" id="btnname2" >Odblokuj</a>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="row">
        <div class="container p-3 my-3 border shadow p-1 mb-1 bg-white rounded">
            <a href="/admin/registerF" style="float:left" class="btn btn-success" >Dodaj fundację</a>
        </div>
    </div>
</header>
<script src="/resources/js/app.js" type="text/javascript"></script>
</body>
</html>
