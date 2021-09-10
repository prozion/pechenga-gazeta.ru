CREATE TABLE pna_visits (
       id INT NOT NULL AUTO_INCREMENT
     , article INT
     , ip CHAR(15)
     , time TIMESTAMP
     , PRIMARY KEY (id)
);

ALTER TABLE pna_visits
  ADD CONSTRAINT FK_pna_visits_1
      FOREIGN KEY (article)
      REFERENCES pna_articles (id);

