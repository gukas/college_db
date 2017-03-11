select timediff(
    (select update_time from information_schema.tables where table_schema='college' and table_name='sub_faculty'),
    (select create_time from information_schema.tables where table_schema='college' and table_name='payment')
) as data_load_time_diff;