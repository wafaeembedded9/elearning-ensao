<?php
require_once 'includes/db.php'; 

if ($_SERVER["REQUEST_METHOD"] == "POST") {
    
    $identifiant = $_POST['id_etudiant'];  
    $nom = trim($_POST['nom']);
    $prenom = trim($_POST['prenom']);
    $filiere = trim($_POST['filiere']); 
    $email = trim($_POST['email_inscription']);
    $mot_de_passe = $_POST['mot_de_passe_inscription'];
    $confirmation = $_POST['confirmation_mot_de_passe'];

    
    $erreurs = [];

    
    if ($mot_de_passe !== $confirmation) {
        $erreurs[] = "Les mots de passe ne correspondent pas.";
    }

    
    if (strlen($mot_de_passe) < 8) {
        $erreurs[] = "Le mot de passe doit contenir au moins 8 caractères.";
    }

    
    if (!filter_var($email, FILTER_VALIDATE_EMAIL)) {
        $erreurs[] = "L'adresse email n'est pas valide.";
    }

    
    $stmt = $pdo->prepare("SELECT id FROM utilisateurs WHERE email = ? OR identifiant = ?");
    $stmt->execute([$email, $identifiant]);
    if ($stmt->rowCount() > 0) {
        $erreurs[] = "Cet email ou identifiant est déjà utilisé.";
    }


    if (!empty($erreurs)) {
        echo "<script>alert('" . implode("\\n", $erreurs) . "'); window.history.back();</script>";
        exit();
    }

    
    $mot_de_passe_hache = password_hash($mot_de_passe, PASSWORD_DEFAULT);

    
    try {
        $stmt = $pdo->prepare("INSERT INTO utilisateurs 
                              (type, identifiant, nom, prenom, email, mot_de_passe, departement_filiere) 
                              VALUES ('etudiant', ?, ?, ?, ?, ?, ?)");

        $result = $stmt->execute([
            $identifiant,
            $nom,
            $prenom,
            $email,
            $mot_de_passe_hache,
            $filiere
        ]);

        if ($result) {
            
            echo "<script>
                alert('Inscription réussie. Vous pouvez maintenant vous connecter.');
                window.location.href = 'espace_etudiant.html'; // page de connexion étudiant
            </script>";
            exit();
        }
    } catch (PDOException $e) {
        error_log("Erreur d'inscription étudiant: " . $e->getMessage());
        echo "<script>
            alert('Une erreur technique est survenue. Veuillez réessayer plus tard.');
            window.history.back();
        </script>";
        exit();
    }
} else {
    
    header("Location: etudiant.html"); 
    exit();
}
?>