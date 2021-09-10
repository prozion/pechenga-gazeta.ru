CREATE TABLE pna_authors (
       id INT NOT NULL AUTO_INCREMENT
     , surname VARCHAR(255)
     , name VARCHAR(255)
     , secondName VARCHAR(255)
     , penname VARCHAR(255)
     , info TEXT
     , PRIMARY KEY (id)
) type=InnoDB;

CREATE TABLE pna_issues (
       id INT NOT NULL AUTO_INCREMENT
     , type set('sp', 'pe') DEFAULT 'pe'
     , date DATE
     , number INT
     , UNIQUE pna_issue_1 (number)
     , PRIMARY KEY (id)
) type=InnoDB;

CREATE TABLE pna_editors (
       id INT NOT NULL AUTO_INCREMENT
     , login VARCHAR(255)
     , password VARCHAR(255)
     , UNIQUE UQ_pna_editors_1 (login)
     , PRIMARY KEY (id)
) type=InnoDB;

CREATE TABLE pna_rubrics (
       id INT NOT NULL AUTO_INCREMENT
     , name VARCHAR(255)
     , description TEXT
     , PRIMARY KEY (id)
) type=InnoDB;

CREATE TABLE pna_places (
       id INT NOT NULL AUTO_INCREMENT
     , name VARCHAR(255)
     , description TEXT
     , PRIMARY KEY (id)
) type=InnoDB;

CREATE TABLE pna_articles (
       id INT NOT NULL AUTO_INCREMENT
     , `_updated` TIMESTAMP
     , `_created` DATETIME
     , title VARCHAR(255)
     , picture VARCHAR(255)
     , text TEXT
     , authorline VARCHAR(255)
     , issue INT
     , rubric INT
     , contributor INT
     , PRIMARY KEY (id)
) type=InnoDB;

CREATE TABLE pna_articles_places (
       id INT NOT NULL AUTO_INCREMENT
     , article_id INT
     , place_id INT
     , PRIMARY KEY (id)
) type=InnoDB;

CREATE TABLE pna_articles_authors (
       id INT NOT NULL AUTO_INCREMENT
     , article_id INT
     , author_id INT
     , PRIMARY KEY (id)
) type=InnoDB;

ALTER TABLE pna_articles
  ADD CONSTRAINT FK_pna_article_1
      FOREIGN KEY (contributor)
      REFERENCES pna_editors (id);

ALTER TABLE pna_articles
  ADD CONSTRAINT FK_pna_article_4
      FOREIGN KEY (rubric)
      REFERENCES pna_rubrics (id);

ALTER TABLE pna_articles
  ADD CONSTRAINT FK_pna_article_3
      FOREIGN KEY (issue)
      REFERENCES pna_issues (id)
   ON DELETE CASCADE
   ON UPDATE CASCADE;

ALTER TABLE pna_articles_places
  ADD CONSTRAINT FK_pna_places_articles_1
      FOREIGN KEY (article_id)
      REFERENCES pna_articles (id);

ALTER TABLE pna_articles_places
  ADD CONSTRAINT FK_pna_places_articles_2
      FOREIGN KEY (place_id)
      REFERENCES pna_places (id);

ALTER TABLE pna_articles_authors
  ADD CONSTRAINT FK_pna_authorship_1
      FOREIGN KEY (article_id)
      REFERENCES pna_articles (id);

ALTER TABLE pna_articles_authors
  ADD CONSTRAINT FK_pna_authors_articles_2
      FOREIGN KEY (author_id)
      REFERENCES pna_authors (id);


INSERT INTO `pna_issues` VALUES (1, 'pe', '2008-01-12', 1991);
INSERT INTO `pna_issues` VALUES (2, 'pe', '2008-01-16', 1992);
INSERT INTO `pna_issues` VALUES (3, 'pe', '2008-01-19', 1993);
INSERT INTO `pna_issues` VALUES (4, 'pe', '2008-01-23', 1994);
INSERT INTO `pna_issues` VALUES (5, 'pe', '2008-01-26', 1995);
INSERT INTO `pna_issues` VALUES (6, 'pe', '2008-01-30', 1996);
INSERT INTO `pna_issues` VALUES (7, 'pe', '2008-02-02', 1997);
INSERT INTO `pna_issues` VALUES (8, 'pe', '2008-02-06', 1998);
INSERT INTO `pna_issues` VALUES (9, 'pe', '2008-02-09', 1999);
INSERT INTO `pna_issues` VALUES (10, 'pe', '2008-02-13', 2000);
INSERT INTO `pna_issues` VALUES (11, 'pe', '2008-02-16', 2001);
INSERT INTO `pna_issues` VALUES (12, 'pe', '2008-02-20', 2002);
INSERT INTO `pna_issues` VALUES (13, 'pe', '2008-02-26', 2003);
INSERT INTO `pna_issues` VALUES (14, 'pe', '2008-02-27', 2004);
INSERT INTO `pna_issues` VALUES (15, 'pe', '2008-03-01', 2005);
INSERT INTO `pna_issues` VALUES (16, 'pe', '2008-03-05', 2006);
INSERT INTO `pna_issues` VALUES (17, 'pe', '2008-03-08', 2007);
INSERT INTO `pna_issues` VALUES (18, 'pe', '2008-03-12', 2008);
INSERT INTO `pna_issues` VALUES (19, 'pe', '2008-03-15', 2009);
INSERT INTO `pna_issues` VALUES (20, 'pe', '2008-03-19', 2010);
INSERT INTO `pna_issues` VALUES (21, 'pe', '2008-03-22', 2011);
INSERT INTO `pna_issues` VALUES (22, 'pe', '2008-03-26', 2012);
INSERT INTO `pna_issues` VALUES (23, 'pe', '2008-03-29', 2013);
INSERT INTO `pna_issues` VALUES (24, 'pe', '2008-04-02', 2014);
INSERT INTO `pna_issues` VALUES (25, 'pe', '2008-04-05', 2015);
INSERT INTO `pna_issues` VALUES (26, 'pe', '2008-04-09', 2016);
INSERT INTO `pna_issues` VALUES (27, 'pe', '2008-04-12', 2017);
INSERT INTO `pna_issues` VALUES (28, 'pe', '2008-04-16', 2018);
INSERT INTO `pna_issues` VALUES (29, 'pe', '2008-04-19', 2019);
INSERT INTO `pna_issues` VALUES (30, 'pe', '2008-04-23', 2020);
INSERT INTO `pna_issues` VALUES (31, 'pe', '2008-04-26', 2021);
INSERT INTO `pna_issues` VALUES (32, 'pe', '2008-04-30', 2022);
INSERT INTO `pna_issues` VALUES (33, 'pe', '2008-03-07', 2023);
INSERT INTO `pna_issues` VALUES (34, 'pe', '2008-05-09', 2024);
INSERT INTO `pna_issues` VALUES (35, 'pe', '2008-05-14', 2025);
INSERT INTO `pna_issues` VALUES (36, 'pe', '2008-05-17', 2026);
INSERT INTO `pna_issues` VALUES (37, 'pe', '2008-05-21', 2027);
INSERT INTO `pna_issues` VALUES (38, 'pe', '2008-05-24', 2028);
INSERT INTO `pna_issues` VALUES (39, 'pe', '2008-05-28', 2029);
INSERT INTO `pna_issues` VALUES (40, 'pe', '2008-05-31', 2030);

insert into pna_articles(title, issue) values('1', 10);
insert into pna_articles(title, issue) values('2', 10);
insert into pna_articles(title, issue) values('3', 10);
insert into pna_articles(title, issue) values('4', 20);
insert into pna_articles(title, issue) values('5', 20);
insert into pna_articles(title, issue) values('6', 20);
insert into pna_articles(title, issue) values('7', 20);
insert into pna_articles(title, issue) values('8', 22);
insert into pna_articles(title, issue) values('9', 22);
insert into pna_articles(title, issue) values('10', 22);
insert into pna_articles(title, issue) values('11', 22);


