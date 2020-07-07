-- INTEGRANTES : Jorge Ramirez, Camilo Rivera, Aylin Perez, Jorge Gajardo y Susana Lefimil


-- Consultas
-- 1. ¿Qué consulta ejecutarías para obtener todos los clientes dentro 
-- de city_id = 312? Su consulta debe devolver el nombre, apellido, correo electrónico y dirección del cliente.

SELECT * FROM address;
SELECT * FROM customer;
SELECT * FROM city;

SELECT customer.first_name ,  customer.last_name ,  customer.email, address.address, city.city
FROM customer
  JOIN address ON  customer.address_id=address.address_id
  JOIN city ON address.city_id=city.city_id
WHERE city.city_id=312
;


-- 2 ¿Qué consulta harías para obtener todas las películas de comedia? Su consulta debe devolver el título de la película, la descripción,
-- el año de estreno,
-- la calificación, las características especiales y el género (categoría).

select * FROM film;
select * FROM film_category;
select * FROM category;
SELECT film.title, film.description, film.release_year, film.rating, film.special_features, category.name
FROM film
   JOIN film_category ON film.film_id=film_category.film_id
   JOIN category ON category.category_id=film_category.category_id
WHERE category.name='Comedy'
;

-- 3. ¿Qué consulta harías para obtener todas las películas unidas por actor_id = 5? Su consulta debe devolver la identificación del actor, 
-- el nombre del actor, el título de la película, la descripción y el año de lanzamiento.


SELECT actor.first_name, actor.last_name, actor.actor_id,  film.title, film.description, film.release_year
FROM actor
  JOIN film_actor ON actor.actor_id=film_actor.actor_id
  JOIN film ON film.film_id=film_actor.film_id
WHERE actor.actor_id=5
;

-- 4. ¿Qué consulta ejecutaría para obtener todos los clientes en store_id = 1 y dentro de estas ciudades (1, 42, 312 y 459)? 
-- Su consulta debe devolver el nombre, apellido, correo electrónico y dirección del cliente.

SELECT customer.first_name ,  customer.last_name ,  customer.email, address.address, address.city_id , customer.store_id
FROM customer
  JOIN address ON  customer.address_id=address.address_id
WHERE customer.store_id=1 AND address.city_id  IN (1,42,312,459)
;

-- 5. ¿Qué consulta realizarías para obtener todas las películas con una "calificación = G" y "característica especial = detrás de escena", 
-- unidas por actor_id = 15? Su consulta debe devolver el título de la película, la descripción, el año de lanzamiento, 
-- la calificación y la función especial. Sugerencia: puede usar la función LIKE para obtener la parte 'detrás de escena'.

SELECT film.title, film.description, film.release_year, film.rating, film.special_features
FROM film
  WHERE film.special_features LIKE '%Behind the Scenes%' AND film.rating='G'
;

-- 6. ¿Qué consulta harías para obtener todos los actores que se unieron en el film_id = 369? Su consulta 
-- debe devolver film_id, title, actor_id y actor_name.

SELECT  film.film_id, film.title ,  actor.actor_id,  actor.first_name, actor.last_name
FROM film
  JOIN film_actor ON film.film_id=film_actor.film_id
  JOIN actor ON actor.actor_id=film_actor.actor_id
WHERE film.film_id=369
;

-- 7. ¿Qué consulta harías para obtener todas las películas dramáticas con una tarifa de alquiler de 2.99? Su consulta 
-- debe devolver el título de la película, la 
-- descripción, el año de estreno, la calificación, las características especiales y el género (categoría).


SELECT film.title, film.description, film.rating, film.special_features, category.name As categoria 
FROM film
  JOIN film_category ON film.film_id=film_category.film_id
  JOIN category ON category.category_id=film_category.category_id
WHERE film.rental_rate=2.99 AND category.name='Drama'
;

-- 8. ¿Qué consulta harías para obtener todas las películas de acción a las que se une SANDRA KILMER? Su consulta debe devolver 
-- el título de la película, la descripción, el año de estreno, la calificación, 
-- las características especiales, el género (categoría) y el nombre y apellido del actor.


SELECT film.title, film.description, film.release_year, film.rating, film.special_features, category.name As categoria ,  actor.first_name AS nombre, actor.last_name AS apellido
FROM film
   JOIN film_category ON film.film_id=film_category.film_id
   JOIN category ON category.category_id=film_category.category_id
   JOIN film_actor ON film.film_id=film_actor.film_id
   JOIN actor ON film_actor.actor_id=actor.actor_id
WHERE actor.first_name='SANDRA' AND actor.last_name='KILMER' AND category.name='Action'
;
