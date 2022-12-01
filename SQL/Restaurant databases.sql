-- Restaurant Owners
-- 5 Tables
-- 1x Fact, 4x Dimension
-- search google, how to add foreign key
-- write SQL 3-5 queries analyze data
-- 1x subquery/ with



--FACT
CREATE TABLE orders (
  ORDER_ID int primary key,
  DATE_TIME text,
  PRODUCTID int,
  QUANTITY int,
  PAYMENT_ID int,
  SALETYPE_ID int
);

  insert into orders values
  (1,'2022-05-01 10:05:00',4,1,2,1),
  (2,'2022-05-01 10:10:00',5,1,2,2),
  (3,'2022-05-01 10:35:00',7,3,1,2),
  (4,'2022-05-01 10:45:00',8,2,2,2),
  (5,'2022-05-01 10:50:00',5,1,1,2),
  (6,'2022-05-01 11:05:00',1,2,2,1),
  (7,'2022-05-01 11:15:00',3,4,1,1),
  (8,'2022-05-01 11:25:00',6,1,1,2),
  (9,'2022-05-01 11:40:00',2,6,1,1),
  (10,'2022-05-01 11:45:00',6,4,2,2),
  (11,'2022-05-01 11:45:00',6,1,2,2),
  (12,'2022-05-01 12:05:00',8,1,1,1),
  (13,'2022-05-01 12:10:00',7,2,2,1),
  (14,'2022-05-01 12:20:00',7,2,1,1),
  (15,'2022-05-01 12:30:00',7,2,2,1);

--DIMENSION
CREATE TABLE MENU (
  PRODUCTID INT  ,
  PRODUCTNAME TEXT,
  PRODUCTPRICE real,
  PRODUCTTYPE text
);

INSERT INTO MENU values
  (1,'Hot Espresso',50,'hot'),
  (2,'Hot Black Coffee',50,'hot'),
  (3,'Hot Cappuccino',50,'hot'),
  (4,'Hot Latte',50,'hot'), 
  (5,'Iced Black Coffee',55,'cold'), 
  (6,'Iced Cappuccino',55,'cold'), 
  (7,'Iced Latte',55,'cold'),
  (8,'Coffee Marble',60,'cold');

--DIMENSION
CREATE TABLE TYPE_PRODUCT (
  TypeID INT PRIMARY KEY,
  TypeName TAXT
);

insert into TYPE_PRODUCT values
  (1,'HOT'),
  (2,'COLD');

--DIMENSION
CREATE TABLE PAYMENT_TYPE (
  PAYMENT_ID INT PRIMARY key,
  PAYMENTTYPE TEXT
);

INSERT INTO PAYMENT_TYPE values
  (1,'CASH'),
  (2,'QR CODE');

--DIMENSION
CREATE TABLE SALE_TYPE (
  SALETYPE_ID INT primary KEY,
  SALETYPE TEXT
);

INSERT INTO SALE_TYPE values
  (1,'Buy at store'),
  (2,'Delivery');

.mode markdown
.header on 

-- amount of order more than 100 baht
with sub as (
  select 
    order_id,  
    PRODUCTNAME,
    PRODUCTPRICE,
    quantity,
    productprice * quantity as Total_price 
  from orders,menu,PAYMENT_TYPE,SALE_TYPE
  where 
  orders.productid = menu.productid
  and  orders.PAYMENT_ID = PAYMENT_TYPE.PAYMENT_ID
  and  orders.SALETYPE_ID = SALE_TYPE.SALETYPE_ID
  )
select 
  count (total_price)
from sub
where total_price >= 100;


--The number of each item sold
select
  productname,
  count (quantity)
from (
select * from orders
join menu
on orders.productid = menu.productid
join PAYMENT_TYPE
on orders.PAYMENT_ID = PAYMENT_TYPE.PAYMENT_ID
join SALE_TYPE
on orders.SALETYPE_ID = SALE_TYPE.SALETYPE_ID
) as sub 
group by 1
order by 2 desc;

  
--percent of payment type
with sub as (
  select 
    order_id,  
    PRODUCTNAME,
    PAYMENTTYPE
  from orders,menu,PAYMENT_TYPE
  where 
  orders.productid = menu.productid and
  orders.PAYMENT_ID = PAYMENT_TYPE.PAYMENT_ID
  )
  
select 
  paymenttype,
  count(paymenttype),
  count(paymenttype)*(100/15) AS Percent_Payment
from sub
group by paymenttype;

  
--percent of sale type
with sub as (
  select 
    order_id,  
    PRODUCTNAME,
    SALETYPE
  from orders,menu,SALE_TYPE
  where 
  orders.productid = menu.productid and
  orders.SALETYPE_ID = SALE_TYPE.SALETYPE_ID
  )
  
select 
  SALETYPE,
  count(saletype),
  count(SALETYPE)*(100/15) AS Percent_SALETYPE
from sub
group by SALETYPE;
