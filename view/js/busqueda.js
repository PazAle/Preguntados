
    // Función para buscar y mostrar las preguntas
function buscarPreguntas() {

    var numeroPregunta = document.getElementById("numeroPregunta").value;

    // Realizar una solicitud AJAX al controlador
    $.ajax({
        url: "/pregunta/verPregunta",
        method: "GET",
        data: { numeroPregunta: numeroPregunta },
        success: function(jsonPreguntas) {
            var preguntasEncontradas = JSON.parse(jsonPreguntas);

            var listaPreguntas = document.getElementById("listaPreguntas");
            listaPreguntas.innerHTML = ""; // Limpiar el contenido anterior

            // Recorrer el array de preguntas encontradas y agregar cada una a la lista
            for (var i = 0; i < preguntasEncontradas.length; i++) {
                var pregunta = preguntasEncontradas[i];

                var listItem = document.createElement("li");

                var numeroSpan = document.createElement("span");
                numeroSpan.innerHTML = pregunta.pregunta_id + ". ";
                listItem.appendChild(numeroSpan);

                var textoSpan = document.createElement("span");
                textoSpan.innerHTML = pregunta.enunciado;
                listItem.appendChild(textoSpan);

                var modificarDiv = document.createElement("div");
                modificarDiv.classList.add("form-group");


                var modificarBtn = document.createElement("button");
                modificarBtn.innerHTML = "Modificar pregunta";
                modificarBtn.classList.add("btn");
                modificarBtn.classList.add("btn-primary");

                modificarBtn.addEventListener(
                    "click",
                    modificarPregunta.bind(null, pregunta.pregunta_id)
                );

                modificarDiv.appendChild(modificarBtn);
                listItem.appendChild(modificarDiv);

                var eliminarDiv = document.createElement("div");
                eliminarDiv.classList.add("form-group");

                var eliminarBtn = document.createElement("button");
                eliminarBtn.innerHTML = "Eliminar pregunta";
                eliminarBtn.classList.add("btn");
                eliminarBtn.classList.add("btn-primary");

                eliminarDiv.appendChild(eliminarBtn);
                listItem.appendChild(eliminarDiv);

                eliminarBtn.addEventListener("click", function() {
                    var confirmarEliminacion = confirm("¿Estás seguro de eliminar el registro?");
                    if (confirmarEliminacion) {
                        eliminarPregunta(pregunta.pregunta_id);
                    }
                });

                listaPreguntas.appendChild(listItem);
            }
        },
        error: function(error) {
            console.log("Error en la solicitud AJAX:", error);
        }
    });
}

function modificarPregunta(numeroPregunta) {
    window.location.href = 'http://localhost/pregunta/formularioPregunta?idPregunta=' + numeroPregunta;
}


function eliminarPregunta(numeroPregunta) {
    $.ajax({
        url: "/pregunta/eliminarPregunta",
        method: "POST",
        data: { numeroPregunta: numeroPregunta },
        success: function() {
            console.log("Pregunta eliminada con éxito");
        },
        error: function(error) {
            console.log("Error en la solicitud AJAX:", error);
        }
    });
}

