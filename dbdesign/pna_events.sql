CREATE TABLE pna_events (
       id INT NOT NULL AUTO_INCREMENT
     , `_updated` TIMESTAMP
     , `_status` CHAR(255) DEFAULT 'active'
     , date DATE
     , title CHAR(255)
     , PRIMARY KEY (id)
);

