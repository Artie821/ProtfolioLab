<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<footer>
    <div class="contact" id="contact">
        <c:if test="${param.send}">
            <div style="font-size: 15px; height: 20px; color: green; align-self: center">
                Email został wysłany!
            </div>
        </c:if>
        <c:if test="${param.sendError}">
            <div style="font-size: 15px; height: 20px; color: red; align-self: center">
                Nie udało się wysłać wiadomości - spróbuj ponownie!
            </div>
        </c:if>
        <h2>Skontaktuj się z nami</h2>
        <h3>Formularz kontaktowy</h3>
        <form class="form--contact" method="post" action="/emailSender/">
            <div class="form-group form-group--50"><input type="text" name="name" placeholder="Imię"/></div>
            <div class="form-group form-group--50"><input type="text" name="surname" placeholder="Nazwisko"/></div>

            <div class="form-group"><textarea name="message" placeholder="Wiadomość" rows="1"></textarea></div>
            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
            <button class="btn" type="submit">Wyślij</button>
        </form>
    </div>
    <div class="bottom-line">
        <span class="bottom-line--copy">Copyright &copy; 2018</span>
        <div class="bottom-line--icons">
            <a href="#" class="btn btn--small"><img src="<c:url value="resources/images/icon-facebook.svg"/>"/></a> <a
                href="#"
                class="btn btn--small"><img
                src="<c:url value="resources/images/icon-instagram.svg"/>"/></a>
        </div>
    </div>
</footer>

<script src="<c:url value="resources/js/app.js"/>"></script>
</body>
</html>