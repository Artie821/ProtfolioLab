<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="header.jsp" %>

<div class="slogan container container--90">
    <div class="slogan--item">
        <h1>
            <section class="login-page">
                <h2 style="height: 80px">Zaloguj się</h2>
                <form class="form-signin" method="post">
                    <div class="form-group">
                        <c:if test="${param.successToken}">
                            <div style="color: green; font-size: 20px">
                                Gratulacje! konto zostało aktywowane!
                            </div>
                            <div style="color: green; font-size: 20px">
                                Możesz się teraz zalogować!
                            </div>
                        </c:if>
                        <c:if test="${param.newPassword}">
                            <div style="color: green; font-size: 20px">
                                Gratulacje! Hasło zostało zmienione!
                            </div>
                            <div style="color: green; font-size: 20px">
                                Teraz możesz się zalogować!
                            </div>
                        </c:if>
                        <c:if test="${param.error}">
                            <div style="color: red; font-size: 20px">
                                Niestety takie konto nie istnieje w naszej bazie, <br> jest zablokowane, lub nie jest aktywowane!
                            </div>
                        </c:if>
                        <input type="text" id="username" placeholder="Nazwa użytkownika" required autofocus name="username" />
                    </div>
                    <div class="form-group">
                        <input type="password" id="password" placeholder="Hasło" required name="password" />
                        <br>
                        <button type="button" class="btn btn--small btn--without-border reset-password">
                            <a href="/passwordReset" style="color:inherit" > Przypomnij hasło </a>
                        </button>
                    </div>
                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                    <div class="form-group form-group--buttons">
                        <button type="button" class="btn btn--without-border">
                            <a href="/register" style="color:inherit" > Załóż konto </a>
                        </button>
                        <button class="btn" type="submit">Zaloguj się</button>
                    </div>
                </form>
            </section>
        </h1>
    </div>
</div>
</header>

<section class="login-page">
</section>

<%@ include file="footer.jsp" %>
