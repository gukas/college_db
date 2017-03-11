--  Sample college database

DROP DATABASE IF EXISTS college;
CREATE DATABASE IF NOT EXISTS college;
USE college;

SELECT 'CREATING DATABASE STRUCTURE' as 'INFO';

DROP TABLE IF EXISTS sub_faculty,
                     profession,
                     group_st,
                     lecturer,
                     enterprise,
                     representative,
                     student,
                     relative,
                     abroad,
                     var_assignment,
                     assignment,
                     payment;

CREATE TABLE sub_faculty (
    id      INT         NOT NULL,
    nomer   INT         NOT NULL,
    name    VARCHAR(60) NOT NULL,
    PRIMARY KEY (id),
    UNIQUE  KEY (name)
) DEFAULT CHARSET=utf8;

CREATE TABLE profession(
    id          INT         NOT NULL,
    nomer       INT         NOT NULL,
    name        VARCHAR(100) NOT NULL,
    sub_fac_id  INT         NOT NULL,
    FOREIGN KEY (sub_fac_id) REFERENCES sub_faculty (id) ON DELETE CASCADE,
    PRIMARY KEY (id),
    UNIQUE  KEY (nomer, name, sub_fac_id)
) DEFAULT CHARSET=utf8;

CREATE TABLE group_st(
    id          INT         NOT NULL,
    nomer       VARCHAR(30) NOT NULL,
    sub_fac_id  INT         NOT NULL,
    FOREIGN KEY (sub_fac_id) REFERENCES sub_faculty (id) ON DELETE CASCADE,
    PRIMARY KEY (id),
    UNIQUE  KEY (nomer)
) DEFAULT CHARSET=utf8;

CREATE TABLE lecturer(
    id          INT         NOT NULL,
    surname     VARCHAR(30) NOT NULL,
    name        VARCHAR(30) NOT NULL,
    sub_fac_id  INT         NOT NULL,
    FOREIGN KEY (sub_fac_id) REFERENCES sub_faculty (id) ON DELETE CASCADE,
    PRIMARY KEY (id)
) DEFAULT CHARSET=utf8;

CREATE TABLE enterprise(
    id      INT         NOT NULL,
    name    VARCHAR(30) NOT NULL,
    address VARCHAR(30) NOT NULL,
    PRIMARY KEY (id),
    UNIQUE  KEY (name, address)
) DEFAULT CHARSET=utf8;

CREATE TABLE representative(
    id      INT         NOT NULL,
    surname VARCHAR(30) NOT NULL,
    name    VARCHAR(30) NOT NULL,
    job     VARCHAR(30) NOT NULL,
    ent_id  INT         NOT NULL,
    FOREIGN KEY (ent_id) REFERENCES enterprise (id) ON DELETE CASCADE,
    PRIMARY KEY (id)
) DEFAULT CHARSET=utf8;

CREATE TABLE student(
    id          INT            NOT NULL,
    surname     VARCHAR(30)    NOT NULL,
    name        VARCHAR(30)    NOT NULL,
    sex         ENUM ('М','Ж') NOT NULL,
    birthday    DATE           NOT NULL,
    nationality VARCHAR(30)    NOT NULL,
    address     VARCHAR(30)    NOT NULL,
    mark        DECIMAL(3,2),
    group_id    INT            NOT NULL,
    FOREIGN KEY (group_id) REFERENCES group_st (id) ON DELETE CASCADE,
    PRIMARY KEY (id)
) DEFAULT CHARSET=utf8;

CREATE TABLE relative(
    id          INT            NOT NULL,
    surname     VARCHAR(30)    NOT NULL,
    name        VARCHAR(30)    NOT NULL,
    rodstvo     VARCHAR(30)    NOT NULL,
    address     VARCHAR(30),
    work_place  VARCHAR(30),
    job         VARCHAR(30),
    stud_id     INT            NOT NULL,
    FOREIGN KEY (stud_id) REFERENCES student (id) ON DELETE CASCADE,
    PRIMARY KEY (id)
) DEFAULT CHARSET=utf8;

CREATE TABLE abroad(
    id      INT            NOT NULL,
    data    DATE           NOT NULL,
    country VARCHAR(30)    NOT NULL,
    rel_id  INT            NOT NULL,
    FOREIGN KEY (rel_id) REFERENCES relative (id) ON DELETE CASCADE,
    PRIMARY KEY (id)
) DEFAULT CHARSET=utf8;

CREATE TABLE var_assignment(
    id          INT     NOT NULL,
    data_talk   DATE    NOT NULL,
    stud_id     INT     NOT NULL,
    repres_id   INT     NOT NULL,
    lect_id     INT     NOT NULL,
    ent_id      INT     NOT NULL,
    FOREIGN KEY (stud_id)   REFERENCES student (id) ON DELETE CASCADE,
    FOREIGN KEY (repres_id) REFERENCES representative (id) ON DELETE CASCADE,
    FOREIGN KEY (lect_id)   REFERENCES lecturer (id) ON DELETE CASCADE,
    FOREIGN KEY (ent_id)    REFERENCES enterprise (id) ON DELETE CASCADE,
    PRIMARY KEY (id)
) DEFAULT CHARSET=utf8;

CREATE TABLE assignment(
    id           INT     NOT NULL,
    data_contr   DATE    NOT NULL,
    data_work    DATE    NOT NULL,
    var_assig_id INT     NOT NULL,
    FOREIGN KEY (var_assig_id) REFERENCES var_assignment (id) ON DELETE CASCADE,
    PRIMARY KEY (id)
) DEFAULT CHARSET=utf8;

CREATE TABLE payment(
    id          INT             NOT NULL,
    data        DATE            NOT NULL,
    summa       DECIMAL(10,2)   NOT NULL DEFAULT 0,
    assig_id    INT             NOT NULL,
    FOREIGN KEY (assig_id) REFERENCES assignment (id) ON DELETE CASCADE,
    PRIMARY KEY (id)
) DEFAULT CHARSET=utf8;

flush logs;

SELECT 'INSERTING sub_faculty' as 'INFO';
source insert_sub_faculty.sql;
SELECT 'INSERTING profession' as 'INFO';
source insert_profession.sql;
SELECT 'INSERTING group_st' as 'INFO';
source insert_group_st.sql;
SELECT 'INSERTING lecturer' as 'INFO';
source insert_lecturer.sql;
SELECT 'INSERTING enterprise' as 'INFO';
source insert_enterprise.sql;
SELECT 'INSERTING representative' as 'INFO';
source insert_representative.sql;
SELECT 'INSERTING student' as 'INFO';
source insert_student.sql;
SELECT 'INSERTING relative' as 'INFO';
source insert_relative.sql;
SELECT 'INSERTING abroad' as 'INFO';
source insert_abroad.sql;
SELECT 'INSERTING var_assignment' as 'INFO';
source insert_var_assignment.sql;
SELECT 'INSERTING assignment' as 'INFO';
source insert_assignment.sql;
SELECT 'INSERTING payment' as 'INFO';
source insert_payment.sql;

source show_elapsed.sql;
