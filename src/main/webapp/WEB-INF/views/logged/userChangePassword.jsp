<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ include file="header.jsp" %>

<div class="slogan container container--90">
    <div class="slogan--item">
        <h1>
            <section class="login-page">
                <h2 style="height: 80px;">Edycja hasła użytkownika:</h2>
                <c:if test="${param.success}">
                    <div style="font-size: 15px; height: 20px; color: green">HASłO ZOSATAłO ZMIENIONE!</div>
                </c:if>
                <c:if test="${param.pattern}">
                    <div style="font-size: 15px; height: 20px; color: red">Hasło musi mieć conajmniej 8 zanków,</div>
                    <div style="font-size: 15px; height: 20px; color: red">jedną dużą literę,</div>
                    <div style="font-size: 15px; height: 20px; color: red">jedną liczbę,</div>
                    <div style="font-size: 15px; height: 20px; color: red">jednen znak specjalny!</div>
                </c:if>
                <c:if test="${param.notMatch}">
                    <div style="font-size: 15px; height: 20px; color: red">WPISANE HASłA NIE SĄ TAKIE SAME!</div>
                </c:if>
                <c:if test="${param.invalidOld}">
                    <div style="font-size: 15px; height: 20px; color: red">Wpisano niepoprawne stare hasło!</div>
                </c:if>
                <form method="post" modelAttribute="user" action="/logged/changePassword">
                    <div class="form-group" method="post">
                        <div style="font-size: 20px; height: 25px;">Stare hasło użytkownika:<br></div>
                        <div style="font-size: 10px; height: 35px;">Aby zmienić hasło podaj stare hasło użytkownika:<br></div>
                        <input type="password"  class="form-control" placeholder="Podaj stare hasło" name="oldpass"/>
                        <div></div>
                        <div style="font-size: 20px">Nowe hasło użytkownika:<br></div>
                        <input type="password" class="form-control" placeholder="Podaj nowe hasło" name="newpass"/>
                        <div style="height: 20px;"></div>
                        <input type="password" class="form-control" placeholder="Powtórz nowe hasło" name="newpassConfirm"/>
                    </div>
                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                    <div class="form-group form-group--buttons">
                        <button type="button" class="btn">
                            <a href="/logged/userSettings" style="color:inherit" > Powrót </a>
                        </button>
                        <button class="btn" type="submit">Zmień hasło</button>
                    </div>
                </form>
            </section>
        </h1>
    </div>
</div>

<%@ include file="footer.jsp" %>