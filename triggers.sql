use blog_site;

-- *****************************************************************************************

-- trigger: after_category_delete
delimiter //
create trigger after_category_delete after delete on category
for each row
begin
    delete from post_category where category_id = old.category_id;
end //
delimiter ;

-- *****************************************************************************************

-- trigger: DeleteUserPostsAndRelatedData
delimiter //
create trigger DeleteUserPostsAndRelatedData before delete on user
for each row
begin
    delete from post_likes where user_id = old.user_id;
    delete from comment where user_id = old.user_id;
end //
delimiter ;

-- *****************************************************************************************

show triggers;
