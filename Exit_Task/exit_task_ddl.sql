-- create user
BEGIN
   EXECUTE IMMEDIATE 'DROP USER TALEND_ET CASCADE';
EXCEPTION
   WHEN OTHERS THEN
      IF SQLCODE != -1918 THEN
         RAISE;
      END IF;
END;
/

CREATE USER TALEND_ET IDENTIFIED BY TALEND_ET
DEFAULT TABLESPACE users
QUOTA UNLIMITED ON users
TEMPORARY TABLESPACE temp
PROFILE default;

GRANT connect TO TALEND_ET;
GRANT resource TO TALEND_ET;
GRANT CREATE SYNONYM TO TALEND_ET;

-- create table for loaded files
BEGIN
   EXECUTE IMMEDIATE 'DROP TABLE TALEND_ET.LOADED_FILES';
EXCEPTION
   WHEN OTHERS THEN
      IF SQLCODE != -942 THEN
         RAISE;
      END IF;
END;
/

CREATE TABLE TALEND_ET.LOADED_FILES (
     filename varchar2(255)
);

-- create sequence for customers
BEGIN
   EXECUTE IMMEDIATE 'DROP SEQUENCE TALEND_ET.dim_customers_seq';
EXCEPTION
   WHEN OTHERS THEN
      IF SQLCODE != -2289 THEN
         RAISE;
      END IF;
END;
/

CREATE SEQUENCE TALEND_ET.dim_customers_seq START WITH 1 INCREMENT BY 1;

-- create sequence for products
BEGIN
   EXECUTE IMMEDIATE 'DROP SEQUENCE TALEND_ET.dim_products_seq';
EXCEPTION
   WHEN OTHERS THEN
      IF SQLCODE != -2289 THEN
         RAISE;
      END IF;
END;
/

CREATE SEQUENCE TALEND_ET.dim_products_seq START WITH 1 INCREMENT BY 1;

-- create sequence for purchases
BEGIN
   EXECUTE IMMEDIATE 'DROP SEQUENCE TALEND_ET.fct_purchases_seq';
EXCEPTION
   WHEN OTHERS THEN
      IF SQLCODE != -2289 THEN
         RAISE;
      END IF;
END;
/

CREATE SEQUENCE TALEND_ET.fct_purchases_seq START WITH 1 INCREMENT BY 1;

-- create dim_customers
BEGIN
   EXECUTE IMMEDIATE 'DROP TABLE TALEND_ET.dim_customers';
EXCEPTION
   WHEN OTHERS THEN
      IF SQLCODE != -942 THEN
         RAISE;
      END IF;
END;
/

CREATE TABLE TALEND_ET.dim_customers (
    id_dm                NUMBER(10, 0) NOT NULL,
    id                   NUMBER(38, 0) NOT NULL,
    name                 NVARCHAR2(255) NOT NULL,
    username             NVARCHAR2(255) NOT NULL,
    email                NVARCHAR2(255) NOT NULL,
    dateofbirth          DATE NOT NULL,
    streetaddress        NVARCHAR2(255) NOT NULL,
    city                 NVARCHAR2(20) NOT NULL,
    country              NVARCHAR2(50) NOT NULL,
    zip                  NVARCHAR2(50) NOT NULL,
    state                NVARCHAR2(10) NOT NULL,
    phone                NVARCHAR2(50) NOT NULL
);

-- create dim_products
BEGIN
   EXECUTE IMMEDIATE 'DROP TABLE TALEND_ET.dim_products';
EXCEPTION
   WHEN OTHERS THEN
      IF SQLCODE != -942 THEN
         RAISE;
      END IF;
END;
/

CREATE TABLE TALEND_ET.dim_products (
    id_dm                NUMBER(10, 0) NOT NULL,
    id                   NUMBER(38, 0),
    product_name          NVARCHAR2(255),
    company_name          NVARCHAR2(255),
    price                NUMBER(10, 3),
    state          NVARCHAR2(255)
);

-- create fct_purchases
BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE TALEND_ET.fct_purchases';
EXCEPTION
    WHEN OTHERS THEN
        IF
            sqlcode !=-942
        THEN
            RAISE;
        END IF;
END;
/

CREATE TABLE talend_et.fct_purchases (
    purchase_id          NUMBER(10,0) NOT NULL,
    payment_id           NUMBER(10,0) NOT NULL,
    customer_id_dm       NUMBER(10,0) NOT NULL,
    product_id_dm        NUMBER(10,0) NOT NULL,
    transaction_date     DATE NOT NULL,
    credit_card          NVARCHAR2(255) NOT NULL,
    credit_card_number   NVARCHAR2(255) NOT NULL,
    is_inter_state       NUMBER(10) NOT NULL
);