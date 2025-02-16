CREATE TABLE TBL_PIZZA_01 (
    PCODE CHAR(4) NOT NULL,
    PNAME VARCHAR2(30),
    COST NUMBER(7),
    CONSTRAINT PK_PIZZA PRIMARY KEY (PCODE)
);

CREATE TABLE TBL_SHOP_01 (
    SCODE CHAR(4) NOT NULL,
    SNAME VARCHAR2(20),
    CONSTRAINT PK_SHOP PRIMARY KEY (SCODE)
);

CREATE TABLE TBL_SALELIST_01 (
    SALENO NUMBER(7) NOT NULL,
    SCODE CHAR(4) NOT NULL,
    SALEDATE DATE,
    PCODE CHAR(4) NOT NULL,
    AMOUNT NUMBER(5),
    CONSTRAINT PK_SALELIST PRIMARY KEY (SALENO)
);

INSERT INTO TBL_PIZZA_01 VALUES('AA01', '고르곤졸라피자', 6000);
INSERT INTO TBL_PIZZA_01 VALUES('AA02', '치즈피자', 6500);
INSERT INTO TBL_PIZZA_01 VALUES('AA03', '페퍼로니피자', 7000);
INSERT INTO TBL_PIZZA_01 VALUES('AA04', '콤비네이션피자', 7500);
INSERT INTO TBL_PIZZA_01 VALUES('AA05', '고구마피자', 6000);
INSERT INTO TBL_PIZZA_01 VALUES('AA06', '포테이토피자', 7000);
INSERT INTO TBL_PIZZA_01 VALUES('AA07', '불고기피자', 8000);
INSERT INTO TBL_PIZZA_01 VALUES('AA08', '니플리피자', 8000);

INSERT INTO TBL_SHOP_01 VALUES('S001',  '강남전');
INSERT INTO TBL_SHOP_01 VALUES('S002',  '강서점');
INSERT INTO TBL_SHOP_01 VALUES('S003',  '강동점');
INSERT INTO TBL_SHOP_01 VALUES('S004',  '영등점');
INSERT INTO TBL_SHOP_01 VALUES('S005',  '시정점');
INSERT INTO TBL_SHOP_01 VALUES('S006',  '인천점');

INSERT INTO TBL_SALELIST_01 VALUES(100001, 'S001', '2018-12-02', 'AA01', 50);
INSERT INTO TBL_SALELIST_01 VALUES(100002, 'S001', '2018-12-02', 'AA02', 30);
INSERT INTO TBL_SALELIST_01 VALUES(100003, 'S001', '2018-12-02', 'AA03', 20);
INSERT INTO TBL_SALELIST_01 VALUES(100004, 'S001', '2018-12-02', 'AA04', 50);
INSERT INTO TBL_SALELIST_01 VALUES(100005, 'S003', '2018-12-03', 'AA01', 40);
INSERT INTO TBL_SALELIST_01 VALUES(100006, 'S003', '2018-12-03', 'AA02', 60);
INSERT INTO TBL_SALELIST_01 VALUES(100007, 'S003', '2018-12-03', 'AA04', 60);
INSERT INTO TBL_SALELIST_01 VALUES(100008, 'S003', '2018-12-04', 'AA05', 70);
INSERT INTO TBL_SALELIST_01 VALUES(100009, 'S005', '2018-12-02', 'AA01', 80);
INSERT INTO TBL_SALELIST_01 VALUES(100010, 'S005', '2018-12-02', 'AA03', 30);
INSERT INTO TBL_SALELIST_01 VALUES(100011, 'S005', '2018-12-02', 'AA04', 40);
INSERT INTO TBL_SALELIST_01 VALUES(100012, 'S005', '2018-12-02', 'AA05', 50);
INSERT INTO TBL_SALELIST_01 VALUES(100013, 'S004', '2018-12-04', 'AA01', 30);
INSERT INTO TBL_SALELIST_01 VALUES(100014, 'S004', '2018-12-04', 'AA02', 20);
INSERT INTO TBL_SALELIST_01 VALUES(100015, 'S004', '2018-12-04', 'AA06', 50);


SELECT
    SALELIST.SALENO, SHOP.SCODE, SHOP.SNAME,
    SALELIST.SALEDATE, PIZZA.PCODE, PIZZA.PNAME, SALELIST.AMOUNT,
    SUM(PIZZA.COST * SALELIST.AMOUNT)  AS TOTAL_COST
FROM
    TBL_PIZZA_01 PIZZA,
    TBL_SHOP_01 SHOP,
    TBL_SALELIST_01 SALELIST
WHERE
    SALELIST.SCODE = SHOP.SCODE
    AND SALELIST.PCODE = PIZZA.PCODE
GROUP BY 
    PIZZA.PCODE, PIZZA.PNAME
ORDER BY TOTAL_COST DESC;


SELECT
    SHOP.SCODE, SHOP.SNAME,
    SUM(PIZZA.COST * SALELIST.AMOUNT)  AS TOTAL_COST
FROM
    TBL_SALELIST_01 SALELIST,
    TBL_SHOP_01 SHOP,
    TBL_PIZZA_01 PIZZA
WHERE
    SALELIST.SCODE = SHOP.SCODE
    AND SALELIST.PCODE = PIZZA.PCODE
GROUP BY 
    SHOP.SCODE, SHOP.SNAME
ORDER BY SCODE ASC;



SELECT
    pizza.pcode, PIZZA.PNAME,
    SUM(PIZZA.COST * SALELIST.AMOUNT)  AS TOTAL_COST
FROM
    TBL_SALELIST_01   SALELIST,
    TBL_SHOP_01       SHOP,
    TBL_PIZZA_01      PIZZA
WHERE
    SALELIST.SCODE = SHOP.SCODE
    AND SALELIST.PCODE = PIZZA.PCODE
GROUP BY 
    PIZZA.PCODE, PIZZA.PNAME
ORDER BY TOTAL_COST DESC;



SELECT PCODE, PNAME FROM TBL_PIZZA_01