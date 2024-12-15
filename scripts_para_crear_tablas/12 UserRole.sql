/*
Usuario por Rol.

Representa la relación entre un usuario y un rol, permitiendo gestionar
el acceso de usuarios a múltiples roles en el sistema.

¿Para qué sirve?:

1. Gestión de permisos de usuarios por rol.

2. Control de acceso multirol para cada usuario.

3. Configuración de preferencias específicas por usuario y rol.

5. Soporte para roles y responsabilidades diferentes en cada compañía.

Creado por:
@Claudio 

Fecha: 27/10/2024
*/

-- Create UserRole Table
CREATE TABLE UserRole (
    -- Primary Key
    id_userole BIGINT IDENTITY(1,1) PRIMARY KEY,                -- Identificador único para la relación usuario-rol
    
    -- Foreign Keys
    user_id BIGINT NOT NULL                                   -- Usuario asociado a la compañía
        CONSTRAINT FK_UserRole_User 
        FOREIGN KEY REFERENCES [User](id_user),
    
    role_id BIGINT NOT NULL									-- Rol asociado al usuario
        CONSTRAINT FK_UserRole_Role 
        FOREIGN KEY REFERENCES Role(id_role),
    
    -- Status
    usero_active BIT NOT NULL DEFAULT 1,                      -- Indica si la relación usuario-rol está activa (1) o inactiva (0)
    
    -- Unique constraint for user and role combination
    CONSTRAINT UQ_User_Role UNIQUE (user_id, role_id)
);

INSERT INTO UserRole VALUES(1, 1, 1)
INSERT INTO UserRole VALUES(2, 2, 1)

SELECT * FROM UserRole