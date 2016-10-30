CREATE DATABASE IF NOT EXISTS maimai_blogchecker_developer;
USE maimai_blogchecker_developer;

create table users (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT,
  email VARCHAR(256),
  confirm_id VARCHAR(256),
  status INT UNSIGNED,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY(id)
);
