<?php


use PHPMailer\PHPMailer\PHPMailer;
use PHPMailer\PHPMailer\Exception;


require './third-party/phpmailer/Exception.php';
require './third-party/phpmailer/PHPMailer.php';
require './third-party/phpmailer/SMTP.php';


class RegistroController
{
    private $registroModel;
    private $renderer;

    public function __construct($registroModel, $renderer)
    {
        $this->registroModel = $registroModel;
        $this->renderer = $renderer;
    }

    public function execute()
    {
        echo $this->renderer->render("registro");
    }

    public function procesarFormulario()
    {
        if (isset($_POST['enviarRegistro'])) {
            $errors = array();
            $nombre = $_POST['nombre'];
            $apellido = $_POST['apellido'];
            $fechaNac = $_POST['fechaNac'];
            $genero = $_POST['genero'];
            $pais = $_POST['pais'];
            $ciudad = $_POST['ciudad'];
            $coordenadas = $_POST['direccion'];
            $email = $_POST['email'];
            $contrasenia = $_POST['contrasenia'];
            $contraseniaRepe = $_POST['contraseniaRepe'];
            $usuario = $_POST['usuario'];
            $estado = 0;
            $fechaRegistro = date("Y/m/d");
            $idRol = 3;

            $partesCoordenadas = explode(",", $coordenadas);

            $latitud = trim($partesCoordenadas[0]); // Obtener la latitud
            $longitud = trim($partesCoordenadas[1]); // Obtener la longitud

            /*CALCULCAR GRUPO DE EDAD*/
            $fechaRegistroParaUsarLaFuncionDiffMasAdelante = DateTime::createFromFormat('Y/m/d', $fechaRegistro);

            $fechaNacEnFormatoDate = dateTime::createFromFormat('Y-m-d', $fechaNac); // Convierte el string a un objeto DateTime


            $intervalo = $fechaNacEnFormatoDate->diff($fechaRegistroParaUsarLaFuncionDiffMasAdelante); // Calcula la diferencia entre las fechas y obtiene un objeto DateInterval que tiene diferencia de fechas

            $edad = $intervalo->y; // Obtiene la diferencia en años
            $grupoEdad='';
            switch (true){
                case $edad < 18:
                   $grupoEdad='menor';
                    break;

                case $edad> 18 && $edad < 60:
                    $grupoEdad='medio';
                    break;
                case $edad > 60:
                    $grupoEdad='jubilado';
                    break;

            }

            if ($contrasenia != $contraseniaRepe) {
                $errors['contraseña'] = 'La contraseñas deben ser iguales';
            }


            /*LE APLICO HASH A LA CONTRASEÑA*/
            $contraseniaHasheada = md5($contrasenia);



            /*VERIFICO SI EL USUARIO EXISTE*/
            $usuarioBuscado = $this->registroModel->verificarSiExisteUsuario($usuario);
            if (count($usuarioBuscado) >= 1) {
                $errors['usuario'] = 'El usuario ya existe';
            }



            /*VERIFICO SI EL EMAIL ESTA EN UN FORMATO CORRECTO*/
            if (!filter_var($email, FILTER_VALIDATE_EMAIL)) {
                $errors['email'] = 'El correo electrónico no tiene un formato válido';
            }



            // VERIFICO SI HAY ERRORES Y LOS MANDO A LA VISTA
            if (count($errors) > 0) {
                $erroresEncontrados = $errors;

                $data = array('errors' => $erroresEncontrados);

                $this->renderer->render("registro", $data);
                exit;
            }

            $target_dir = "./uploads/";
            $target_file = $target_dir . basename($_FILES["foto"]["name"]);
            $uploadOk = 1;
            $imageFileType = strtolower(pathinfo($target_file,PATHINFO_EXTENSION));
            $target_file = $target_dir . $_REQUEST["usuario"] . "." . $imageFileType;

            if($imageFileType != "jpg" && $imageFileType != "png" && $imageFileType != "jpeg"
                && $imageFileType != "gif" ) {
                echo "Sorry, only JPG, JPEG, PNG & GIF files are allowed.";
                $uploadOk = 0;
            }

            if ($uploadOk == 0) {
                echo "Sorry, your file was not uploaded.";
            } else {
                if (move_uploaded_file($_FILES["foto"]["tmp_name"], $target_file)) {
                    echo "The file ". htmlspecialchars( basename( $_FILES["foto"]["name"])). " has been uploaded.";
                } else {
                    echo "Sorry, there was an error uploading your file.";
                }
            }

            $hash_de_registro = hash("md5", time());

            $valores = "VALUES ('$nombre', '$apellido', '$fechaNac','$grupoEdad', '$genero', '$pais', '$ciudad', '$latitud','$longitud', '$email', '$contraseniaHasheada','$hash_de_registro', '$usuario', '$estado', '$fechaRegistro', '$idRol', '$target_file')";
            $this->registroModel->altaUsuario($valores);
            $this->generarQr($usuario);

            /*Envio de email de confirmacion*/

            $mail = new PHPMailer(true);
            $mail->IsSMTP();
            $mail->SMTPAuth = true;
            $mail->Host = 'smtp.gmail.com';
            $mail->Username = 'unlamtrivia2023@gmail.com';
            $mail->Password = 'yajdxumayekelxtl';
            $mail->Port = 587;
            $mail->CharSet = 'UTF-8';

            $mail->setFrom('unlamtrivia2023@gmail.com', 'Unlam Trivia 2023');
            $mail->addAddress($email);

            $asunto = 'Registracion | Email de confirmacion';

            $mail->isHTML(true);
            $mail->Subject = $asunto;
            $cuerpo =  '
 
                    ¡Gracias por registrarse!</br>
                    Su cuenta ha sido creada, puede ingresar con las siguientes credenciales luego de que haya activado su cuenta presionando en el link que se encuenta debajo</br>
                    </br>
                    ------------------------</br>
                    Email: '.$email.'</br>
                    ------------------------</br>
                     </br>
                    Por favor, clickee este link para activar su cuenta:</br>
                    <a href="http://localhost/registro/verificacion?email='.$email.'&hash='.$hash_de_registro.'" > Activación </a>
                    ';

            $mail->msgHTML($cuerpo);

            if (!$mail->send()) {
                echo "<script>alert('$mail->ErrorInfo')</script>";
            } else {
                header('location: /registro/confirmacion');
                exit();
            }
        }
    }

    public function confirmacion(){
        $this->renderer->render("registro_pendiente");
    }

    public function verificacion(){
        if(isset($_GET['email']) && !empty($_GET['email']) AND isset($_GET['hash']) && !empty($_GET['hash'])) {
            $email = $_GET['email'];
            $hash = $_GET['hash'];

            $finalizar = $this->registroModel->finalizarRegistro($email, $hash);

            if($finalizar == 1){
                $mensaje = "Su cuenta ha sido activada, ahora puede ingresar.";
            }else{
                $mensaje= "La url es inválida o ustded ya ha activado su cuenta.";
            }

            $data = array('mensaje' => $mensaje);

            $this->renderer->render("registro_finalizar",$data);
        }
    }

    public function generarQr($usuario){
        $contenidoQR = "http://localhost/perfil/verPerfil?usuario=$usuario";
        $nombreArchivoQR = 'qrcode_' . $usuario . '.png';
        $rutaQR = './uploads/' . $nombreArchivoQR;
        QRcode::png($contenidoQR, $rutaQR, QR_ECLEVEL_L, 10);
    }

}

