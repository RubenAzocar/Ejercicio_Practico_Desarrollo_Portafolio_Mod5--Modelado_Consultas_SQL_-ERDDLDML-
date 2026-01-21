# Módulo 5 — Modelado y Consultas SQL (PostgreSQL)

## 📋 Descripción del Proyecto

Este proyecto implementa un sistema completo de **base de datos relacional para un e-commerce** utilizando PostgreSQL. Incluye:

- **Modelado Entidad-Relación (ER)**: Diseño conceptual con 5 entidades principales
- **DDL (Data Definition Language)**: Creación de tablas, restricciones e índices
- **DML (Data Manipulation Language)**: Poblamiento con datos de ejemplo
- **Consultas SQL avanzadas**: Reportes, análisis de ventas y gestión de inventario

### Entidades del Sistema

1. **usuarios** - Clientes registrados en el sistema
2. **productos** - Catálogo de productos disponibles
3. **inventario** - Control de stock (relación 1:1 con productos)
4. **ordenes** - Registro de compras realizadas
5. **orden_items** - Detalle de productos por orden

## 🎯 Funcionalidades Implementadas

### Consultas Principales

1. **Oferta Verano**: Actualización masiva de precios con descuento del 20%
2. **Stock Crítico**: Identificación de productos con ≤ 5 unidades
3. **Simulación de Compra**: Cálculo de subtotal, IVA (19%) y total
4. **Reporte Mensual**: Total de ventas de diciembre 2022
5. **Análisis de Clientes**: Usuario con más compras del año 2022

### Consultas Adicionales

- Top 5 productos más vendidos
- Ingresos mensuales del año 2022
- Productos que requieren reposición urgente
- Detalle de órdenes por cliente

## 🚀 Cómo Ejecutar el Proyecto

### Prerequisitos

- PostgreSQL 12 o superior instalado
- pgAdmin 4 (recomendado) o acceso a `psql`
- Permisos para crear bases de datos

### Pasos de Instalación

#### Opción 1: Usando pgAdmin

1. **Abrir pgAdmin** y conectarse al servidor PostgreSQL

2. **Crear la base de datos**:
   - Click derecho en "Databases" → Create → Database
   - Nombre: `ecommerce_db`
   - Click en "Save"

3. **Ejecutar el script**:
   - Click derecho en `ecommerce_db` → Query Tool
   - Abrir el archivo `sql/script.sql`
   - Presionar F5 o click en el botón "Execute/Refresh"

4. **Verificar la creación**:
   - Expandir `ecommerce_db` → Schemas → public → Tables
   - Deberías ver las 5 tablas creadas

#### Opción 2: Usando línea de comandos (psql)

```bash
# 1. Conectarse a PostgreSQL
psql -U postgres

# 2. Crear la base de datos
CREATE DATABASE ecommerce_db;

# 3. Conectarse a la nueva base de datos
\c ecommerce_db

# 4. Ejecutar el script
\i 'ruta/completa/al/archivo/sql/script.sql'

# 5. Verificar las tablas
\dt
```

### Ejecutar Consultas Individuales

Una vez ejecutado el script completo, puedes ejecutar consultas específicas:

```sql
-- Ver productos con stock crítico
SELECT p.id_producto, p.nombre, i.stock
FROM inventario i
JOIN productos p USING (id_producto)
WHERE i.stock <= 5;

-- Ver ventas de diciembre 2022
SELECT SUM(oi.cantidad*oi.precio_unitario) AS total_neto
FROM ordenes o
JOIN orden_items oi ON oi.id_orden = o.id_orden
WHERE o.fecha BETWEEN '2022-12-01' AND '2022-12-31';
```

## 📊 Estructura del Repositorio

```
Ejercicio_Practico_Desarrollo_Portafolio_Mod5/
│
├── er/
│   └── diagrama_er.txt          # Diagrama Entidad-Relación (formato texto)
│
├── sql/
│   └── script.sql               # Script completo (DDL + DML + Consultas)
│
└── README.md                     # Este archivo
```

## 📈 Evidencias y Resultados

### Diagrama Entidad-Relación

El diagrama ER completo está disponible en [`er/diagrama_er.txt`](er/diagrama_er.txt) e incluye:
- 5 entidades con sus atributos
- Relaciones con cardinalidades (1:1, 1:N)
- Restricciones de integridad (PK, FK, CHECK, UNIQUE)
- Índices para optimización de consultas

### Resultados Esperados de las Consultas

#### 1. Oferta Verano (-20%)
- Se actualizan todos los precios en la tabla `productos`
- Ejemplo: Laptop de $599,990 → $479,992

#### 2. Stock Crítico
```
id_producto | nombre              | stock | estado_stock
------------|---------------------|-------|-------------
10          | Hub USB-C 7 puertos | 2     | CRÍTICO
6           | WebCam Logitech HD  | 3     | CRÍTICO
12          | Mousepad Gaming XXL | 4     | BAJO
8           | Memoria RAM 16GB    | 5     | BAJO
```

#### 3. Simulación de Compra (4 productos)
```
Subtotal:     $1,029,960.00
IVA (19%):    $195,692.40
TOTAL:        $1,225,652.40
```

#### 4. Ventas Diciembre 2022
```
total_ordenes | total_neto    | total_con_iva
--------------|---------------|---------------
6             | $2,899,730.00 | $3,450,678.70
```

#### 5. Usuario con Más Compras (2022)
```
cliente        | numero_de_ordenes | gasto_total  | ticket_promedio
---------------|-------------------|--------------|----------------
María González | 4                 | $1,389,940.00| $347,485.00
```

## 🔧 Características Técnicas

### Restricciones Implementadas

- **PRIMARY KEY**: En todas las tablas
- **FOREIGN KEY**: Con `ON DELETE CASCADE` y `ON DELETE RESTRICT`
- **CHECK**:
  - `stock >= 0` en inventario
  - `cantidad > 0` en orden_items
  - `precio >= 0` en productos
- **UNIQUE**: Email único en usuarios
- **DEFAULT**: Valores por defecto (timestamps, booleans)

### Índices Creados

```sql
idx_ordenes_fecha          -- Optimiza búsquedas por rango de fechas
idx_ordenes_usuario        -- Optimiza consultas por cliente
idx_orden_items_orden      -- Optimiza joins con ordenes
idx_orden_items_producto   -- Optimiza joins con productos
idx_usuarios_email         -- Optimiza búsquedas por email
```

### Integridad Referencial

- **Usuarios → Ordenes**: `ON DELETE RESTRICT` (no eliminar usuario con órdenes)
- **Ordenes → Orden_Items**: `ON DELETE CASCADE` (eliminar ítems al eliminar orden)
- **Productos → Inventario**: `ON DELETE CASCADE` (relación 1:1)
- **Productos → Orden_Items**: `ON DELETE RESTRICT` (no eliminar producto en órdenes)

## 📚 Tecnologías Utilizadas

- **PostgreSQL 16.1**: Sistema de gestión de bases de datos
- **pgAdmin 4**: Interfaz gráfica para administración
- **SQL (DDL/DML)**: Lenguaje de definición y manipulación de datos

## 👨‍💻 Autor

**Rubén**
Estudiante - Curso Fullstack Talento Digital
Módulo 5: Modelado y Consultas SQL

## 📅 Fecha de Entrega

20 de enero de 2026

## 📝 Notas Importantes

1. **Reutilización del script**: El script incluye `DROP TABLE IF EXISTS` al inicio, permitiendo ejecutarlo múltiples veces sin errores.

2. **Consulta de Oferta**: La actualización de precios es **permanente**. Si necesitas restaurar los precios originales, deberás re-ejecutar el script completo.

3. **Simulación de Compra**: Cada ejecución de la Consulta 3 crea una **nueva orden**. Esto es intencional para demostrar el funcionamiento del sistema.

4. **IVA Configurado**: Todas las consultas utilizan un IVA del **19%** según las instrucciones del módulo.

5. **Datos de Ejemplo**: El script incluye:
   - 7 usuarios
   - 12 productos
   - 14 órdenes del año 2022
   - Más de 20 líneas de detalle (orden_items)

## 🎓 Objetivos de Aprendizaje Alcanzados

✅ Diseño de modelos Entidad-Relación
✅ Creación de tablas con restricciones complejas
✅ Implementación de integridad referencial
✅ Inserción masiva de datos relacionados
✅ Consultas con JOIN múltiples
✅ Agregaciones y funciones de grupo
✅ CTEs (Common Table Expressions)
✅ Subconsultas correlacionadas
✅ Índices para optimización
✅ Transacciones y bloques PL/pgSQL

## 📞 Soporte

Para dudas o consultas sobre este proyecto, revisar:
- Documentación oficial de PostgreSQL: https://www.postgresql.org/docs/
- Tutorial pgAdmin: https://www.pgadmin.org/docs/

---

**Proyecto desarrollado como parte del Portafolio del Módulo 5**
*Curso Fullstack - Talento Digital 2026*
# Ejercicio_Practico_Desarrollo_Portafolio_Mod5--Modelado_Consultas_SQL_-ERDDLDML-
