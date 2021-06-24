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
            <li class="logged-user">
                Witaj ${username}
                <sec:authorize access="isAuthenticated()">
                    <form id="myForm" action="<c:url value="/perform_logout"/>" method="post">
                        <ul class="dropdown">
                            <li><a href="/logged/userSettings">Profil</a></li>
                            <li><a href="/logged/donations/">Moje zbiórki</a></li>
                            <li>
                                <a href="#" onclick="document.getElementById('myForm').submit();">Wyloguj</a>
                                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                            </li>
                        </ul>
                    </form>
                </sec:authorize>
            </li>
        </ul>

        <ul>
            <li><a href="/logged/form#form--steps" class="btn btn--without-border active" onclick='refreshPage()'>Start</a></li>
            <li><a href="/logged/dashboard#steps" class="btn btn--without-border">O co chodzi?</a></li>
            <li><a href="/logged/dashboard#about-us" class="btn btn--without-border">O nas</a></li>
            <li><a href="/logged/dashboard#help" class="btn btn--without-border">Fundacje i organizacje</a></li>
            <li><a href="/logged/dashboard#contact" class="btn btn--without-border">Kontakt</a></li>
        </ul>
        <script type="text/javascript">
            function refreshPage(){
                    location.reload();
            }
        </script>
    </nav>