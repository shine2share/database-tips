oracle
select floor(DBMS_RANDOM.value * 1000000) as text-num,
DBMS_RANDOM.string('a', 20) as test_text,
to_date('2024-09-24', 'YYYY-MM-DD') + (DBMS_RANDOM.value * 365 * 20) as test_date
from dual;

create or replace procedure generate_sample_data(number_of_rows IN INTEGER)
as
begin
 for row_increment IN 1 .. number_of_rows LOOP
   insert into test_data(test_num, test_text, test_datetime)
   select
   floor(DBMS_RANDOM.value() * 1000000),
   DBMS_RANDOM.string('a', 20),
   to_date('2024-09-24', 'YYYY-MM-DD') + (DBMS_RANDOM.value() * 365 * 20)
   from dual;
 end LOOP;
end;

call generate_sample_data(10000000);

-> too slow

using connect by level

insert into test_data (test_num, test_text, test_datetime)
select
   floor(DBMS_RANDOM.value() * 1000000),
   DBMS_RANDOM.string('a', 20),
   to_date('2024-09-24', 'YYYY-MM-DD') + (DBMS_RANDOM.value() * 365 * 20)
   from dual
connect by level <= 10000000;

-> maybe throw not enough memory when run on local
but if run on linux server this error may not throw,
solution to run on local: using docker to adjust memory allocation.

-----------------------------

postgresql
using store procedure
create or replace procedure generate_sample_data(
    IN number_of_rows INTEGER
)
language plpgsql
as $$
begin
    for loop_increment in 1 .. number_of_rows loop
    insert into test_data(test_num, test_text, test_datetime)
      select
      floor(random() * 1000000),
      substring(md5(random()::text), 1, 20),
      '2024-09-20'::date + trunc(random() * 365 * 20)::int;
    end loop;
end;$$


using generate_series() build in function
