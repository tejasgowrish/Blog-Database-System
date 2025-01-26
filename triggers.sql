USE blog_site;

-- *****************************************************************************************

-- Trigger: after_category_delete
DELIMITER //
CREATE TRIGGER after_category_delete AFTER DELETE ON CATEGORY
FOR EACH ROW
BEGIN
    DELETE FROM POST_CATEGORY WHERE CATEGORY_ID = OLD.CATEGORY_ID;
END //
DELIMITER ;

-- *****************************************************************************************

-- Trigger: DeleteUserPostsAndRelatedData
DELIMITER //
CREATE TRIGGER DeleteUserPostsAndRelatedData BEFORE DELETE ON USER
FOR EACH ROW
BEGIN
    DELETE FROM POST_LIKES WHERE USER_ID = OLD.USER_ID;
    DELETE FROM COMMENT WHERE USER_ID = OLD.USER_ID;
END //
DELIMITER ;

-- *****************************************************************************************

SHOW triggers;