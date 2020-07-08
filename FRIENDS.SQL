-- Crea una base de datos llamada "friends" y luego importe friends.sql. Esto creará dos nuevas tablas: usuarios y amistades.

-- Usando el siguiente ERD como referencia, escribe una consulta SQL que devuelva una lista de usuarios junto con los nombres de sus amigos.

USE friends;
SELECT * FROM users; 
SELECT u.first_name as nombre_usuario, u.last_name  as apellido_usuario,u2.first_name as nombre_amigo, u2.last_name as apellido_amigo
FROM users u
  LEFT JOIN friendships f ON u.id  =f.user_id
  JOIN users as u2 ON u2.id = f.friend_id;
  
-- Devuelva a todos los usuarios que son amigos de Kermit, asegúrese de que sus nombres se muestren en los resultados.
SELECT u.first_name as nombre_usuario, u.last_name  as apellido_usuario, u2.first_name as nombre_amigo, u2.last_name as apellido_amigo
FROM users u
  LEFT JOIN friendships f ON u.id  =f.user_id
  LEFT JOIN users as u2 ON u2.id = f.friend_id
  WHERE u.first_name='Kermit'or u2.first_name='Kermit';
  
  
-- Devuelve el recuento de todas las amistades.
SELECT u.first_name as nombre_usuario, u.last_name  as apellido_usuario, u2.first_name as nombre_amigo, u2.last_name as apellido_amigo
FROM users u
  LEFT JOIN friendships f ON u.id  =f.user_id
  LEFT JOIN users as u2 ON u2.id = f.friend_id
;
  
  
-- Descubre quién tiene más amigos y devuelve el recuento de sus amigos.
SELECT u.first_name as nombre_usuario, u.last_name  as apellido_usuario, count(concat(u2.first_name,u2.last_name)) as amigos
FROM users u
  LEFT JOIN friendships f ON u.id  =f.user_id
  LEFT JOIN users as u2 ON u2.id = f.friend_id
  group by u.first_name 
  order by amigos desc
  limit 1
 ;
 
 
-- Crea un nuevo usuario y hazlos amigos de Eli Byers, Kermit The Frog y Marky Mark

INSERT INTO friends.users(first_name, last_name, created_at)
VALUES ('nuevo','usuario', now());
SET @last_id_in_users = LAST_INSERT_ID();
INSERT INTO friends.friendships(user_id, friend_id, created_at) 
VALUES (@last_id_in_users, 2, now()),
 (@last_id_in_users, 4, now()),
 (@last_id_in_users, 5, now());  


-- Devuelve a los amigos de Eli en orden alfabético.
  
  SELECT 
  CASE WHEN (u.first_name !='Eli') 
     THEN CONCAT(u.first_name, '', u.last_name)
     ELSE CONCAT(u2.first_name, '', u2.last_name)
   END AS amigos  
FROM users u
  LEFT JOIN friendships f ON u.id  =f.user_id
  LEFT JOIN users as u2 ON u2.id = f.friend_id
  WHERE u.first_name='Eli'or u2.first_name='Eli'
  ORDER BY amigos
  ;
  
-- Eliminar a Marky Mark de los amigos de Eli.

  DELETE  FROM friendships
  WHERE user_id='2' AND friend_id='5'OR user_id='5' AND friend_id='2'
  ;
-- Devuelve todas las amistades, mostrando solo el nombre y apellido de ambos amigos


SELECT u.first_name as nombre_usuario, u.last_name  as apellido_usuario,u2.first_name as nombre_amigo, u2.last_name as apellido_amigo
FROM users u
  LEFT JOIN friendships f ON u.id  =f.user_id
  JOIN users as u2 ON u2.id = f.friend_id;

