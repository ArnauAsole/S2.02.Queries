# S2.MYSQL.Lv2

### 🎓 Tienda & Universidad
Aquest projecte conté dues bases de dades educatives, Tienda i Universidad, dissenyades per a practicar consultes SQL, gestió de dades relacionades i consultes avançades com joins, agregats, subconsultes i funcions.

### 📚 Project Overview
Aquest projecte inclou:

Dos esquemes de base de dades: tienda i universidad

Relacions amb claus foranes i dades d'exemple

Consultes SQL per cobrir:

Selecció bàsica

Ordenació i filtres

Joins (INNER, LEFT, RIGHT)

Funcions d'agregació

Subconsultes

Consultes amb aliasses i formats de text

### 🧱 Entity Overview
### 🏪 Tienda
Taules principals:

### 📦 producto
codigo (PK)

nombre

precio

codigo_fabricante (FK)

### 🏭 fabricante
codigo (PK)

nombre

Relació:
Un fabricant pot tenir múltiples productes.

### 🎓 Universidad
Taules principals:

### 👨‍🎓 alumno
Inclou noms, cognoms, NIF, telèfon, data de naixement

### 👨‍🏫 profesor
Inclou noms, cognoms, NIF, telèfon, departament

### 🏫 departamento
id, nombre

### 📚 asignatura
id, nombre, cuatrimestre, curso, grado_id

### 🧾 grado
id, nombre, plan_estudios

### 📋 matricula
Connexió entre alumnes i assignatures per curs escolar

### 🚀 Getting Started
Crear les bases de dades:

```
CREATE DATABASE tienda;
CREATE DATABASE universidad;
```

Crear les taules:
Executa els scripts proporcionats (schema_tienda.sql, schema_universidad.sql).

Afegir dades d'exemple (si s'inclouen):

```
USE tienda;
-- INSERT INTO fabricante (...) VALUES (...);

USE universidad;
-- INSERT INTO alumno (...) VALUES (...);
```

### 🔍 Example Queries
🔹 Tienda
Productes amb preus en euros i dòlars:

```
SELECT nombre, precio, ROUND(precio * 1.1, 2) AS dolares FROM producto;
```

Productes del fabricant "Lenovo":

```
SELECT nombre FROM producto 
JOIN fabricante ON producto.codigo_fabricante = fabricante.codigo 
WHERE fabricante.nombre = 'Lenovo';
```

Producte més car:

```
SELECT nombre, precio FROM producto 
ORDER BY precio DESC 
LIMIT 1;

```
🔹 Universidad
Alumnes ordenats per nom:

```
SELECT apellido1, apellido2, nombre FROM alumno 
ORDER BY apellido1, apellido2, nombre;
Professors sense departament:

SELECT nombre, apellido1 FROM profesor 
WHERE departamento_id IS NULL;
Nombre d'alumnes per any de naixement:

SELECT YEAR(fecha_nacimiento) AS any_naixement, COUNT(*) AS total 
FROM alumno 
GROUP BY any_naixement;
```

### 📈 Advanced Reports
Professors per departament (inclosos els sense assignatures):

```
SELECT d.nombre AS departamento, COUNT(p.id) AS num_profesores
FROM departamento d
LEFT JOIN profesor p ON d.id = p.departamento_id
GROUP BY d.nombre;
```

Crèdits per tipus d'assignatura i grau:

```
SELECT g.nombre AS grau, a.tipo, SUM(a.creditos) AS total_creditos
FROM asignatura a
JOIN grado g ON a.grado_id = g.id
GROUP BY g.nombre, a.tipo;
```

### 🛠️ Tools Used
MySQL per a la gestió de bases de dades relacionals

DBeaver i/o phpMyAdmin per a la visualització i execució de consultes

VS Code / DataGrip per a editar scripts SQL

Markdown per a la documentació

### 🔗 GitHub Repository
📂 Repositori: https://github.com/ArnauAsole/S2.02.Queries.git

