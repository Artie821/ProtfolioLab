<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<html>
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <meta http-equiv="X-UA-Compatible" content="ie=edge"/>
    <title>Document</title>
    <link rel="stylesheet" href="/resources/css/style.css"/>
</head>
<body>
<header>
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
            <li><a href="/logged/form#form--steps" class="btn btn--without-border active"
                   onclick='refreshPage()'>Start</a></li>
            <li><a href="/logged/dashboard#steps" class="btn btn--without-border">O co chodzi?</a></li>
            <li><a href="/logged/dashboard#about-us" class="btn btn--without-border">O nas</a></li>
            <li><a href="/logged/dashboard#help" class="btn btn--without-border">Fundacje i organizacje</a></li>
            <li><a href="/logged/dashboard#contact" class="btn btn--without-border">Kontakt</a></li>
        </ul>
        <script type="text/javascript">
            function refreshPage() {
                location.reload();
            }
        </script>
    </nav>
</header>
<section class="help" id="help">
    <h2>Moje zbiórki:</h2>
    <div>
        <table>
            <thead style="border-top: 1px solid #ddd;">
            <tr>
                <th style="padding: 15px;
  text-align: left;border-bottom: 1px solid #ddd; ">
                    Data utworzenia:
                </th>
                <th style="padding: 15px;
  text-align: left;border-bottom: 1px solid #ddd; ">
                    Status:
                </th>
                <th style="padding: 15px;
  text-align: left; border-bottom: 1px solid #ddd;">
                    Data przekazania:
                </th>
                <th style="padding: 15px;
  text-align: left; border-bottom: 1px solid #ddd;">
                    Organizacja:
                </th>
                <th style="padding: 15px;
  text-align: left; border-bottom: 1px solid #ddd;">
                    Ilość przekazanych worków:
                </th>
                <th style="padding: 15px;
  text-align: left; border-bottom: 1px solid #ddd;">
                    Akcja:
                </th>
            </tr>
            </thead>
            <tbody>
            <c:forEach items="${donations}" var="donation">
                <tr>
                    <td style="padding: 15px;
  text-align: left;border-bottom: 1px solid #ddd; ">
                            ${donation.createdDate}
                    </td>
                    <td style="padding: 15px;
  text-align: left; border-bottom: 1px solid #ddd;">

                        <c:if test="${donation.status=='NIEODEBRANE'}">
                            <p style="color: red">${donation.status}</p>
                        </c:if>
                        <c:if test="${donation.status=='ODEBRANE'}">
                            <p style="color: green">${donation.status}</p>
                        </c:if>
                        <c:if test="${donation.status=='ANULOWANA'}">
                            ANULOWANO TRANZAKCJĘ
                        </c:if>
                    </td>
                    <td style="padding: 15px;
  text-align: left; border-bottom: 1px solid #ddd;">
                        <c:if test="${donation.status=='NIEODEBRANE'}">
                            Jeszcze nie przekazano
                        </c:if>
                        <c:if test="${donation.status=='ANULOWANA'}">
                            ----------
                        </c:if>
                            ${donation.statusChangeDate}
                    </td>
                    <td style="padding: 15px;
  text-align: left; border-bottom: 1px solid #ddd;">
                            ${donation.institution.name}
                    </td>
                    <td style="padding: 15px;
  text-align: left; border-bottom: 1px solid #ddd;">
                        <c:if test="${donation.quantity==1}">
                            ${donation.quantity} worek 60 litrów.
                        </c:if>
                        <c:if test="${donation.quantity>1 && donation.quantity<=4}">
                            ${donation.quantity} worki 60 litrów.
                        </c:if>
                        <c:if test="${donation.quantity>=5}">
                            ${donation.quantity} worków 60 litrów.
                        </c:if>
                    </td>
                    <td style="padding: 15px;
  text-align: left; border-bottom: 1px solid #ddd;">

                        <button type="button" class="btn">
                            <a href="/logged/donationsDetails/${donation.id}" style="color:inherit"> SZCZEGÓłY </a>
                        </button>
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>
    <!-- SLIDE 1 -->
    <div class="help--slides active" data-id="1">

        <p>W sekcji szczegóły znajdziesz bardziej szczegółowe dane dotyczące każdej dotacji a także możliwość anulowania nieodebranej dotacji jak i odznaczenia już odebranych.</p>

    </div>

</section>
<%@ include file="footer.jsp" %>