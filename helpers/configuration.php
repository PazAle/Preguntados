<?php

include_once('helpers/MySqlDatabase.php');
include_once("third-party/phpqrcode/qrlib.php");
include_once('Router.php');

include_once('helpers/MustacheRender.php');
include_once('third-party/mustache/src/Mustache/Autoloader.php');

include_once('controller/SesionController.php');
include_once('controller/RegistroController.php');
include_once('controller/LoginController.php');
include_once('controller/LobbyUsuarioController.php');
include_once('controller/PartidaController.php');
include_once('controller/RankingController.php');
include_once('controller/PerfilController.php');
include_once('controller/LobbyAdminController.php');
include_once('controller/PreguntaController.php');
include_once('controller/CategoriaController.php');



include_once('model/SesionModel.php');
include_once('model/RegistroModel.php');
include_once('model/PreguntaModel.php');
include_once('model/PartidaModel.php');
include_once('model/RankingModel.php');
include_once('model/PerfilModel.php');
include_once ('model/LobbyAdminModel.php');
include_once('model/CategoriaModel.php');

class configuration{

    private $configFile = 'config/config.ini';
    private $arrData;

    public function __construct() {
        $this->arrData = parse_ini_file($this->configFile);
    }

    public function getRouter() {
        return new Router(
            $this,
            "getLoginController",
            "execute");
    }

    public function getDataBase(){
        $config =  $this->arrData;
        return new MySqlDatabase(
            $config['servername'],
            $config['username'],
            $config['password'],
            $config['database']);
    }

    public function getConfigParameter($strField){
        if(isset($this->arrData[$strField])){
            return $this->arrData[$strField];
        }
        return null;
    }


    private function getRenderer() {
        return new MustacheRender('view/partial');
    }

    public function getLoginController(){
        return new LoginController($this->getRenderer());
    }
    public function getLobbyUsuarioController(){
        return new LobbyUsuarioController($this->getRenderer(),new PerfilModel($this->getDataBase()),new CategoriaModel($this->getDataBase()));
    }

    public function getSesionController(){
        return new SesionController(new SesionModel($this->getDataBase()),$this->getRenderer(), new PerfilModel($this->getDataBase()));
    }

    public function getRegistroController(){
        return new RegistroController(new RegistroModel($this->getDataBase()),$this->getRenderer());
    }

    public function getPartidaController(){
        return new PartidaController(new PartidaModel($this->getDataBase()),new PreguntaModel($this->getDataBase()),$this->getRenderer());
    }

    public function getRankingController(){
        return new RankingController(new RankingModel($this->getDataBase()),$this->getRenderer());
    }

    public function getPerfilController(){
        return new PerfilController(new PerfilModel($this->getDataBase()),$this->getRenderer());
    }

    public function getLobbyAdminController(){
        return new LobbyAdminController($this->getRenderer(),new LobbyAdminModel($this->getDataBase()),new PerfilModel($this->getDataBase()));
    }
    public function getPreguntaController(){
        return new PreguntaController(new PreguntaModel($this->getDataBase()),$this->getRenderer());
    }

    public function getCategoriaController(){
        return new CategoriaController(new CategoriaModel($this->getDataBase()),$this->getRenderer());
    }


}