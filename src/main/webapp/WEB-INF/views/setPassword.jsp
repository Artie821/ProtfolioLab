<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="header.jsp" %>

<div class="slogan container container--90">
    <div class="slogan--item">
        <h1>
            <section class="login-page">
                <h2 style="height: 80px">WPISZ NOWE HASłO:</h2>
                <form class="form-signin" method="post" action="/savePassword">
                    <div class="form-group">
                        <c:if test="${param.notMatch}">
                            <div style="color: green; font-size: 20px">
                                Email z linkiem został wyslany!
                            </div>
                            <div style="color: green; font-size: 20px">
                                Aby utworzyć nowe hasło sprawdź swoją skrzynkę email!
                            </div>
                        </c:if>
                        <c:if test="${regex}">
                            <div style="color: red; font-size: 20px">
                                NIE PASUJE 8 zanków!
                            </div>
                        </c:if>
                        <c:if test="${match}">
                            <div style="color: red; font-size: 20px">
                                inne hasła!
                            </div>
                        </c:if>
                        <c:if test="${param.missingEmail}">
                            <div style="color: red; font-size: 20px">
                                Niestety nie ma takiego adresu email w bazie!
                            </div>
                        </c:if>
                        <input type="hidden" name="username" value="${user.username}">
                        <input type="hidden" name="email" value="${user.email}">
                        <input type="hidden" name="token" value="${token}">
                        <input type="password" id="password" placeholder="Wprowadź hasło" required autofocus name="password"/>
                        <br>
                        <input type="password" id="passconf" placeholder="Potwierdź hasło" required  name="passconf"/>
                        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                        <br>
                        <button class="btn" type="submit" style="align-self: center">Zatwierdź</button>
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
