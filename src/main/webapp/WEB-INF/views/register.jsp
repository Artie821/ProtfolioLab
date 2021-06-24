<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="header.jsp" %>

<div class="slogan container container--90">
    <div class="slogan--item">
        <h1>
            <section class="login-page">
                <h2 style="height: 80px">Załóż konto</h2>
                <form:form method="post" modelAttribute="userEntity">
                    <div class="form-group" method="post">
                        <c:if test="${login}">
                            <div style="color: red; font-size: 20px">
                                Taki login już istnieje, wybierz inny!
                            </div>
                        </c:if>
                        <c:if test="${email}">
                            <div style="color: red; font-size: 20px">
                                Taki email już istnieje, wybierz inny!
                            </div>
                        </c:if>
                        <form:errors path="username" class="text-danger" cssClass="error" element="div" cssStyle="font-size: 10px; height: 15px;"/>
                        <form:input path="username" class="form-control" placeholder="Podaj login"/>
                        <div></div>
                        <form:errors path="password" class="text-danger" cssClass="error" element="div" cssStyle="font-size: 10px; height: 15px;"/>
                        <form:password path="password" class="form-control" placeholder="Podaj hasło"/>
                        <div></div>
                        <form:errors path="email" class="text-danger" cssClass="error" element="div" cssStyle="font-size: 10px; height: 15px;"/>
                        <form:input path="email" class="form-control" placeholder="Podaj email"/>
                    </div>
                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                    <div class="form-group form-group--buttons">
                        <button type="button" class="btn btn--without-border">
                            <a href="/login" style="color:inherit" > Zaloguj się </a>
                        </button>
                        <button class="btn" type="submit">Załóż konto</button>
                    </div>
                </form:form>
            </section>
        </h1>
    </div>
</div>
</header>

<section class="login-page">
</section>

<%@ include file="footer.jsp" %>
