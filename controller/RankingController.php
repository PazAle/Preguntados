<?php

class RankingController{

    private $rankingModel;
    private $renderer;


    public function __construct($rankingModel,$renderer){
        $this->rankingModel = $rankingModel;
        $this->renderer = $renderer;
    }


    public function obtenerRanking(){
        $data["usuarios"] = $this->rankingModel->listar();
        if(isset($_SESSION['rol'])){
            switch ($_SESSION['rol']){
                case 1:
                    $data["admin"] = 1;
                    break;
                case 2:
                    $data["editor"] = 2;
                    break;
                case 3:
                    $data["usuarioComun"] = 3;
                    breaK;
            }
        }
        $this->renderer->render("ranking", $data);
    }


}