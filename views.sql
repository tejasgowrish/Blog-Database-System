use blog_site;

-- *****************************************************************************************

-- view for posts with all info
-- drop view postWithCategories;
create or replace view postWithCategories as
select 
    p.post_id,
    p.title,
    p.content,
    p.user_id,
    u.name as user_name,
    p.post_date,
    p.no_of_likes,
    group_concat(c.category_name separator ', ') as category_names
from 
    post p
join 
    user u on p.user_id = u.user_id
left join 
    post_category pc on p.post_id = pc.post_id
left join 
    category c on pc.category_id = c.category_id
group by 
    p.post_id;


select * from postwithcategories;
-- *****************************************************************************************

-- view for posts with above average likes
create view postsAboveAverageLikes as
select 
    p.post_id,
    p.title,
    p.content,
    u.name as user_name,
    p.no_of_likes
from 
    post p
join 
    user u on p.user_id = u.user_id
where 
    p.no_of_likes > (select avg(no_of_likes) from post);
    
select * from postsaboveaveragelikes;    

-- *****************************************************************************************

select * from comment;

create view postComments as
select 
    post.post_id,
    post.title as post_title,
    comment.comment_id,
    comment.comment_content,
    user.user_id
from 
    comment
join 
    post on comment.post_id = post.post_id
left join 
    user on comment.user_id = user.user_id;

select * from postComments where post_id = 24;
