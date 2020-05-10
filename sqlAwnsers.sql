-- section 1-----------------------------------------------------------------------------
-- 1

SELECT *
FROM invoice i
JOIN invoice_line il ON il.invoice_id = i.invoice_id
WHERE il.unit_price > 0.99;

-- 2

select i.invoice_date, c.first_name, c.last_name, i.total
from invoice i
join customer c on i.customer_id = c.customer_id

-- 3

select c.first_name,c.last_name,e.first_name,e.last_name
from customer c
join employee e on c.support_rep_id =e.employee_id

-- 4

select album.title, artist.name
from album 
join artist on album.artist_id = artist.artist_id

-- 5

select pt.track_id
from playlist_track pt
join playlist p on p.playlist_id = pt.playlist_id
where p.name = 'Music';

-- 6

select t.name 
from track t 
join playlist_track pt on pt.track_id=t.track_id
where pt.playlist_id = 5 ;

-- 7 
-- Get all track names and the playlist name that they're on ( 2 joins ).
select t.name, p.name 
from track t 
join playlist_track pt on t.track_id=pt.track_id
join playlist p on pt.playlist_id = p.playlist_id 

-- 8

select t.name, a.title
from track t
join album a on t.album_id = a.album_id
join genre g on g.genre_id = t.genre_id
where g.name = 'Alternative & Punk';

-- section 2 ----------------------------------------------------------------------------

-- 1
select * from invoice 
where invoice_id in (select invoice_id from invoice_line where unit_price > 0.99)

-- 2
select * from playlist_track
where playlist_id in ( select playlist_id from playlist where name = 'Music' );

-- 3
select * from track
where track_id in ( select track_id from playlist_track where playlist_id = 5 );

-- 4

select * from track where genre_id in (select genre_id from genre where name = 'Comedy')

-- 5

select * from track
where album_id in (select album_id from album where title = 'Fireball')

-- 6

select * from track 
where album_id in (
    select album_id from album where album_id in (
        select album_id from artist where name = 'Queen'
    )
)

-- Practice updating rows ---------------------------------------------------------------
-- 1
update customer 
set fax = null 
where fax is not null

-- 2
update customer 
set company = 'Self'
where company is null 

-- 3

update customer
set last_name = 'Thompson'
where first_name = 'Julia' and last_name = 'Barnett'

--4 
update customer 
set support_rep_id = 4
where email = 'luisrojas@yahoo.cl'

--5 
update track
set composer = 'The darkness around us'
where genre_id = (select genre_id from genre where name = 'Metal')
and composer is null

--Group by-------------------------------------------------------------------------------

-- 1
select count(*), g.name
from track t 
join genre g on t.genre_id =g.genre_id
group by g.name

--2 

select COUNT(*), g.name from track as t
join genre as g on g.genre_id = t.genre_id
where g.name = 'Pop' or g.name = 'Rock'
group by g.name;

--3 

select ar.name, count(*)
from album al
join artist ar on ar.artist_id =al.artist_id
group by ar.name

--Use Distinct---------------------------------------------------------------------------
-- 1
select Distinct composer from track
--2
select Distinct billing_postal_code from invoice
--3 
select Distinct company from customer

--Delete Rows ---------------------------------------------------------------------------

--1
Delete from practice_delete where type = 'bronze'
--2
Delete from practice_delete where type = 'silver'
--3 
Delete from practice_delete where value = 150

--Ecom Sim-------------------------------------------------------------------------------


create table users
(
    id serial primary key,
    name varchar(100) not null,
    email varchar(100) not null
);

create table products
(
    id serial primary key,
    name varchar(100) not null,
    price integer not null 
)

create table orders
(
    id serial primary key,
    product_id integer,
    foreign key (id) references products(id)
)

INSERT INTO users 
(name, email)
VALUES 
('Trevor', 'trevor@gmail.com'),
('DJ', 'DJ@gmail.com'),
('Jermy', 'jermy@gmail.com');

INSERT INTO products 
(name, price)
VALUES 
('video game', 60),
('stone egg', 100),
('mystery stuff', 1000);

INSERT INTO orders (product_id)
VALUES (1), (2), (3);