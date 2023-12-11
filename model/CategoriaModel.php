<?php

class CategoriaModel{
    private $database;

    public function __construct($database)
    {
        $this->database = $database;
    }

    public function agregarCategoriaEnBD($valores){
        $insert = 'INSERT INTO `categoria`
                   (nombre, color)' . $valores . ";";
        $this->database->execute($insert);
    }

    public function listar(){
        $sql = 'SELECT * FROM categoria';

        return $this->database->query($sql);
    }

}