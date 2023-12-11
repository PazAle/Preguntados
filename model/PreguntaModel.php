<?php

class PreguntaModel{
    private $database;
    public function __construct($database)
    {
        $this->database = $database;
    }

    public function obtenerPregunta($idUsuarioActual){
        $ratio = $this->obtenerNivelUsuario($idUsuarioActual);

        //Usuario con pocas respuesta correctas - Preguntas faciles
        if($ratio < 30){
            $sql = "SELECT p.pregunta_id, p.enunciado, p.categoria_id, p.respuestaA, p.respuestaB, p.respuestaC, p.respuestaD, p.respuesta_correcta, c.color
                    FROM preguntas p
                    JOIN categoria c ON p.categoria_id = c.categoria_id
                    WHERE ((p.veces_correcta * 100) / p.veces_respondida) >=70
                            AND NOT EXISTS (
                            SELECT 1
                            FROM pregunta_usuario pu
                            WHERE pu.idUsuario = $idUsuarioActual
                            AND pu.idPregunta = p.pregunta_id
                            )
                    ORDER BY RAND()
                    LIMIT 1";
        //Usuario Medio - Preguntas medias o preguntas nuevas
        }else if($ratio >=30 && $ratio <= 70){
            $sql = "SELECT p.pregunta_id, p.enunciado, p.categoria_id, p.respuestaA, p.respuestaB, p.respuestaC, p.respuestaD, p.respuesta_correcta, c.color
                    FROM preguntas p
                    JOIN categoria c ON p.categoria_id = c.categoria_id
                    WHERE ((p.veces_correcta * 100) / p.veces_respondida) >=30 AND ((p.veces_correcta * 100) / p.veces_respondida) <=70
                            AND NOT EXISTS (
                            SELECT 1
                            FROM pregunta_usuario pu
                            WHERE pu.idUsuario = $idUsuarioActual
                            AND pu.idPregunta = p.pregunta_id
                            )
                    OR p.veces_correcta = 0 
                    OR p.veces_respondida = 0
                    ORDER BY RAND()
                    LIMIT 1";
        //Usuario con muchas respuestas correctas - Preguntas dificiles
        }else{
            $sql = "SELECT p.pregunta_id, p.enunciado, p.categoria_id, p.respuestaA, p.respuestaB, p.respuestaC, p.respuestaD, p.respuesta_correcta, c.color
                    FROM preguntas p
                    JOIN categoria c ON p.categoria_id = c.categoria_id
                    WHERE ((p.veces_correcta * 100) / p.veces_respondida) <30
                            AND NOT EXISTS (
                            SELECT 1
                            FROM pregunta_usuario pu
                            WHERE pu.idUsuario = $idUsuarioActual
                            AND pu.idPregunta = p.pregunta_id
                            )
                    ORDER BY RAND()
                    LIMIT 1";
        }

        $resultado = $this->database->getOne($sql);

        if($resultado == null){
            $sql = "SELECT p.pregunta_id, p.enunciado, p.categoria_id, p.respuestaA, p.respuestaB, p.respuestaC, p.respuestaD, p.respuesta_correcta, c.color
                    FROM preguntas p
                    JOIN categoria c ON p.categoria_id = c.categoria_id
                    ORDER BY RAND()
                    LIMIT 1";
            $resultado = $this->database->getOne($sql);
        }

        return $resultado;
    }

    public function obtenerNivelUsuario($idUsuarioActual){
        $sql1 = "SELECT COUNT(*) AS totalPreguntas FROM pregunta_usuario WHERE idUsuario = $idUsuarioActual";
        $resultado1 = $this->database->execute($sql1);

        $total = 0;
        $totalCorrecta = 0;

        if ($resultado1 === true) {
            $row = $resultado1->fetch_assoc();
            $total = $row['totalPreguntas'];
        }

        $sql2 = "SELECT COUNT(*) AS totalCorrectas FROM pregunta_usuario WHERE estadoRespuesta = 1  AND idUsuario = $idUsuarioActual";
        $resultado2 = $this->database->execute($sql2);

        if ($resultado2 === true) {
            $row = $resultado2->fetch_assoc();
            $totalCorrecta = $row['totalCorrectas'];
        }

        if($total === 0 || $totalCorrecta === 0){
            $ratio = 50;
        }else{
            $ratio = ($totalCorrecta * 100) / $total;
        }

        /*Mayor respuestas correctas, mayor ratio*/

        return $ratio;

    }


    public function obtenerPreguntaPorId($strIdPregunta){

        //TODO mejorar como se selecciona aleatoriamente

            $sql = "SELECT P.* FROM preguntas P
            WHERE P.pregunta_id = $strIdPregunta";
            return $this->database->getOne($sql);

        $sql = "SELECT P.* FROM preguntas P
        WHERE P.pregunta_id = $strIdPregunta";
        return $this->database->getOne($sql);
    }


    public function aumentarRespondidaBien($idPregunta){
        $sql = "UPDATE preguntas SET veces_correcta = veces_correcta + 1 WHERE pregunta_id='$idPregunta'";
        $this->database->execute($sql);
    }

    public function aumentarCantidadDeVeces($idPregunta){
        $sql = "UPDATE preguntas SET veces_respondida = veces_respondida + 1 WHERE pregunta_id='$idPregunta'";
        $this->database->execute($sql);
    }


    public function agregarPreguntaEnBD($valores){
        $insert = 'INSERT INTO `preguntas`
                   (enunciado, respuestaA, respuestaB, respuestaC, respuestaD, respuesta_correcta, categoria_id,preguntaSugerida,fecha)' . $valores . ";";
        $this->database->execute($insert);
    }

    public function buscarPreguntasEnBD($buscado){
        $sql ="SELECT * FROM preguntas WHERE pregunta_id LIKE '%$buscado%' OR enunciado LIKE '%$buscado%'";
        return $this->database->query($sql);
    }

    public function eliminarPreguntaEnBD($valor){
        $delete ="DELETE FROM preguntas WHERE pregunta_id = $valor";
        $this->database->execute($delete);
    }

    public function modificarPreguntaEnBD($valores){
        $id = $valores['idPregunta'];
        $enunciado = $valores['enunciado'];
        $opcionA = $valores['opcionA'];
        $opcionB = $valores['opcionB'];
        $opcionC = $valores['opcionC'];
        $opcionD = $valores['opcionD'];
        $respuesta = $valores['respuesta'];


        $sql = "UPDATE preguntas SET enunciado = '$enunciado', respuestaA = '$opcionA', respuestaB = '$opcionB', respuestaC = '$opcionC', respuestaD = '$opcionD', respuesta_correcta = '$respuesta' WHERE pregunta_id='$id'";

        $this->database->execute($sql);
    }

    public function agregarSugerenciaEnBD($valores){
        $insert = 'INSERT INTO `pregunta_sugerida`
                   (enunciado_s, respuestaA_s, respuestaB_s, respuestaC_s, respuestaD_s, respuesta_correcta_s, categoria_id_s, creado_por)' . $valores . ";";
        $this->database->execute($insert);
    }

    public function listarPreguntasSugeridasEnBD(){
        $sql ="SELECT * FROM pregunta_sugerida WHERE estado = 0";
        return $this->database->query($sql);
    }

    public function obtenerPreguntaSugeridaEnBD($idSugerida){
        $sql ="SELECT * FROM pregunta_sugerida WHERE id_sugerencia = $idSugerida";
        return $this->database->query($sql);
    }

    public function actualizarSugerencia($flag,$id){
        if($flag=="Aceptar"){
            $sql = "UPDATE pregunta_sugerida SET estado = 1 WHERE id_sugerencia='$id'";

        }else if($flag=="Eliminar"){
            $sql = "DELETE FROM pregunta_sugerida WHERE id_sugerencia = $id";
        }

        $this->database->execute($sql);
    }

    public function agregarReporteEnBD($valores){
        $id = $valores['idPregunta'];
        $motivo = $valores['motivo'];

        $sql = "UPDATE preguntas SET motivo_reporte = '$motivo', reportada = 1 WHERE pregunta_id='$id'";

        $this->database->execute($sql);
    }

    public function listarPreguntasReportadasEnBD(){
        $sql ="SELECT * FROM preguntas WHERE reportada = 1";
        return $this->database->query($sql);
    }

    public function actualizarReportada($flag,$id){
        if($flag=="Desestimar"){
            $sql = "UPDATE preguntas SET reportada = 0, motivo_reporte='' WHERE pregunta_id='$id'";

        }else if($flag=="Eliminar"){
            $sql = "DELETE FROM preguntas WHERE pregunta_id = $id";
        }

        $this->database->execute($sql);
    }

}