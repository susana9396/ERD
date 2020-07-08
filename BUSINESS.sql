--  ¿Qué consulta ejecutaría para obtener los ingresos totales para marzo de 2012?
USE lead_gen_business;
SELECT * FROM billing;
SELECT  sum(b.amount) as 'Ingresos totales en Marzo'
FROM billing b
  WHERE YEAR(b.charged_datetime) = '2012' AND MONTH(b.charged_datetime) = '03';


-- ¿Qué consulta ejecutaría para obtener los ingresos totales recaudados
--  del cliente con una identificación de 2?
SELECT  sum(b.amount) as 'Ingresos totales', c.client_id
FROM billing b
  JOIN clients c ON c.client_id = b.client_id
  WHERE  c.client_id= '2';


-- ¿Qué consulta ejecutaría para obtener todos los sitios que posee client = 10?

SELECT  site_id, domain_name, client_id
FROM sites s
  WHERE  s.client_id= '10';


-- ¿Qué consulta ejecutaría para obtener el número total de sitios
--  creados por mes por año para el cliente con una identificación de 1?
--  ¿Qué pasa con el cliente = 20?

SELECT  year(created_datetime) as y, month(created_datetime) as m ,count(site_id) as num_sitios
FROM sites s
  WHERE  s.client_id= '1'
  GROUP BY
  y, m ;

SELECT  year(created_datetime) as y, month(created_datetime) as m ,count(site_id) as num_sitios
FROM sites s
  WHERE  s.client_id= '20'
  GROUP BY
  y, m ;


--  ¿Qué consulta ejecutaría para obtener el número total de
--  clientes potenciales generados para cada uno de los sitios
-- entre el 1 de enero de 2011 y el 15 de febrero de 2011?

SELECT count(l.leads_id) as clientes_potenciales
FROM leads l
  WHERE registered_datetime >'2010-12-31' and registered_datetime <'2011-02-16';


--  ¿Qué consulta ejecutaría para obtener una lista de nombres de clientes
--  y el número total de clientes potenciales que hemos generado para cada 
-- uno de nuestros clientes entre el 1 de enero de 2011 y el 31 de diciembre de 2011?

SELECT * FROM lead_gen_business.leads;
SELECT * FROM lead_gen_business.sites;
SELECT * FROM lead_gen_business.clients;

SELECT  c.first_name as nombre_cliente, c.last_name as apellido_cliente, count(l.leads_id) as clientes_potenciales
FROM sites s
JOIN clients c ON c.client_id= s.client_id
JOIN leads l ON l.site_id=s.site_id
GROUP BY nombre_cliente 
  ;


-- ¿Qué consulta ejecutaría para obtener una lista de nombres de clientes y el número total de clientes potenciales 
-- que hemos generado para cada cliente cada mes entre los meses 1 y 6 del año 2011?
SELECT  year(l.registered_datetime) as y, month(l.registered_datetime) as m , c.first_name as nombre_cliente, c.last_name as apellido_cliente, count(l.leads_id) as clientes_potenciales
FROM sites s
  JOIN clients c ON c.client_id= s.client_id
  JOIN leads l ON l.site_id=s.site_id
  WHERE year(l.registered_datetime)='2011' AND month(l.registered_datetime) IN (1,2,3,4,5,6)
  GROUP BY nombre_cliente , y, m;



--  ¿Qué consulta ejecutaría para obtener una lista de nombres de clientes y el número total de clientes potenciales que hemos
-- generado para cada uno de los sitios de nuestros clientes entre el 1 de enero de 2011 y el 31 de diciembre de 2011? 
-- Solicite esta consulta por ID de cliente. Presente una segunda consulta que muestre todos los clientes, 
-- los nombres del sitio y el número total de clientes potenciales generados en cada sitio en todo momento.
SELECT   c.first_name as nombre_cliente, c.last_name as apellido_cliente, count(l.leads_id) as clientes_potenciales, registered_datetime
FROM sites s
  JOIN clients c ON c.client_id= s.client_id
  JOIN leads l ON l.site_id=s.site_id
  WHERE year(registered_datetime)='2011'
  GROUP BY nombre_cliente;
  
SELECT c.client_id , c.first_name as nombre_cliente, c.last_name as apellido_cliente, count(l.leads_id) as clientes_potenciales, count(s.site_id) as num_sitios
FROM sites s
  JOIN clients c ON c.client_id= s.client_id
  JOIN leads l ON l.site_id=s.site_id
  GROUP BY c.client_id;


-- Escriba una sola consulta que recupere los ingresos totales recaudados de cada cliente para cada mes del año. Pídalo por ID de cliente.
SELECT c.client_id , c.first_name as nombre_cliente, c.last_name as apellido_cliente, SUM(b.amount) as ingreso_total
FROM clients c
  LEFT JOIN billing b ON c.client_id= b.client_id
   GROUP BY c.client_id
;

--  Escriba una sola consulta que recupere todos los sitios que posee cada cliente. Agrupe los resultados para que 
-- cada fila muestre un nuevo cliente. Se volverá más claro cuando agregue un nuevo campo llamado 'sitios' que tiene
--  todos los sitios que posee el cliente. (SUGERENCIA: use GROUP_CONCAT)
SELECT  c.first_name as nombre_cliente, c.last_name as apellido_cliente,  GROUP_CONCAT(DISTINCT s.domain_name ORDER BY c.client_id SEPARATOR ', ') as sitios
FROM clients c
  LEFT JOIN sites s ON c.client_id= s.client_id
  GROUP BY c.client_id
;
