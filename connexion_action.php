<?php
session_start();
require_once 'includes/db.php'; 

if ($_SERVER["REQUEST_METHOD"] == "POST") {
    $email = $_POST["email"];
    $mot_de_passe = $_POST["mot_de_passe"];

    
    $stmt = $pdo->prepare("SELECT * FROM utilisateurs WHERE email = ? AND type = 'professeur'");
    $stmt->execute([$email]);
    $prof = $stmt->fetch(PDO::FETCH_ASSOC);

    
    if ($prof && password_verify($mot_de_passe, $prof['mot_de_passe'])) {
        
        $_SESSION["professeur_id"] = $prof["id"];
        $_SESSION["nom"] = $prof["nom"];
        $_SESSION["prenom"] = $prof["prenom"];

        
        header("Location: espace_professeur.php");
        exit();
    } else {
        echo "<script>alert('Email ou mot de passe incorrect.'); window.history.back();</script>";
    }
}
?>