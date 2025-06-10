use blog_site;

-- user table
create index idx_user_email on user(email);
create index idx_user_srn on user(srn);

-- post table
create index idx_post_user on post(user_id);
create index idx_post_date on post(post_date);
create index idx_post_likes on post(no_of_likes);

-- comment table 
create index idx_comment_user on comment(user_id);
create index idx_comment_post on comment(post_id);
create index idx_comment_time on comment(comment_time);



-- post_category junction table - primary key already creates clustered index on (post_id, category_id)
create index idx_post_category_category on post_category(category_id);

-- post_likes table - primary key already creates clustered index on (post_id, user_id)
create index idx_post_likes_user on post_likes(user_id);
create index idx_post_likes_time on post_likes(time_of_like);
