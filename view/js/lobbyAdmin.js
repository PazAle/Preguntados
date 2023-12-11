mostrarGraficos();

function mostrarGraficos() {

    var filtroFecha = document.getElementById("filtroFecha").value;

    $.ajax({
        url: "/lobbyAdmin/datosParaGraficos",
        method: "POST",
        data: {filtroFecha: filtroFecha},
        success: function (jsonDataConsultas) {
            var data = JSON.parse(jsonDataConsultas);

            var chartJugadoresTotal = Chart.getChart('jugadoresTotal');
            if (chartJugadoresTotal) {
                chartJugadoresTotal.destroy();
            }
            var chartPartidasJugadas = Chart.getChart('partidasJugadas');
            if (chartPartidasJugadas) {
                chartPartidasJugadas.destroy();
            }
            var chartPreguntasEnJuego = Chart.getChart('preguntasEnJuego');
            if (chartPreguntasEnJuego) {
                chartPreguntasEnJuego.destroy();
            }
            var chartPreguntasDadasDeAlta = Chart.getChart('preguntasDadasDeAlta');
            if (chartPreguntasDadasDeAlta) {
                chartPreguntasDadasDeAlta.destroy();
            }
            var chartUsuariosNuevos = Chart.getChart('usuariosNuevos');
            if (chartUsuariosNuevos) {
                chartUsuariosNuevos.destroy();
            }
            var chartUsuariosPorPais = Chart.getChart('usuariosPorPais');
            if (chartUsuariosPorPais) {
                chartUsuariosPorPais.destroy();
            }
            var chartUsuarioPorGenero = Chart.getChart('usuarioPorGenero');
            if (chartUsuarioPorGenero) {
                chartUsuarioPorGenero.destroy();
            }
            var chartUsuariosPorGrupo = Chart.getChart('usuariosPorGrupo');
            if (chartUsuariosPorGrupo) {
                chartUsuariosPorGrupo.destroy();
            }
            var chartPorcentajeCorrectasUsur = Chart.getChart('porcentajeCorrectasUsur');
            if (chartPorcentajeCorrectasUsur) {
                chartPorcentajeCorrectasUsur.destroy();
            }

            var labels1 = Object.keys(data.cantidadDeJugadoresTotales);
            var values1 = Object.values(data.cantidadDeJugadoresTotales);

            var ctx = document.getElementById('jugadoresTotal');
            new Chart(ctx, {
                type: 'bar',
                data: {
                    labels: labels1,
                    datasets: [{
                        label: 'Jugadores Totales',
                        data: values1,
                        backgroundColor: 'rgba(75, 192, 192, 0.2)',
                        borderColor: 'rgba(75, 192, 192, 1)',
                        borderWidth: 1
                    }]
                },
                options: {
                    // Opciones adicionales de configuración
                }
            });

            var labels2 = Object.keys(data.cantidadDePartidasJugadas);
            var values2 = Object.values(data.cantidadDePartidasJugadas);

            var ctx2 = document.getElementById('partidasJugadas');
            new Chart(ctx2, {
                type: 'bar',
                data: {
                    labels: labels2,
                    datasets: [{
                        label: 'Partidas Jugadas',
                        data: values2,
                        backgroundColor: 'rgba(54, 162, 235, 0.2)',
                        borderColor: 'rgba(54, 162, 235, 1)',
                        borderWidth: 1
                    }]
                },
                options: {

                }
            });

            var labels3 = Object.keys(data.cantidadDePreguntasEnJuego);
            var values3 = Object.values(data.cantidadDePreguntasEnJuego);

            var pieChartCtx = document.getElementById('preguntasEnJuego');
            new Chart(pieChartCtx, {
                type: 'pie',
                data: {
                    labels: labels3,
                    datasets: [{
                        label: 'Preguntas en el Juego',
                        data: values3,
                        backgroundColor: ['rgba(255, 99, 132, 0.2)', 'rgba(54, 162, 235, 0.2)', 'rgba(255, 206, 86, 0.2)'],
                        borderColor: ['rgba(255, 99, 132, 1)', 'rgba(54, 162, 235, 1)', 'rgba(255, 206, 86, 1)'],
                        borderWidth: 1
                    }]
                },
                options: {
                    // Opciones adicionales de configuración para el gráfico de pastel
                }
            });

            var labels4 = Object.keys(data.cantidadDePreguntasDadasDeAlta);
            var values4 = Object.values(data.cantidadDePreguntasDadasDeAlta);

            var lineChartCtx2 = document.getElementById('preguntasDadasDeAlta');
            new Chart(lineChartCtx2, {
                type: 'line',
                data: {
                    labels: labels4,
                    datasets: [{
                        label: 'Preguntas dadas de Alta',
                        data: values4,
                        backgroundColor: 'rgba(255, 99, 132, 0.2)',
                        borderColor: 'rgba(255, 99, 132, 1)',
                        borderWidth: 1
                    }]
                },
                options: {
                    scales: {
                        x: {
                            title: {
                                display: true,
                                text: 'Mes'
                            }
                        },
                        y: {
                            title: {
                                display: true,
                                text: 'Cantidad'
                            }
                        }
                    }
                }
            });

            var labels5 = Object.keys(data.cantidadDeUsuariosNuevos);
            var values5 = Object.values(data.cantidadDeUsuariosNuevos);

            var lineChartCtx3 = document.getElementById('usuariosNuevos');
            new Chart(lineChartCtx3, {
                type: 'line',
                data: {
                    labels: labels5,
                    datasets: [{
                        label: 'Usuarios Nuevos',
                        data: values5,
                        backgroundColor: 'rgba(255, 99, 132, 0.2)',
                        borderColor: 'rgba(255, 99, 132, 1)',
                        borderWidth: 1
                    }]
                },
                options: {
                    scales: {
                        x: {
                            title: {
                                display: true,
                                text: 'Semana'
                            }
                        },
                        y: {
                            title: {
                                display: true,
                                text: 'Cantidad'
                            }
                        }
                    }
                }
            });

            var labels6 = Object.keys(data.cantidadDeUsuariosPorPais);
            var values6 = Object.values(data.cantidadDeUsuariosPorPais);

            var pieChartCtx2 = document.getElementById('usuariosPorPais');
            new Chart(pieChartCtx2, {
                type: 'pie',
                data: {
                    labels: labels6,
                    datasets: [{
                        label: 'Usuarios por País',
                        data: values6,
                        backgroundColor: ['rgba(255, 99, 132, 0.2)', 'rgba(54, 162, 235, 0.2)', 'rgba(255, 206, 86, 0.2)'],
                        borderColor: ['rgba(255, 99, 132, 1)', 'rgba(54, 162, 235, 1)', 'rgba(255, 206, 86, 1)'],
                        borderWidth: 1
                    }]
                },
                options: {
                    // Opciones adicionales de configuración para el gráfico de pastel
                }
            });

            var labels7 = Object.keys(data.cantidadDeUsuariosPorSexo);
            var values7 = Object.values(data.cantidadDeUsuariosPorSexo);

            var pieChartCtx3 = document.getElementById('usuarioPorGenero');
            new Chart(pieChartCtx3, {
                type: 'pie',
                data: {
                    labels: labels7,
                    datasets: [{
                        label: 'Usuarios por Género',
                        data: values7,
                        backgroundColor: ['rgba(255, 99, 132, 0.2)', 'rgba(54, 162, 235, 0.2)', 'rgba(255, 206, 86, 0.2)'],
                        borderColor: ['rgba(255, 99, 132, 1)', 'rgba(54, 162, 235, 1)', 'rgba(255, 206, 86, 1)'],
                        borderWidth: 1
                    }]
                },
                options: {
                    // Opciones adicionales de configuración para el gráfico de pastel
                }
            });

            var labels8 = Object.keys(data.cantidadDeUsuariosPorGrupoDeEdad);
            var values8 = Object.values(data.cantidadDeUsuariosPorGrupoDeEdad);

            var pieChartCtx4 = document.getElementById('usuariosPorGrupo');
            new Chart(pieChartCtx4, {
                type: 'pie',
                data: {
                    labels: labels8,
                    datasets: [{
                        label: 'Usuarios por Grupo',
                        data: values8,
                        backgroundColor: ['rgba(255, 99, 132, 0.2)', 'rgba(54, 162, 235, 0.2)', 'rgba(255, 206, 86, 0.2)'],
                        borderColor: ['rgba(255, 99, 132, 1)', 'rgba(54, 162, 235, 1)', 'rgba(255, 206, 86, 1)'],
                        borderWidth: 1
                    }]
                },
                options: {
                    // Opciones adicionales de configuración para el gráfico de pastel
                }
            });
            var labels5 = Object.keys(data.porcentajeDePreguntasRespondidasCorrectamentePorElUsuario);
            var values5 = Object.values(data.porcentajeDePreguntasRespondidasCorrectamentePorElUsuario);

            var pieChartCtx5 = document.getElementById('porcentajeCorrectasUsur');
            new Chart(pieChartCtx5, {
                type: 'pie',
                data: {
                    labels: labels5,
                    datasets: [{
                        label: 'Porcentajes de preguntas correctas',
                        data: values5,
                        backgroundColor: ['rgba(255, 99, 132, 0.2)', 'rgba(54, 162, 235, 0.2)', 'rgba(255, 206, 86, 0.2)'],
                        borderColor: ['rgba(255, 99, 132, 1)', 'rgba(54, 162, 235, 1)', 'rgba(255, 206, 86, 1)'],
                        borderWidth: 1
                    }]
                },
                options: {
                    // Opciones adicionales de configuración para el gráfico de pastel
                }
            });
        },
        error: function (error) {
            console.log("Error en la solicitud AJAX:", error);
        }

    });
}

function genPDF(idDeEtiqueta){

    var chartCanvas = document.getElementById(idDeEtiqueta);
    var chartImage = chartCanvas.toDataURL();

    var doc=new jsPDF();
    var imageWidth = 100;
    var imageHeight = (imageWidth / chartCanvas.width) * chartCanvas.height; // Mantener la relación de aspecto

    doc.addImage(chartImage, 'JPEG', 20, 20, imageWidth, imageHeight);
    doc.save('Test.pdf');

}
