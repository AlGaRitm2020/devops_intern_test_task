-- Создаём базу данных
CREATE DATABASE IF NOT EXISTS testdb;
USE testdb;

-- Создаём таблицу
CREATE TABLE IF NOT EXISTS messages (
    id INT AUTO_INCREMENT PRIMARY KEY,
    content VARCHAR(255) NOT NULL
);

-- Вставляем данные
INSERT INTO messages (content) VALUES
('место для творчества'),
('в эпоху ИИ');

-- Создаём пользователя 'app' с паролем 'password' и даём ему права на testdb
CREATE USER IF NOT EXISTS 'app'@'localhost' IDENTIFIED BY 'password';
GRANT ALL PRIVILEGES ON testdb.* TO 'app'@'localhost';
FLUSH PRIVILEGES;
