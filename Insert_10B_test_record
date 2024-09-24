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
