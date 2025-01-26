USE blog_site;

-- *****************************************************************************************

-- USER table
CREATE TABLE USER (
    USER_ID INT PRIMARY KEY AUTO_INCREMENT,
    PHONE_NO VARCHAR(15),
    SRN VARCHAR(20),
    NAME VARCHAR(100),
    PASSWORD VARCHAR(100),
    EMAIL VARCHAR(100)
);

-- *****************************************************************************************

-- POST table
CREATE TABLE POST (
    POST_ID INT PRIMARY KEY AUTO_INCREMENT,
    TITLE VARCHAR(255),
    CONTENT TEXT,
    USER_ID INT,
    POST_DATE DATETIME,
    NO_OF_LIKES INT DEFAULT 0,
    FOREIGN KEY (USER_ID) REFERENCES USER(USER_ID) ON DELETE CASCADE
);

-- *****************************************************************************************

-- COMMENT table
CREATE TABLE COMMENT (
    COMMENT_ID INT PRIMARY KEY AUTO_INCREMENT,
    COMMENT_CONTENT TEXT,
    USER_ID INT,
    POST_ID INT,
    FOREIGN KEY (USER_ID) REFERENCES USER(USER_ID) ON DELETE CASCADE,
    FOREIGN KEY (POST_ID) REFERENCES POST(POST_ID) ON DELETE CASCADE
);

-- *****************************************************************************************

-- CATEGORY table
CREATE TABLE CATEGORY (
    CATEGORY_ID INT PRIMARY KEY AUTO_INCREMENT,
    CATEGORY_NAME VARCHAR(100) UNIQUE
);
-- This table only stores the categories and their ids

-- *****************************************************************************************

-- POST_CATEGORY junction table
CREATE TABLE POST_CATEGORY (
    POST_ID INT,
    CATEGORY_ID INT,
    PRIMARY KEY (POST_ID, CATEGORY_ID),
    FOREIGN KEY (POST_ID) REFERENCES POST(POST_ID) ON DELETE CASCADE,
    FOREIGN KEY (CATEGORY_ID) REFERENCES CATEGORY(CATEGORY_ID) ON DELETE CASCADE
);
-- This table is meant to associate the posts in the database with categories based on category id

-- *****************************************************************************************

-- POST_LIKES table
CREATE TABLE POST_LIKES (
    POST_ID INT,
    USER_ID INT,
    TIME_OF_LIKE DATETIME,
    PRIMARY KEY (POST_ID, USER_ID),
    FOREIGN KEY (POST_ID) REFERENCES POST(POST_ID) ON DELETE CASCADE,
    FOREIGN KEY (USER_ID) REFERENCES USER(USER_ID) ON DELETE CASCADE
);

-- *****************************************************************************************

SHOW tables;