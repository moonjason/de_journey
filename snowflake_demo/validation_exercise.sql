create or replace table exercise_db.public.employees (
    customer_id int,
    first_name varchar(50),
    last_name varchar(50), 
    email varchar(50),
    age int,
    department varchar(50)
)

create or replace stage exercise_db.public.validation_ex
    url='s3://snowflake-assignments-mc/copyoptions/example1/'

create or replace file format exercise_db.file_formats.validation_ex_format
    type = 'csv'
    field_delimiter = ','
    skip_header = 1 

desc file format exercise_db.file_formats.validation_ex_format

list @exercise_db.public.validation_ex

copy into exercise_db.public.employees 
    from @exercise_db.public.validation_ex
    file_format = (format_name = exercise_db.file_formats.validation_ex_format )
    files = ('employees.csv')
    -- validation_mode = return_errors
    on_error = 'continue'
    
select * from exercise_db.public.employees


-- INSTRUCTOR ANSWERs


-- Use validation mode
COPY INTO EXERCISE_DB.PUBLIC.EMPLOYEES
    FROM @aws_stage
      file_format= EXERCISE_DB.public.aws_fileformat
      VALIDATION_MODE = RETURN_ERRORS;
 

-- Use ON_ERROR
COPY INTO EXERCISE_DB.PUBLIC.EMPLOYEES
    FROM @aws_stage
      file_format= EXERCISE_DB.public.aws_fileformat
      ON_ERROR = CONTINUE;      
      