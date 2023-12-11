<?php

class CategoriaController{

    private $categoriaModel;
    private $renderer;


    public function __construct($categoriaModel,$renderer){
        $this->categoriaModel = $categoriaModel;
        $this->renderer = $renderer;
    }


    public function procesarCategoria(){
        if (isset($_POST['add'])) {
            $errors = array();
            $categoria = $_POST['categoria'];
            $color = $_POST['color'];

            if (empty($_POST['categoria'])) {
                $errors['categoria'] = 'Por favor indique una categoria';
            }

            if (count($errors) > 0) {
                $erroresEncontrados = $errors;

                $data = array('errors' => $erroresEncontrados);
                if($_SESSION['rol']=2) {
                    $data['editor'] = 2;
                }
                $this->renderer->render("agregarCategoria", $data);
                exit;
            }

            $valores = "VALUES ('$categoria', '$color')";
            $this->categoriaModel->agregarCategoriaEnBD($valores);

            $this->renderer->render("pregunta_exito");
        }

    }


}