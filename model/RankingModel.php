<?php

class RankingModel{
    private $database;

    public function __construct($database)
    {
        $this->database = $database;
    }

    public function listar(){
        $sql = 'SELECT idUsuario, usuario, puntosTotales FROM usuario WHERE idRol=3 ORDER BY  puntosTotales DESC';

        return $this->database->query($sql);
    }

}