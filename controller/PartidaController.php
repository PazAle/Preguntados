<?php

class PartidaController
{
    private $partidaModel;
    private $preguntaModel;
    private $renderer;

    public function __construct($partidaModel, $preguntaModel, $renderer)
    {
        $this->partidaModel = $partidaModel;
        $this->preguntaModel = $preguntaModel;
        $this->renderer = $renderer;

    }

    public function nuevaPartida()
    {
        if (!isset($_SESSION['email'])) {
            header("location: /");
            exit();
        }


        $idUsuario = $_SESSION['id'];
        $fecha = date("Y/m/d");
        unset($_SESSION['id_pregunta']);
        $intIdPartida = $this->partidaModel->generarPartida($idUsuario, $fecha);
        $_SESSION['id_partida'] = $intIdPartida;
        header('location: ./jugar?id='.$intIdPartida);
        exit();
    }

    public function jugar() {

        if (!isset($_SESSION['email'])) {
            header("location: /");
            exit();
        }

        /*if(!isset($_REQUEST['id'])) {
            header('location: ./nuevaPartida');
            return;
        }*/

        $idPartida = $_REQUEST['id'];


        $arrDatosPartida = $this->partidaModel->obtenerPartida($idPartida);

        /*Valida que haya tocado F5 en base a si se asigno una pregunta previamente*/
        if(isset($_SESSION['id_pregunta'])) {
            /*Marco la partida como terminada*/
            $num_partida = $arrDatosPartida['idPartida'];
            $id_usuario = $arrDatosPartida['idUsuario'];
            $this->partidaModel->marcarComoTerminada($num_partida,$id_usuario);

            $this->errorDePartida();
            return;
        }

        if(!isset($arrDatosPartida['idPartida'])) {
            $this->redirigirHome();
            return;
        }

        if($arrDatosPartida['terminada'] == 1) {
            $this->redirigirHome();
            return;
        }

        //Valido que el usuario logueado coincida con el "dueño" de la partida
        if($arrDatosPartida['idUsuario'] != $_SESSION['id']) {
            $this->redirigirHome();
            return;
        }

        $this->renderer->render("partida");
    }

    public function next()
    {
        if (!isset($_SESSION['email'])) {
            exit();
        }

        if(!isset($_REQUEST['id'])) {
            exit();
        }

        $idPartida = $_REQUEST['id'];

        $idUsuario = $_SESSION['id'];

        $arrDatosPartida = $this->partidaModel->obtenerPartida($idPartida);

        if(!isset($arrDatosPartida['idPartida'])) {
            $this->redirigirHome();
            return;
        }

        if($arrDatosPartida['terminada'] == 1) {
            $this->redirigirHome();
            return;
        }


        //Valido que el usuario logueado coincida con el "dueño" de la partida
        if($arrDatosPartida['idUsuario'] != $_SESSION['id']) {
            $this->redirigirHome();
            return;
        }

        $arrDevolucion=[];

        $arrDevolucion['pregunta_anterior']=null;
        $arrDevolucion['pregunta_nueva']=[];


        if(isset($arrDatosPartida['idPreguntaActual']) && $arrDatosPartida['idPreguntaActual']>0) {
            //Por defecto asumo que la respuesta es incorrecta
            $bRespuestaCorrecta = false;

            //Cargo datos de la pregunta anterior (en términos de tabla se denominada idPreguntaActual)
            $arrDatosPreguntaRespondida = $this->preguntaModel->obtenerPreguntaPorId($arrDatosPartida['idPreguntaActual']);

            //Si me llegó la respuesta correcta a la pregunta planteada, entonces marco la respuesta como correcta
            if(isset($_REQUEST['id_pregunta']) && $_REQUEST['id_pregunta'] == $arrDatosPartida['idPreguntaActual']) {
                $strRespuesta = "";
                $fueraDeTiempo = false;
                if(isset($_REQUEST['respuesta'])) {
                    $strRespuesta = $_REQUEST['respuesta'];
                }

                if(isset($_REQUEST['tiempo'])) {
                    $strTiempo = $_REQUEST['tiempo'];
                }

                /*Control del tiempo dese backend - La marca en rojo igual para no saber si era correcta o no*/
                $tiempoActual = time();
                $tiempoInicioPregunta = $strTiempo;
                $tiempoLimite = 10;

                $tiempoTranscurrido = $tiempoActual - $tiempoInicioPregunta;
                if ($tiempoTranscurrido > $tiempoLimite) {
                    $fueraDeTiempo = true;
                }

                if(is_array($arrDatosPreguntaRespondida) && isset($arrDatosPreguntaRespondida['respuesta_correcta']) && $arrDatosPreguntaRespondida['respuesta_correcta'] == $strRespuesta && $fueraDeTiempo === false){
                    //Respuesta es correcta
                    $bRespuestaCorrecta = true;
                    $this->partidaModel->actualizarPuntaje($idPartida);
                    /*Aumentar cantidad de veces respondida bien*/
                    $this->preguntaModel->aumentarRespondidaBien($arrDatosPreguntaRespondida['pregunta_id']);
                    $arrDatosPartida['puntosObtenidos']+=1;
                    //Indico Respuesta correcta en el historial de Pregunta_Usuario
                    $this->partidaModel->updateEstadoRespuesta($idPartida, $arrDatosPreguntaRespondida['pregunta_id'], $idUsuario, $strRespuesta );
                }

                //Almaceno respuesta
                $this->partidaModel->updatePreguntaUsuario($idPartida, $arrDatosPreguntaRespondida['pregunta_id'], $idUsuario, $strRespuesta );
            }

            //Marco como terminada la partida si la respuesta es incorrecta
            if($bRespuestaCorrecta == false) {
                $this->partidaModel->marcarComoTerminada($idPartida,$idUsuario);
            }

            /*Aumentar cantidad de veces respondida*/
            $this->preguntaModel->aumentarCantidadDeVeces($arrDatosPreguntaRespondida['pregunta_id']);

            //Configuro datos para devolver al frontend
            $arrDevolucion['pregunta_anterior'] = $arrDatosPreguntaRespondida;
            $arrDevolucion['pregunta_anterior'] ['resultado'] = $bRespuestaCorrecta;
        }

        //Otorgo nueva pregunta
        if($arrDevolucion['pregunta_anterior'] == null || ($arrDevolucion['pregunta_anterior'] != null && $arrDevolucion['pregunta_anterior'] ['resultado'] == true) ) {

            $arrDatosPregunta = $this->preguntaModel->obtenerPregunta($idUsuario);
            $_SESSION['id_pregunta'] = $arrDatosPregunta['pregunta_id'];
            $this->partidaModel->actualizarPreguntaPartida($idPartida, $arrDatosPregunta['pregunta_id'], $idUsuario);
            $arrDatosPregunta['respuestas'] = [];

            try{
                array_push($arrDatosPregunta['respuestas'], $arrDatosPregunta['respuestaA']);
                array_push($arrDatosPregunta['respuestas'], $arrDatosPregunta['respuestaB']);
                array_push($arrDatosPregunta['respuestas'], $arrDatosPregunta['respuestaC']);
                array_push($arrDatosPregunta['respuestas'], $arrDatosPregunta['respuestaD']);

                unset($arrDatosPregunta['respuestaA']);
                unset($arrDatosPregunta['respuestaB']);
                unset($arrDatosPregunta['respuestaC']);
                unset($arrDatosPregunta['respuestaD']);
                unset($arrDatosPregunta['respuesta_correcta']);
                unset($arrDatosPregunta['veces_respondida']);
                unset($arrDatosPregunta['veces_correcta']);

                $arrDevolucion['pregunta_nueva'] = $arrDatosPregunta;
            } catch (Exception $e) {

            }
        }

        $arrDevolucion['puntos']=$arrDatosPartida['puntosObtenidos'];

        header('Content-Type: application/json');
        echo json_encode($arrDevolucion);
        exit();
    }

    private function redirigirHome() {
        header("location: /lobbyUsuario");
        exit();
    }

    private function errorDePartida(){
        $this->renderer->render("partida_error");
    }

    public function acumularpuntos(){
        $requestData = json_decode(file_get_contents('php://input'), true);

        $idUsuario = $_SESSION['id'];
        $puntos = $requestData['puntos'];

        $this->partidaModel->sumarPuntosTotales($idUsuario, $puntos);
    }

}