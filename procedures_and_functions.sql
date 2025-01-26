USE blog_site;

-- *****************************************************************************************

CreatePostWithCategory - Users can create posts with a category directly
DELIMITER //
CREATE PROCEDURE CreatePostWithCategory(
    IN p_title VARCHAR(255),
    IN p_content TEXT,
    IN p_user_id INT,
    IN p_category_name VARCHAR(100),
    IN p_date DATETIME
)
BEGIN
    DECLARE category_id INT DEFAULT NULL;

    -- Insert post into POST table
    INSERT INTO POST (TITLE, CONTENT, USER_ID, POST_DATE) VALUES (p_title, p_content, p_user_id, p_date);

    -- Check if the category already exists
    SELECT CATEGORY_ID INTO category_id FROM CATEGORY WHERE CATEGORY_NAME = p_category_name;

    -- If category does not exist, create it
    IF category_id IS NULL THEN
        INSERT INTO CATEGORY (CATEGORY_NAME) VALUES (p_category_name);
        SET category_id = LAST_INSERT_ID();
    END IF;

    -- Insert into POST_CATEGORY to link the post and category
    INSERT INTO POST_CATEGORY (POST_ID, CATEGORY_ID) VALUES (LAST_INSERT_ID(), category_id);
END //
DELIMITER ;


-- DELIMITER //
-- CREATE PROCEDURE CreatePostWithCategory(
--     IN p_title VARCHAR(255),
--     IN p_content TEXT,
--     IN p_user_id INT,
--     IN p_category_name VARCHAR(100),
--     IN p_date DATETIME
-- )
-- BEGIN
--     DECLARE category_id INT DEFAULT NULL;

--     -- Insert post into POST table
--     INSERT INTO POST (TITLE, CONTENT, USER_ID, POST_DATE) VALUES (p_title, p_content, p_user_id, p_date);

--     -- Check if the category already exists
--     SELECT CATEGORY_ID INTO category_id FROM CATEGORY WHERE CATEGORY_NAME = p_category_name;

--     -- If category does not exist, create it
--     IF category_id IS NULL THEN
--         INSERT INTO CATEGORY (CATEGORY_NAME) VALUES (p_category_name);
--         SET category_id = LAST_INSERT_ID();
--     END IF;

--     -- Insert into POST_CATEGORY to link the post and category
--     INSERT INTO POST_CATEGORY (POST_ID, CATEGORY_ID) VALUES (LAST_INSERT_ID(), category_id);
-- END //
-- DELIMITER ;

-- drop procedure CreatePostWithCategory;
-- *****************************************************************************************

-- Delete User - deletes associated records in the user, posts, likes, and comments tables
DELIMITER //
CREATE PROCEDURE DeleteUser(IN p_user_id INT)
BEGIN
    -- Deletes user's posts, comments, likes automatically via cascade
    DELETE FROM USER WHERE USER_ID = p_user_id;
END //
DELIMITER ;

-- *****************************************************************************************

-- DeletePost - deletes all associates likes and comments from those tables
DELIMITER //
CREATE PROCEDURE DeletePost(IN p_post_id INT)
BEGIN
    -- Deletes comments, likes, and categories linked to post via cascade
    DELETE FROM POST WHERE POST_ID = p_post_id;
END //
DELIMITER ;



DELIMITER //
CREATE PROCEDURE CountLikesOnPost(
    IN p_post_id INT,
    OUT like_count INT
)
BEGIN
    SELECT COUNT(*) INTO like_count
    FROM POST_LIKES
    WHERE POST_ID = p_post_id;
END //
DELIMITER ;

-- *****************************************************************************************

-- LikePost - users can put likes on posts by post id
DELIMITER //
CREATE PROCEDURE LikePost(IN p_post_id INT, IN p_user_id INT)
BEGIN
    DECLARE likeExists INT DEFAULT 0;

    -- Check if the user has already liked the post
    SELECT COUNT(*) INTO likeExists FROM POST_LIKES WHERE POST_ID = p_post_id AND USER_ID = p_user_id;

    -- If not, add like and increment like count on the post
    IF likeExists = 0 THEN
        INSERT INTO POST_LIKES (POST_ID, USER_ID, TIME_OF_LIKE) VALUES (p_post_id, p_user_id, NOW());
        UPDATE POST SET NO_OF_LIKES = NO_OF_LIKES + 1 WHERE POST_ID = p_post_id;
    END IF;
END //
DELIMITER ;

-- *****************************************************************************************

-- CommentOnPost
DELIMITER //
CREATE PROCEDURE CommentOnPost(IN p_post_id INT, IN p_comment_content TEXT, IN p_user_id INT)
BEGIN
    INSERT INTO COMMENT (COMMENT_CONTENT, USER_ID, POST_ID) VALUES (p_comment_content, p_user_id, p_post_id);
END //
DELIMITER ;
-- drop procedure CommentOnPost;
-- *****************************************************************************************

-- EditPost
DELIMITER //
CREATE PROCEDURE EditPost(IN p_post_id INT, IN p_new_title VARCHAR(255), IN p_new_content TEXT)
BEGIN
    UPDATE POST SET TITLE = p_new_title, CONTENT = p_new_content WHERE POST_ID = p_post_id;
END //
DELIMITER ;

-- *****************************************************************************************

--  GetPostsByUser
DELIMITER //
CREATE PROCEDURE GetPostsByUser(IN p_user_id INT)
BEGIN
    SELECT POST_ID, TITLE, CONTENT, POST_DATE, NO_OF_LIKES
    FROM POST
    WHERE USER_ID = p_user_id
    ORDER BY POST_DATE DESC;
END //
DELIMITER ;

-- *****************************************************************************************

--  GetPostsByCategory
DELIMITER //
CREATE PROCEDURE GetPostsByCategory(IN p_category_name VARCHAR(100))
BEGIN
    SELECT P.POST_ID, P.TITLE, P.CONTENT, P.POST_DATE, P.NO_OF_LIKES
    FROM POST P
    JOIN POST_CATEGORY PC ON P.POST_ID = PC.POST_ID
    JOIN CATEGORY C ON PC.CATEGORY_ID = C.CATEGORY_ID
    WHERE C.CATEGORY_NAME = p_category_name
    ORDER BY P.POST_DATE DESC;
END //
DELIMITER ;



-- *****************************************************************************************

--  SearchPostsByKeyword
DELIMITER //
CREATE PROCEDURE SearchPostsByKeyword(IN p_keyword VARCHAR(255))
BEGIN
    SELECT POST_ID, TITLE, CONTENT, POST_DATE, NO_OF_LIKES
    FROM POST
    WHERE TITLE LIKE CONCAT('%', p_keyword, '%') OR CONTENT LIKE CONCAT('%', p_keyword, '%')
    ORDER BY POST_DATE DESC;
END //
DELIMITER ;

-- *****************************************************************************************

