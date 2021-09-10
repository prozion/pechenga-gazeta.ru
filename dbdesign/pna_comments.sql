CREATE TABLE `2007681_1`.pna_comments (
       id INT NOT NULL AUTO_INCREMENT
     , `_status` VARCHAR(255) DEFAULT 'active'
     , name VARCHAR(255)
     , town VARCHAR(255)
     , text TEXT
     , email VARCHAR(255)
     , ip VARCHAR(15)
     , datetime DATETIME
     , article_id INT
     , PRIMARY KEY (id)
     , INDEX (article_id)
     , CONSTRAINT FK_pna_comments_1 FOREIGN KEY (article_id)
                  REFERENCES pnarc.pna_articles (id) ON DELETE CASCADE ON UPDATE CASCADE
);

