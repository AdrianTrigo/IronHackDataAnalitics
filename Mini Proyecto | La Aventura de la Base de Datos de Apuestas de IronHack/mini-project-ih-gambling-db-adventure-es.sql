USE ironhack_dapt;

SELECT  * FROM customer;
SELECT  * FROM account;
SELECT  * FROM betting;

-- Pregunta 01: Usando la tabla o pestaña de clientes, por favor escribe una consulta SQL que muestre Título, Nombre y Apellido y Fecha de Nacimiento para cada uno de los clientes. No necesitarás hacer nada en Excel para esta.
SELECT  Title,FirstName,LastName,DateOfBirth FROM customer;
-- Pregunta 02: Usando la tabla o pestaña de clientes, por favor escribe una consulta SQL que muestre el número de clientes en cada grupo de clientes (Bronce, Plata y Oro). Puedo ver visualmente que hay 4 Bronce, 3 Plata y 3 Oro pero si hubiera un millón de clientes ¿cómo lo haría en Excel?
SELECT  CustomerGroup, COUNT(CustId) FROM customer
GROUP BY CustomerGroup;

-- Pregunta 03: El gerente de CRM me ha pedido que proporcione una lista completa de todos los datos para esos clientes en la tabla de clientes pero necesito añadir el código de moneda de cada jugador para que pueda enviar la oferta correcta en la moneda correcta. Nota que el código de moneda no existe en la tabla de clientes sino en la tabla de cuentas.

SELECT  c.CustId, a.CurrencyCode FROM customer AS c
JOIN account AS a
ON c.CustID = a.CustID;


-- Pregunta 04: Ahora necesito proporcionar a un gerente de producto un informe resumen que muestre, por producto y por día, cuánto dinero se ha apostado en un producto particular. TEN EN CUENTA que las transacciones están almacenadas en la tabla de apuestas y hay un código de producto en esa tabla que se requiere buscar (classid & categoryid) para determinar a qué familia de productos pertenece esto. Por favor, escribe el SQL que proporcionaría el informe. Si imaginas que esto fue un conjunto de datos mucho más grande en Excel, ¿cómo proporcionarías este informe en Excel?

SELECT product.CLASSID, product.CATEGORYID,betting.BetDate, sum(Bet_amt)
FROM product 
JOIN betting 
ON product.CLASSID = betting.ClassId AND product.CATEGORYID = betting.CategoryId
GROUP BY product.CLASSID, product.CATEGORYID,betting.BetDate;


-- Pregunta 05: Acabas de proporcionar el informe de la pregunta 4 al gerente de producto, ahora él me ha enviado un correo electrónico y quiere que se cambie. ¿Puedes por favor modificar el informe resumen para que solo resuma las transacciones que ocurrieron el 1 de noviembre o después y solo quiere ver transacciones de Sportsbook. Nuevamente, por favor escribe el SQL abajo que hará esto. Si yo estuviera entregando esto vía Excel, ¿cómo lo haría?

SELECT product.CLASSID, product.CATEGORYID,betting.BetDate, sum(Bet_amt),betting.product
FROM product 
JOIN betting 
ON product.CLASSID = betting.ClassId AND product.CATEGORYID = betting.CategoryId
GROUP BY product.CLASSID, product.CATEGORYID,betting.BetDate,betting.product
HAVING betting.product = 'Sportsbook' AND  betting.BetDate>= '2012-10-1';


-- Pregunta 06: Como suele suceder, el gerente de producto ha mostrado su nuevo informe a su director y ahora él también quiere una versión diferente de este informe. Esta vez, quiere todos los productos pero divididos por el código de moneda y el grupo de clientes del cliente, en lugar de por día y producto. También le gustaría solo transacciones que ocurrieron después del 1 de diciembre. Por favor, escribe el código SQL que hará esto.

SELECT b.CLASSID, b.CATEGORYID,a.CurrencyCode, c.CustomerGroup, b.BetDate, sum(Bet_amt)
FROM betting AS b
JOIN account AS a
ON b.AccountNo = b.AccountNo
JOIN Customer As c
ON c.CustId=a.CustId
GROUP BY a.CurrencyCode, b.CLASSID, b.CATEGORYID, b.BetDate,c.CustomerGroup
HAVING b.BetDate> '2012-12-1';

-- Pregunta 07: Nuestro equipo VIP ha pedido ver un informe de todos los jugadores independientemente de si han hecho algo en el marco de tiempo completo o no. En nuestro ejemplo, es posible que no todos los jugadores hayan estado activos. Por favor, escribe una consulta SQL que muestre a todos los jugadores Título, Nombre y Apellido y un resumen de su cantidad de apuesta para el período completo de noviembre.





SELECT c.CustId,c.Title, c.FirstName, c.LastName,MIN(b.BetDate),MAX(b.BetDate),ROUND(sum(b.Bet_amt),2) AS amount
FROM Customer As c
JOIN account AS a
ON c.CustId=a.CustId 
JOIN betting AS b
ON b.AccountNo = a.AccountNo
WHERE b.BetDate>= '2012-11-1' AND b.BetDate < '2012-11-30'
GROUP BY c.CustId;

-- Pregunta 08: Nuestros equipos de marketing y CRM quieren medir el número de jugadores que juegan más de un producto. ¿Puedes por favor escribir 2 consultas, una que muestre el número de productos por jugador y otra que muestre jugadores que juegan tanto en Sportsbook como en Vegas?

SELECT c.CustId,c.Title, c.FirstName, c.LastName,COUNT(DISTINCT(b.product)) AS ProductNo
FROM Customer As c
JOIN account AS a
ON c.CustId=a.CustId 
JOIN betting AS b
ON b.AccountNo = a.AccountNo
GROUP BY c.CustId;


SELECT c.CustId, c.Title, c.FirstName, c.LastName
FROM Customer As c
JOIN account AS a ON c.CustId=a.CustId 
JOIN betting AS b ON b.AccountNo = a.AccountNo
WHERE b.product = 'Sportsbook' OR b.product = 'Vegas'
GROUP BY c.CustId
HAVING COUNT(DISTINCT b.product) = 2;

-- Pregunta 09: Ahora nuestro equipo de CRM quiere ver a los jugadores que solo juegan un producto, por favor escribe código SQL que muestre a los jugadores que solo juegan en sportsbook, usa bet_amt > 0 como la clave. Muestra cada jugador y la suma de sus apuestas para ambos productos.


SELECT c.CustId, c.Title, c.FirstName, c.LastName,b.product,ROUND(sum(b.Bet_amt),2) AS amount
FROM Customer As c
JOIN account AS a ON c.CustId=a.CustId 
JOIN betting AS b ON b.AccountNo = a.AccountNo
WHERE b.product = 'Sportsbook' AND b.Bet_Amt > 0
GROUP BY c.CustId;

-- Pregunta 10: La última pregunta requiere que calculemos y determinemos el producto favorito de un jugador. Esto se puede determinar por la mayor cantidad de dinero apostado. Por favor, escribe una consulta que muestre el producto favorito de cada jugador
WITH BetSums AS (
	SELECT c.CustId, c.Title, c.FirstName, c.LastName,b.product,SUM(b.Bet_amt) AS amount
	FROM Customer As c
	JOIN account AS a ON c.CustId = a.CustId 
	JOIN betting AS b ON b.AccountNo = a.AccountNo
GROUP BY c.CustId,b.product),
MaxSums AS (
	SELECT CustId, MAX(amount) AS max_amount
    FROM BetSums
    GROUP BY CustId)

SELECT bs.CustId, bs.Title, bs.FirstName, bs.LastName,bs.product
FROM BetSums AS bs
JOIN MaxSums AS ms ON bs.CustId = ms.CustId 
AND bs.amount = ms.max_amount;


-- Pregunta 11: Escribe una consulta que devuelva a los 5 mejores estudiantes basándose en el GPA

SELECT * FROM student
ORDER BY GPA DESC
LIMIT 5;

-- Pregunta 12: Escribe una consulta que devuelva el número de estudiantes en cada escuela. (¡una escuela debería estar en la salida incluso si no tiene estudiantes!)

SELECT school_name,sc.school_id, COUNT(st.student_name) FROM school AS sc
LEFT JOIN student AS st ON sc.school_id = st.school_id
GROUP BY school_name,school_id;

-- Pregunta 13: Escribe una consulta que devuelva los nombres de los 3 estudiantes con el GPA más alto de cada universidad.

SELECT st.student_name,sc.school_name, RANK() OVER(PARTITION BY sc.school_name ORDER BY st.GPA DESC) AS 'school_rank' FROM student AS st 
JOIN school AS sc ON sc.school_id = st.school_id
WHERE  'school_rank' <= 3
ORDER BY st.GPA DESC;




