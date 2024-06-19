-- Creating an s3 stage 
CREATE OR REPLACE STAGE EXERCISE_DB.PUBLIC.MY_EXERCISE_STAGE
    url = 's3://snowflake-assignments-mc/fileformat/'

-- Creating a file formats schema for organization
CREATE OR REPLACE SCHEMA EXERCISE_DB.FILE_FORMATS


-- Creating a file format
CREATE OR REPLACE FILE FORMAT EXERCISE_DB.FILE_FORMATS.my_file_format

ALTER FILE FORMAT EXERCISE_DB.FILE_FORMATS.my_file_format
    set field_delimiter = '|', skip_header = 1

DESC FILE FORMAT EXERCISE_DB.FILE_FORMATS.my_file_format


-- LIST FILES in STAGE
LIST @EXERCISE_DB.PUBLIC.MY_EXERCISE_STAGE --@MY_EXERCISE_STAGE IF CONTEXT of DB + SCHEMA is selected 

COPY INTO EXERCISE_DB.PUBLIC.CUSTOMERS
    FROM @EXERCISE_DB.PUBLIC.MY_EXERCISE_STAGE
    file_format = (format_name = EXERCISE_DB.FILE_FORMATS.my_file_format)
    files = ('customers4.csv')
    on_error = 'CONTINUE'


-- FULL SOLUTION DOWN BELOW

--  ---- Assignment - Create file format & load data ----
 
-- -- create stage object
-- CREATE OR REPLACE STAGE EXERCISE_DB.public.aws_stage
--     url='s3://snowflake-assignments-mc/fileformat';

-- -- List files in stage
-- LIST @EXERCISE_DB.public.aws_stage;

-- -- create file format object
-- CREATE OR REPLACE FILE FORMAT EXERCISE_DB.public.aws_fileformat
-- TYPE = CSV
-- FIELD_DELIMITER='|'
-- SKIP_HEADER=1;

-- -- Load the data 
-- COPY INTO EXERCISE_DB.PUBLIC.CUSTOMERS
--     FROM @aws_stage
--       file_format= (FORMAT_NAME=EXERCISE_DB.public.aws_fileformat)
      
-- -- Alternative
-- COPY INTO EXERCISE_DB.PUBLIC.CUSTOMERS
--     FROM @aws_stage
--       file_format= EXERCISE_DB.public.aws_fileformat