create or replace table exercise_db.public.employees (
    customer_id int,
    first_name varchar(50),
    last_name varchar(50),
    email varchar(50),
    age int,
    department varchar(50)
)

create or replace stage exercise_db.public.copy_func_stage 
    url = 's3://snowflake-assignments-mc/copyoptions/example2/';

list @EXERCISE_DB.PUBLIC.COPY_FUNC_STAGE

create file format exercise_db.file_formats.copy_func_format
    type = 'csv'
    field_delimiter = ','
    skip_header = 1 

desc file format exercise_db.file_formats.copy_func_format

copy into employees 
    from @copy_func_stage
    file_format = exercise_db.file_formats.copy_func_format
    files = ('/employees_error.csv')
    on_error = continue
    return_failed_only = true
    truncatecolumns = true

SELECT * FROM employees;



-- INSTRUCTOR ANSWERS 
-- Use validation mode
COPY INTO EXERCISE_DB.PUBLIC.EMPLOYEES
    FROM @aws_stage
      file_format= EXERCISE_DB.public.aws_fileformat
      VALIDATION_MODE = RETURN_ERRORS;

       
-- Use TRUNCATECOLUMNS

COPY INTO EXERCISE_DB.PUBLIC.EMPLOYEES
    FROM @aws_stage
      file_format= EXERCISE_DB.public.aws_fileformat
      TRUNCATECOLUMNS = TRUE; 