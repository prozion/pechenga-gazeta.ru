CREATE TABLE pna_messages (
       id INT NOT NULL AUTO_INCREMENT
     , `_status` VARCHAR(255) DEFAULT 'active'
     , name VARCHAR(255)
     , town VARCHAR(255)
     , text TEXT
     , commentary TEXT
     , ip VARCHAR(15)
     , datetime DATETIME
     , PRIMARY KEY (id)
);

