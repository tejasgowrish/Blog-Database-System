use blog_site;

-- *****************************************************************************************

-- CreatePostWithCategory - Users can create posts with a category directly
delimiter //
create procedure CreatePostWithCategory(
    in p_title varchar(255),
    in p_content text,
    in p_user_id int,
    in p_category_name varchar(100),
    in p_date datetime
)
begin
    declare category_id int default null;

    -- insert post into post table
    insert into post (title, content, user_id, post_date) values (p_title, p_content, p_user_id, p_date);

    -- check if the category already exists
    select category_id into category_id from category where category_name = p_category_name;

    -- if category does not exist, create it
    if category_id is null then
        insert into category (category_name) values (p_category_name);
        set category_id = last_insert_id();
    end if;

    -- insert into post_category to link the post and category
    insert into post_category (post_id, category_id) values (last_insert_id(), category_id);
end //
delimiter ;

-- *****************************************************************************************

-- Delete User - deletes associated records in the user, posts, likes, and comments tables
delimiter //
create procedure DeleteUser(in p_user_id int)
begin
    -- deletes user's posts, comments, likes automatically via cascade
    delete from user where user_id = p_user_id;
end //
delimiter ;

-- *****************************************************************************************

-- DeletePost - deletes all associates likes and comments from those tables
delimiter //
create procedure DeletePost(in p_post_id int)
begin
    -- deletes comments, likes, and categories linked to post via cascade
    delete from post where post_id = p_post_id;
end //
delimiter ;

-- *****************************************************************************************

delimiter //
create procedure CountLikesOnPost(
    in p_post_id int,
    out like_count int
)
begin
    select count(*) into like_count
    from post_likes
    where post_id = p_post_id;
end //
delimiter ;

-- *****************************************************************************************

-- LikePost - users can put likes on posts by post id
delimiter //
create procedure LikePost(in p_post_id int, in p_user_id int)
begin
    declare likeexists int default 0;

    -- check if the user has already liked the post
    select count(*) into likeexists from post_likes where post_id = p_post_id and user_id = p_user_id;

    -- if not, add like and increment like count on the post
    if likeexists = 0 then
        insert into post_likes (post_id, user_id, time_of_like) values (p_post_id, p_user_id, now());
        update post set no_of_likes = no_of_likes + 1 where post_id = p_post_id;
    end if;
end //
delimiter ;

-- *****************************************************************************************

-- CommentOnPost
delimiter //
create procedure CommentOnPost(in p_post_id int, in p_comment_content text, in p_user_id int)
begin
    insert into comment (comment_content, user_id, post_id) values (p_comment_content, p_user_id, p_post_id);
end //
delimiter ;

-- *****************************************************************************************

-- EditPost
delimiter //
create procedure EditPost(in p_post_id int, in p_new_title varchar(255), in p_new_content text)
begin
    update post set title = p_new_title, content = p_new_content where post_id = p_post_id;
end //
delimiter ;

-- *****************************************************************************************

-- GetPostsByUser
delimiter //
create procedure GetPostsByUser(in p_user_id int)
begin
    select post_id, title, content, post_date, no_of_likes
    from post
    where user_id = p_user_id
    order by post_date desc;
end //
delimiter ;

-- *****************************************************************************************

-- GetPostsByCategory
delimiter //
create procedure GetPostsByCategory(in p_category_name varchar(100))
begin
    select p.post_id, p.title, p.content, p.post_date, p.no_of_likes
    from post p
    join post_category pc on p.post_id = pc.post_id
    join category c on pc.category_id = c.category_id
    where c.category_name = p_category_name
    order by p.post_date desc;
end //
delimiter ;

-- *****************************************************************************************

-- SearchPostsByKeyword
delimiter //
create procedure SearchPostsByKeyword(in p_keyword varchar(255))
begin
    select post_id, title, content, post_date, no_of_likes
    from post
    where title like concat('%', p_keyword, '%') or content like concat('%', p_keyword, '%')
    order by post_date desc;
end //
delimiter ;
