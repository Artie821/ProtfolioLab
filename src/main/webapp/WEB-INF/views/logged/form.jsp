<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ include file="header.jsp" %>



    <div class="slogan container container--90">
        <div class="slogan--item">
            <h1>
                Oddaj rzeczy, których już nie chcesz<br />
                <span class="uppercase">potrzebującym</span>
            </h1>

            <div class="slogan--steps">
                <div class="slogan--steps-title">Wystarczą 4 proste kroki:</div>
                <ul class="slogan--steps-boxes">
                    <li>
                        <div><em>1</em><span>Wybierz rzeczy</span></div>
                    </li>
                    <li>
                        <div><em>2</em><span>Spakuj je w worki</span></div>
                    </li>
                    <li>
                        <div><em>3</em><span>Wybierz fundację</span></div>
                    </li>
                    <li>
                        <div><em>4</em><span>Zamów kuriera</span></div>
                    </li>
                </ul>
            </div>
        </div>
    </div>
</header>

<section class="form--steps" id="form--steps">
    <div class="form--steps-instructions">
        <div class="form--steps-container">
            <h3>Ważne!</h3>
            <p data-step="1" class="active">
                Uzupełnij szczegóły dotyczące Twoich rzeczy. Dzięki temu będziemy
                wiedzieć komu najlepiej je przekazać.
            </p>
            <p data-step="2">
                Uzupełnij szczegóły dotyczące Twoich rzeczy. Dzięki temu będziemy
                wiedzieć komu najlepiej je przekazać.
            </p>
            <p data-step="3">
                Wybierz jedną, do
                której trafi Twoja przesyłka.
            </p>
            <p data-step="4">Podaj adres oraz termin odbioru rzeczy.</p>
        </div>
    </div>

    <div class="form--steps-container">
        <div class="form--steps-counter">Krok <span>1</span>/4</div>

<form:form modelAttribute="donation" method="post" action="/logged/confirm">
            <!-- STEP 1: class .active is switching steps -->
            <div data-step="1" class="active">
                <h3>Zaznacz co chcesz oddać:</h3>
                <c:forEach items="${categories}" var="category">
                <div class="form-group form-group--checkbox">
                    <label>
                        <input
                                type="checkbox"
                                name="category"
                                value="${category.name}"
                                onclick='handleClick(this);'
                        />
                        <span class="checkbox"></span>
                        <span class="description"
                        >${category.name}</span
                        >
                    </label>

                </div>
                </c:forEach>
                <script>
                    var chcecked = [];
                    function handleClick(cb) {
                        var text = document.getElementById("text");
                        if (cb.checked == true){

                            chcecked.push(cb.value +" ")

                        } else {
                           let index = chcecked.indexOf(cb);
                           chcecked.splice(index,1)
                        }
                        console.log(chcecked)
                        document.getElementById("summaryBagNumber").innerText = chcecked;
                        if(chcecked.length==0){
                            document.getElementById('categoriesNext').style.display = "none"
                        } else {
                            document.getElementById('categoriesNext').style.display = "block"
                        }
                    }
                </script>
                <p id="loop"></p>

                <div class="form-group form-group--buttons">
                    <button type="button" class="btn prev-step" disabled>Wstecz</button>
                    <button type="button" id="categoriesNext" style="display: none" class="btn next-step">Dalej</button>
                </div>
            </div>

            <!-- STEP 2 -->
            <div data-step="2">
                <h3>Podaj liczbę 60l worków, w które spakowałeś/aś rzeczy:</h3>

                <div class="form-group form-group--inline">
                    <label>
                        Liczba 60l worków:
                        <form:input path="quantity" onchange="getInputValue()"/>
                    </label>
                    <script type="text/javascript">
                        window.addEventListener('keydown',function(e){if(e.keyIdentifier=='U+000A'||e.keyIdentifier=='Enter'||e.keyCode==13){if(e.target.nodeName=='INPUT'&&e.target.type=='text'){e.preventDefault();return false;}}},true);
                    </script>
                    <script>
                        function getInputValue(){
                            var inputVal = document.getElementById("quantity").value;
                            let summary = document.getElementById('summaryBagNumber');
                            if(inputVal==1){
                                summary.innerHTML = inputVal + ' worek z:' + '<br>' + summary.innerText;
                            }else if (inputVal>=2 && inputVal<=4){
                                summary.innerHTML = inputVal + ' worki z:' + '<br>' + summary.innerText;
                            }else if(inputVal>=5)(
                                summary.innerHTML = inputVal + ' worków z:' + '<br>' + summary.innerText
                            )
                            if(inputVal==0){
                                document.getElementById('bagsNext').style.display = "none"
                            } else {
                                document.getElementById('bagsNext').style.display = "block"
                            }
                        }
                    </script>
                </div>

                <div class="form-group form-group--buttons">
                    <button type="button" class="btn prev-step" >Wstecz</button>
                    <button type="button" id="bagsNext" style="display: none;" class="btn next-step">Dalej</button>
                </div>
            </div>



            <!-- STEP 4 -->
            <div data-step="3">
                <h3>Wybierz organizacje, której chcesz pomóc:</h3>
                <c:forEach items="${institutions}" var="institution">
                <div class="form-group form-group--checkbox">
                    <label>
                        <input type="radio" name="instit" value="${institution.id}" onclick="displayRadioValue()"/>
                        <span class="checkbox radio"></span>
                        <span class="description">
                  <div class="title" id="instTitle">${institution.name}</div>
                  <div class="subtitle" id="instSubtitle">${institution.description}</div>
                </span>
                    </label>
                </div>
                    </c:forEach>

                <script>
                    function displayRadioValue() {
                        var ele = document.getElementsByName('instit');

                        for(i = 0; i < ele.length; i++) {
                            if(ele[i].checked)
                                document.getElementById("institutionResult").innerHTML
                                    = ele[i].nextElementSibling.nextElementSibling.firstElementChild.textContent;
                        }
                        if(ele.length==0){
                            document.getElementById('institutionNext').style.display = "none"
                        } else {
                            document.getElementById('institutionNext').style.display = "block"
                        }
                    }
                </script>
                <div class="form-group form-group--buttons">
                    <button type="button" class="btn prev-step">Wstecz</button>
                    <button type="button" class="btn next-step" id="institutionNext" style="display: none">Dalej</button>
                </div>
            </div>

            <!-- STEP 5 -->
            <div data-step="4">
                <h3>Podaj adres oraz termin odbioru rzecz przez kuriera:</h3>

                <div class="form-section form-section--columns">
                    <div class="form-section--column">
                        <h4>Adres odbioru</h4>
                        <div class="form-group form-group--inline">
                            <label> Ulica <form:input path="street" onchange="getInputValueStreet();"/> </label>
                            <script>
                                function getInputValueStreet(){
                                    var inputVal = document.getElementById("street").value;
                                    let summary = document.getElementById('streetValue');
                                    summary.innerText = inputVal;
                                }
                            </script>
                        </div>

                        <div class="form-group form-group--inline">
                            <label> Miasto <form:input path="city" onchange="getInputValueCity();"/> </label>
                            <script>
                                function getInputValueCity(){
                                    var inputVal = document.getElementById("city").value;
                                    let summary = document.getElementById('cityValue');
                                    summary.innerText = inputVal;
                                }
                            </script>
                        </div>

                        <div class="form-group form-group--inline">
                            <label>
                                Kod pocztowy <form:input path="zipCode" onchange="getInputValueZip();"/>
                            </label>
                            <script>
                                function getInputValueZip(){
                                    var inputVal = document.getElementById("zipCode").value;
                                    let summary = document.getElementById('zipValue');
                                    summary.innerText = inputVal;
                                }
                            </script>
                        </div>

                        <div class="form-group form-group--inline">
                            <label>
                                Numer telefonu <form:input type="phone" name="phone" path="phone" onchange="getInputValuePhone();"/>
                            </label>
                        </div>
                        <script>
                            function getInputValuePhone(){
                                var inputVal = document.getElementById("phone").value;
                                let summary = document.getElementById('phoneValue');
                                summary.innerText = inputVal;
                            }
                        </script>
                    </div>

                    <div class="form-section--column">
                        <h4>Termin odbioru</h4>
                        <div class="form-group form-group--inline">
                            <label> Data <input type="date" name="pickUpDate" id="pickUpDate" path="pickUpDate" min="" onchange="getInputValueDate();"/> </label>
                        </div>
                        <script>
                            var today = new Date();
                            var dd = today.getDate();
                            var mm = today.getMonth()+1; //January is 0!
                            var yyyy = today.getFullYear();
                            if(dd<10){
                                dd='0'+dd
                            }
                            if(mm<10){
                                mm='0'+mm
                            }

                            today = yyyy+'-'+mm+'-'+dd;
                            document.getElementById("pickUpDate").setAttribute("min", today);
                        </script>
                        <script>
                            function getInputValueDate(){
                                var inputVal = document.getElementById("pickUpDate").value;
                                let summary = document.getElementById('dateValue');
                                summary.innerText = inputVal;
                            }
                        </script>

                        <div class="form-group form-group--inline">
                            <label> Godzina <form:input type="time" path="pickUpTime" onchange="getInputValueTime();"/> </label>
                        </div>
                        <script>
                            function getInputValueTime(){
                                var inputVal = document.getElementById("pickUpTime").value;
                                let summary = document.getElementById('timeValue');
                                summary.innerText = inputVal;
                            }
                        </script>

                        <div class="form-group form-group--inline">
                            <label>
                                Uwagi dla kuriera
                                <form:textarea path="pickUpComment" onchange="getInputValueComment();"/>
                            </label>
                            <script>
                                function getInputValueComment(){
                                    var inputVal = document.getElementById("pickUpComment").value;
                                    let summary = document.getElementById('commentValue');
                                    summary.innerText = inputVal;
                                }
                            </script>
                        </div>
                    </div>
                </div>
                <div class="form-group form-group--buttons">
                    <button type="button" class="btn prev-step">Wstecz</button>
                    <button type="button" class="btn next-step">Dalej</button>
                </div>
            </div>

            <!-- STEP 6 -->
            <div data-step="5">
                <h3>Podsumowanie Twojej darowizny</h3>

                <div class="summary">
                    <div class="form-section">
                        <h4>Oddajesz:</h4>
                        <ul>
                            <li>
                                <span class="icon icon-bag"></span>
                                <span class="summary--text" id="summaryBagNumber"
                                > worki ubrań w dobrym stanie dla dzieci</span
                                >
                            </li>

                            <li>
                                <span class="icon icon-hand"></span>
                                <span class="summary--text" id="institutionResult">Dla fundacji "Mam marzenie" w Warszawie</span
                                >
                            </li>
                        </ul>
                    </div>

                    <div class="form-section form-section--columns">
                        <div class="form-section--column">
                            <h4>Adres odbioru:</h4>
                            <ul>
                                <li id="streetValue">Prosta 51</li>
                                <li id="cityValue">Warszawa</li>
                                <li id="zipValue">99-098</li>
                                <li id="phoneValue">123 456 789</li>
                            </ul>
                        </div>

                        <div class="form-section--column">
                            <h4>Termin odbioru:</h4>
                            <ul>
                                <li id="dateValue">13/12/2018</li>
                                <li id="timeValue">15:40</li>
                                <li id="commentValue">Brak uwag</li>
                            </ul>
                        </div>
                    </div>
                </div>

                <div class="form-group form-group--buttons">
                    <button type="button" class="btn prev-step">Wstecz</button>
                    <button type="submit" class="btn" id="submit" value="SEND">Potwierdzam</button>
                </div>
            </div>
        </form:form>
    </div>
</section>

<%@ include file="footer.jsp" %>