CREATE OR REPLACE FUNCTION get_season(month_number int) RETURNS text AS $$
DECLARE
    season text;
BEGIN

    IF month_number NOT BETWEEN 1 AND 12 THEN
        RAISE EXCEPTION 'Invalid month, You passed: (%)', month_number USING HINT='Allowed from 1 to 12', ERRCODE = 12782;
    END IF;

    IF month_number BETWEEN 3 AND 5 
        THEN season = 'Spring';
    ELSEIF month_number BETWEEN 6 AND 8 
        THEN season = 'Summer';
    ELSEIF month_number BETWEEN 9 AND 11 
        THEN season = 'Autum';
    ELSE season = 'Winter';
    END IF;
    
    RETURN season;
END;
$$ LANGUAGE plpgsql;

SELECT get_season(16);

CREATE OR REPLACE FUNCTION get_season_coller(month_number int) RETURNS text AS $$
DECLARE
    err_ctx text;
    err_msg text;
    err_detail text;
    err_code text;
BEGIN
    RETURN get_season(month_number);
EXCEPTION WHEN SQLSTATE '12782' THEN
    GET STACKED DIAGNOSTICS 
        err_ctx = PG_EXCEPTION_CONTEXT,
        err_msg = MESSAGE_TEXT,
        err_detail = PG_EXCEPTION_DETAIL,
        err_code = RETURNED_SQLSTATE;
    RAISE INFO 'My custom handler:';
    RAISE INFO 'Error msg: %', err_msg;
    RAISE INFO 'Error detail: %', err_detail;
    RAISE INFO 'Error code: %', err_code;
    RAISE INFO 'Error context: %', err_ctx;
    RAISE INFO 'A problem. Nothig special.';
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

SELECT get_season_coller(16);


CREATE OR REPLACE FUNCTION get_season_coller2(month_number int) RETURNS text AS $$
BEGIN
    RETURN get_season(month_number);
EXCEPTION 
    WHEN SQLSTATE '12782' THEN
        RAISE INFO 'My custom handler:';
        RAISE INFO 'Error name: %', SQLERRM;
        RAISE INFO 'Error detail: %', SQLSTATE;
        RETURN NULL;
    WHEN OTHERS THEN
        RAISE INFO 'My custom handler:';
        RAISE INFO 'Error name: %', SQLERRM;
        RAISE INFO 'Error detail: %', SQLSTATE;
        RETURN NULL;
END;
$$ LANGUAGE plpgsql;

SELECT get_season_coller2(16);
