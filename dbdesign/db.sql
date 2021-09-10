CREATE TABLE pna_editors (
       id INT NOT NULL AUTO_INCREMENT
     , login VARCHAR(255)
     , password VARCHAR(255)
     , UNIQUE UQ_pna_editors_1 (login)
     , PRIMARY KEY (id)
);

CREATE TABLE pna_issues (
       id INT NOT NULL AUTO_INCREMENT
     , type set('sp', 'pe') DEFAULT 'pe'
     , date DATE
     , number INT
     , UNIQUE pna_issue_1 (number)
     , PRIMARY KEY (id)
);

CREATE TABLE pna_authors (
       id INT NOT NULL AUTO_INCREMENT
     , surname VARCHAR(255)
     , name VARCHAR(255)
     , secondName VARCHAR(255)
     , penname VARCHAR(255)
     , info TEXT
     , PRIMARY KEY (id)
);

CREATE TABLE pna_places (
       id INT NOT NULL AUTO_INCREMENT
     , name VARCHAR(255)
     , description TEXT
     , PRIMARY KEY (id)
);

CREATE TABLE pna_rubrics (
       id INT NOT NULL AUTO_INCREMENT
     , name VARCHAR(255)
     , description TEXT
     , PRIMARY KEY (id)
);

CREATE TABLE pna_articles (
       id INT NOT NULL AUTO_INCREMENT
     , `_updated` TIMESTAMP
     , `_created` DATETIME
     , `_status` VARCHAR(255) DEFAULT 'active'
     , title VARCHAR(255)
     , picture VARCHAR(255)
     , text TEXT
     , issue INT
     , rubric INT
     , contributor INT
     , PRIMARY KEY (id)
);

CREATE TABLE pna_articles_authors (
       id INT NOT NULL AUTO_INCREMENT
     , article_id INT
     , author_id INT
     , PRIMARY KEY (id)
);

CREATE TABLE pna_articles_places (
       id INT NOT NULL AUTO_INCREMENT
     , article_id INT
     , place_id INT
     , PRIMARY KEY (id)
);

ALTER TABLE pna_articles
  ADD CONSTRAINT FK_pna_article_3
      FOREIGN KEY (issue)
      REFERENCES pna_issues (id)
   ON DELETE CASCADE
   ON UPDATE CASCADE;

ALTER TABLE pna_articles
  ADD CONSTRAINT FK_pna_article_4
      FOREIGN KEY (rubric)
      REFERENCES pna_rubrics (id)
   ON DELETE CASCADE
   ON UPDATE CASCADE;

ALTER TABLE pna_articles
  ADD CONSTRAINT FK_pna_article_1
      FOREIGN KEY (contributor)
      REFERENCES pna_editors (id)
   ON DELETE CASCADE
   ON UPDATE CASCADE;

ALTER TABLE pna_articles_authors
  ADD CONSTRAINT FK_pna_authors_articles_1
      FOREIGN KEY (article_id)
      REFERENCES pna_articles (id)
   ON DELETE CASCADE
   ON UPDATE CASCADE;

ALTER TABLE pna_articles_authors
  ADD CONSTRAINT FK_pna_authors_articles_2
      FOREIGN KEY (author_id)
      REFERENCES pna_authors (id)
   ON DELETE CASCADE
   ON UPDATE CASCADE;

ALTER TABLE pna_articles_places
  ADD CONSTRAINT FK_pna_places_articles_1
      FOREIGN KEY (article_id)
      REFERENCES pna_articles (id)
   ON DELETE CASCADE
   ON UPDATE CASCADE;

ALTER TABLE pna_articles_places
  ADD CONSTRAINT FK_pna_places_articles_2
      FOREIGN KEY (place_id)
      REFERENCES pna_places (id)
   ON DELETE CASCADE
   ON UPDATE CASCADE;

