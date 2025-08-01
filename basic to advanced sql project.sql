create table books (Book_ID serial primary key,
Title varchar(100),
Author varchar(100),
Genre varchar(50),
Published_Year int,
Price numeric(10,2),
Stock int
);
select * from books;

create table customers(
customer_id serial primary key,
name varchar(100),
email varchar(100),
phone varchar(15),
city varchar(50),
country varchar(150)
);
select * from customers;

create table orders(
order_id serial primary key,
customer_id int references customers(customer_id),
book_id int references books(book_id),
order_date date,
quantity int,
total_amount numeric(10,2)
);
select * from orders;

--retrieve all books in the 'function' genre
select * from books
where genre = 'Fiction';

--find books published after the year 1950:
select * from books
where published_year > 1950;

--list all the customers from Canada
select * from customers 
where country = 'Canada';

--show orders placed in November 2023
select * from orders
where order_date >= '2023-11-01'and order_date <= '2023-11-30';
select * from orders
where order_date between '2023-11-01' and '2023-11-30';

--retrieve the total stock of books available
select sum(stock) as total_stock from books;

--find the details of the most expencive book
select * from books order by price desc limit 1;

--show all customers who orderd more than 1 quantity of a book
select * from orders
where quantity > 1;

--retrieve all orders where the total amount exceeds $20
select * from orders
where total_amount>20;

--list all genres available in the book tabel
select distinct genre from books;

--find the book with lowest stock
select * from books order by stock asc limit 1;

--calculate the total revenue generated from all orders
select sum(total_amount) as total_revenue from orders;

--retrieve the total number of books sold for each genre
select b.genre, sum(o.quantity) as total_book_sold
from orders o
join books b on o.book_id = b.book_id
group by b.genre;

--find the average price of books in the 'fantasy' genre
select avg(price) as avg_price from books
where genre ='Fantasy';

--list customers who have placed at least 2 ordear
select o.customer_id, c.name, count(o.order_id) as order_count
from orders o join customers c on o.customer_id = c.customer_id
group by o.customer_id, c.name
having count(order_id)>=2;

--find the most frequency ordered book
select o.book_id,b.title, count(o.order_id) as order_count from orders o
join books b on o.book_id=b.book_id
group by o.book_id, b.title order by order_count desc limit 1;

--show the top 3 most expensive books of 'fantasy' genre
select * from books 
where genre = 'Fantasy' order by price desc limit 3;

--retrieve the total quantity of books sold by each author
select b.author, sum(o.quantity) as total_book_sold
from orders o join books b on o.book_id=b.book_id
group by b.author;

--list the cities where customers who spent over $30 are located
select distinct c.city, total_amount
from orders o
join customers c on o.customer_id=c.customer_id
where o.total_amount > 30;

--find the customer who spent the most on orders
select c.customer_id, c.name, sum(o.total_amount) as total_spent from orders o
join customers c on o.customer_id=c.customer_id
group by c.customer_id, c.name
order by total_spent desc limit 1;

--calculate the stock remaining after fulfilling all orders
select b.book_id, b.title, b.stock, coalesce(sum(o.quantity),0) as order_quantity,
b.stock - coalesce(sum(o.quantity),0) as remaining_quantity
from books b 
left join orders o on b.book_id=o.book_id
group by b.book_id order by b.book_id;