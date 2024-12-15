/*
Usuario por Rol.

Representa la relaci�n entre un usuario y un rol, permitiendo gestionar
el acceso de usuarios a m�ltiples roles en el sistema.

�Para qu� sirve?:

1. Gesti�n de permisos de usuarios por rol.

2. Control de acceso multirol para cada usuario.

3. Configuraci�n de preferencias espec�ficas por usuario y rol.

5. Soporte para roles y responsabilidades diferentes en cada compa��a.

Creado por:
@Claudio 

Fecha: 27/10/2024
*/

-- Create UserRole Table
CREATE TABLE UserRole (
    -- Primary Key
    id_userole BIGINT IDENTITY(1,1) PRIMARY KEY,                -- Identificador �nico para la relaci�n usuario-rol
    
    -- Foreign Keys
    user_id BIGINT NOT NULL                                   -- Usuario asociado a la compa��a
        CONSTRAINT FK_UserRole_User 
        FOREIGN KEY REFERENCES [User](id_user),
    
    role_id BIGINT NOT NULL									-- Rol asociado al usuario
        CONSTRAINT FK_UserRole_Role 
        FOREIGN KEY REFERENCES Role(id_role),
    
    -- Status
    usero_active BIT NOT NULL DEFAULT 1,                      -- Indica si la relaci�n usuario-rol est� activa (1) o inactiva (0)
    
    -- Unique constraint for user and role combination
    CONSTRAINT UQ_User_Role UNIQUE (user_id, role_id)
);

INSERT INTO UserRole VALUES(1, 1, 1)
INSERT INTO UserRole VALUES(2, 2, 1)

SELECT * FROM UserRole