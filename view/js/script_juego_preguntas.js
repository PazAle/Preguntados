let tiempo_valor = 10;
let tiempo_contador;
let time;
let strRespuestaUsuario = null;
let strTiempo = null;
let arrDatosPregunta = null;

next();

function next() {
    let url_string = location.href;
    let url = new URL(url_string);
    let idPartida = url.searchParams.get("id");
    // Realizar una petición AJAX para obtener los datos de preguntas JSON
    let strURL = '/partida/next?id='+idPartida;
    if(arrDatosPregunta != null) {
        strURL = strURL + "&id_pregunta="+arrDatosPregunta['pregunta_id']+"&respuesta="+strRespuestaUsuario+"&tiempo="+strTiempo;
    }

    $.ajax({
        url: strURL,
        method: 'GET',
        dataType: 'json',
        success: function(response) {



            const quiz_box = document.querySelector(".quiz-box");

            arrDatosPregunta = response.pregunta_nueva;

            //Actualizo puntaje
            let elemPuntos=document.getElementById('elem_puntos');
            elemPuntos.innerHTML=response.puntos;

            if(response.pregunta_anterior == null) {
                mostrarPregunta();
            } else {
                if(response.pregunta_anterior.respuesta_correcta) {
                    let cruzIcon = '<div class="icon tick"><i class="fas fa-check"></i></div>';
                    let equisIcon = '<div class="icon cross"><i class="fas fa-times"></i></div>';
                    const opciones_lista = document.querySelector(".opciones-lista");

                    let todasOpciones = opciones_lista.children.length;

                    // SI LA RESPUESTA ES INCORRECTA MOSTRAR LA QUE ES CORRECTA
                    for (let i = 0; i < todasOpciones; i++) {
                        if (opciones_lista.children[i].textContent == response.pregunta_anterior.respuesta_correcta) {
                            opciones_lista.children[i].setAttribute("class", "opcion correcto");
                        }
                        if (opciones_lista.children[i].textContent == strRespuestaUsuario && response.pregunta_anterior.resultado != true) {
                            opciones_lista.children[i].setAttribute("class", "opcion incorrecto");
                        }

                    }

                    if(response.pregunta_anterior.resultado == true) {
                        setTimeout(mostrarPregunta, 1500);
                    } else {
                        setTimeout(function redirigir(){
                            mostrarGameOver(response.puntos);
                            //window.location.href="/login";
                        }, 3000);
                    }


                }
            }
        },
        error: function() {
            // Manejar el error de la petición AJAX
            console.log('Error al obtener los datos de la base de datos.');
        }
    });
}

function mostrarGameOver(puntos) {
    const resultBox = document.querySelector(".result-box");
    const quiz_box = document.querySelector(".quiz-box");
    let elemPuntos=document.getElementById('puntos_final');

    elemPuntos.innerHTML=puntos;

    quiz_box.style.display = "none";
    resultBox.style.opacity = 1;
    resultBox.style.display = "block";
    resultBox.style.pointerEvents = 'auto';

    const data = {
        puntos: puntos
    };

    $.ajax({
        url: '/partida/acumularpuntos',
        type: 'POST',
        contentType: 'application/json',
        data: JSON.stringify(data),
        success: function() {
            console.log('Puntos enviados exitosamente');
        },
        error: function() {
            console.error('Error al enviar los puntos');
        }
    });
}

function mostrarPregunta() {
    const pregunta = document.querySelector(".pregunta");
    const opciones_lista = document.querySelector(".opciones-lista");

    const color_seccion = document.querySelector(".tipo_pregunta");
    color_seccion.style.backgroundColor = arrDatosPregunta.color;

    let pregunta_tag = '<span>' + arrDatosPregunta.enunciado + '</span>';
    pregunta.innerHTML = pregunta_tag;
    opciones_lista.innerHTML = "";
    strRespuestaUsuario = "";

    clearInterval(tiempo_contador);
    startTimer(tiempo_valor);

    arrDatosPregunta.respuestas.forEach(function(element) {
        let opcion_tag =
            '<div class="opcion">' +
            element +
            '<span></span></div>' ;
        opciones_lista.innerHTML = opciones_lista.innerHTML + opcion_tag;

    });


    const opcion = opciones_lista.querySelectorAll(".opcion");
    for (let i = 0; i < opcion.length; i++) {
        opcion[i].addEventListener("click", function() {
            opcionSeleccionada(this);
        });
    }
}


/* RESPUESTA DEL USUARIO */
function opcionSeleccionada(respuesta) {
    strRespuestaUsuario = respuesta.textContent;
    next();
}

/* CONTADOR DE TIEMPO */
function startTimer(tiempo_valor) {
    strTiempo = Math.floor(Date.now() / 1000);
    time = tiempo_valor;
    tiempo_contador = setInterval(timer, 1000);
}

function timer() {
    const quiz_box = document.querySelector(".quiz-box");
    const timeCount = quiz_box.querySelector(".tiempo .tiempo-segundos");
    timeCount.textContent = time;
    time--;

    if (time < 0) {
        clearInterval(tiempo_contador);
        timeCount.textContent = "0";

        next();

    }
}


// SELECCIONA LA OPCION INCCORRECTA SI SE TERMINA EL TIEMPO
function seleccionarOpcionIncorrecta() {
    const opciones = opciones_lista.querySelectorAll(".opcion");
    const opciones_lista = document.querySelector(".opciones-lista");
    //const respuestaCorrecta = preguntas[index_conteo].respuesta_correcta;

    for (let i = 0; i < opciones.length; i++) {
        const opcion = opciones[i];
        /*
        if (opcion.textContent !== respuestaCorrecta) {
            opcionSeleccionada(opcion);
            break;
        }
        */
    }
}

function reportarPregunta(idPregunta) {
    const data = {
        pregunta_id: idPregunta
    };

    $.ajax({
        url: '/pregunta/reportar',
        method: 'POST',
        contentType: 'application/json',
        data: JSON.stringify(data),
        success: function() {
            console.log('Redireccionando a formulario de reporte');
        },
        error: function() {
            console.error('Error al reportar la pregunta');
        }
    });
}


document.getElementById("reportar-btn").addEventListener("click", function() {
    window.location.href = 'http://localhost/pregunta/reportar?idPregunta=' + arrDatosPregunta.pregunta_id;
});