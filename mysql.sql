-- Usar la base twitter
USE twitter;
-- Seleccionar la tabla usuarios
SELECT * FROM twitter.users ORDER BY id ASC;
-- Insertar cinco usuarios nuevos
INSERT INTO twitter.users(first_name, last_name, handle, birthday, created_at)
VALUES ('user1','test', 'uno', '1983-03-03', '2011-07-01 00:00:01'),
('user2','test', 'dos', '1983-03-03', '2011-07-01 00:00:01'),
('user3','test', 'tres', '1983-03-03', '2011-07-01 00:00:01'),
('user4','test', 'cuatro', '1983-03-03', '2011-07-01 00:00:01'),
('user5','test', 'cinco', '1983-03-03', '2011-07-01 00:00:01');
-- Verificar el cambio en la tabla usuarios
SELECT * FROM twitter.users ORDER BY id ASC;

-- Actualizar NOW de la columna updated_at en la tabla usuarios, si esta no tiene información

UPDATE  twitter.users SET
updated_at = NOW() 
WHERE updated_at IS null ;  
-- Verificar el cambio en la tabla usuarios
SELECT * FROM twitter.users ORDER BY id ASC;

-- Seleccionar la tabla tweets
SELECT * FROM twitter.tweets ORDER BY id ASC;
-- Insertar 5 tweets a 4 usuarios 
INSERT INTO twitter.tweets(tweet, user_id, created_at)
VALUES ('uno', '6' ,'2011-07-01 00:00:01'),
('dos','7', '2011-07-01 00:00:01'),
('tres','8',  '2011-07-01 00:00:01'),
('cuatro','8',  '2011-07-01 00:00:01'),
('cinco', '10','2011-07-01 00:00:01');
-- Verificar el cambio en la tabla tweets
SELECT * FROM twitter.tweets ORDER BY id ASC;


-- Seleccionar tabla faves 
SELECT * FROM twitter.faves ORDER BY id ASC;
-- Insertar 5 faves nuevos; 2 a tweet 13 del user 6, 2 al tweet 15 del user 8 y 1 al tweet 16 del user 8
INSERT INTO twitter.faves(user_id, tweet_id, created_at)
VALUES ('6','13', '2011-07-01 00:00:01'),
('6','13',  '2011-07-01 00:00:01'),
('8','15',  '2011-07-01 00:00:01'),
('8','15',  '2011-07-01 00:00:01'),
('8','16', '2011-07-01 00:00:01');
-- Verificar el cambio en la tabla faves
SELECT * FROM twitter.faves ORDER BY id ASC;

-- Actualizar con  CURTIME de la columna updated_at en la tabla faves, si esta no tiene información
UPDATE  twitter.faves SET
updated_at = curtime()
WHERE updated_at IS null ;  
-- Verificar el cambio en la tabla faves
SELECT * FROM twitter.faves ORDER BY id ASC;

-- Seleccionar tabla follows
SELECT * FROM twitter.follows ORDER BY id ASC;
-- Que cada usuario nuevo sea seguidor de un usuario antiguo
INSERT INTO twitter.follows(followed_id, follower_id, created_at)
VALUES ('1','6', '2011-07-01 00:00:01'),
('2','7',  '2011-07-01 00:00:01'),
('3','8',  '2011-07-01 00:00:01'),
('4','9',  '2011-07-01 00:00:01'),
('5','10', '2011-07-01 00:00:01');

-- Verificar el cambio en la tabla follows
SELECT * FROM twitter.follows ORDER BY id ASC;


-- Actualizar solo DATE  de la columna updated_at en la tabla usuarios, si esta no tiene información
UPDATE  twitter.follows SET
updated_at = curdate()
WHERE updated_at IS null ;  
-- Verificar el cambio en la tabla follows
SELECT * FROM twitter.follows ORDER BY id ASC;



-- Borrar todos los registros que sean seguidos por el usuario 4 en la tabla follows

-- Borro bajo la condición de que follower sea = 4
DELETE FROM twitter.follows WHERE follower_id = 4 ;
-- Verifico tabla seguidores
SELECT * FROM twitter.follows ORDER BY id ASC;