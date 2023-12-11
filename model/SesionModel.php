<?php

class SesionModel
{

    private $database;

    public function __construct($database)
    {
        $this->database = $database;
    }

    public function validar($email, $clave)
    {
        $claveHasheada = md5($clave);

        $sql = "SELECT *  FROM usuario WHERE email='$email' AND contrasenia='$claveHasheada' AND estado='1'";

        return $this->database->query($sql);
    }

    public function validarEmail($email)
    {
        $sql = "SELECT email FROM usuario WHERE email='" . $email . "' AND estado='1'";
        $resultado = $this->database->query($sql);

        if ($resultado) {
            return 1;
        }
        return 0;
    }
    public function cerrarSesion()
    {
        session_destroy();
    }
}