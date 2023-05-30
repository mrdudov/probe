SELECT *
FROM products;

SELECT supplier_id, SUM(units_in_stock)
FROM products
GROUP BY supplier_id
ORDER BY supplier_id;

SELECT supplier_id, category_id, SUM(units_in_stock)
FROM products
GROUP BY supplier_id, category_id
ORDER BY supplier_id;

SELECT supplier_id, category_id, SUM(units_in_stock)
FROM products
GROUP BY GROUPING SETS (supplier_id, (supplier_id, category_id))
ORDER BY supplier_id, category_id NULLS FIRST;

SELECT supplier_id, SUM(units_in_stock)
FROM products
GROUP BY ROLLUP(supplier_id);

SELECT supplier_id, category_id, SUM(units_in_stock)
FROM products
GROUP BY ROLLUP (supplier_id, category_id)
ORDER BY supplier_id, category_id NULLS FIRST;

SELECT supplier_id, category_id, reorder_level, SUM(units_in_stock)
FROM products
GROUP BY ROLLUP (supplier_id, category_id, reorder_level)
ORDER BY supplier_id, category_id NULLS FIRST;

SELECT supplier_id, category_id, SUM(units_in_stock)
FROM products
GROUP BY CUBE (supplier_id, category_id)
ORDER BY supplier_id, category_id NULLS FIRST;

SELECT supplier_id, category_id, reorder_level, SUM(units_in_stock)
FROM products
GROUP BY CUBE (supplier_id, category_id, reorder_level)
ORDER BY supplier_id, category_id NULLS FIRST;
