drop table if exists books;
create table books (
       Book_ID serial primary key,
	   Title varchar(100),
	   Author varchar(100),
	   Genre varchar(50),
	   Published_Year INT,
	   Price numeric(10,2),
	   Stock int);

DROP TABLE IF EXISTS customers;
CREATE TABLE Customers (
    Customer_ID SERIAL PRIMARY KEY,
    Name VARCHAR(100),
    Email VARCHAR(100),
    Phone VARCHAR(15),
    City VARCHAR(50),
    Country VARCHAR(150)
);

DROP TABLE IF EXISTS orders;


create table orders (
            Order_ID serial primary key,
			Customer_ID int references customers (customer_id),
			book_id int references books(book_id),
			Order_date date,
		    Quantity INT,
			Total_amount numeric(10,2));

SELECT * FROM Books;
SELECT * FROM Customers;
SELECT * FROM Orders;


--1. 
select * from books 
where genre='Fiction';

--2. 
select * from books
where published_year>1950;

--3. 
select * from customers
where country='Canada';

--4.
select * from orders
where order_date between '2023-11-01' and '2023-11-30';

--5. 
select sum (stock) as sum_of_stock_of_books
from books;

--6.
select * from books
order by price desc;

--option 2
select * from books
where price=(select max(price)from books);

--7.
select * from orders
where quantity>1;

--8.
select * from orders
where total_amount> 20.00;

--9. 
select distinct(genre) from books;

--10.
select * from books
order by stock asc;


--11.
select sum(total_amount) as Total_Revenue
from orders;

-- ADVANCED QUESTIONS 

--1.
select b.genre, sum(o.quantity) as total_books_sold
       from books b join orders o
	   on b.book_id=o.book_id
	   group by b.genre;

--2. average price of books of fantasy genre

select avg(price) as average_price_fantasy
from books
where genre='Fantasy';

--3. 
 select o.customer_id, c.name, count(o.order_id) as order_count
 from orders o
 join
 customers c on o.customer_id=c.customer_id
 group by o.customer_id, c.name
 having count(order_id)>=2;

--4.

select b.title, o.book_id, count(o.book_id) as Frequency_order
from orders o
join books b
on o.book_id=b.book_id
group by o.book_id, b.title
order by Frequency_order desc ;


--5. 
select * from books
where genre='Fantasy' 
order by price desc
limit 3;

--6. total qty. of books sold by each author

select b.author, sum(o.quantity)
      from books b
	  join orders o
	  on b.book_id = o.book_id
	  group by b.author
	  order by sum(o.quantity) desc;



select * from customers;
select * from orders;



--7. 
select distinct c.city, c.customer_id, c.name, o.total_amount
       from customers c
	   join orders o
	   on c.customer_id=o.customer_id
	   where o.total_amount>30;
	   
	   
--8.

select c.*, sum(o.total_amount) as total_spent
       from customers c
	   join orders o
	   on c.customer_id=o.customer_id
	   group by c.customer_id
	   order by sum(o.total_amount) desc 
	   limit 10;
	  
	   
	   
 --9. Calculate the stock remaining after fulfilling all orders.

select b.book_id, b.title, b.stock, 
coalesce (sum(o.quantity),0) as Quantity_ordererd,b.stock - coalesce (sum(o.quantity)) as final_stock
from books b
left join orders o
on b.book_id=o.book_id
group by b.book_id
order by b.book_id;



create database hospitals;