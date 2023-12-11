<?php

class LobbyUsuarioController{
    private $renderer;
    private $perfilModel;
    private $categoriaModel;



    public function __construct($renderer, $perfilModel, $categoriaModel){
        $this->renderer = $renderer;
        $this->perfilModel=$perfilModel;
        $this->categoriaModel = $categoriaModel;

    }

    public function execute()
    {
        if(!isset($_SESSION['email'])){
            header("location: /");
            exit();
        }
        $datos['datosUsur']=$this->perfilModel->obtenerDatos($_SESSION["id"]);
        $datos['userPartidas']=$this->perfilModel->obtenerDatosPartidas($_SESSION['id']);
        switch ($_SESSION['rol']){
            case "1":
                $datos['admin'] = 1;
                break;
            case "2":
                $datos['editor'] = 2;
                break;
            default:
                $datos['usuarioComun'] = 3;
                break;
        }

        echo $this->renderer->render("lobbyUsuario",$datos);
    }

    public function agregarSugerencia(){
        if(!isset($_SESSION['email'])){
            header("location: /");
            exit();
        }
        if($_SESSION['rol']=3) {
            $datos['usuarioComun'] = 3;
            $datos['datosUsur']=$this->perfilModel->obtenerDatos($_SESSION["id"]);
            $datos['categorias']=$this->categoriaModel->listar();
            $this->renderer->render("sugerirPregunta",$datos);
        }
    }
    public function agregarPregunta(){
        if(!isset($_SESSION['email'])){
            header("location: /");
            exit();
        }
         if($_SESSION['rol']=2) {
             $datos['editor'] = 2;
             $datos['categorias']=$this->categoriaModel->listar();
             $this->renderer->render("agregarPregunta",$datos);
         }
    }

    public function agregarCategoria(){
        if(!isset($_SESSION['email'])){
            header("location: /");
            exit();
        }
        if($_SESSION['rol']=2) {
            $datos['editor'] = 2;
            $this->renderer->render("agregarCategoria",$datos);
        }
    }

    public function modificarPregunta(){
        if(!isset($_SESSION['email'])){
            header("location: /");
            exit();
        }
        if($_SESSION['rol']=2) {
            $datos['editor'] = 2;
            $this->renderer->render("modificarPregunta",$datos);
        }
    }



}