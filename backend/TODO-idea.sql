-- TODO: find compatibility with sqlode
--
-- Column that can be set during INSERT, but cannot be changed afterward with UPDATE
--
-- CREATE TABLE my_table (
--     id bigint GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
--     original_text text NOT NULL
-- );

-- CREATE FUNCTION prevent_original_text_update()
-- RETURNS trigger
-- LANGUAGE plpgsql
-- AS $$
-- BEGIN
--     IF NEW.original_text IS DISTINCT FROM OLD.original_text THEN
--         RAISE EXCEPTION 'original_text cannot be changed after creation';
--     END IF;

--     RETURN NEW;
-- END;
-- $$;

-- CREATE TRIGGER original_text_immutable
-- BEFORE UPDATE ON my_table
-- FOR EACH ROW
-- EXECUTE FUNCTION prevent_original_text_update();
