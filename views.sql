USE blog_site;

-- *****************************************************************************************

-- View for PostWithAllInfo
-- drop view PostWithCategories;
CREATE OR REPLACE VIEW PostWithCategories AS
SELECT 
    P.POST_ID,
    P.TITLE,
    P.CONTENT,
    P.USER_ID,
    U.NAME AS USER_NAME,
    P.POST_DATE,
    P.NO_OF_LIKES,
    GROUP_CONCAT(C.CATEGORY_NAME SEPARATOR ', ') AS CATEGORY_NAMES
FROM 
    POST P
JOIN 
    USER U ON P.USER_ID = U.USER_ID
LEFT JOIN 
    POST_CATEGORY PC ON P.POST_ID = PC.POST_ID
LEFT JOIN 
    CATEGORY C ON PC.CATEGORY_ID = C.CATEGORY_ID
GROUP BY 
    P.POST_ID;


select * from PostWithCategories;
-- *****************************************************************************************

-- View for PostsWithAboveAverageLikes
CREATE VIEW PostsAboveAverageLikes AS
SELECT 
    P.POST_ID,
    P.TITLE,
    P.CONTENT,
    U.NAME AS USER_NAME,
    P.NO_OF_LIKES
FROM 
    POST P
JOIN 
    USER U ON P.USER_ID = U.USER_ID
WHERE 
    P.NO_OF_LIKES > (SELECT AVG(NO_OF_LIKES) FROM POST);
    
select * from PostsAboveAverageLikes;	
-- *****************************************************************************************
select * from comment;

CREATE VIEW PostComments AS
SELECT 
    post.post_id,
    Post.title AS post_title,
    Comment.comment_id,
    Comment.comment_content,
    User.user_id
FROM 
    Comment
JOIN 
    Post ON Comment.post_id = Post.post_id
LEFT JOIN 
    User ON Comment.user_id = User.user_id;

SELECT * FROM PostComments WHERE post_id = 24;
