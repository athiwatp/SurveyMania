-- MySQL Script generated by MySQL Workbench
-- 03/11/15 17:29:15
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering


-- -----------------------------------------------------
-- Schema surveymania
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS surveymania CASCADE;

-- -----------------------------------------------------
-- Schema surveymania
-- -----------------------------------------------------
CREATE SCHEMA  surveymania   ;

-- -----------------------------------------------------
-- Table surveymania.organizations
-- -----------------------------------------------------
DROP TABLE IF EXISTS surveymania.organizations CASCADE;

CREATE TABLE  surveymania.organizations (
  id SERIAL NOT NULL ,
  name VARCHAR(80) NOT NULL,
  description VARCHAR(4096) NOT NULL,
  adress VARCHAR(255) NOT NULL,
  telephone VARCHAR(20) NOT NULL,
  logo_path VARCHAR(255) NOT NULL,
  url_add_discount VARCHAR(255) NOT NULL,
  url_verify_discount VARCHAR(255) NOT NULL,
  url_remove_discount VARCHAR(255) NOT NULL,
  current_points INT NOT NULL,
  PRIMARY KEY (id));


-- -----------------------------------------------------
-- Table surveymania.survey_themes
-- -----------------------------------------------------
DROP TABLE IF EXISTS surveymania.survey_themes CASCADE;

CREATE TABLE  surveymania.survey_themes (
  id SERIAL NOT NULL ,
  theme_name VARCHAR(45) NOT NULL,
  PRIMARY KEY (id));


-- -----------------------------------------------------
-- Table surveymania.survey_headers
-- -----------------------------------------------------
DROP TABLE IF EXISTS surveymania.survey_headers CASCADE;

CREATE TABLE  surveymania.survey_headers (
  id SERIAL NOT NULL ,
  organization_id INT NOT NULL,
  theme_id INT NOT NULL,
  name VARCHAR(80) NOT NULL,
  instructions VARCHAR(4096) NULL DEFAULT NULL,
  info VARCHAR(255) NULL DEFAULT NULL,
  points INT NOT NULL,
  PRIMARY KEY (id),
  CONSTRAINT fk_organization_id
    FOREIGN KEY (id)
    REFERENCES surveymania.organizations (id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_theme_id
    FOREIGN KEY (theme_id)
    REFERENCES surveymania.survey_themes (id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table surveymania.survey_sections
-- -----------------------------------------------------
DROP TABLE IF EXISTS surveymania.survey_sections CASCADE;

CREATE TABLE  surveymania.survey_sections (
  id SERIAL NOT NULL ,
  header_id INT NOT NULL,
  title VARCHAR(80) NOT NULL,
  subtitle VARCHAR(80) NULL DEFAULT NULL,
  required BOOLEAN NOT NULL,
  PRIMARY KEY (id),
  CONSTRAINT fk_header_id
    FOREIGN KEY (header_id)
    REFERENCES surveymania.survey_headers (id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table surveymania.input_types
-- -----------------------------------------------------
DROP TABLE IF EXISTS surveymania.input_types CASCADE;

CREATE TABLE  surveymania.input_types (
  id SERIAL NOT NULL ,
  type_name VARCHAR(45) NOT NULL,
  PRIMARY KEY (id));


-- -----------------------------------------------------
-- Table surveymania.option_groups
-- -----------------------------------------------------
DROP TABLE IF EXISTS surveymania.option_groups CASCADE;

CREATE TABLE  surveymania.option_groups (
  id SERIAL NOT NULL ,
  group_name VARCHAR(45) NOT NULL,
  PRIMARY KEY (id));


-- -----------------------------------------------------
-- Table surveymania.units_measure
-- -----------------------------------------------------
DROP TABLE IF EXISTS surveymania.units_measure CASCADE;

CREATE TABLE  surveymania.units_measure (
  id SERIAL NOT NULL ,
  measure_name VARCHAR(45) NOT NULL,
  PRIMARY KEY (id));


-- -----------------------------------------------------
-- Table surveymania.questions
-- -----------------------------------------------------
DROP TABLE IF EXISTS surveymania.questions CASCADE;

CREATE TABLE  surveymania.questions (
  id SERIAL NOT NULL ,
  survey_section_id INT NOT NULL,
  input_type_id INT NOT NULL,
  option_group_id INT NULL DEFAULT NULL,
  unit_measure_id INT NOT NULL,
  name VARCHAR(255) NOT NULL,
  description VARCHAR(500) NULL DEFAULT NULL,
  required BOOLEAN NOT NULL,
  multiple_answers BOOLEAN NOT NULL,
  PRIMARY KEY (id),
  CONSTRAINT fk_survey_section_id
    FOREIGN KEY (survey_section_id)
    REFERENCES surveymania.survey_sections (id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_input_type_id
    FOREIGN KEY (input_type_id)
    REFERENCES surveymania.input_types (id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_option_group_id
    FOREIGN KEY (option_group_id)
    REFERENCES surveymania.option_groups (id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_unit_measure_id
    FOREIGN KEY (unit_measure_id)
    REFERENCES surveymania.units_measure (id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table surveymania.user_types
-- -----------------------------------------------------
DROP TABLE IF EXISTS surveymania.user_types CASCADE;

CREATE TABLE  surveymania.user_types (
  id SERIAL NOT NULL ,
  type_name VARCHAR(45) NOT NULL,
  PRIMARY KEY (id));


-- -----------------------------------------------------
-- Table surveymania.users
-- -----------------------------------------------------
DROP TABLE IF EXISTS surveymania.users CASCADE;

CREATE TABLE  surveymania.users (
  id SERIAL NOT NULL ,
  email VARCHAR(45) NOT NULL,
  password VARCHAR(255) NOT NULL,
  user_type INT NOT NULL,
  user_organization INT NULL DEFAULT NULL,
  name VARCHAR(45) NOT NULL,
  lastname VARCHAR(45) NOT NULL,
  telephone VARCHAR(45) NULL DEFAULT NULL,
  adress VARCHAR(255) NULL DEFAULT NULL,
  creation_dt TIMESTAMP NOT NULL,
  last_dt TIMESTAMP NOT NULL,
  invite_dt TIMESTAMP NULL DEFAULT NULL,
  inviter_id INT NULL DEFAULT NULL,
  points INT NOT NULL DEFAULT 0,
  verified BOOLEAN NOT NULL,
  verified_dt TIMESTAMP NULL DEFAULT NULL,
  PRIMARY KEY (id),
  CONSTRAINT fk_user_type
    FOREIGN KEY (user_type)
    REFERENCES surveymania.user_types (id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_user_organization
    FOREIGN KEY (id)
    REFERENCES surveymania.organizations (id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table surveymania.survey_comments
-- -----------------------------------------------------
DROP TABLE IF EXISTS surveymania.survey_comments CASCADE;

CREATE TABLE  surveymania.survey_comments (
  id SERIAL NOT NULL ,
  header_id INT NOT NULL,
  user_id INT NOT NULL,
  comment VARCHAR(4096) NOT NULL,
  PRIMARY KEY (id),
  CONSTRAINT fk_header_id
    FOREIGN KEY (header_id)
    REFERENCES surveymania.survey_headers (id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_user_id
    FOREIGN KEY (user_id)
    REFERENCES surveymania.users (id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table surveymania.user_survey_sections
-- -----------------------------------------------------
DROP TABLE IF EXISTS surveymania.user_survey_sections CASCADE;

CREATE TABLE  surveymania.user_survey_sections (
  id SERIAL NOT NULL ,
  user_id INT NOT NULL,
  section_id INT NOT NULL,
  completed TIMESTAMP NULL DEFAULT NULL,
  last_modification TIMESTAMP NOT NULL,
  duration INT NOT NULL DEFAULT 0,
  PRIMARY KEY (id),
  CONSTRAINT fk_user_id
    FOREIGN KEY (user_id)
    REFERENCES surveymania.users (id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_section_id
    FOREIGN KEY (section_id)
    REFERENCES surveymania.survey_sections (id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table surveymania.cashier
-- -----------------------------------------------------
DROP TABLE IF EXISTS surveymania.cashier CASCADE;

CREATE TABLE  surveymania.cashier (
  id SERIAL NOT NULL ,
  organization_id INT NOT NULL,
  code VARCHAR(15) NOT NULL,
  num INT NOT NULL,
  password VARCHAR(255) NOT NULL,
  PRIMARY KEY (id),
  CONSTRAINT fk_organization_id
    FOREIGN KEY (organization_id)
    REFERENCES surveymania.organizations (id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table surveymania.option_choices
-- -----------------------------------------------------
DROP TABLE IF EXISTS surveymania.option_choices CASCADE;

CREATE TABLE  surveymania.option_choices (
  id SERIAL NOT NULL ,
  option_group_id INT NOT NULL,
  choice_name VARCHAR(45) NOT NULL,
  PRIMARY KEY (id),
  CONSTRAINT fk_option_group_id
    FOREIGN KEY (option_group_id)
    REFERENCES surveymania.option_groups (id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table surveymania.question_options
-- -----------------------------------------------------
DROP TABLE IF EXISTS surveymania.question_options CASCADE;

CREATE TABLE  surveymania.question_options (
  id SERIAL NOT NULL ,
  question_id INT NOT NULL,
  option_choice_id INT NOT NULL,
  PRIMARY KEY (id),
  CONSTRAINT fk_question_id
    FOREIGN KEY (question_id)
    REFERENCES surveymania.questions (id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_option_choice_id
    FOREIGN KEY (option_choice_id)
    REFERENCES surveymania.option_choices (id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table surveymania.answers
-- -----------------------------------------------------
DROP TABLE IF EXISTS surveymania.answers CASCADE;

CREATE TABLE  surveymania.answers (
  id SERIAL NOT NULL ,
  user_id INT NOT NULL,
  question_option_id INT NOT NULL,
  answer_num INT NULL DEFAULT NULL,
  answer_text VARCHAR(255) NULL DEFAULT NULL,
  PRIMARY KEY (id),
  CONSTRAINT fk_user_id
    FOREIGN KEY (id)
    REFERENCES surveymania.users (id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_question_option_id
    FOREIGN KEY (question_option_id)
    REFERENCES surveymania.question_options (id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table surveymania.user_surveys
-- -----------------------------------------------------
DROP TABLE IF EXISTS surveymania.user_surveys CASCADE;

CREATE TABLE  surveymania.user_surveys (
  id SERIAL NOT NULL ,
  user_id INT NOT NULL,
  survey_header_id INT NOT NULL,
  completed TIMESTAMP NULL DEFAULT NULL,
  PRIMARY KEY (id),
  CONSTRAINT fk_user_id
    FOREIGN KEY (user_id)
    REFERENCES surveymania.users (id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_survey_header_id
    FOREIGN KEY (survey_header_id)
    REFERENCES surveymania.survey_headers (id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table surveymania.discount
-- -----------------------------------------------------
DROP TABLE IF EXISTS surveymania.discount CASCADE;

CREATE TABLE  surveymania.discount (
  id SERIAL NOT NULL ,
  discount_price INT NOT NULL,
  discount_perc INT NULL DEFAULT NULL,
  creation_dt TIMESTAMP NOT NULL,
  barcode INT NOT NULL,
  image_path VARCHAR(255) NULL DEFAULT NULL,
  available BOOLEAN NOT NULL,
  PRIMARY KEY (id));


-- -----------------------------------------------------
-- Table surveymania.user_discounts
-- -----------------------------------------------------
DROP TABLE IF EXISTS surveymania.user_discounts CASCADE;

CREATE TABLE  surveymania.user_discounts (
  id SERIAL NOT NULL ,
  user_id INT NOT NULL,
  discount_id INT NOT NULL,
  recieved_dt TIMESTAMP NOT NULL,
  used_dt TIMESTAMP NULL,
  used BOOLEAN NOT NULL,
  PRIMARY KEY (id),
  CONSTRAINT fk_user_id
    FOREIGN KEY (user_id)
    REFERENCES surveymania.users (id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_discount_id
    FOREIGN KEY (discount_id)
    REFERENCES surveymania.discount (id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table surveymania.surveys_discounts
-- -----------------------------------------------------
DROP TABLE IF EXISTS surveymania.surveys_discounts CASCADE;

CREATE TABLE  surveymania.surveys_discounts (
  id SERIAL NOT NULL ,
  survey_id INT NOT NULL,
  discount_id INT NOT NULL,
  PRIMARY KEY (id),
  CONSTRAINT fk_survey_id
    FOREIGN KEY (survey_id)
    REFERENCES surveymania.survey_headers (id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_discount_id
    FOREIGN KEY (discount_id)
    REFERENCES surveymania.discount (id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table surveymania.question_medias
-- -----------------------------------------------------
DROP TABLE IF EXISTS surveymania.question_medias CASCADE;

CREATE TABLE  surveymania.question_medias (
  id SERIAL NOT NULL ,
  question_id INT NOT NULL,
  media_path VARCHAR(255) NOT NULL,
  media_order INT NOT NULL,
  media_type VARCHAR(5) NOT NULL,
  PRIMARY KEY (id),
  CONSTRAINT fk_question_id
    FOREIGN KEY (question_id)
    REFERENCES surveymania.questions (id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table surveymania.user_tokens
-- -----------------------------------------------------
DROP TABLE IF EXISTS surveymania.user_tokens CASCADE;

CREATE TABLE  surveymania.user_tokens (
  id SERIAL NOT NULL ,
  user_id INT NOT NULL,
  token VARCHAR(255) NOT NULL,
  creation_dt TIMESTAMP NOT NULL,
  expiration_dt TIMESTAMP NOT NULL,
  valide BOOLEAN NOT NULL,
  PRIMARY KEY (id),
  CONSTRAINT fk_user_id
    FOREIGN KEY (user_id)
    REFERENCES surveymania.users (id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table surveymania.dashboards
-- -----------------------------------------------------
DROP TABLE IF EXISTS surveymania.dashboards CASCADE;

CREATE TABLE  surveymania.dashboards (
  id SERIAL NOT NULL ,
  survey_id INT NOT NULL,
  PRIMARY KEY (id),
  CONSTRAINT fk_survey_id
    FOREIGN KEY (survey_id)
    REFERENCES surveymania.survey_headers (id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table surveymania.achievements
-- -----------------------------------------------------
DROP TABLE IF EXISTS surveymania.achievements CASCADE;

CREATE TABLE  surveymania.achievements (
  id SERIAL NOT NULL ,
  name VARCHAR(45) NOT NULL,
  image_path VARCHAR(255) NOT NULL,
  description VARCHAR(255) NOT NULL,
  PRIMARY KEY (id));


-- -----------------------------------------------------
-- Table surveymania.user_achievements
-- -----------------------------------------------------
DROP TABLE IF EXISTS surveymania.user_achievements CASCADE;

CREATE TABLE  surveymania.user_achievements (
  id SERIAL NOT NULL ,
  user_id INT NOT NULL,
  achiev_id INT NOT NULL,
  recieved_dt TIMESTAMP NOT NULL,
  PRIMARY KEY (id),
  CONSTRAINT fk_user_id
    FOREIGN KEY (user_id)
    REFERENCES surveymania.users (id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_achiev_id
    FOREIGN KEY (achiev_id)
    REFERENCES surveymania.achievements (id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table surveymania.user_verifications
-- -----------------------------------------------------
DROP TABLE IF EXISTS surveymania.user_verifications CASCADE;

CREATE TABLE  surveymania.user_verifications (
  id SERIAL NOT NULL ,
  user_id INT NOT NULL,
  code VARCHAR(255) NOT NULL,
  creation_dt TIMESTAMP NOT NULL,
  PRIMARY KEY (id),
  CONSTRAINT fk_user_id
    FOREIGN KEY (user_id)
    REFERENCES surveymania.users (id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);