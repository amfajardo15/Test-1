/****** Object:  StoredProcedure [dbo].[spUser_Permission]    Script Date: 26/11/2024 9:21:07 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*  procedure/function spUser_Permission
----------------------------------------------------------------------------
							COMPAÑIA		
----------------------------------------------------------------------------
	Proyecto: 
	Módulo:								
----------------------------------------------------------------------------
----------------------------------------------------------------------------
	Nombre Proc:	spUser_Permission					
	Objetivo:	Devolver los permisos asignados al usuario, tanto a nivel de entidad como a nivel de registros dentro de la entidad.
	Requerimiento:	
	Disenado por:	Andres Mauricio Fajardo
	Fecha diseno:	24/11/2024					
	Programador:	Andres Mauricio Fajardo
	Fecha liberacion:	
	Parametros entrada:
		@id_entit: INT Identificador único para el elemento del catálogo de entidades
		@id_user: BIGINT -- Identificador único para el usuario

								
----------------------------------------------------------------------------
				Modificaciones				
----------------------------------------------------------------------------
	Fecha		Autor		Propósito		Version	
----------------------------------------------------------------------------
*/

CREATE PROCEDURE [dbo].[spUser_Permission]
	@id_entit INT,
	@id_user BIGINT

AS
/*
declare @id_entit INT,
	@id_user BIGINT

set @id_entit = 2
set @id_user = 1

EXEC spUser_Permission @id_entit, @id_user
*/

-- 1. PERMISOS A NIVEL DE REGISTRO

-- TABLA TEMPORAL PARA TOMAR DATOS NECESARIOS A NIVEL DE REGISTRO Y ALISTAR DATOS PARA QUERY DINAMICO
CREATE TABLE #tmpPermi_Record(
id INT IDENTITY(1,1) PRIMARY KEY,
user_username NVARCHAR(255) NOT NULL,
compa_name NVARCHAR(255) NOT NULL,
Permission_Type VARCHAR(50) NOT NULL,
entitycatalog_id INT NOT NULL,
entit_name NVARCHAR(255) NOT NULL,
can_create BIT NOT NULL,
can_read BIT NOT NULL,
can_update BIT NOT NULL,
can_delete BIT NOT NULL,
can_import BIT NOT NULL,
can_export BIT NOT NULL,
peusr_record BIGINT NOT NULL,
peusr_include BIT NOT NULL
)


-- TOMAR DATOS NECESARIOS A NIVEL DE REGISTRO
--A NIVEL DE USUARIO
INSERT INTO #tmpPermi_Record
SELECT U.user_username, C.compa_name, 'User_Record' as Permission_Type, PUR.entitycatalog_id, EC.entit_name, P.can_create, P.can_read, P.can_update, P.can_delete, P.can_import, P.can_export, PUR.peusr_record, PUR.peusr_include
FROM [User] U 
		INNER JOIN UserCompany UC
			ON U.id_user = UC.user_id AND U.user_is_active = 1 AND UC.useco_active = 1
		INNER JOIN Company C
			ON UC.company_id = C.id_compa AND C.compa_active = 1
		INNER JOIN PermiUserRecord PUR
			ON UC.id_useco = PUR.usercompany_id
		INNER JOIN Permission P
			ON PUR.permission_id = P.id_permi
		INNER JOIN EntityCatalog EC
			ON PUR.entitycatalog_id = EC.id_entit AND EC.entit_active = 1
WHERE U.id_user = @id_user  
UNION
--A NIVEL DE ROL
SELECT U.user_username, C.compa_name, 'Role_Record' as Permission_Type, PRR.entitycatalog_id, EC.entit_name, P.can_create, P.can_read, P.can_update, P.can_delete, P.can_import, P.can_export, PRR.perrc_record, PRR.perrc_include
FROM [User] U 
		INNER JOIN UserRole UR
			ON U.id_user = UR.user_id AND U.user_is_active = 1 AND UR.usero_active = 1
		INNER JOIN UserCompany UC
			ON U.id_user = UC.user_id AND UC.useco_active = 1
		INNER JOIN Company C
			ON UC.company_id = C.id_compa AND C.compa_active = 1
		INNER JOIN PermiRoleRecord PRR
			ON UR.role_id = PRR.role_id
		INNER JOIN Permission P
			ON PRR.permission_id = P.id_permi
		INNER JOIN EntityCatalog EC
			ON PRR.entitycatalog_id = EC.id_entit AND EC.entit_active = 1
WHERE U.id_user = @id_user 

-- PRESENTACION DE PERMISOS POR REGISTRO	
	-- SE REALIZA QUERY DINAMICO PARA IDENTIFICAR UNO A UNO LOS PERMISOS ASOCIADOS A CADA REGISTRO DE CADA ENTIDAD
	-- SE REALIZA ASÍ EN CASO QUE EN ALGÚN MOMENTO SE QUIERA INGRESAR SOLO EL @id_user Y SE QUIERA PRESENTAR TODOS LOS PERMISOS ASOCIADOS A ESE USUARIO 

DECLARE @i INT, @max INT

SET @i = 1
SELECT @max = MAX(id) FROM #tmpPermi_Record

WHILE (@i <= @max)
BEGIN
	DECLARE @entit_name NVARCHAR(255), @column_entit NVARCHAR(255), @record BIGINT, @include BIT
	DECLARE @query NVARCHAR(MAX) 
	
	SELECT @entit_name = entit_name, @record = peusr_record, @include = peusr_include
	FROM #tmpPermi_Record
	WHERE id = @i

	SELECT @column_entit = c.name
	FROM sysobjects o
		INNER JOIN syscolumns c
			ON o.id = c.id
	WHERE o.xtype = 'U' AND o.name = @entit_name AND c.colid = 1
	
	SET @query = ''
	
	SET @query = 'SELECT *' 
				+ ' FROM #tmpPermi_Record tmp' 
				+ ' CROSS JOIN ' + @entit_name + ' e' 
				+ ' WHERE tmp.id = ' + CONVERT(VARCHAR(15), @i) 
				+ ' AND e.' + @column_entit + CASE @include 
												WHEN 1 THEN ' = ' -- INCLUIDOS
												WHEN 0 THEN ' <> ' -- EXCLUIDOS
											  END
											+ CONVERT(VARCHAR(15), @record)
				

	--PRINT @query
	EXECUTE sp_executesql @query

	SET @i = @i + 1
END

-- 2. PERMISOS A NIVEL DE ENTIDAD

-- TOMAR DATOS NECESARIOS A NIVEL DE ENTIDAD
--A NIVEL DE USUARIO
SELECT U.user_username, C.compa_name, 'User_Entity' as Permission_Type, PU.entitycatalog_id, EC.entit_name, P.can_create, P.can_read, P.can_update, P.can_delete, P.can_import, P.can_export, PU.peusr_include
INTO #tmpPermi_Entity
FROM [User] U 
		INNER JOIN UserCompany UC
			ON U.id_user = UC.user_id AND U.user_is_active = 1 AND UC.useco_active = 1
		INNER JOIN Company C
			ON UC.company_id = C.id_compa AND C.compa_active = 1
		INNER JOIN PermiUser PU
			ON UC.id_useco = PU.usercompany_id
		INNER JOIN Permission P
			ON PU.permission_id = P.id_permi
		INNER JOIN EntityCatalog EC
			ON PU.entitycatalog_id = EC.id_entit AND EC.entit_active = 1
WHERE U.id_user = @id_user 
UNION
--A NIVEL DE ROL
SELECT U.user_username, C.compa_name, 'Role_Entity' as Permission_Type, PR.entitycatalog_id, EC.entit_name, P.can_create, P.can_read, P.can_update, P.can_delete, P.can_import, P.can_export, PR.perol_include
FROM [User] U
		INNER JOIN UserRole UR
			ON U.id_user = UR.user_id AND U.user_is_active = 1 AND UR.usero_active = 1 
		INNER JOIN UserCompany UC
			ON U.id_user = UC.user_id AND U.user_is_active = 1 AND UC.useco_active = 1
		INNER JOIN Company C
			ON UC.company_id = C.id_compa AND C.compa_active = 1
		INNER JOIN PermiRole PR
			ON UR.role_id = PR.role_id
		INNER JOIN Permission P
			ON PR.permission_id = P.id_permi
		INNER JOIN EntityCatalog EC
			ON PR.entitycatalog_id = EC.id_entit AND EC.entit_active = 1
WHERE U.id_user = @id_user 

-- MANEJO Y PRESENTACION DE PERMISOS POR ENTIDAD
	-- INCLUIDOS
SELECT DISTINCT user_username,	compa_name,	Permission_Type, entitycatalog_id,	entit_name,	can_create,	can_read,	can_update,	can_delete,	can_import,	can_export
FROM #tmpPermi_Entity
WHERE peusr_include = 1 AND entitycatalog_id = @id_entit 
UNION
	-- EXCLUIDOS
SELECT DISTINCT tPR.user_username,	tPR.compa_name,	tPR.Permission_Type, EC.id_entit,	EC.entit_name,	tPR.can_create,	tPR.can_read,	tPR.can_update,	tPR.can_delete,	tPR.can_import,	tPR.can_export
FROM #tmpPermi_Entity tPR
		INNER JOIN EntityCatalog EC
			ON tPR.entitycatalog_id <> EC.id_entit
WHERE peusr_include = 0 AND EC.id_entit = @id_entit 










