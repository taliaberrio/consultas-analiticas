create table categorias (
id 	serial primary key,
nombre varchar (50) not null
);

INSERT INTO categorias (nombre) VALUES
('Electrónicos'),
('Ropa'),
('Hogar'),
('Deportes'),
('Juguetes');

CREATE TABLE productos (
  id SERIAL PRIMARY KEY,
  nombre VARCHAR(255) NOT NULL,
  marca VARCHAR(255) NOT NULL,
  categoria_id INT,
  precio_unitario DECIMAL(10, 2) NOT NULL,
  FOREIGN KEY (categoria_id) REFERENCES categorias(id)
);

INSERT INTO productos (nombre, marca, categoria_id, precio_unitario) VALUES
('Televisor', 'Sony', 1, 1000),
('Laptop', 'HP', 1, 800),
('Camisa', 'Zara', 2, 50),
('Pantalón', 'Levi''s', 2, 70),
('Sartén', 'T-fal', 3, 30),
('Toalla', 'Cannon', 3, 20),
('Pelota', 'Nike', 4, 15),
('Raqueta', 'Wilson', 4, 50),
('Muñeca', 'Barbie', 5, 25),
('Carro', 'Hot Wheels', 5, 10);


CREATE TABLE sucursales (
  id SERIAL PRIMARY KEY,
  nombre VARCHAR(255) NOT NULL,
  direccion VARCHAR(255) NOT NULL
);

INSERT INTO sucursales (nombre, direccion) VALUES
('Sucursal A', 'Calle 1'),
('Sucursal B', 'Calle 2'),
('Sucursal C', 'Calle 3');

CREATE TABLE clientes (
  id SERIAL PRIMARY KEY,
  nombre VARCHAR(255) NOT NULL,
  telefono VARCHAR(15) NOT NULL
);

INSERT INTO clientes (nombre, telefono) VALUES
('Juan', '1234567890'),
('María', '0987654321'),
('Pedro', '5555555555');

CREATE TABLE ordenes (
  id SERIAL PRIMARY KEY,
  cliente_id INT,
  sucursal_id INT,
  fecha DATE NOT NULL,
  total DECIMAL(10, 2) NOT NULL,
  FOREIGN KEY (cliente_id) REFERENCES clientes(id),
  FOREIGN KEY (sucursal_id) REFERENCES sucursales(id)
);

INSERT INTO ordenes (cliente_id, sucursal_id, fecha, total) VALUES
(1, 3, '2023-06-12', 575),
(2, 1, '2023-06-12', 705),
(3, 3, '2023-06-12', 9000),
(2, 3, '2023-06-12', 10400),
(3, 3, '2023-06-12', 85),
(1, 1, '2023-06-12', 830),
(1, 1, '2023-06-12', 490),
(3, 3, '2023-06-12', 16100),
(3, 2, '2023-06-12', 680),
(2, 1, '2023-06-12', 7525),
(2, 3, '2023-06-12', 725),
(3, 1, '2023-06-12', 11430),
(3, 3, '2023-06-12', 4900),
(3, 3, '2023-06-12', 5490),
(1, 1, '2023-06-12', 420);

CREATE TABLE stocks (
  id SERIAL PRIMARY KEY,
  sucursal_id INT,
  producto_id INT,
  cantidad INT NOT NULL,
  FOREIGN KEY (sucursal_id) REFERENCES sucursales(id),
  FOREIGN KEY (producto_id) REFERENCES productos(id)
);
INSERT INTO stocks (sucursal_id, producto_id, cantidad) values
(1, 1, 65),
(1, 2, 71),
(1, 3, 8),
(1, 4, 42),
(1, 5, 61),
(1, 6, 14),
(1, 7, 70),
(1, 8, 66),
(1, 9, 13),
(1, 10, 68),
(2, 1, 14),
(2, 2, 67),
(2, 3, 74),
(2, 4, 32),
(2, 5, 75),
(2, 6, 37),
(2, 7, 14),
(2, 8, 42),
(2, 9, 51),
(2, 10, 41),
(3, 1, 59),
(3, 2, 98),
(3, 3, 52),
(3, 4, 85),
(3, 5, 31),
(3, 6, 17),
(3, 7, 13),
(3, 8, 18),
(3, 9, 76),
(3, 10, 1);


CREATE TABLE items (
  id SERIAL PRIMARY KEY,
  orden_id INT,
  producto_id INT,
  cantidad INT NOT NULL,
  monto_venta DECIMAL(10, 2) NOT NULL,
  FOREIGN KEY (orden_id) REFERENCES ordenes(id),
  FOREIGN KEY (producto_id) REFERENCES productos(id)
);
INSERT INTO items (orden_id, producto_id, cantidad, monto_venta) values
(1, 9, 7, 175),
(1, 8, 8, 400),
(2, 9, 3, 75),
(2, 5, 9, 270),
(2, 5, 10, 300),
(2, 6, 3, 60),
(3, 1, 9, 9000),
(4, 1, 4, 4000),
(4, 2, 8, 6400),
(5, 6, 2, 40),
(5, 7, 3, 45),
(6, 4, 9, 630),
(6, 9, 4, 100),
(6, 3, 2, 100),
(7, 5, 8, 240),
(7, 9, 6, 150),
(7, 8, 2, 100),
(8, 1, 6, 6000),
(8, 1, 10, 10000),
(8, 3, 2, 100),
(9, 8, 9, 450),
(9, 3, 3, 150),
(9, 7, 2, 30),
(9, 10, 5, 50),
(10, 9, 9, 225),
(10, 1, 7, 7000),
(10, 3, 6, 300),
(11, 7, 5, 75),
(11, 9, 8, 200),
(11, 3, 9, 450),
(12, 2, 7, 5600),
(12, 1, 5, 5000),
(12, 6, 9, 180),
(12, 8, 9, 450),
(12, 8, 4, 200),
(13, 9, 4, 100),
(13, 2, 6, 4800),
(14, 1, 5, 5000),
(14, 4, 7, 490),
(15, 9, 6, 150),
(15, 5, 9, 270);

--- Obtener el precio mínimo, precio máximo y precio promedio de todos los productos.
SELECT
  MIN(precio_unitario) AS precio_minimo,
  MAX(precio_unitario) AS precio_maximo,
  AVG(precio_unitario) AS precio_promedio
FROM productos;

----Calcular la cantidad total de productos en stock por sucursal.
SELECT
  sucursal_id,
  SUM(cantidad) AS cantidad_total
FROM stocks
GROUP BY sucursal_id;

---Obtener el total de ventas por cliente.
SELECT
  c.nombre AS cliente,
  SUM(i.monto_venta) AS total_ventas
FROM clientes c
JOIN ordenes o ON c.id = o.cliente_id
JOIN items i ON o.id = i.orden_id
GROUP BY c.id;


