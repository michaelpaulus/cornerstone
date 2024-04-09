﻿-- TransactionHistory

IF NOT EXISTS
    (
        SELECT
            1
        FROM
            sys.tables INNER JOIN
            sys.schemas ON
                tables.schema_id = schemas.schema_id
        WHERE
            tables.name = 'TransactionHistory' AND
            schemas.name = 'Production'
    )
    CREATE TABLE [Production].[TransactionHistory]
    (
        [TransactionID] INT IDENTITY (1, 1) NOT NULL,
        [ProductID] INT NOT NULL,
        [ReferenceOrderID] INT NOT NULL,
        [ReferenceOrderLineID] INT NOT NULL DEFAULT (0),
        [TransactionDate] DATETIME NOT NULL DEFAULT (GETDATE()),
        [TransactionType] NCHAR(1) NOT NULL,
        [Quantity] INT NOT NULL,
        [ActualCost] MONEY NOT NULL,
        [ModifiedDate] DATETIME NOT NULL DEFAULT (GETDATE())
    )
GO

IF EXISTS
    (
        SELECT
            1
        FROM
            fn_listextendedproperty('MS_Description', 'schema', 'Production', 'table', 'TransactionHistory', DEFAULT, DEFAULT)
    )
BEGIN
    EXEC sys.sp_dropextendedproperty @name = N'MS_Description',
                                     @level0type = N'schema',
                                     @level0name = 'Production',
                                     @level1type = N'table',
                                     @level1name = 'TransactionHistory';
END
GO

EXEC sys.sp_addextendedproperty @name = N'MS_Description',
                                @value = N'Record of each purchase order, sales order, or work order transaction year to date.',
                                @level0type = N'schema',
                                @level0name = 'Production',
                                @level1type = N'table',
                                @level1name = 'TransactionHistory';
GO


IF EXISTS
    (
        SELECT
            1
        FROM
            fn_listextendedproperty('MS_Description', 'schema', 'Production', 'table', 'TransactionHistory', 'column', 'TransactionID')
    )
BEGIN
    EXEC sys.sp_dropextendedproperty @name = N'MS_Description',
                                     @level0type = N'schema',
                                     @level0name = 'Production',
                                     @level1type = N'table',
                                     @level1name = 'TransactionHistory',
                                     @level2type = N'column',
                                     @level2name = 'TransactionID';
END
GO

EXEC sys.sp_addextendedproperty @name = N'MS_Description',
                                @value = N'Primary key for TransactionHistory records.',
                                @level0type = N'schema',
                                @level0name = 'Production',
                                @level1type = N'table',
                                @level1name = 'TransactionHistory',
                                @level2type = N'column',
                                @level2name = 'TransactionID';
GO


IF EXISTS
    (
        SELECT
            1
        FROM
            fn_listextendedproperty('MS_Description', 'schema', 'Production', 'table', 'TransactionHistory', 'column', 'ProductID')
    )
BEGIN
    EXEC sys.sp_dropextendedproperty @name = N'MS_Description',
                                     @level0type = N'schema',
                                     @level0name = 'Production',
                                     @level1type = N'table',
                                     @level1name = 'TransactionHistory',
                                     @level2type = N'column',
                                     @level2name = 'ProductID';
END
GO

EXEC sys.sp_addextendedproperty @name = N'MS_Description',
                                @value = N'Product identification number. Foreign key to Product.ProductID.',
                                @level0type = N'schema',
                                @level0name = 'Production',
                                @level1type = N'table',
                                @level1name = 'TransactionHistory',
                                @level2type = N'column',
                                @level2name = 'ProductID';
GO


IF EXISTS
    (
        SELECT
            1
        FROM
            fn_listextendedproperty('MS_Description', 'schema', 'Production', 'table', 'TransactionHistory', 'column', 'ReferenceOrderID')
    )
BEGIN
    EXEC sys.sp_dropextendedproperty @name = N'MS_Description',
                                     @level0type = N'schema',
                                     @level0name = 'Production',
                                     @level1type = N'table',
                                     @level1name = 'TransactionHistory',
                                     @level2type = N'column',
                                     @level2name = 'ReferenceOrderID';
END
GO

EXEC sys.sp_addextendedproperty @name = N'MS_Description',
                                @value = N'Purchase order, sales order, or work order identification number.',
                                @level0type = N'schema',
                                @level0name = 'Production',
                                @level1type = N'table',
                                @level1name = 'TransactionHistory',
                                @level2type = N'column',
                                @level2name = 'ReferenceOrderID';
GO


IF EXISTS
    (
        SELECT
            1
        FROM
            fn_listextendedproperty('MS_Description', 'schema', 'Production', 'table', 'TransactionHistory', 'column', 'ReferenceOrderLineID')
    )
BEGIN
    EXEC sys.sp_dropextendedproperty @name = N'MS_Description',
                                     @level0type = N'schema',
                                     @level0name = 'Production',
                                     @level1type = N'table',
                                     @level1name = 'TransactionHistory',
                                     @level2type = N'column',
                                     @level2name = 'ReferenceOrderLineID';
END
GO

EXEC sys.sp_addextendedproperty @name = N'MS_Description',
                                @value = N'Line number associated with the purchase order, sales order, or work order.',
                                @level0type = N'schema',
                                @level0name = 'Production',
                                @level1type = N'table',
                                @level1name = 'TransactionHistory',
                                @level2type = N'column',
                                @level2name = 'ReferenceOrderLineID';
GO


IF EXISTS
    (
        SELECT
            1
        FROM
            fn_listextendedproperty('MS_Description', 'schema', 'Production', 'table', 'TransactionHistory', 'column', 'TransactionDate')
    )
BEGIN
    EXEC sys.sp_dropextendedproperty @name = N'MS_Description',
                                     @level0type = N'schema',
                                     @level0name = 'Production',
                                     @level1type = N'table',
                                     @level1name = 'TransactionHistory',
                                     @level2type = N'column',
                                     @level2name = 'TransactionDate';
END
GO

EXEC sys.sp_addextendedproperty @name = N'MS_Description',
                                @value = N'Date and time of the transaction.',
                                @level0type = N'schema',
                                @level0name = 'Production',
                                @level1type = N'table',
                                @level1name = 'TransactionHistory',
                                @level2type = N'column',
                                @level2name = 'TransactionDate';
GO


IF EXISTS
    (
        SELECT
            1
        FROM
            fn_listextendedproperty('MS_Description', 'schema', 'Production', 'table', 'TransactionHistory', 'column', 'TransactionType')
    )
BEGIN
    EXEC sys.sp_dropextendedproperty @name = N'MS_Description',
                                     @level0type = N'schema',
                                     @level0name = 'Production',
                                     @level1type = N'table',
                                     @level1name = 'TransactionHistory',
                                     @level2type = N'column',
                                     @level2name = 'TransactionType';
END
GO

EXEC sys.sp_addextendedproperty @name = N'MS_Description',
                                @value = N'W = WorkOrder, S = SalesOrder, P = PurchaseOrder',
                                @level0type = N'schema',
                                @level0name = 'Production',
                                @level1type = N'table',
                                @level1name = 'TransactionHistory',
                                @level2type = N'column',
                                @level2name = 'TransactionType';
GO


IF EXISTS
    (
        SELECT
            1
        FROM
            fn_listextendedproperty('MS_Description', 'schema', 'Production', 'table', 'TransactionHistory', 'column', 'Quantity')
    )
BEGIN
    EXEC sys.sp_dropextendedproperty @name = N'MS_Description',
                                     @level0type = N'schema',
                                     @level0name = 'Production',
                                     @level1type = N'table',
                                     @level1name = 'TransactionHistory',
                                     @level2type = N'column',
                                     @level2name = 'Quantity';
END
GO

EXEC sys.sp_addextendedproperty @name = N'MS_Description',
                                @value = N'Product quantity.',
                                @level0type = N'schema',
                                @level0name = 'Production',
                                @level1type = N'table',
                                @level1name = 'TransactionHistory',
                                @level2type = N'column',
                                @level2name = 'Quantity';
GO


IF EXISTS
    (
        SELECT
            1
        FROM
            fn_listextendedproperty('MS_Description', 'schema', 'Production', 'table', 'TransactionHistory', 'column', 'ActualCost')
    )
BEGIN
    EXEC sys.sp_dropextendedproperty @name = N'MS_Description',
                                     @level0type = N'schema',
                                     @level0name = 'Production',
                                     @level1type = N'table',
                                     @level1name = 'TransactionHistory',
                                     @level2type = N'column',
                                     @level2name = 'ActualCost';
END
GO

EXEC sys.sp_addextendedproperty @name = N'MS_Description',
                                @value = N'Product cost.',
                                @level0type = N'schema',
                                @level0name = 'Production',
                                @level1type = N'table',
                                @level1name = 'TransactionHistory',
                                @level2type = N'column',
                                @level2name = 'ActualCost';
GO


IF EXISTS
    (
        SELECT
            1
        FROM
            fn_listextendedproperty('MS_Description', 'schema', 'Production', 'table', 'TransactionHistory', 'column', 'ModifiedDate')
    )
BEGIN
    EXEC sys.sp_dropextendedproperty @name = N'MS_Description',
                                     @level0type = N'schema',
                                     @level0name = 'Production',
                                     @level1type = N'table',
                                     @level1name = 'TransactionHistory',
                                     @level2type = N'column',
                                     @level2name = 'ModifiedDate';
END
GO

EXEC sys.sp_addextendedproperty @name = N'MS_Description',
                                @value = N'Date and time the record was last updated.',
                                @level0type = N'schema',
                                @level0name = 'Production',
                                @level1type = N'table',
                                @level1name = 'TransactionHistory',
                                @level2type = N'column',
                                @level2name = 'ModifiedDate';
GO
