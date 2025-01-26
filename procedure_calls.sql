USE blog_site;

-- *****************************************************************************************

-- Getting the number of likes on each post

SET @like_count = 0;	-- output variable
CALL CountLikesOnPost(1, @like_count);
SELECT @like_count AS LikeCount;	-- result

CALL CountLikesOnPost(2, @like_count);
SELECT @like_count AS LikeCount;

CALL CountLikesOnPost(3, @like_count);
SELECT @like_count AS LikeCount;

-- *****************************************************************************************

-- Searching for posts by keyword

CALL SearchPostsByKeyword('Maggi');
CALL SearchPostsByKeyword('Football');
CALL SearchPostsByKeyword('language');

-- *****************************************************************************************

-- Getting posts of by category

CALL GetPostsByCategory('Sports');
CALL GetPostsByCategory('Programming');	
CALL GetPostsByCategory('Health & Wellness');
CALL GetPostsByCategory('Academics');

-- *****************************************************************************************

-- Getting posts by user

CALL GetPostsByUser(1);
CALL GetPostsByUser(2);
CALL GetPostsByUser(3);

-- *****************************************************************************************

-- Editing posts

CALL EditPost(
	2, 
	'Updated Intro to Python', 
    'Here is an updated overview of Python programming, including its uses in various fields like web development, data science, and machine learning.');

CALL EditPost(
	3, 
	'Updated Intro to C++', 
	'Here is an introduction to C++, covering its importance in system programming and application development.');

CALL EditPost(
	4, 
    'Updated How to make Maggi', 
    'New recipe update: How to make Maggi with additional spices for extra flavor.');

-- *****************************************************************************************

-- Deleting posts

CALL DeletePost(1);
CALL DeletePost(2);
CALL DeletePost(3);

 -- *****************************************************************************************
 
 -- Deleting users
 
 CALL DeleteUser(8);
 CALL DeleteUser(9);
 CALL DeleteUser(10);
 