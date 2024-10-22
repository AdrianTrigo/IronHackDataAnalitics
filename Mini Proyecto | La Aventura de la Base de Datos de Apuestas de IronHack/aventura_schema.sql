-- Creación del schema
CREATE DATABASE ironhack_dapt;
USE ironhack_dapt;
CREATE SCHEMA ironhack_class;


DROP TABLE IF EXISTS product;
DROP TABLE IF EXISTS betting;
DROP TABLE IF EXISTS account;
DROP TABLE IF EXISTS customer;


CREATE TABLE customer (
    CustId INTEGER NOT NULL PRIMARY KEY,
    AccountLocation VARCHAR(8),
    Title VARCHAR(10),
    FirstName VARCHAR(34),
    LastName  VARCHAR(34),
    CreateDate DATE,
    CountryCode VARCHAR(8),
    Language VARCHAR(4),
    Status VARCHAR(4),
    DateOfBirth DATE,
    Contact VARCHAR(4),
    CustomerGroup VARCHAR(30)
);


CREATE TABLE account (
    AccountNo VARCHAR(32) NOT NULL PRIMARY KEY,
    CustId INTEGER,
    AccountLocation VARCHAR(10),
    CurrencyCode VARCHAR(4),
    DailyDepositLimit INTEGER,
    StakeScale FLOAT,
    SourceProd VARCHAR(4),
    FOREIGN KEY (CustId) REFERENCES customer(CustId)
);


CREATE TABLE betting (
    AccountNo VARCHAR(32),
    BetDate DATE,
    ClassId VARCHAR(50),
    CategoryId INTEGER,
    Source VARCHAR(2),
    BetCount INTEGER,
    Bet_Amt FLOAT,
    Win_Amt FLOAT,
    Product VARCHAR(46),
    FOREIGN KEY (AccountNo) REFERENCES account(AccountNo)
);


CREATE TABLE product (
    CLASSID VARCHAR(50),
    CATEGORYID INTEGER,
    product VARCHAR(30),
    sub_product VARCHAR(30),
    description VARCHAR(128),
    bet_or_play SMALLINT
);


