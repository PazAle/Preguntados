<?php

class PerfilModel{
    private $database;

    public function __construct($database)
    {
        $this->database = $database;
    }

    public function obtenerDatos($idUsuario){
        $sql = "SELECT *  FROM usuario WHERE idUsuario='$idUsuario'";
        return $this->database->query($sql);
    }
    public function obtenerDatosPartidas($idUsuario){
        $sql = "SELECT P.* FROM partida P JOIN usuario U ON P.idUsuario=U.idUsuario 
           WHERE U.idUsuario='$idUsuario' AND P.terminada = 1 ORDER BY  P.numPartidaDelJugador DESC";
        return $this->database->query($sql);
    }
}