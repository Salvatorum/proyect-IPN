USE IPN-proyect-BBDD;

GO

CREATE PROCEDURE SP_item_image_add
	@url VARCHAR(300),
	@colorId INT,
	@itemId INT 
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
	VALUES (@url, @colorId, @itemId);

	SELECT SCOPE_IDENTITY() AS idColorInsert, 'imagen insertado correctamente' AS Mensaje;

	
END;

GO
/* SP de TB_item */

CREATE PROCEDURE SP_item_add
    @name VARCHAR(100),
    @sku VARCHAR(20),
    @desc VARCHAR(400),
	@idItemInsert INT OUTPUT
AS
BEGIN
    
    IF EXISTS (SELECT 1 FROM TB_item WHERE sku = @sku)
    BEGIN
        RAISERROR('Ya existe un producto/artículo con ese SKU.', 16, 1)
        RETURN
    END

   
    INSERT INTO TB_item (name, sku, description)
    VALUES (@name, @sku, @desc);

	SET @idItemInsert = SCOPE_IDENTITY();
   
END;

GO

/* SP de item_price_list */

CREATE PROCEDURE SP_item_price_list
	@itemId INT,
	@price_list_id INT,
	@price INT 

AS
BEGIN
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
    VALUES (@itemId, @price_list_id, @price);

    SELECT SCOPE_IDENTITY() AS id_item_price_list, 'Registro de TB_item_price_list insertado correctamente' AS Mensaje;  
END;

GO

/* SP encargado de accionar los anteriores SP */

CREATE PROCEDURE SP_item_complete_add
    @url VARCHAR(300),
    @colorId INT,
    @name VARCHAR(100),
    @sku VARCHAR(20),
    @desc VARCHAR(400),
    @price_list_id INT,
    @price INT
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION

			DECLARE @itemId INT;

			EXEC SP_item_add @name, @sku, @desc, @itemId OUTPUT; 

			EXEC SP_item_image_add @url, @colorId, @itemId;  

			EXEC SP_item_price_list @itemId, @price_list_id, @price;

		COMMIT TRANSACTION

		SELECT @itemId AS idItemInsertado, 'Producto/Artículo insertado correctamente' AS Mensaje;


	END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION

        DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE()
        DECLARE @ErrorSeverity INT = ERROR_SEVERITY()
        DECLARE @ErrorState INT = ERROR_STATE()

        RAISERROR(@ErrorMessage, @ErrorSeverity, @ErrorState)
    END CATCH
END;
GO