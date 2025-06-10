USE blog_site;

-- *****************************************************************************************

-- Getting the number of likes on each post

set @like_count = 0;	-- output variable
call CountLikesOnPost(1, @like_count);
select @like_count AS LikeCount;	-- result

call CountLikesOnPost(2, @like_count);
select @like_count AS LikeCount;

call CountLikesOnPost(3, @like_count);
select @like_count AS LikeCount;

-- *****************************************************************************************

-- Searching for posts by keyword

call SearchPostsByKeyword('Maggi');
call SearchPostsByKeyword('Football');
call SearchPostsByKeyword('language');

-- *****************************************************************************************

-- Getting posts of by category

call GetPostsByCategory('Sports');
call GetPostsByCategory('Programming');	
call GetPostsByCategory('Health & Wellness');
call GetPostsByCategory('Academics');

-- *****************************************************************************************

-- Getting posts by user

call GetPostsByUser(1);
call GetPostsByUser(2);
call GetPostsByUser(3);

-- *****************************************************************************************

-- Editing posts

call EditPost(
	2, 
	'Updated Intro to Python', 
    'Here is an updated overview of Python programming, including its uses in various fields like web development, data science, and machine learning.');

call EditPost(
	3, 
	'Updated Intro to C++', 
	'Here is an introduction to C++, covering its importance in system programming and application development.');

call EditPost(
	4, 
    'Updated How to make Maggi', 
    'New recipe update: How to make Maggi with additional spices for extra flavor.');

-- *****************************************************************************************

-- Deleting posts

call DeletePost(1);
call DeletePost(2);
call DeletePost(3);

 -- *****************************************************************************************
 
 -- Deleting users
 
 call DeleteUser(8);
 call DeleteUser(9);
 call DeleteUser(10);
 
