<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="header.jsp" %>

<div class="slogan container container--90">
    <div class="slogan--item">
        <h1>
            <section class="login-page">
                <h2 style="height: 80px">RESETOWANIE HASłA</h2>
                <form class="form-signin" method="post">
                    <div class="form-group">
                        <c:if test="${param.success}">
                            <div style="color: green; font-size: 20px">
                                Email z linkiem został wyslany!
                            </div>
                            <div style="color: green; font-size: 20px">
                                Aby utworzyć nowe hasło sprawdź swoją skrzynkę email!
                            </div>
                        </c:if>
                        <c:if test="${param.missingEmail}">
                            <div style="color: red; font-size: 20px">
                                Niestety nie ma takiego adresu email w bazie!
                            </div>
                        </c:if>

                            <div style="color: grey; font-size: 16px">
                                Aby zresetować hasło podaj adres email użyty do rejestracji konta.
                            </div>

                        <input type="email" id="email" placeholder="Adres email" required autofocus name="email"/>
                        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                        <br>
                        <button class="btn" type="submit" style="align-self: center">WYSLIJ LINK RESETUJĄCY</button>
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
