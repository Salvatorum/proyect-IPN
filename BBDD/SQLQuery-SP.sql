USE [IPN-proyect-BBDD-02]
GO

-- SP_item_price_list
ALTER PROCEDURE [dbo].[SP_item_price_list]
	@itemId INT,
	@price_list_id INT,
	@price DECIMAL(18,2), -- Cambiado a decimal para precios
	@id_item_price_list INT OUTPUT  -- Agregado output parameter
AS
BEGIN
	IF (@price <= 0)
	BEGIN
		RAISERROR('Precio ingresado no valido.', 16, 1)
		RETURN
	END

	IF NOT EXISTS (SELECT 1 FROM TB_item WHERE id_item = @itemId)
	BEGIN
		RAISERROR('Este producto/artículo no existe en la tabla TB_item.', 16, 1)
		RETURN
	END

	IF NOT EXISTS (SELECT 1 FROM TB_price_list WHERE id_price_list = @price_list_id)
	BEGIN
		RAISERROR('Esta lista de precio no existe en TB_price_list.', 16, 1)
		RETURN
	END

	INSERT INTO TB_item_price_list(id_item, id_price_list, price)
    VALUES (@itemId, @price_list_id, @price)

	IF @@ERROR <> 0  -- Verificar errores de inserción
    BEGIN
        RETURN -1 -- Devolver un código de error
    END

	SET @id_item_price_list = SCOPE_IDENTITY()

    RETURN 1 -- Éxito
END
GO

-- SP_item_image_add
ALTER PROCEDURE [dbo].[SP_item_image_add]
	@url VARCHAR(300),
	@colorId INT,
	@itemId INT,
	@idImgInsert INT OUTPUT -- Agregado output parameter
AS
BEGIN 
	IF EXISTS (SELECT 1 FROM TB_img WHERE url_img = @url)
	BEGIN
		RAISERROR('Ya existe esta imagen.', 16, 1)
		RETURN
	END

	IF NOT EXISTS (SELECT 1 FROM TB_color WHERE id_color = @colorId)
	BEGIN
		RAISERROR('Este color no existe en la tabla TB_color.', 16, 1)
		RETURN
	END

	IF NOT EXISTS (SELECT 1 FROM TB_item WHERE id_item = @itemId)
	BEGIN
		RAISERROR('Este producto/artículo no existe en la tabla TB_item.', 16, 1)
		RETURN
	END

	INSERT INTO TB_img (url_img, id_color, id_item)
	VALUES (@url, @colorId, @itemId)

    IF @@ERROR <> 0  -- Verificar errores de inserción
    BEGIN
        RETURN -1 -- Devolver un código de error
    END

	SET @idImgInsert = SCOPE_IDENTITY()

	RETURN 1 -- Éxito
END
GO

-- SP_item_complete_add
ALTER PROCEDURE [dbo].[SP_item_complete_add]
    @url VARCHAR(300),
	@colorId INT,
	@name VARCHAR(100),
	@sku VARCHAR(20),
	@desc VARCHAR(400),
	@price_list_id INT,
	@is_article BIT,
	@is_published BIT,
	@is_deleted BIT,
	@id_brand INT,
	@id_category INT,
	@weight INT,
	@height INT,
	@width INT,
	@depth INT,
	@volume INT,
	@price DECIMAL(18,2),
	@idItemInsertado INT OUTPUT
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION

        DECLARE @itemId INT
		DECLARE @rc INT  -- Variable para almacenar el código de retorno
		DECLARE @idImgInsert INT  -- Declaración de @idImgInsert AQUI

        EXEC @rc = SP_item_add @name, @sku, @desc, @is_article, @is_published, @is_deleted, @id_brand, @id_category, @weight, @height, @width, @depth, @volume, @itemId OUTPUT
        IF @rc <> 1 RETURN @rc --  Verificar el retorno del SP

		EXEC @rc = SP_item_image_add @url, @colorId, @itemId, @idImgInsert OUTPUT -- Usar la variable @itemId
        IF @rc <> 1 RETURN @rc --  Verificar el retorno del SP

		DECLARE @id_item_price_list INT
        EXEC @rc = SP_item_price_list @itemId, @price_list_id, @price, @id_item_price_list OUTPUT
        IF @rc <> 1 RETURN @rc -- Verificar el retorno del SP

        COMMIT TRANSACTION

        SET @idItemInsertado = @itemId

        RETURN 1 -- Éxito

    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION

		-- Registrar el error en una tabla de log o devolver un código de error específico
        RETURN -1 -- Error
    END CATCH
END
GO

-- SP_item_add
ALTER PROCEDURE [dbo].[SP_item_add]
    @name VARCHAR(100),
    @sku VARCHAR(20),
    @desc VARCHAR(400),
    @is_article BIT,
    @is_published BIT,
    @is_deleted BIT,
    @id_brand INT,
    @id_category INT,
    @weight INT,
    @height INT,
    @width INT,  
    @depth INT,
    @volume INT,
    @idItemInsert INT OUTPUT
AS
BEGIN
    IF EXISTS (SELECT 1 FROM TB_item WHERE sku = @sku)
    BEGIN
         RAISERROR('Ya existe un producto/artículo con ese SKU.', 16, 1)
        RETURN
    END

    INSERT INTO TB_item (name, sku, description, is_article, is_published, is_deleted, id_brand, id_category, weight, height, width, depth, volume)
    VALUES (@name, @sku, @desc, @is_article, @is_published, @is_deleted, @id_brand, @id_category, @weight, @height, @width, @depth, @volume)

	IF @@ERROR <> 0  -- Verificar errores de inserción
    BEGIN
        RETURN -1 -- Devolver un código de error
    END

    SET @idItemInsert = SCOPE_IDENTITY()

    RETURN 1 -- Éxito
END
GO