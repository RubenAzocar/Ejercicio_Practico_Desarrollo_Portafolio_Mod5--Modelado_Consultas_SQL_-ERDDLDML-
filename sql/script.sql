-- ============================================================================
-- MÓDULO 5 - MODELADO Y CONSULTAS SQL (PostgreSQL)
-- Sistema E-Commerce - Base de Datos Relacional
-- Autor: Rubén
-- Fecha: 20 de enero de 2026
-- ============================================================================

-- ============================================================================
-- SECCIÓN 1: ELIMINACIÓN Y CREACIÓN DE BASE DE DATOS
-- ============================================================================

-- Eliminar la base de datos si existe (ejecutar en terminal psql, no en pgAdmin)
-- DROP DATABASE IF EXISTS ecommerce_db;

-- Crear la base de datos (ejecutar en terminal psql, no en pgAdmin)
-- CREATE DATABASE ecommerce_db;

-- Conectarse a la base de datos ecommerce_db antes de ejecutar el resto del script

-- ============================================================================
-- SECCIÓN 2: ELIMINACIÓN DE TABLAS EXISTENTES (por si se re-ejecuta el script)
-- ============================================================================

DROP TABLE IF EXISTS orden_items CASCADE;
DROP TABLE IF EXISTS ordenes CASCADE;
DROP TABLE IF EXISTS inventario CASCADE;
DROP TABLE IF EXISTS productos CASCADE;
DROP TABLE IF EXISTS usuarios CASCADE;

-- ============================================================================
-- SECCIÓN 3: DDL - CREACIÓN DE TABLAS (CREATE TABLE)
-- ============================================================================

-- ----------------------------------------------------------------------------
-- Tabla: usuarios
-- Descripción: Almacena información de los usuarios/clientes del sistema
-- ----------------------------------------------------------------------------
CREATE TABLE usuarios (
    id_usuario SERIAL PRIMARY KEY,
    nombre TEXT NOT NULL,
    email TEXT UNIQUE NOT NULL,
    creado_en TIMESTAMP DEFAULT NOW()
);

-- ----------------------------------------------------------------------------
-- Tabla: productos
-- Descripción: Catálogo de productos disponibles en el e-commerce
-- ----------------------------------------------------------------------------
CREATE TABLE productos (
    id_producto SERIAL PRIMARY KEY,
    nombre TEXT NOT NULL,
    precio NUMERIC(10, 2) NOT NULL CHECK (precio >= 0),
    activo BOOLEAN DEFAULT TRUE
);

-- ----------------------------------------------------------------------------
-- Tabla: inventario
-- Descripción: Control de stock para cada producto (relación 1:1 con productos)
-- ----------------------------------------------------------------------------
CREATE TABLE inventario (
    id_producto INT PRIMARY KEY,
    stock INT NOT NULL DEFAULT 0 CHECK (stock >= 0),
    CONSTRAINT fk_inventario_producto
        FOREIGN KEY (id_producto)
        REFERENCES productos(id_producto)
        ON DELETE CASCADE
);

-- ----------------------------------------------------------------------------
-- Tabla: ordenes
-- Descripción: Registro de las órdenes de compra realizadas por usuarios
-- ----------------------------------------------------------------------------
CREATE TABLE ordenes (
    id_orden SERIAL PRIMARY KEY,
    id_usuario INT NOT NULL,
    fecha DATE NOT NULL DEFAULT CURRENT_DATE,
    total NUMERIC(12, 2) DEFAULT 0,
    CONSTRAINT fk_ordenes_usuario
        FOREIGN KEY (id_usuario)
        REFERENCES usuarios(id_usuario)
        ON DELETE RESTRICT
);

-- ----------------------------------------------------------------------------
-- Tabla: orden_items
-- Descripción: Detalle de productos incluidos en cada orden (líneas de orden)
-- ----------------------------------------------------------------------------
CREATE TABLE orden_items (
    id_item SERIAL PRIMARY KEY,
    id_orden INT NOT NULL,
    id_producto INT NOT NULL,
    cantidad INT NOT NULL CHECK (cantidad > 0),
    precio_unitario NUMERIC(10, 2) NOT NULL CHECK (precio_unitario >= 0),
    CONSTRAINT fk_orden_items_orden
        FOREIGN KEY (id_orden)
        REFERENCES ordenes(id_orden)
        ON DELETE CASCADE,
    CONSTRAINT fk_orden_items_producto
        FOREIGN KEY (id_producto)
        REFERENCES productos(id_producto)
        ON DELETE RESTRICT
);

-- ============================================================================
-- SECCIÓN 4: CREACIÓN DE ÍNDICES PARA OPTIMIZACIÓN DE CONSULTAS
-- ============================================================================

-- Índice para búsquedas por fecha en órdenes
CREATE INDEX idx_ordenes_fecha ON ordenes(fecha);

-- Índice para búsquedas por usuario en órdenes
CREATE INDEX idx_ordenes_usuario ON ordenes(id_usuario);

-- Índice para búsquedas por orden en orden_items
CREATE INDEX idx_orden_items_orden ON orden_items(id_orden);

-- Índice para búsquedas por producto en orden_items
CREATE INDEX idx_orden_items_producto ON orden_items(id_producto);

-- Índice para búsquedas por email en usuarios
CREATE INDEX idx_usuarios_email ON usuarios(email);

-- ============================================================================
-- SECCIÓN 5: DML - POBLAMIENTO DE DATOS (INSERT)
-- ============================================================================

-- ----------------------------------------------------------------------------
-- Inserción de usuarios (clientes)
-- ----------------------------------------------------------------------------
INSERT INTO usuarios (nombre, email, creado_en) VALUES
('María González', 'maria.gonzalez@email.com', '2022-01-15 10:30:00'),
('Juan Pérez', 'juan.perez@email.com', '2022-02-20 14:45:00'),
('Ana Martínez', 'ana.martinez@email.com', '2022-03-10 09:15:00'),
('Carlos Rodríguez', 'carlos.rodriguez@email.com', '2022-04-05 16:20:00'),
('Laura Fernández', 'laura.fernandez@email.com', '2022-05-12 11:00:00'),
('Pedro López', 'pedro.lopez@email.com', '2022-06-08 13:30:00'),
('Sofía Torres', 'sofia.torres@email.com', '2022-07-22 15:45:00');

-- ----------------------------------------------------------------------------
-- Inserción de productos
-- ----------------------------------------------------------------------------
INSERT INTO productos (nombre, precio, activo) VALUES
('Laptop HP 15"', 599990.00, TRUE),
('Mouse Logitech MX Master', 49990.00, TRUE),
('Teclado Mecánico RGB', 79990.00, TRUE),
('Monitor Samsung 24"', 189990.00, TRUE),
('Audífonos Sony WH-1000XM4', 249990.00, TRUE),
('WebCam Logitech HD', 39990.00, TRUE),
('Disco Duro Externo 1TB', 59990.00, TRUE),
('Memoria RAM 16GB DDR4', 69990.00, TRUE),
('SSD Samsung 500GB', 89990.00, TRUE),
('Hub USB-C 7 puertos', 29990.00, TRUE),
('Cable HDMI 2.0 3m', 12990.00, TRUE),
('Mousepad Gaming XXL', 19990.00, TRUE);

-- ----------------------------------------------------------------------------
-- Inserción de inventario (stock para cada producto)
-- ----------------------------------------------------------------------------
INSERT INTO inventario (id_producto, stock) VALUES
(1, 15),  -- Laptop HP
(2, 45),  -- Mouse Logitech
(3, 32),  -- Teclado RGB
(4, 8),   -- Monitor Samsung
(5, 22),  -- Audífonos Sony
(6, 3),   -- WebCam (stock crítico)
(7, 28),  -- Disco Duro
(8, 5),   -- RAM (stock crítico)
(9, 18),  -- SSD
(10, 2),  -- Hub USB (stock crítico)
(11, 65), -- Cable HDMI
(12, 4);  -- Mousepad (stock crítico)

-- ----------------------------------------------------------------------------
-- Inserción de órdenes (ventas realizadas)
-- ----------------------------------------------------------------------------
INSERT INTO ordenes (id_usuario, fecha, total) VALUES
-- Órdenes 2022 - Usuario 1 (María)
(1, '2022-03-15', 0),  -- id_orden 1
(1, '2022-06-20', 0),  -- id_orden 2
(1, '2022-09-10', 0),  -- id_orden 3
(1, '2022-12-05', 0),  -- id_orden 4

-- Órdenes 2022 - Usuario 2 (Juan)
(2, '2022-04-10', 0),  -- id_orden 5
(2, '2022-07-25', 0),  -- id_orden 6
(2, '2022-12-15', 0),  -- id_orden 7

-- Órdenes 2022 - Usuario 3 (Ana)
(3, '2022-05-18', 0),  -- id_orden 8
(3, '2022-12-20', 0),  -- id_orden 9

-- Órdenes 2022 - Usuario 4 (Carlos)
(4, '2022-08-12', 0),  -- id_orden 10
(4, '2022-11-08', 0),  -- id_orden 11

-- Órdenes 2022 - Usuario 5 (Laura)
(5, '2022-10-05', 0),  -- id_orden 12
(5, '2022-12-28', 0),  -- id_orden 13

-- Órdenes 2022 - Usuario 6 (Pedro)
(6, '2022-12-10', 0);  -- id_orden 14

-- ----------------------------------------------------------------------------
-- Inserción de items de orden (detalle de cada venta)
-- ----------------------------------------------------------------------------

-- Orden 1 (María - Marzo 2022)
INSERT INTO orden_items (id_orden, id_producto, cantidad, precio_unitario) VALUES
(1, 1, 1, 599990.00),  -- Laptop
(1, 2, 1, 49990.00),   -- Mouse
(1, 3, 1, 79990.00);   -- Teclado

-- Orden 2 (María - Junio 2022)
INSERT INTO orden_items (id_orden, id_producto, cantidad, precio_unitario) VALUES
(2, 4, 1, 189990.00),  -- Monitor
(2, 6, 1, 39990.00);   -- WebCam

-- Orden 3 (María - Septiembre 2022)
INSERT INTO orden_items (id_orden, id_producto, cantidad, precio_unitario) VALUES
(3, 7, 2, 59990.00);   -- Disco Duro x2

-- Orden 4 (María - Diciembre 2022)
INSERT INTO orden_items (id_orden, id_producto, cantidad, precio_unitario) VALUES
(4, 5, 1, 249990.00),  -- Audífonos
(4, 11, 2, 12990.00);  -- Cable HDMI x2

-- Orden 5 (Juan - Abril 2022)
INSERT INTO orden_items (id_orden, id_producto, cantidad, precio_unitario) VALUES
(5, 1, 1, 599990.00),  -- Laptop
(5, 8, 2, 69990.00),   -- RAM x2
(5, 9, 1, 89990.00);   -- SSD

-- Orden 6 (Juan - Julio 2022)
INSERT INTO orden_items (id_orden, id_producto, cantidad, precio_unitario) VALUES
(6, 3, 1, 79990.00),   -- Teclado
(6, 12, 1, 19990.00);  -- Mousepad

-- Orden 7 (Juan - Diciembre 2022)
INSERT INTO orden_items (id_orden, id_producto, cantidad, precio_unitario) VALUES
(7, 2, 2, 49990.00),   -- Mouse x2
(7, 10, 1, 29990.00);  -- Hub USB

-- Orden 8 (Ana - Mayo 2022)
INSERT INTO orden_items (id_orden, id_producto, cantidad, precio_unitario) VALUES
(8, 4, 2, 189990.00),  -- Monitor x2
(8, 11, 3, 12990.00);  -- Cable HDMI x3

-- Orden 9 (Ana - Diciembre 2022)
INSERT INTO orden_items (id_orden, id_producto, cantidad, precio_unitario) VALUES
(9, 7, 1, 59990.00),   -- Disco Duro
(9, 9, 1, 89990.00);   -- SSD

-- Orden 10 (Carlos - Agosto 2022)
INSERT INTO orden_items (id_orden, id_producto, cantidad, precio_unitario) VALUES
(10, 1, 1, 599990.00), -- Laptop
(10, 2, 1, 49990.00),  -- Mouse
(10, 3, 1, 79990.00),  -- Teclado
(10, 4, 1, 189990.00); -- Monitor

-- Orden 11 (Carlos - Noviembre 2022)
INSERT INTO orden_items (id_orden, id_producto, cantidad, precio_unitario) VALUES
(11, 5, 2, 249990.00); -- Audífonos x2

-- Orden 12 (Laura - Octubre 2022)
INSERT INTO orden_items (id_orden, id_producto, cantidad, precio_unitario) VALUES
(12, 6, 1, 39990.00),  -- WebCam
(12, 8, 1, 69990.00);  -- RAM

-- Orden 13 (Laura - Diciembre 2022)
INSERT INTO orden_items (id_orden, id_producto, cantidad, precio_unitario) VALUES
(13, 9, 2, 89990.00),  -- SSD x2
(13, 11, 1, 12990.00); -- Cable HDMI

-- Orden 14 (Pedro - Diciembre 2022)
INSERT INTO orden_items (id_orden, id_producto, cantidad, precio_unitario) VALUES
(14, 1, 1, 599990.00), -- Laptop
(14, 7, 1, 59990.00),  -- Disco Duro
(14, 12, 1, 19990.00); -- Mousepad

-- Actualizar el total de cada orden
UPDATE ordenes o
SET total = (
    SELECT COALESCE(SUM(oi.cantidad * oi.precio_unitario), 0)
    FROM orden_items oi
    WHERE oi.id_orden = o.id_orden
);

-- ============================================================================
-- SECCIÓN 6: CONSULTAS REQUERIDAS
-- ============================================================================

-- ============================================================================
-- CONSULTA 1: OFERTA VERANO - Actualizar precio con descuento del 20%
-- ============================================================================
-- Antes de aplicar la oferta, veamos los precios actuales
SELECT id_producto, nombre, precio AS precio_original
FROM productos
ORDER BY id_producto;

-- Aplicar descuento del 20% (precio final = precio * 0.80)
UPDATE productos
SET precio = ROUND(precio * 0.80, 2);

-- Verificar los precios actualizados
SELECT id_producto, nombre, precio AS precio_con_descuento
FROM productos
ORDER BY id_producto;

-- ============================================================================
-- CONSULTA 2: STOCK CRÍTICO - Productos con stock menor o igual a 5 unidades
-- ============================================================================
SELECT
    p.id_producto,
    p.nombre AS producto,
    i.stock,
    CASE
        WHEN i.stock = 0 THEN 'SIN STOCK'
        WHEN i.stock <= 2 THEN 'CRÍTICO'
        WHEN i.stock <= 5 THEN 'BAJO'
    END AS estado_stock
FROM inventario i
JOIN productos p USING (id_producto)
WHERE i.stock <= 5
ORDER BY i.stock ASC, p.nombre;

-- ============================================================================
-- CONSULTA 3: SIMULAR COMPRA - Calcular subtotal, IVA 19% y total
-- ============================================================================
-- Simulamos una compra del usuario 1 con fecha 2022-12-15
-- Productos: Laptop (1), Mouse (2), Teclado (1), Audífonos (1)

-- Paso 1: Crear la orden y obtener el ID
DO $$
DECLARE
    nueva_orden_id INT;
    subtotal_calculado NUMERIC(12,2);
    iva_19_calculado NUMERIC(12,2);
    total_con_iva NUMERIC(12,2);
BEGIN
    -- Insertar la nueva orden
    INSERT INTO ordenes (id_usuario, fecha, total)
    VALUES (1, '2022-12-15', 0)
    RETURNING id_orden INTO nueva_orden_id;

    RAISE NOTICE 'Orden creada con ID: %', nueva_orden_id;

    -- Paso 2: Insertar los ítems de la orden (mínimo 3 productos)
    INSERT INTO orden_items (id_orden, id_producto, cantidad, precio_unitario) VALUES
    (nueva_orden_id, 1, 1, 599990.00),  -- Laptop x1
    (nueva_orden_id, 2, 2, 49990.00),   -- Mouse x2
    (nueva_orden_id, 3, 1, 79990.00),   -- Teclado x1
    (nueva_orden_id, 5, 1, 249990.00);  -- Audífonos x1

    -- Paso 3: Calcular subtotal, IVA 19% y total
    SELECT
        SUM(oi.cantidad * oi.precio_unitario),
        ROUND(SUM(oi.cantidad * oi.precio_unitario) * 0.19, 2),
        ROUND(SUM(oi.cantidad * oi.precio_unitario) * 1.19, 2)
    INTO subtotal_calculado, iva_19_calculado, total_con_iva
    FROM orden_items oi
    WHERE oi.id_orden = nueva_orden_id;

    -- Actualizar el total de la orden
    UPDATE ordenes
    SET total = total_con_iva
    WHERE id_orden = nueva_orden_id;

    -- Mostrar el resultado
    RAISE NOTICE '================================';
    RAISE NOTICE 'RESUMEN DE COMPRA (Orden #%)', nueva_orden_id;
    RAISE NOTICE '================================';
    RAISE NOTICE 'Subtotal:     $%', subtotal_calculado;
    RAISE NOTICE 'IVA (19%%):    $%', iva_19_calculado;
    RAISE NOTICE 'TOTAL:        $%', total_con_iva;
    RAISE NOTICE '================================';
END $$;

-- Consulta alternativa para ver el detalle de la compra simulada
-- (Nota: usar el id_orden correcto, probablemente sea 15 si se ejecutó el script completo)
SELECT
    p.nombre AS producto,
    oi.cantidad,
    oi.precio_unitario,
    (oi.cantidad * oi.precio_unitario) AS subtotal_item
FROM orden_items oi
JOIN productos p ON oi.id_producto = p.id_producto
WHERE oi.id_orden = (SELECT MAX(id_orden) FROM ordenes)
ORDER BY oi.id_item;

-- Resumen financiero de la última orden
SELECT
    o.id_orden,
    u.nombre AS cliente,
    o.fecha,
    SUM(oi.cantidad * oi.precio_unitario) AS subtotal,
    ROUND(SUM(oi.cantidad * oi.precio_unitario) * 0.19, 2) AS iva_19,
    ROUND(SUM(oi.cantidad * oi.precio_unitario) * 1.19, 2) AS total_con_iva
FROM ordenes o
JOIN usuarios u ON o.id_usuario = u.id_usuario
JOIN orden_items oi ON oi.id_orden = o.id_orden
WHERE o.id_orden = (SELECT MAX(id_orden) FROM ordenes)
GROUP BY o.id_orden, u.nombre, o.fecha;

-- ============================================================================
-- CONSULTA 4: TOTAL DE VENTAS DICIEMBRE 2022
-- ============================================================================
SELECT
    COUNT(DISTINCT o.id_orden) AS total_ordenes,
    SUM(oi.cantidad * oi.precio_unitario) AS total_neto,
    ROUND(SUM(oi.cantidad * oi.precio_unitario) * 0.19, 2) AS iva_total,
    ROUND(SUM(oi.cantidad * oi.precio_unitario) * 1.19, 2) AS total_con_iva
FROM ordenes o
JOIN orden_items oi ON oi.id_orden = o.id_orden
WHERE o.fecha BETWEEN '2022-12-01' AND '2022-12-31';

-- Detalle por orden en diciembre 2022
SELECT
    o.id_orden,
    u.nombre AS cliente,
    o.fecha,
    COUNT(oi.id_item) AS items,
    SUM(oi.cantidad) AS unidades_totales,
    SUM(oi.cantidad * oi.precio_unitario) AS total_orden
FROM ordenes o
JOIN usuarios u ON o.id_usuario = u.id_usuario
JOIN orden_items oi ON oi.id_orden = o.id_orden
WHERE o.fecha BETWEEN '2022-12-01' AND '2022-12-31'
GROUP BY o.id_orden, u.nombre, o.fecha
ORDER BY o.fecha, o.id_orden;

-- ============================================================================
-- CONSULTA 5: USUARIO CON MÁS COMPRAS EN 2022
-- ============================================================================
-- Definimos "más compras" como el mayor número de órdenes

WITH por_usuario AS (
    SELECT
        u.id_usuario,
        u.nombre,
        u.email,
        COUNT(o.id_orden) AS total_ordenes,
        SUM(o.total) AS monto_total_gastado,
        MIN(o.fecha) AS primera_compra,
        MAX(o.fecha) AS ultima_compra
    FROM usuarios u
    JOIN ordenes o ON o.id_usuario = u.id_usuario
    WHERE o.fecha BETWEEN '2022-01-01' AND '2022-12-31'
    GROUP BY u.id_usuario, u.nombre, u.email
)
SELECT
    id_usuario,
    nombre AS cliente,
    email,
    total_ordenes AS numero_de_ordenes,
    ROUND(monto_total_gastado, 2) AS gasto_total,
    ROUND(monto_total_gastado / total_ordenes, 2) AS ticket_promedio,
    primera_compra,
    ultima_compra
FROM por_usuario
ORDER BY total_ordenes DESC, monto_total_gastado DESC
LIMIT 1;

-- ============================================================================
-- CONSULTA ADICIONAL: Detalle de las órdenes del usuario con más compras
-- ============================================================================
-- Listado detallado de todas las órdenes del usuario con más compras (María)

SELECT
    o.id_orden,
    o.fecha,
    COUNT(oi.id_item) AS productos_diferentes,
    SUM(oi.cantidad) AS unidades_totales,
    STRING_AGG(p.nombre || ' (x' || oi.cantidad || ')', ', ' ORDER BY oi.id_item) AS productos,
    o.total AS total_orden
FROM ordenes o
JOIN orden_items oi ON oi.id_orden = o.id_orden
JOIN productos p ON p.id_producto = oi.id_producto
WHERE o.id_usuario = (
    SELECT id_usuario
    FROM ordenes
    WHERE fecha BETWEEN '2022-01-01' AND '2022-12-31'
    GROUP BY id_usuario
    ORDER BY COUNT(*) DESC
    LIMIT 1
)
AND o.fecha BETWEEN '2022-01-01' AND '2022-12-31'
GROUP BY o.id_orden, o.fecha, o.total
ORDER BY o.fecha;

-- ============================================================================
-- SECCIÓN 7: CONSULTAS ADICIONALES DE ANÁLISIS
-- ============================================================================

-- ----------------------------------------------------------------------------
-- Top 5 productos más vendidos en 2022
-- ----------------------------------------------------------------------------
SELECT
    p.id_producto,
    p.nombre AS producto,
    SUM(oi.cantidad) AS unidades_vendidas,
    COUNT(DISTINCT oi.id_orden) AS apariciones_en_ordenes,
    ROUND(SUM(oi.cantidad * oi.precio_unitario), 2) AS ingresos_generados
FROM productos p
JOIN orden_items oi ON oi.id_producto = p.id_producto
JOIN ordenes o ON o.id_orden = oi.id_orden
WHERE o.fecha BETWEEN '2022-01-01' AND '2022-12-31'
GROUP BY p.id_producto, p.nombre
ORDER BY unidades_vendidas DESC
LIMIT 5;

-- ----------------------------------------------------------------------------
-- Ingresos mensuales 2022
-- ----------------------------------------------------------------------------
SELECT
    TO_CHAR(o.fecha, 'YYYY-MM') AS mes,
    COUNT(DISTINCT o.id_orden) AS ordenes,
    SUM(oi.cantidad) AS unidades_vendidas,
    ROUND(SUM(oi.cantidad * oi.precio_unitario), 2) AS ingresos_netos
FROM ordenes o
JOIN orden_items oi ON oi.id_orden = o.id_orden
WHERE o.fecha BETWEEN '2022-01-01' AND '2022-12-31'
GROUP BY TO_CHAR(o.fecha, 'YYYY-MM')
ORDER BY mes;

-- ----------------------------------------------------------------------------
-- Productos que requieren reposición (stock crítico)
-- ----------------------------------------------------------------------------
SELECT
    p.id_producto,
    p.nombre AS producto,
    i.stock AS stock_actual,
    COALESCE(SUM(oi.cantidad), 0) AS unidades_vendidas_2022,
    ROUND(COALESCE(SUM(oi.cantidad), 0) / 12.0, 1) AS venta_promedio_mensual,
    CASE
        WHEN i.stock = 0 THEN 'URGENTE - SIN STOCK'
        WHEN i.stock <= 5 THEN 'CRÍTICO - REPONER YA'
        ELSE 'ACEPTABLE'
    END AS alerta
FROM productos p
JOIN inventario i ON i.id_producto = p.id_producto
LEFT JOIN orden_items oi ON oi.id_producto = p.id_producto
LEFT JOIN ordenes o ON o.id_orden = oi.id_orden
    AND o.fecha BETWEEN '2022-01-01' AND '2022-12-31'
WHERE i.stock <= 5
GROUP BY p.id_producto, p.nombre, i.stock
ORDER BY i.stock ASC;

-- ============================================================================
-- FIN DEL SCRIPT
-- ============================================================================

-- NOTAS IMPORTANTES:
-- 1. Este script está diseñado para PostgreSQL 12+
-- 2. Ejecutar todo el script en pgAdmin o psql
-- 3. Los precios en la Consulta 1 se actualizan permanentemente (-20%)
-- 4. La Consulta 3 crea una nueva orden cada vez que se ejecuta
-- 5. Todas las consultas incluyen comentarios explicativos
-- 6. IVA utilizado: 19% según instrucciones del módulo
