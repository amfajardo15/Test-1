/*
Permiso.

Un permiso representa los diferentes niveles de acceso y operaciones
que pueden realizarse sobre una entidad del sistema.

¿Para qué sirve?:

1. Control granular de acciones sobre entidades del sistema.

2. Definición de permisos específicos para operaciones CRUD.

3. Gestión de capacidades de importación y exportación de datos.

4. Implementación de políticas de seguridad y acceso.

5. Configuración flexible de permisos por funcionalidad.

Creado por:
@Claudio

Fecha: 27/10/2024
*/

-- Create Permission Table
CREATE TABLE Permission (
    -- Primary Key
    id_permi BIGINT IDENTITY(1,1) PRIMARY KEY,                -- Identificador único para el permiso
    
    -- Basic Information
    name NVARCHAR(255) NOT NULL,                              -- Nombre descriptivo del permiso
    description NVARCHAR(MAX) NULL,                           -- Descripción detallada del permiso y su propósito
    
    -- CRUD Permissions
    can_create BIT NOT NULL DEFAULT 0,                        -- Permite crear nuevos registros
    can_read BIT NOT NULL DEFAULT 0,                          -- Permite ver registros existentes
    can_update BIT NOT NULL DEFAULT 0,                        -- Permite modificar registros existentes
    can_delete BIT NOT NULL DEFAULT 0,                        -- Permite eliminar registros existentes
    
    -- Data Transfer Permissions
    can_import BIT NOT NULL DEFAULT 0,                        -- Permite importar datos masivamente
    can_export BIT NOT NULL DEFAULT 0                         -- Permite exportar datos del sistema
);

INSERT INTO Permission VALUES('PERMISO1','PERMISO1',0,0,0,0,0,0)
INSERT INTO Permission VALUES('PERMISO2','PERMISO2',0,0,0,0,0,1)
INSERT INTO Permission VALUES('PERMISO3','PERMISO3',0,0,0,0,1,0)
INSERT INTO Permission VALUES('PERMISO4','PERMISO4',0,0,0,0,1,1)
INSERT INTO Permission VALUES('PERMISO5','PERMISO5',0,0,0,1,0,0)
INSERT INTO Permission VALUES('PERMISO6','PERMISO6',0,0,0,1,0,1)
INSERT INTO Permission VALUES('PERMISO7','PERMISO7',0,0,0,1,1,0)
INSERT INTO Permission VALUES('PERMISO8','PERMISO8',0,0,0,1,1,1)
INSERT INTO Permission VALUES('PERMISO9','PERMISO9',0,0,1,0,0,0)
INSERT INTO Permission VALUES('PERMISO10','PERMISO10',0,0,1,0,0,1)
INSERT INTO Permission VALUES('PERMISO11','PERMISO11',0,0,1,0,1,0)
INSERT INTO Permission VALUES('PERMISO12','PERMISO12',0,0,1,0,1,1)
INSERT INTO Permission VALUES('PERMISO13','PERMISO13',0,0,1,1,0,0)
INSERT INTO Permission VALUES('PERMISO14','PERMISO14',0,0,1,1,0,1)
INSERT INTO Permission VALUES('PERMISO15','PERMISO15',0,0,1,1,1,0)
INSERT INTO Permission VALUES('PERMISO16','PERMISO16',0,0,1,1,1,1)
INSERT INTO Permission VALUES('PERMISO17','PERMISO17',0,1,0,0,0,0)
INSERT INTO Permission VALUES('PERMISO18','PERMISO18',0,1,0,0,0,1)
INSERT INTO Permission VALUES('PERMISO19','PERMISO19',0,1,0,0,1,0)
INSERT INTO Permission VALUES('PERMISO20','PERMISO20',0,1,0,0,1,1)
INSERT INTO Permission VALUES('PERMISO21','PERMISO21',0,1,0,1,0,0)
INSERT INTO Permission VALUES('PERMISO22','PERMISO22',0,1,0,1,0,1)
INSERT INTO Permission VALUES('PERMISO23','PERMISO23',0,1,0,1,1,0)
INSERT INTO Permission VALUES('PERMISO24','PERMISO24',0,1,0,1,1,1)
INSERT INTO Permission VALUES('PERMISO25','PERMISO25',0,1,1,0,0,0)
INSERT INTO Permission VALUES('PERMISO26','PERMISO26',0,1,1,0,0,1)
INSERT INTO Permission VALUES('PERMISO27','PERMISO27',0,1,1,0,1,0)
INSERT INTO Permission VALUES('PERMISO28','PERMISO28',0,1,1,0,1,1)
INSERT INTO Permission VALUES('PERMISO29','PERMISO29',0,1,1,1,0,0)
INSERT INTO Permission VALUES('PERMISO30','PERMISO30',0,1,1,1,0,1)
INSERT INTO Permission VALUES('PERMISO31','PERMISO31',0,1,1,1,1,0)
INSERT INTO Permission VALUES('PERMISO32','PERMISO32',0,1,1,1,1,1)
INSERT INTO Permission VALUES('PERMISO33','PERMISO33',1,0,0,0,0,0)
INSERT INTO Permission VALUES('PERMISO34','PERMISO34',1,0,0,0,0,1)
INSERT INTO Permission VALUES('PERMISO35','PERMISO35',1,0,0,0,1,0)
INSERT INTO Permission VALUES('PERMISO36','PERMISO36',1,0,0,0,1,1)
INSERT INTO Permission VALUES('PERMISO37','PERMISO37',1,0,0,1,0,0)
INSERT INTO Permission VALUES('PERMISO38','PERMISO38',1,0,0,1,0,1)
INSERT INTO Permission VALUES('PERMISO39','PERMISO39',1,0,0,1,1,0)
INSERT INTO Permission VALUES('PERMISO40','PERMISO40',1,0,0,1,1,1)
INSERT INTO Permission VALUES('PERMISO41','PERMISO41',1,0,1,0,0,0)
INSERT INTO Permission VALUES('PERMISO42','PERMISO42',1,0,1,0,0,1)
INSERT INTO Permission VALUES('PERMISO43','PERMISO43',1,0,1,0,1,0)
INSERT INTO Permission VALUES('PERMISO44','PERMISO44',1,0,1,0,1,1)
INSERT INTO Permission VALUES('PERMISO45','PERMISO45',1,0,1,1,0,0)
INSERT INTO Permission VALUES('PERMISO46','PERMISO46',1,0,1,1,0,1)
INSERT INTO Permission VALUES('PERMISO47','PERMISO47',1,0,1,1,1,0)
INSERT INTO Permission VALUES('PERMISO48','PERMISO48',1,0,1,1,1,1)
INSERT INTO Permission VALUES('PERMISO49','PERMISO49',1,1,0,0,0,0)
INSERT INTO Permission VALUES('PERMISO50','PERMISO50',1,1,0,0,0,1)
INSERT INTO Permission VALUES('PERMISO51','PERMISO51',1,1,0,0,1,0)
INSERT INTO Permission VALUES('PERMISO52','PERMISO52',1,1,0,0,1,1)
INSERT INTO Permission VALUES('PERMISO53','PERMISO53',1,1,0,1,0,0)
INSERT INTO Permission VALUES('PERMISO54','PERMISO54',1,1,0,1,0,1)
INSERT INTO Permission VALUES('PERMISO55','PERMISO55',1,1,0,1,1,0)
INSERT INTO Permission VALUES('PERMISO56','PERMISO56',1,1,0,1,1,1)
INSERT INTO Permission VALUES('PERMISO57','PERMISO57',1,1,1,0,0,0)
INSERT INTO Permission VALUES('PERMISO58','PERMISO58',1,1,1,0,0,1)
INSERT INTO Permission VALUES('PERMISO59','PERMISO59',1,1,1,0,1,0)
INSERT INTO Permission VALUES('PERMISO60','PERMISO60',1,1,1,0,1,1)
INSERT INTO Permission VALUES('PERMISO61','PERMISO61',1,1,1,1,0,0)
INSERT INTO Permission VALUES('PERMISO62','PERMISO62',1,1,1,1,0,1)
INSERT INTO Permission VALUES('PERMISO63','PERMISO63',1,1,1,1,1,0)
INSERT INTO Permission VALUES('PERMISO64','PERMISO64',1,1,1,1,1,1)


SELECT * FROM Permission