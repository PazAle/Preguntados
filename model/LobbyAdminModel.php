<?php

class LobbyAdminModel
{
    private $database;

    public function __construct($database)
    {
        $this->database = $database;
    }

    public function cantidadDeJugadoresTotales($fecha)
    {
        $sql = "SELECT MONTHNAME(fecha_registro) AS mes, count(*) AS cantidad  FROM usuario WHERE fecha_registro <='$fecha' AND idRol=3 GROUP BY MONTH(fecha_registro)";

        return $this->database->query($sql);


    }

    public function cantidadDePartidasJugadas($fecha)
    {
        $sql = "SELECT MONTHNAME(fecha) AS mes, count(*) AS cantidad  FROM partida WHERE terminada=1 AND fecha <='$fecha' GROUP BY MONTH(fecha)";
        return $this->database->query($sql);

    }

    public function cantidadDePreguntasEnJuego($fecha)
    {

        $sql = "SELECT MONTHNAME(fecha) AS mes, count(*) AS cantidad  FROM preguntas WHERE fecha <='$fecha' GROUP BY MONTH(fecha)";
        return $this->database->query($sql);
    }

    public function cantidadDePreguntasDadasDeAlta($fecha)
    {
        $sql="SELECT MONTHNAME(fecha) AS mes, count(*) AS cantidad FROM preguntas WHERE preguntaSugerida=1 AND fecha <='$fecha' GROUP BY MONTH(fecha)";

        return $this->database->query($sql);

    }

    public function cantidadDeUsuariosNuevos($fecha)
    {

        $sql = "SELECT WEEK(fecha_registro,3) AS semana,count(*) AS cantidad FROM usuario WHERE MONTH(fecha_registro) = MONTH('$fecha') GROUP BY semana ORDER BY semana;";
        return $this->database->query($sql);

    }

    /*ESTA MAL*/
    public function porcentajeDePreguntasRespondidasCorrectamentePorElUsuario($fecha)
    {
        $sql1="SELECT SUM(P.puntosObtenidos) AS suma FROM partida P JOIN usuario U ON U.idUsuario=P.idUsuario WHERE P.fecha <='$fecha'";
        $respuestaSql=$this->database->getOne($sql1);

        $respuestaFinal=$respuestaSql['suma'];

        $sql2 = "SELECT U.usuario AS nombre, ('$respuestaFinal'/count(*))*100 AS porcentaje FROM usuario U JOIN pregunta_usuario P ON U.idUsuario= P.idUsuario WHERE P.respuesta IS NOT NULL AND U.idRol=3 GROUP BY U.nombre";
        return $this->database->query($sql2);

    }

    public function cantidadDeUsuariosPorPais($fecha)
    {

        $sql = "SELECT pais, count(*) AS cantidad FROM usuario WHERE fecha_registro <='$fecha' AND idRol=3 GROUP BY pais";
        return $this->database->query($sql);


    }

    /*REVISAR*/
    public function cantidadDeUsuariosPorSexo($fecha)
    {

        $sql = "SELECT genero,count(*) AS cantidad FROM usuario WHERE fecha_registro <='$fecha' AND idRol=3 GROUP BY genero";
        return $this->database->query($sql);


    }

    public function cantidadDeUsuariosPorGrupoDeEdad($fecha)
    {
        $sql = "SELECT grupoEdad,count(*) AS cantidad FROM usuario WHERE fecha_registro <='$fecha' AND idRol=3 GROUP BY grupoEdad";
                return $this->database->query($sql);

        }

}