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

-- SELECT  -- the $1 keyword can be used to reference an an object/unstructured data
-- $1:first_name::STRING,
-- $1:last_name::STRING,
-- $1:Skills[0]::STRING,
-- $1:Skills[1]::STRING
-- FROM JSON_RAW;

CREATE TABLE exercise_db.public.SKILLS AS
SELECT 
$1:first_name::STRING as first_name,
$1:last_name::STRING as last_name,
$1:Skills[0]::STRING as Skill_1,
$1:Skills[1]::STRING as Skill_2
FROM exercise_db.public.JSON_RAW;

select * from exercise_db.public.skills
where first_name = 'Florina'