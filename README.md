# ajp_ecom_bigmart
> below is db creation commands:

CREATE TABLE ajp_ecom_user(
	userid NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	uname VARCHAR2(30) NOT NULL UNIQUE,
	pass varchar2(20) NOT NULL,
 	is_seller NUMBER(1,0) NOT NULL,
	date_created date default sysdate NOT NULL
);



CREATE TABLE ajp_ecom_prod(
	pid NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	pname VARCHAR2(50) NOT NULL,
	price  NUMBER(10,2) NOT NULL,
 	seller VARCHAR2(30) NOT NULL,
	sid NUMBER ,
	rating NUMBER(2,1)
);

CREATE TABLE ajp_ecom_cart(
 	uname VARCHAR2(30) NOT NULL,
	pid NUMBER NOT NULL,
	quantity NUMBER NOT NULL,
	CONSTRAINT pk PRIMARY KEY (uname, pid)
);


CREATE TABLE ajp_ecom_order(
	oid NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
   	uname VARCHAR2(30) NOT NULL,
	pid NUMBER NOT NULL,
	quantity NUMBER NOT NULL,
	is_confirmed NUMBER(1,0) NOT NULL
);

CREATE TABLE ajp_ecom_review(
	pid NUMBER NOT NULL,
   	userid NUMBER NOT NULL,
	title VARCHAR2(30) NOT NULL,
	content VARCHAR2(255),
	rating NUMBER(2,1) NOT NULL,
	CONSTRAINT pk_review PRIMARY KEY (userid, pid)
);


ALTER TABLE ajp_ecom_order
ADD FOREIGN KEY (pid) REFERENCES ajp_ecom_prod(pid);

ALTER TABLE ajp_ecom_prod
ADD FOREIGN KEY (sid) REFERENCES ajp_ecom_user(userid);
