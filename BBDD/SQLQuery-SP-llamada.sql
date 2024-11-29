-- Ejemplo de cómo llamar a SP_item_complete_add y verificar el retorno
DECLARE @returnCode INT
DECLARE @idItem INT

EXEC @returnCode = SP_item_complete_add 
    @url = '...',  -- Los valores de los parámetros
	@colorId = 1,  
	-- ... otros parámetros
    @price = 100.50,
	@idItemInsertado = @idItem OUTPUT

IF @returnCode = 1
BEGIN
    PRINT 'Inserción exitosa. ID del item: ' + CAST(@idItem AS VARCHAR)
END
ELSE
BEGIN
    PRINT 'Error durante la inserción. Código de error: ' + CAST(@returnCode AS VARCHAR)
END

--Para los otros SPs el uso es similar.  Declaras una variable para el output y otra para el return code.

DECLARE @id_item_price_list INT
DECLARE @rc INT

EXEC @rc = SP_item_price_list @itemId=1, @price_list_id=1, @price = 10.50, @id_item_price_list OUTPUT

IF @rc = 1 
	PRINT 'OK - ID insertado: ' + CAST(@id_item_price_list AS VARCHAR(10))
ELSE
	PRINT 'Error al insertar en item_price_list'