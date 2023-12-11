<?php

class LoginController{
    private $renderer;

    public function __construct($renderer){
        $this->renderer = $renderer;
    }

    //cat 5-10p 4-7p 3-5p 2-3p 1-4p
    public function execute()
    {
        if(isset($_SESSION['email'])) {
            switch ( $_SESSION['rol']){
                case "1":
                    header("location: /lobbyAdmin");
                    break;
                default:
                    header("location: /lobbyUsuario");
                    break;
            }
        }
        echo $this->renderer->render("login");
    }
}