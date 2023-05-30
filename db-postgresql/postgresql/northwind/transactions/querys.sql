BEGIN TRANSACTION ISOLATION LEVEL SERIALIZABLE;

WITH prod_update AS (
    UPDATE products
    SET discontinued = 1
    WHERE units_in_stock < 10
    RETURNING product_id
)
SELECT * INTO last_orders_on_discontinued
FROM order_details
WHERE product_id IN (SELECT product_id FROM prod_update);

DROP TABLE last_orders_on_discontinued11111111111111111;

SAVEPOINT backup;

DELETE FROM order_details
WHERE product_id IN (SELECT product_id FROM prod_update);

ROLLBACK TO backup;

COMMIT;

SELECT * FROM last_orders_on_discontinued;

DROP TABLE IF EXISTS last_orders_on_discontinued;
