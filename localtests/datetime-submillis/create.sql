drop table if exists gh_ost_test;
create table gh_ost_test (
  id int auto_increment,
  i int not null,
  dt0 datetime(6),
  dt1 datetime(6),
  ts2 timestamp(6),
  updated tinyint unsigned default 0,
  primary key(id),
  key i_idx(i)
) auto_increment=1;

drop event if exists gh_ost_test;
delimiter ;;
create event gh_ost_test
  on schedule every 1 second
  starts current_timestamp
  ends current_timestamp + interval 60 second
  on completion not preserve
  disable on slave
  do
begin
  insert into gh_ost_test values (null, 11, now(), now(), now(), 0);
  update gh_ost_test set dt1='2016-10-31 11:22:33.444', updated = 1 where i = 11 order by id desc limit 1;

  insert into gh_ost_test values (null, 13, now(), now(), now(), 0);
  update gh_ost_test set ts1='2016-11-01 11:22:33.444', updated = 1 where i = 13 order by id desc limit 1;
end ;;
