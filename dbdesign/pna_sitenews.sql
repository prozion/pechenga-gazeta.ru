CREATE TABLE pna_sitenews (
       id INT NOT NULL AUTO_INCREMENT
     , `_updated` TIMESTAMP
     , `_status` CHAR(255) DEFAULT 'active'
     , date DATE
     , title CHAR(255)
     , PRIMARY KEY (id)
);

