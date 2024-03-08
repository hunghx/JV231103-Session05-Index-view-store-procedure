use firstdb;
create table Employee
(
    id   int primary key auto_increment, -- có 1 index được đánh bới khóa chính
    name varchar(100)
);

# thêm dữ liệu vào bảng
insert into employee value
    (1, 'Nguyễn Văn A'),
    (5, 'Nguyễn Văn B'),
    (2, 'Nguyễn Vawnx C');


select *
from employee;
# 102.80, 111 , 2.414
explain analyze
select *
from users
where name like 'Keyon Volkman';
#cost=102.80 rows=998) (actual time=0.133..2.046 rows=998

create index index_name
    on users (name);

# tạo thủ tục
delimiter // -- cấp phát vungf nhớ tạo thủ tuc
create procedure proc_add_student_with_check_age(id_in int, name_in varchar(100), age_in int, sex_in bit)

begin

    if age_in >= 18 then
        insert into student(id, name, age, sex) value (id_in, name_in, age_in, sex_in);
    else
        signal SQLSTATE '45000' set MESSAGE_TEXT = 'Tuoi khong duoc duoi 18';
    end if;
end //
# tạo thủ tục
delimiter // -- cấp phát vungf nhớ tạo thủ tuc
create procedure proc_count_name_length(id_in int, out length int)
begin
    select length(name) into length from student where id = id_in;
end //
#gọi thủ tục
call proc_add_student_with_check_age(112, 'Dỗ mạnh Huascnng', 17, 1);
# không sử dụng được
select length(name)
from student
where id = 3;
call proc_count_name_length(100, @length);
select @length;


# View là bảng ao  được tạo ra từ câu lệnh truy vấn select
# view ghi nhớ lại kết quả câu lệnh select để tái sử dụng

create view view_song_genre
as
select s.*, g.name as `thể loại`
from songs s
         join genres g on s.genre_id = g.id;

select *
from view_song_genre;

create view song_singger_view
as
select *
from songs
where singer_id in (3, 4, 5)
with check option;

insert into song_singger_view(id, name, price, file_url, image, album_id, singer_id, genre_id, created_at) VALUE
    (999, 'em cua ngay hom nay', 999, 'not found', 'no image', 2, 3, 2, now());


drop procedure if exists test_proc;
delimiter  //
create procedure test_proc()
begin
    declare time_current time default current_time();
    declare lunch time;
    set lunch = '12:00:00';
    #     set time_current = '10:30:59';
#     select if(time_current < lunch,'buổi sáng','Buổi chiều');
    # case when
    select case
               when time_current > lunch then 'buổi chiều'
               when time_current = lunch then 'giữa trưa'
               ELSE 'buổi sáng'
               end `buổi`;

end //

select name, case sex when 0 then 'Nữ' when 1 then 'Nam' end 'giới tính'
from student;
call test_proc();