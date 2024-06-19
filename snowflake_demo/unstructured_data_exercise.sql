-- USE EXERCISE_DB;

create or replace stage exercise_db.public.unstructured_stage
    url = 's3://snowflake-assignments-mc/unstructureddata/';

create or replace file format exercise_db.file_formats.unstructured_format
    type = json;

create or replace table exercise_db.public.json_raw (
    raw variant
);
-- variant is a semi structured data type for objects and arrays 

copy into json_raw
    from @unstructured_stage
    file_format = EXERCISE_DB.FILE_FORMATS.UNSTRUCTURED_FORMAT;
    
Select * from json_raw