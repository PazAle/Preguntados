<?php

class LobbyAdminController
{
    private $renderer;
    private $lobbyAdminModel;

    private $perfilModel;



    public function __construct($renderer, $lobbyAdminModel, $perfilModel)
    {
        $this->renderer = $renderer;
        $this->lobbyAdminModel = $lobbyAdminModel;
        $this->perfilModel = $perfilModel;

    }

    public function execute()
    {
        if (!isset($_SESSION['email'])) {
            header("location: /");
            exit();
        }


        $datos['datosUsur'] = $this->perfilModel->obtenerDatos($_SESSION["id"]);
        $datos['admin'] = 1;

        echo $this->renderer->render("lobbyAdmin", $datos);
    }

    public function datosParaGraficos()
    {
        if ($_POST['filtroFecha'] != ''){
            $fecha = $_POST['filtroFecha'];
        } else {
            $fecha = date("Y/m/d");
        }

        $cantidadDeJugadoresTotales = $this->lobbyAdminModel->cantidadDeJugadoresTotales($fecha);
        $cantidadDePartidasJugadas = $this->lobbyAdminModel->cantidadDePartidasJugadas($fecha);
        $cantidadDePreguntasEnJuego = $this->lobbyAdminModel->cantidadDePreguntasEnJuego($fecha);
        $cantidadDePreguntasDadasDeAlta = $this->lobbyAdminModel->cantidadDePreguntasDadasDeAlta($fecha);
        $cantidadDeUsuariosNuevos = $this->lobbyAdminModel->cantidadDeUsuariosNuevos($fecha);
        $cantidadDeUsuariosPorPais = $this->lobbyAdminModel->cantidadDeUsuariosPorPais($fecha);
        $cantidadDeUsuariosPorSexo = $this->lobbyAdminModel->cantidadDeUsuariosPorSexo($fecha);
        $cantidadDeUsuariosPorGrupoDeEdad = $this->lobbyAdminModel->cantidadDeUsuariosPorGrupoDeEdad($fecha);
        $porcentajeDePreguntasRespondidasCorrectamentePorElUsuario = $this->lobbyAdminModel->porcentajeDePreguntasRespondidasCorrectamentePorElUsuario($fecha);

        /*ASIGNO NOMBRES IDENTIFICARIOS DE CLAVES EN EL ARRAY DE DATOS PARA ENVIARSELO A LA VISTA, ASI CREO LOS GRAFICOS EN EL JS*/
        $datos['cantidadDeJugadoresTotales'] = array();
        foreach ($cantidadDeJugadoresTotales as $row) {
            $datos['cantidadDeJugadoresTotales'][$row['mes']] = $row['cantidad'];
        }
        $datos['cantidadDePartidasJugadas'] = array();
        foreach ($cantidadDePartidasJugadas as $row) {
            $datos['cantidadDePartidasJugadas'][$row['mes']] = $row['cantidad'];
        }
        $datos['cantidadDePreguntasEnJuego'] = array();
        foreach ($cantidadDePreguntasEnJuego as $row) {
            $datos['cantidadDePreguntasEnJuego'][$row['mes']] = $row['cantidad'];
        }
        $datos['cantidadDePreguntasDadasDeAlta'] = array();
        foreach ($cantidadDePreguntasDadasDeAlta as $row) {
            $datos['cantidadDePreguntasDadasDeAlta'][$row['mes']] = $row['cantidad'];
        }
        $datos['cantidadDeUsuariosNuevos'] = array();
        foreach ($cantidadDeUsuariosNuevos as $row) {
            $datos['cantidadDeUsuariosNuevos'][$row['semana']] = $row['cantidad'];
        }
        $datos['cantidadDeUsuariosPorPais'] = array();
        foreach ($cantidadDeUsuariosPorPais as $row) {
            $datos['cantidadDeUsuariosPorPais'][$row['pais']] = $row['cantidad'];
        }
        $datos['cantidadDeUsuariosPorSexo'] = array();
        foreach ($cantidadDeUsuariosPorSexo as $row) {
            $datos['cantidadDeUsuariosPorSexo'][$row['genero']] = $row['cantidad'];
        }

        $datos['cantidadDeUsuariosPorGrupoDeEdad'] = array();
        foreach ($cantidadDeUsuariosPorGrupoDeEdad as $row) {
            $datos['cantidadDeUsuariosPorGrupoDeEdad'][$row['grupoEdad']] = $row['cantidad'];
        }

        $datos['porcentajeDePreguntasRespondidasCorrectamentePorElUsuario'] = array();
        foreach ($porcentajeDePreguntasRespondidasCorrectamentePorElUsuario as $row) {
            $datos['porcentajeDePreguntasRespondidasCorrectamentePorElUsuario'][$row['nombre']] = $row['porcentaje'];
        }

        echo json_encode($datos);

    }


}

