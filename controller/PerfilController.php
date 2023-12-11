<?php


class PerfilController {
    private $perfilModel;
    private $renderer;


    public function __construct($perfilModel,$renderer){
        $this->perfilModel = $perfilModel;
        $this->renderer = $renderer;
    }


    public function verPerfil(){
        if(isset($_GET['usuario'])) {
            $idUsuario = $_GET['usuario'];
            $datos['usuarios'] = $this->perfilModel->obtenerDatos($idUsuario);
            $datos['userPartidas'] = $this->perfilModel->obtenerDatosPartidas($idUsuario);
            if(isset($_SESSION['rol'])){
                switch ($_SESSION['rol']){
                    case 1:
                        $datos["admin"] = 1;
                        break;
                    case 2:
                        $datos["editor"] = 2;
                        break;
                    case 3:
                        $datos["usuarioComun"] = 3;
                        breaK;
                }
            }
            $this->renderer->render("perfil", $datos);
        }else{
            header("location: /");
            exit();
        }
    }

}

