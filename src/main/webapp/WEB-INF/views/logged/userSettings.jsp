<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ include file="header.jsp" %>

<div class="slogan container container--90">
    <div class="slogan--item">
        <h1>
            <section>
                <h2 style="height: 80px;">Edycja danych użytkownika:</h2>
                <c:if test="${param.userExist}">
                    <div style="color: red; font-size: 20px">NIESTETY TAKI UŻYTKOWNIK JUŻ ISTNIEJE!</div>
                </c:if>
                <c:if test="${param.wrongPassword}">
                    <div style="color: red; font-size: 20px">PODANO NIEPRAWIDłOWE HASłO! DANE NIE ZOSTAłY ZMIENIONE!</div>
                </c:if>
                <c:if test="${param.success}">
                    <div style="color: green; font-size: 20px">ZAPISANO NOWE DANE UŻYTKOWNIKA!</div>
                </c:if>
                <form:form method="post" modelAttribute="userEntity" action="/logged/userSettings">
                    <div class="form-group" method="post">
                        <div style="display: inline-block;margin: 0px; border-width: 0px; padding: 0px; offset: 0px; font-size: 20px">
                            Nazwa użytkownika:<br></div>
                        <br>
                        <form:input path="username" class="form-control" placeholder="Podaj login"/><br>
                        <form:errors path="username" class="text-danger"
                                     cssStyle="color:red; display: inline-block; margin: -20px; border-width: 0px; padding: -10px; offset: 0px; font-size: 10px;"/>
                        <div></div>
                        <div style="display: inline-block;margin: 0px; border-width: 0px; padding: 0px; offset: 0px; font-size: 20px">
                            Email użytkownika:<br></div>
                        <br>
                        <form:input path="email" class="form-control" placeholder="Podaj email"/><br>
                        <div>
                            <form:errors path="email" class="text-danger"
                                         cssStyle="color:red; display: inline-block; margin: -20px; border-width: 0px; padding: -10px; offset: 0px; font-size: 10px;"/>
                        </div>
                        <div></div>
                        <div style="display: inline-block;margin: -10px; border-width: 0px; padding: -15px; offset: 0px; font-size: 20px">
                            Hasło użytkownika:<br></div>
                        <br>
                        <div style="display: inline-block;margin: -10px; border-width: 0px; padding: -20px; offset: 0px; font-size: 10px">
                            Aby zmienić dane podaj hasło użytkownika:
                        </div>
                        <br>
                        <form:password path="password" class="form-control" placeholder="Podaj hasło"/><br>
                        <form:errors path="password" class="text-danger"
                                     cssStyle="color:red; display: inline-block; margin: -20px; border-width: 0px; padding: -10px; offset: 0px; font-size: 10px;"/>
                    </div>
                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                    <div class="form-group form-group--buttons">
                        <button class="btn" type="submit">Zapisz</button>
                        <button type="button" class="btn">
                            <a href="/logged/changePassword" style="color:inherit"> Zmień hasło </a>
                        </button>
                    </div>
                </form:form>
            </section>
        </h1>
    </div>
</div>

<%@ include file="footer.jsp" %>