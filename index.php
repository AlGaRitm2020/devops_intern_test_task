<?php
$host = '127.0.0.1';
$db = 'testdb';
$user = 'app';
$pass = 'password';

try {
    $pdo = new PDO("mysql:host=$host;dbname=$db", $user, $pass);
    $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

    $stmt = $pdo->query("SELECT content FROM messages LIMIT 2");
    $rows = $stmt->fetchAll(PDO::FETCH_COLUMN);

    echo "<h1>Данные из базы:</h1>";
    foreach ($rows as $row) {
        echo "<p>$row</p>";
    }
} catch (PDOException $e) {
    die("Ошибка подключения к БД: " . $e->getMessage());
}
?>
