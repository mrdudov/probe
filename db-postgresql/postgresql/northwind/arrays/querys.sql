CREATE TABLE chess_game 
(
    white_player text,
    black_player text,
    moves text[],
    final_state text[][]
);

INSERT INTO chess_game
VALUES ('Caruana', 'Nakamura', '{"d4", "d5", "c4", "c6"}',
        '{{"Ra8", "Qe8", "x", "x","x","x","x","x"}, 
         {"a7", "x", "x", "x","x","x","x","x"}, 
         {"Kb5", "Bc5", "d5", "x","x","x","x","x"}}');

SELECT * FROM chess_game;

INSERT INTO chess_game
VALUES ('Caruana', 'Nakamura', ARRAY['d4', 'd5', 'c4', 'c6'],
        ARRAY[['Ra8', 'Qe8', 'x', 'x','x','x','x','x'], 
         ['a7', 'x', 'x', 'x','x','x','x','x'], 
         ['Kb5', 'Bc5', 'd5', 'x','x','x','x','x']]);

SELECT moves[2:3]
FROM chess_game;

SELECT moves[:3]
FROM chess_game;

SELECT moves[2:]
FROM chess_game;


SELECT array_dims(moves), array_length(moves, 1)
FROM chess_game;

SELECT array_dims(final_state), array_length(moves, 1)
FROM chess_game;

UPDATE chess_game
SET moves = ARRAY['e4', 'd3', 'd4', 'Kf6'];


UPDATE chess_game
SET moves[4] = 'g6';

SELECT *
FROM chess_game
WHERE 'g6' = ANY(moves);

-- operators

SELECT ARRAY[1,2,3,4] = ARRAY[1,2,3,4]; -- true

SELECT ARRAY[1,2,4,3] = ARRAY[1,2,3,4]; -- false

SELECT ARRAY[1,2,4,3] > ARRAY[1,2,3,4]; -- true

SELECT ARRAY[1,2,4,3] > ARRAY[1,2,5,4]; -- false

SELECT ARRAY[1,2,3,4] @> ARRAY[1,2]; -- true

SELECT ARRAY[1,2,3,4] @> ARRAY[1,2,5]; -- false

SELECT ARRAY[1,2] <@ ARRAY[1,2,3,4]; -- true

SELECT ARRAY[1,2,6] <@ ARRAY[1,2,5]; -- false

SELECT ARRAY[1,2,3,4] && ARRAY[1,2]; -- true

SELECT ARRAY[1,2,3,4] && ARRAY[5,6]; -- false

SELECT * 
FROM chess_game
WHERE moves && ARRAY['d4'];


-- variadic & foreach

CREATE FUNCTION filtr_even(VARIADIC numbers int[]) RETURNS SETOF int AS $$
BEGIN
    FOR counter IN 1..array_upper(numbers, 1)
    LOOP
        CONTINUE WHEN counter % 2 != 0;
        RETURN NEXT counter;
    END LOOP;
END;
$$ LANGUAGE plpgsql;

SELECT * FROM filtr_even(1, 2, 3, 4, 5, 6, 7, 8, 9);


CREATE OR REPLACE FUNCTION filtr_even(VARIADIC numbers int[]) RETURNS SETOF int AS $$
DECLARE
    counter int;
BEGIN
    FOREACH counter IN ARRAY numbers
    LOOP
        CONTINUE WHEN counter % 2 != 0;
        RETURN NEXT counter;
    END LOOP;
END;
$$ LANGUAGE plpgsql;

SELECT * FROM filtr_even(1, 2, 3, 4, 5, 6, 7, 8, 9);
