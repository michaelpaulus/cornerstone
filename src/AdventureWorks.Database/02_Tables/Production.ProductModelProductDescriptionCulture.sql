﻿-- ProductModelProductDescriptionCulture

IF NOT EXISTS
    (
        SELECT
            1
        FROM
            sys.tables INNER JOIN
            sys.schemas ON
                tables.schema_id = schemas.schema_id
        WHERE
            tables.name = 'ProductModelProductDescriptionCulture' AND
            schemas.name = 'Production'
    )
    CREATE TABLE [Production].[ProductModelProductDescriptionCulture]
    (
        [ProductModelID] INT NOT NULL,
        [ProductDescriptionID] INT NOT NULL,
        [CultureID] NCHAR(6) NOT NULL,
        [ModifiedDate] DATETIME NOT NULL DEFAULT (GETDATE())
    )
GO
