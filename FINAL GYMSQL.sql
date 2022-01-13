CREATE TABLE IF NOT EXISTS `TRAINERS` (
    `T_ID` INT NOT NULL PRIMARY KEY,
    `T_NAME` VARCHAR(45) NOT NULL,
    `T_GENDER` CHAR NULL,
    `T_JOINDATE` DATE NOT NULL,
    `T_EMAIL` VARCHAR(20) NOT NULL UNIQUE,
    `T_MOB_NO` INT NOT NULL UNIQUE,
    `T_LOCATION` VARCHAR(45) NULL
);

CREATE TABLE IF NOT EXISTS "TRAINER_SPEC" (
    "T_SPEC" VARCHAR(45) NOT NULL,
    "TR_ID"	INT NOT NULL,
    FOREIGN KEY("TR_ID") REFERENCES "TRAINERS"("T_ID")
    ON DELETE CASCADE ON UPDATE NO ACTION,
    PRIMARY KEY("T_SPEC","TR_ID")
);

CREATE TABLE IF NOT EXISTS `PACKAGE` (
    `P_ID` INT NOT NULL,
    `P_NAME` VARCHAR(45) NOT NULL,
    `P_PRICE` DECIMAL NOT NULL,
    `P_DURATION` INT NOT NULL,
    PRIMARY KEY (`P_ID`)
);

CREATE TABLE IF NOT EXISTS `MEMBERS` (
    `M_ID` INT NOT NULL,
    `M_NAME` VARCHAR(45) NOT NULL,
    `M_GENDER` CHAR NOT NULL,
    `M_DOB` DATE NOT NULL,
    `M_WEIGHT` DECIMAL NULL,
    `M_HEIGHT` DECIMAL NULL,
    `M_EMAIL` VARCHAR(45) NOT NULL UNIQUE,
    `M_MOB_NO` INT NOT NULL UNIQUE,
    `M_JOINDATE` DATE NOT NULL,
    `M_LOCATION` VARCHAR(45) NULL
    `TR_ID` INT NULL,
    `PK_ID` INT NULL,
    PRIMARY KEY (`M_ID`),

    FOREIGN KEY (`TR_ID`) REFERENCES `TRAINERS` (`T_ID`)
    ON DELETE  SET NULL
    ON UPDATE NO ACTION,

    FOREIGN KEY (`PK_ID`) REFERENCES `PACKAGE` (`P_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
);

CREATE TABLE IF NOT EXISTS `EXERCISE` (
    `E_ID` INT NOT NULL,
    `E_NAME` VARCHAR(45) NOT NULL,
    `E_TYPE` VARCHAR(45) NULL,
    `E_TIMESLOT` TIME NULL,
    PRIMARY KEY (`E_ID`)
);

CREATE TABLE IF NOT EXISTS `EQUIPMENTS` (
    `EQ_ID` INT NOT NULL,
    `EQ_NAME` VARCHAR(45) NOT NULL,
    `EQ_QTY` INT NULL,
    `EQ_COST` DECIMAL NULL,
    PRIMARY KEY (`EQ_ID`)
);

CREATE TABLE IF NOT EXISTS `CONSISTS` (
    `PK_ID` INT NOT NULL,
    `EX_ID` INT NOT NULL,
    PRIMARY KEY (`PK_ID`, `EX_ID`),

    FOREIGN KEY (`PK_ID`)
    REFERENCES `PACKAGE` (`P_ID`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,

    FOREIGN KEY (`EX_ID`)
    REFERENCES `EXERCISE` (`E_ID`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION
);

CREATE TABLE IF NOT EXISTS `CONDUCTS` (
    `TR_ID` INT NOT NULL,
    `EX_ID` INT NOT NULL,
    PRIMARY KEY (`TR_ID`, `EX_ID`),

    FOREIGN KEY (`TR_ID`)
    REFERENCES `TRAINERS` (`T_ID`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,

    FOREIGN KEY (`EX_ID`)
    REFERENCES `EXERCISE` (`E_ID`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION
);

CREATE TABLE IF NOT EXISTS `USES` (
    `MEM_ID` INT NOT NULL,
    `EQP_ID` INT NOT NULL,
    PRIMARY KEY (`MEM_ID`, `EQP_ID`),

    FOREIGN KEY (`MEM_ID`)
    REFERENCES `MEMBERS` (`M_ID`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,

    FOREIGN KEY (`EQP_ID`)
    REFERENCES `EQUIPMENTS` (`EQ_ID`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION
);

CREATE TABLE IF NOT EXISTS `TAKEUP` (
    `MEM_ID` INT NOT NULL,
    `EX_ID` INT NOT NULL,
    PRIMARY KEY (`MEM_ID`, `EX_ID`),

    FOREIGN KEY (`MEM_ID`)
    REFERENCES `MEMBERS` (`M_ID`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,

    FOREIGN KEY (`EX_ID`)
    REFERENCES `EXERCISE` (`E_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
);

INSERT INTO `TRAINERS` (`T_ID`, `T_NAME`, `T_GENDER`, `T_JOINDATE`, `T_EMAIL`, `T_MOB_NO`) VALUES (101, 'JOHN', 'M', '10-JUN-2020', 'JOHN@GMAILL.COM', 123456789);
INSERT INTO `TRAINERS` (`T_ID`, `T_NAME`, `T_GENDER`, `T_JOINDATE`, `T_EMAIL`, `T_MOB_NO`) VALUES (201, 'SAM', 'M', '12-MAY-2021', 'SAM@MAIL.CO', 123345567);


INSERT INTO `TRAINER_SPEC` (`T_SPEC`, `TR_ID`) VALUES ('AEROBICS', 101);
INSERT INTO `TRAINER_SPEC` (`T_SPEC`, `TR_ID`) VALUES ('MUSCULAR', 101);
INSERT INTO `TRAINER_SPEC` (`T_SPEC`, `TR_ID`) VALUES ('AEROBICS', 201);

INSERT INTO `PACKAGE` (`P_ID`, `P_NAME`, `P_PRICE`, `P_DURATION`) VALUES (1, 'BASIC', 1200, 6);
INSERT INTO `PACKAGE` (`P_ID`, `P_NAME`, `P_PRICE`, `P_DURATION`) VALUES (2, 'STAR', 2000, 12);

INSERT INTO `MEMBERS` (`M_ID`, `M_NAME`, `M_GENDER`, `M_DOB`, `M_WEIGHT`, `M_HEIGHT`, `M_EMAIL`, `M_MOB_NO`, `M_JOINDATE`, `TR_ID`, `PK_ID`) VALUES (1, 'PAN', 'F', '11-NOV-2000', 56, 170, 'JAM@MAIL.CO', 1212121212, '13-JAN-2020', 201, 1);
INSERT INTO `MEMBERS` (`M_ID`, `M_NAME`, `M_GENDER`, `M_DOB`, `M_WEIGHT`, `M_HEIGHT`, `M_EMAIL`, `M_MOB_NO`, `M_JOINDATE`, `TR_ID`, `PK_ID`) VALUES (2, 'JAMES', 'M', '14-JAN-2003', 45, 150, 'JAMES@YAHOO.COM', 45454545, '16-DEC-2020', 101, 1);

INSERT INTO `EXERCISE` (`E_ID`, `E_NAME`, `E_TYPE`, `E_TIMESLOT`) VALUES (1, 'RUNNING', 'RUNNING', '12:00:00');
INSERT INTO `EXERCISE` (`E_ID`, `E_NAME`, `E_TYPE`, `E_TIMESLOT`) VALUES (2, 'SWIMMING', 'WATER', '02:00:00');

INSERT INTO `EQUIPMENTS` (`EQ_ID`, `EQ_NAME`, `EQ_QTY`, `EQ_COST`) VALUES (1, 'DUMBELLS', 100, 200);
INSERT INTO `EQUIPMENTS` (`EQ_ID`, `EQ_NAME`, `EQ_QTY`, `EQ_COST`) VALUES (2, 'THREADMILL', 10, 10000);

INSERT INTO `CONSISTS` (`PK_ID`, `EX_ID`) VALUES (1, 1);
INSERT INTO `CONSISTS` (`PK_ID`, `EX_ID`) VALUES (1, 2);
INSERT INTO `CONSISTS` (`PK_ID`, `EX_ID`) VALUES (2, 1);

INSERT INTO `CONDUCTS` (`TR_ID`, `EX_ID`) VALUES (101, 2);
INSERT INTO `CONDUCTS` (`TR_ID`, `EX_ID`) VALUES (101, 1);
INSERT INTO `CONDUCTS` (`TR_ID`, `EX_ID`) VALUES (201, 1);
INSERT INTO `CONDUCTS` (`TR_ID`, `EX_ID`) VALUES (201 , 2);

INSERT INTO `USES` (`MEM_ID`, `EQP_ID`) VALUES (1, 2);
INSERT INTO `USES` (`MEM_ID`, `EQP_ID`) VALUES (1, 1);
INSERT INTO `USES` (`MEM_ID`, `EQP_ID`) VALUES (2, 1);

INSERT INTO `TAKEUP` (`MEM_ID`, `EX_ID`) VALUES (1, 1);
INSERT INTO `TAKEUP` (`MEM_ID`, `EX_ID`) VALUES (1, 2);
INSERT INTO `TAKEUP` (`MEM_ID`, `EX_ID`) VALUES (2, 1);


--QUERIES

SELECT * FROM TRAINERS;
SELECT * FROM TRAINER_SPEC;
SELECT * FROM PACKAGE;
SELECT * FROM MEMBERS;
SELECT * FROM EXERCISE;
SELECT * FROM EQUIPMENTS;
SELECT * FROM CONSISTS;
SELECT * from CONDUCTS;
SELECT * FROM USES;
SELECT * FROM TAKEUP;

--List all Exercises conducted by trainer 'SAM'
SELECT E_NAME FROM EXERCISE WHERE E_ID IN (SELECT ALL EX_ID FROM CONDUCTS WHERE TR_ID  = ( SELECT T_ID FROM TRAINERS WHERE T_NAME='SAM'));

--count total members
SELECT DISTINCT COUNT(M.M_ID) FROM MEMBERS M ;

--MEMBER names who are TRAINED under JOHN
SELECT M_NAME FROM MEMBERS WHERE TR_ID IN (SELECT T_ID FROM TRAINERS WHERE T_NAME='JOHN');

--count number of memebers who are TRAINED under JOHN
SELECT DISTINCT COUNT(M_ID) FROM MEMBERS WHERE TR_ID IN (SELECT T_ID FROM TRAINERS WHERE T_NAME='JOHN');

--Members who have sub to basic pacakage
SELECT M_NAME FROM MEMBERS WHERE PK_ID IN (SELECT P_ID FROM PACKAGE WHERE P_NAME='BASIC');


--Give names of TRAINERS with their specialization
SELECT T.T_ID  , T.T_NAME  , TS.T_SPEC FROM TRAINERS T
JOIN TRAINER_SPEC TS
WHERE TS.TR_ID=T.T_ID;


--list all exercise in basic PACKAGE
SELECT * FROM EXERCISE WHERE E_ID IN (
    SELECT ALL EX_ID FROM CONSISTS WHERE PK_ID = (
        SELECT P_ID FROM PACKAGE WHERE P_NAME = 'BASIC'
    )
);

--List the names of members with their PACKAGES
SELECT M_NAME , P_NAME FROM
(
    SELECT * FROM MEMBERS M JOIN PACKAGE P WHERE M.PK_ID = P.P_ID
);


--List the EQUIPMENTS not used by anyone
SELECT EQ_NAME FROM EQUIPMENTS WHERE EQ_ID NOT IN (SELECT DISTINCT(EQP_ID) FROM USES);

--List the exercises that are neither conducted nor took up by members

--add new exercises

--add new members and trainers

--ADD a new PACKAGE named 'ultra' with the FOLLOWING EXERCISEs : aerobics , swimming , jogging


--Top 5 exercises , equpmemts

--list member names that start with s

--List the trainers who have more than one member(Q1 in order db)

--update time slot of all the exercises that are condicted by trainer sam

--assign running exercise for members who have weight > 45

--give members / trainers who use every equipments / does every exercies

--list all the MEMBERS who have joined after jan 2020

-- sort / members by their height weight age..

--group members  by  their exercises


--FLASK/

    --venv/

    --static/
        --js/
            --bootstrap.min.js
            --jquery.js
            --popper.js
            --script.js
        --css/
            --style.css
            --bootstrap.min.css

    --templates/
        --index.html
        --dashboard.html
        --trainers.html

    --app.py

    --Trainers.py
    --Package.py
    --Member.py
    --Equipment.py
    --Exercise.py

    --Models.py
    --Settings.py

    --gymdb.db


    ------------------------
---CREATION OF TABLES
------------------------

CREATE TABLE `TRAINERS` (
    `T_ID` INT,
    `T_NAME` VARCHAR(45) NOT NULL,
    `T_GENDER` CHAR,
    `T_JOINDATE` DATE NOT NULL,
    `T_EMAIL` VARCHAR(20) NOT NULL UNIQUE,
    `T_MOB_NO` NUMBER(10) NOT NULL UNIQUE,
    `T_LOCATION` VARCHAR(45),
    PRIMARY KEY(`T_ID`)
);

CREATE TABLE `TRAINER_SPEC` (
    `T_SPEC` VARCHAR(45) NOT NULL,
    `TR_ID`	INT NOT NULL,
    PRIMARY KEY(`T_SPEC`,`TR_ID`),
    FOREIGN KEY(`TR_ID`) REFERENCES `TRAINERS`(`T_ID`)
    ON DELETE CASCADE
);

CREATE TABLE `PACKAGE` (
    `P_ID` INT,
    `P_NAME` VARCHAR(45) NOT NULL,
    `P_PRICE` INT NOT NULL,
    `P_DURATION` INT NOT NULL,
    PRIMARY KEY (`P_ID`)
);

CREATE TABLE `MEMBERS` (
    `M_ID` INT,
    `M_NAME` VARCHAR(45) NOT NULL,
    `M_GENDER` CHAR,
    `M_DOB` DATE NOT NULL,
    `M_WEIGHT` DECIMAL ,
    `M_HEIGHT` DECIMAL ,
    `M_EMAIL` VARCHAR(45) NOT NULL UNIQUE,
    `M_MOB_NO` NUMBER(10) NOT NULL UNIQUE,
    `M_JOINDATE` DATE NOT NULL,
    `M_LOCATION` VARCHAR(45),
    `TR_ID` INT ,
    `PK_ID` INT ,
    PRIMARY KEY (`M_ID`),

    FOREIGN KEY (`TR_ID`) REFERENCES `TRAINERS` (`T_ID`)
    ON DELETE  SET NULL,

    FOREIGN KEY (`PK_ID`) REFERENCES `PACKAGE` (`P_ID`)
    ON DELETE NO ACTION
);

CREATE TABLE `EXERCISE` (
    `E_ID` INT,
    `E_NAME` VARCHAR(45) NOT NULL,
    `E_TYPE` VARCHAR(45) ,
    `E_TIMESLOT` TIME,
    PRIMARY KEY (`E_ID`)
);

CREATE TABLE `EQUIPMENTS` (
    `EQ_ID` INT,
    `EQ_NAME` VARCHAR(45) NOT NULL,
    `EQ_QTY` INT ,
    `EQ_COST` DECIMAL ,
    PRIMARY KEY (`EQ_ID`)
);

CREATE TABLE `CONSISTS` (
    `PK_ID` INT ,
    `EX_ID` INT ,
    PRIMARY KEY (`PK_ID`, `EX_ID`),

    FOREIGN KEY (`PK_ID`) REFERENCES `PACKAGE` (`P_ID`)
    ON DELETE CASCADE,

    FOREIGN KEY (`EX_ID`) REFERENCES `EXERCISE` (`E_ID`)
    ON DELETE CASCADE

);

CREATE TABLE `CONDUCTS` (
    `TR_ID` INT ,
    `EX_ID` INT ,
    PRIMARY KEY (`TR_ID`, `EX_ID`),

    FOREIGN KEY (`TR_ID`) REFERENCES `TRAINERS` (`T_ID`)
    ON DELETE CASCADE,

    FOREIGN KEY (`EX_ID`) REFERENCES `EXERCISE` (`E_ID`)
    ON DELETE CASCADE
);

CREATE TABLE  `USES` (
    `MEM_ID` INT ,
    `EQP_ID` INT ,
    PRIMARY KEY (`MEM_ID`, `EQP_ID`),

    FOREIGN KEY (`MEM_ID`) REFERENCES `MEMBERS` (`M_ID`)
    ON DELETE CASCADE,

    FOREIGN KEY (`EQP_ID`) REFERENCES `EQUIPMENTS` (`EQ_ID`)
    ON DELETE CASCADE
);

CREATE TABLE `TAKEUP` (
    `MEM_ID` INT ,
    `EX_ID` INT ,
    PRIMARY KEY (`MEM_ID`, `EX_ID`),

    FOREIGN KEY (`MEM_ID`) REFERENCES `MEMBERS` (`M_ID`)
    ON DELETE CASCADE,

    FOREIGN KEY (`EX_ID`) REFERENCES `EXERCISE` (`E_ID`)
    ON DELETE CASCADE
);


--FLASK MODEL

  from sqlalchemy.orm import backref
from settings import db

CONDUCTS = db.Table('CONDUCTS',
    db.Column('TR_ID' , db.Integer , db.ForeignKey('TRAINERS.T_ID' , ondelete='CASCADE') , primary_key = True ),
    db.Column('EX_ID' , db.Integer , db.ForeignKey('EXERCISE.E_ID' , ondelete='CASCADE')  , primary_key = True  )
)

class TRAINERS(db.Model):

    T_ID = db.Column(db.Integer, primary_key=True)
    T_NAME = db.Column(db.String(45), nullable=False)
    T_GENDER = db.Column(db.CHAR)
    T_JOINDATE = db.Column(db.DateTime , nullable = False)
    T_EMAIL = db.Column(db.String(20) , nullable = False , unique = True)
    T_MOB_NO = db.Column(db.Numeric(10) , unique = True , nullable = False)
    T_LOCATION = db.Column(db.String(15))

    T_SPEC = db.relationship('TRAINER_SPEC' , backref = 'TRAINERS' , lazy = True )

    conducting = db.relationship('EXERCISE' ,  secondary = CONDUCTS, backref = 'conducts' , lazy=True)

    def __init__(self  , t_id , t_name , t_gender , t_joindate , t_email ,  t_mob_no , t_location):
        self.T_ID  = t_id
        self.T_NAME = t_name
        self.T_GENDER = t_gender
        self.T_JOINDATE = t_joindate
        self.T_EMAIL = t_email
        self.T_MOB_NO = t_mob_no
        self.T_LOCATION = t_location


class TRAINER_SPEC(db.Model):

    T_SPEC = db.Column(db.String(15), primary_key=True)
    TR_ID = db.Column(db.Integer ,  db.ForeignKey('TRAINERS.T_ID' , ondelete = 'CASCADE') , primary_key = True)

    def __init__(self  , t_spec , tr_id):
        self.T_SPEC  = t_spec
        self.TR_ID = tr_id


CONSISTS = db.Table('CONSISTS',
    db.Column('PK_ID' , db.Integer , db.ForeignKey('PACKAGE.P_ID' , ondelete = 'CASCADE') , primary_key = True ),
    db.Column('EX_ID' , db.Integer , db.ForeignKey('EXERCISE.E_ID' , ondelete = 'CASCADE')  , primary_key = True )
)

class PACKAGE(db.Model):
    P_ID = db.Column(db.Integer , primary_key = True)
    P_NAME = db.Column(db.String(15) , nullable = False)
    P_PRICE = db.Column(db.Integer , nullable=False)
    P_DURATION = db.Column(db.Integer , nullable = False)

    consisting = db.relationship('EXERCISE' , secondary = CONSISTS, backref = 'consists' , lazy = True)

    def __init__(self , p_id ,p_name , p_price , p_duration):
        self.P_ID = p_id
        self.P_NAME = p_name
        self.P_PRICE = p_price
        self.DURATION = p_duration


class EXERCISE(db.Model):
    E_ID = db.Column(db.Integer , primary_key = True)
    E_NAME = db.Column(db.String(15) , nullable = False)
    E_TYPE = db.Column(db.String(15))
    E_TIMESLOT = db.Column(db.DateTime)

    def __init__(self , e_id , e_name , e_type , e_timeslot):
        self.E_ID = e_id
        self.E_NAME = e_name
        self.E_TYPE = e_type
        self.E_TIMESLOT = e_timeslot


USES = db.Table('USES',
    db.Column('MEM_ID' , db.Integer , db.ForeignKey('MEMBERS.M_ID' , ondelete = 'CASCADE') , primary_key = True ),
    db.Column('EQP_ID' , db.Integer , db.ForeignKey('EQUIPMENTS.EQ_ID' , ondelete = 'CASCADE')  , primary_key = True )
)

TAKEUP = db.Table('TAKEUP',
    db.Column('MEM_ID' , db.Integer , db.ForeignKey('MEMBERS.M_ID' , ondelete = 'CASCADE') , primary_key = True  ),
    db.Column('EX_ID' , db.Integer , db.ForeignKey('EXERCISE.E_ID', ondelete = 'CASCADE')  , primary_key = True )
)

class MEMBERS(db.Model):
    M_ID = db.Column(db.Integer , primary_key = True)
    M_NAME = db.Column(db.String(15) , nullable = False)
    M_GENDER = db.Column(db.CHAR)
    M_DOB = db.Column(db.DateTime , nullable = False)
    M_WEIGHT = db.Column(db.Float)
    M_HEIGHT = db.Column(db.Float)
    M_EMAIL = db.Column(db.String(20) , nullable = False , unique = True)
    M_MOB_NO = db.Column(db.Numeric(10) , unique = True , nullable = False)
    M_JOINDATE = db.Column(db.DateTime , nullable = False)
    M_LOCATION = db.Column(db.String(15))

    TR_ID = db.Column(db.Integer ,  db.ForeignKey('TRAINERS.T_ID' , ondelete='SET NULL') )
    PK_ID = db.Column(db.Integer ,  db.ForeignKey('PACKAGE.P_ID') )

    using = db.relationship('EQUIPMENTS' , secondary = USES, backref = 'uses' , lazy = True)
    taking_up = db.relationship('EXERCISE' , secondary = TAKEUP , backref = 'takes_up' , lazy = True)

    def __init__(self , m_id , m_name , m_gender , m_dob , m_weight , m_height , m_email , m_mob_no, m_location , m_joindate , tr_id , pk_id ):
        self.M_ID = m_id
        self.M_NAME = m_name
        self.M_GENDER = m_gender
        self.M_DOB = m_dob
        self.M_WEIGHT = m_weight
        self.M_HEIGHT = m_height
        self.M_EMAIL = m_email
        self.M_MOB_NO = m_mob_no
        self.M_LOCATION = m_location
        self.M_JOINDATE = m_joindate

        self.TR_ID = tr_id
        self.PK_ID = pk_id



class EQUIPMENTS(db.Model):
    EQ_ID = db.Column(db.Integer , primary_key = True)
    EQ_NAME = db.Column(db.String(15) , nullable = False)
    EQ_QTY = db.Column(db.Integer)
    EQ_COST = db.Column(db.Float)

    def __init__(self , eq_id , eq_name , eq_qty , eq_cost ):
        self.EQ_ID = eq_id
        self.EQ_NAME = eq_name
        self.EQ_QTY = eq_qty
        self.EQ_COST = eq_cost

--TRAINERS INSERTION
----sqlalchemy.exc.IntegrityError: (sqlite3.IntegrityError) UNIQUE constraint failed: TRAINERS.T_MOB_NO

JACK = TRAINERS("JACK" , 'M' , datetime.datetime.utcnow() , "jack@gmail.com" , 1234567890 , "DELHI")
TOM = TRAINERS("TOM" , 'M' , datetime.datetime.utcnow() , "tom@gmail.com" , 6545432319 , "DELHI")
VIMAL = TRAINERS("VIMAL" , 'M' , datetime.datetime.utcnow() , "vimal@gmail.com" , 98978765654, "CHENNAI")
ASMI = TRAINERS("ASMI" , 'F' , datetime.datetime.utcnow() , "asmi@gmail.com" ,4657687934 , "GOA" )
CHITRA = TRAINERS("CHITRA" , 'F' , datetime.datetime.utcnow() , "chitra@gmail.com" ,4657687334 , "BANGALORE" )

db.add_all([JACK , TOM , VIMAL , ASMI , CHITRA])


db.add(JACK)

#Add this before commiting to check foreign key constraint
db.session.execute('pragma foreign_keys=on')
db.session.commit()

--date
>>> print(str(date(int('2019') , int('4'), int('13'))))
2019-04-13

str(date(2019 , 4, 13))
'2019-04-13'

--string to date
datetime.datetime.strptime('12-12-2021' , "%d-%m-%Y").date()

--TRAINERS_SPEC INSERTION
STRENGTH = TRAINER_SPEC("STRENGTH" ,1 )
AEROBIC = TRAINER_SPEC("AEROBIC" , 1)
BALANCE = TRAINER_SPEC("BALANCE" , 1)
STRETCHING = TRAINER_SPEC("STRETCHING" , 1)
MUSCULAR = TRAINER_SPEC("MUSCULAR" , 1)

STRENGTH	1
AEROBIC	1
BALANCE	1
STRETCHING	1
BALANCE	2
STRETCHING	2
AEROBIC	3
MUSCULAR	4
STRETCHING	4
BALANCE	5

--PACKAGE INSERTION

PLATINUM = PACKAGE("PLATINUM" , 3000 , 12)
STAR_PLATINUM = PACKAGE("STAR PLATINUM" , 6000 , 24)

GOLD = PACKAGE("GOLD" , 2000 , 6)
STAR_GOLD = PACKAGE("STAR GOLD" , 4000 , 12)

SILVER = PACKAGE("SILVER" , 1000 , 3)
STAR_SILVER = PACKAGE("STAR SILVER" , 2000 , 6)

--MEMBERS
JAMES = MEMBERS("JAMES" , 'M' , datetime.datetime.utcnow() , 50 , 170 , "james@gmail.com" ,45635342321,datetime.datetime.utcnow() , "BANGALORE" , 1 , 6)
ROCK = MEMBERS("ROCK" , 'M' , datetime.datetime.utcnow() , 50 , 170 , "rock@gmail.com" ,1357908765,datetime.datetime.utcnow() , "DELHI" , 1 , 6)


ARUN = MEMBERS("ARUN" , 'M' , '18-11-2001' , 60 , 165 , "arun@gmail.com" , 6433987652 , "CHENNAI"  ,'12-04-2021'  , 2 , 3)
db.session.add(ARUN)
db.session.execute("pragma foreign_keys=on")
db.session.commit()



RAJESH = MEMBERS("RAJESH" , 'M' , datetime.datetime.utcnow() , 70 , 150 , "rajesh@gmail.com" ,45635342321,datetime.datetime.utcnow() , "BANGALORE" , 3 , 4)
RAM = MEMBERS("RAM" , 'M' , datetime.datetime.utcnow() , 45 , 145 , "ram@gmail.com" ,6574534231,datetime.datetime.utcnow() , "GOA" , 2 , 5)

ARYA = MEMBERS("ARYA" , 'F' , datetime.datetime.utcnow() , 50 , 135 , "arya@gmail.com" ,8987675643, datetime.datetime.utcnow() , "DELHI" ,  4 , 5)
JESSY = MEMBERS("JESSY" , 'F' , datetime.datetime.utcnow() , 70 , 145 , "jessy@gmail.com" ,8987885643, datetime.datetime.utcnow() , "HYDERABAD" ,  5 , 1)

AKSHAY = MEMBERS("AKSHAY" , 'M' , datetime.datetime.utcnow() , 50 , 135 , "akshay@gmail.com" ,6453987652, datetime.datetime.utcnow() , "CHENNAI" ,  2 , 3)
ARUN = MEMBERS("ARUN" , 'M' , datetime.datetime.utcnow() , 60 , 175 , "arun@gmail.com" ,6453987652, datetime.datetime.utcnow() , "CHENNAI" ,  2 , 3)

--equipments

BACK = EQUIPMENTS("BACK EXTENSION MACHINE" , 15 , 750 )
db.session.add(BACK)
db.session.execute("pragma foreign_keys=on")
db.session.commit()

BICEP = EQUIPMENTS("BICEP CURL MACHINE" , 13 , 705 )
db.session.add(BICEP)
db.session.execute("pragma foreign_keys=on")
db.session.commit()

SHOULDER = EQUIPMENTS("SHOULDER PRESS MACHINE" , 12, 750 )
db.session.add(SHOULDER)
db.session.execute("pragma foreign_keys=on")
db.session.commit()

TRICEPS = EQUIPMENTS("TRICEPS PRESS MACHINE" , 15 , 800 )
db.session.add(TRICEPS)
db.session.execute("pragma foreign_keys=on")
db.session.commit()

LEG = EQUIPMENTS("LEG PRESS MACHINE" , 10 , 1800 )
db.session.add(LEG)
db.session.execute("pragma foreign_keys=on")
db.session.commit()

CHEST = EQUIPMENTS("CHEST PRESS MACHINE" , 15 , 500 )
db.session.add(CHEST)
db.session.execute("pragma foreign_keys=on")
db.session.commit()

--uses

MEMBER.using.append(EQUIPMENT)
--for fresh add of member with equip
--ignore if there is already member in table
db.session.add(MEMBER)
db.session.commit()

#SELECT JAMES
JAMES = MEMBERS.query.get(1)
#SELECT BEM
BEM = EQUIPMENTS.query.get(1)
#-using is an attribute in MEMBERS(parent table)
JAMES.using.append(BEM)
db.session.commit()

#james uses 2 and 3rd eqp
EQ2 = EQUIPMENTS.query.get(2)
EQ3 = EQUIPMENTS.query.get(3)
JAMES.using.append(EQ2)
db.session.commit()
JAMES.using.append(EQ3)
db.session.commit()

ROCK = MEMBERS.query.get(2)
RAM = MEMBERS.query.get(4)
ARYA = MEMBERS.query.get(5)
JESSY = MEMBERS.query.get(6)


EQ2 = EQUIPMENTS.query.get(2)
EQ3 = EQUIPMENTS.query.get(3)
EQ4 = EQUIPMENTS.query.get(4)
EQ5 = EQUIPMENTS.query.get(5)

ROCK.using.append(EQ3)
db.session.execute("pragma foreign_keys=on")
db.session.commit()

--Exercises insertion
EX1 = EXERCISE("MOUNTAIN POSE" , "YOGA" , "8:00:00")
EX2 = EXERCISE("TREE POSE" , "YOGA" , "2:00:00")
EX3 = EXERCISE("HAMSTRING STRETCH" , "STRETCHING " , "3:30:00")
EX4 = EXERCISE("SHOULDER STRETCH" , "STRETCHING" , "4:00:00")
EX5 = EXERCISE("RUNNING" , "CARDIO" , "5:00:00")
EX6 = EXERCISE("JOGGING " , "CARDIO" , "6:00:00")
EX7 = EXERCISE("PULL UPS" , "WEIGHT TRAINING" , "19:30:00")
EX8 = EXERCISE("DEAD LIFT" , "WEIGHT TRAINING" , "20:00:00")

--trainer conducts
T1 = TRAINERS.query.get(1)
T2 = TRAINERS.query.get(2)
T3 = TRAINERS.query.get(3)
T4 = TRAINERS.query.get(4)
T5 = TRAINERS.query.get(5)

--EXERCISES
E1 = EXERCISE.query.get(1)
E2 = EXERCISE.query.get(2)
E3 = EXERCISE.query.get(3)
E4 = EXERCISE.query.get(4)
E5 = EXERCISE.query.get(5)
E6 = EXERCISE.query.get(6)
E7 = EXERCISE.query.get(7)
E8 = EXERCISE.query.get(8)

T1.conducting.append(E1)
db.session.execute("pragma foreign_keys=on")
db.session.commit()

T1.conducting.append(E2)
db.session.execute("pragma foreign_keys=on")
db.session.commit()

--ppackgae consisits   exercises

P1 = PACKAGE.query.get(1)
P2 = PACKAGE.query.get(2)
P3 = PACKAGE.query.get(3)
P4 = PACKAGE.query.get(4)
P5 = PACKAGE.query.get(5)
P5 = PACKAGE.query.get(6)

P1.consisting.append(E1)
db.session.execute("pragma foreign_keys=on")
db.session.commit()

--Member take up exercises
M1 = MEMBERS.query.get(1)
M2 = MEMBERS.query.get(2)
M3 = MEMBERS.query.get(3)
M4 = MEMBERS.query.get(4)
M5 = MEMBERS.query.get(5)
M6 = MEMBERS.query.get(6)
M7 = MEMBERS.query.get(7)
M8 = MEMBERS.query.get(8)

M1.taking_up.append(E1)
db.session.execute("pragma foreign_keys=on")
db.session.commit()


datetime.strptime( str( datetime.utcnow().date() ) , "%Y-%m-%d" ).strftime("%d-%m-%Y")


    curr = len(Data_Paginate.items)
    if page_num!=1:
        prev = len(Data_Paginate.prev(error_out = False).items)
    else:
        prev=0
    total += (prev+curr)
    print(total)