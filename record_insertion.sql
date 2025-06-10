USE blog_site;

-- *****************************************************************************************

-- Add records to the users table
insert into user (USER_ID, PHONE_NO, SRN, NAME, PASSWORD, EMAIL)
values 
(1, '7456789012', 'PES1UG22CS643', 'TANMAY G', 'tanmay$123', 'tanmayg@gmail.com'),
(2, '3456789012', 'PES1UG22CS650', 'TEJAS GOWRISH', 'tejas$123', 'tejasg@gmail.com'),
(3, '8467890123', 'PES1UG21CS120', 'RANBIR KAPOOR', 'ranbir$123', 'ranbirkapoor@gmail.com'),
(4, '9478901234', 'PES1UG21CS639', 'UPENDRA KUMAR', 'upendra$123', 'upendra@gmail.com'),
(5, '8489012345', 'PES1UG23CS527', 'CHARLIE BROWN', 'charlie$123', 'charliebrown@gmail.com'),
(6, '9490123456', 'PES1UG22CS128', 'DAVID MILLER', 'david$123', 'davidmiller@gmail.com'),
(7, '7412345678', 'PES1UG22CS129', 'EMILY JOHNSON', 'emily$123', 'emilyjohnson@gmail.com'),
(8, '8423456789', 'PES1UG23CS130', 'RAJNI KANTH', 'rajni$123', 'rajnikanth@gmail.com'),
(9, '8434567890', 'PES1UG19CS643', 'PUNEETH RAJKUMAR', 'puneeth$123', 'puneeth@gmail.com'),
(10, '93445678901', 'PES1UG23CS650', 'JOHN CENA', 'john$123', 'john@gmail.com');

select * from user;

-- *****************************************************************************************

-- Populating the database by calling the appropriate procedures

-- Adding posts by calling the CreatePostWithCategory procedure
select * from post;
call CreatePostWithCategory(
	'Football Legends',
    'Football is the most popular sport in the world. 
     The best football players of all time include Christiano Ronaldp, Lionel Messi and Neymar.',
    1,
    'Sports',
    now()
);

call CreatePostWithCategory(
    'Intro to Python',
    'Python is a high-level, general-purpose programming language used for many applications, including: 
Web development, Software development, Data science, Machine learning, Mathematics, System scripting, and Rapid application development',
    1,                
    'Programming',
    now()
);

call CreatePostWithCategory(
    'Intro to C++',
    'C++ is a general-purpose programming language used to build software. 
	 It is an object-oriented language that focuses on objects, which are data fields with unique attributes. 
	 C++ is one of the most popular programming languages and is used in many industries',
    2,                
    'Programming',
    now()
);

call CreatePostWithCategory(
	'How to make Maggi',
    '1. Boil 250ml of water
	 2. Add maggi noodle cake
     3. Add taste maker
     4. Cook for 2 minutes
     5. Serve hot',
     2,
     'Cooking',
     now()
);

call CreatePostWithCategory(
	'How to improve academic scores',
    'Here are some steps to improve your academic scores.
     1. Study 4 hours a day
     2. Get 8 hours of sleep
     3. Eat healthy food
     4. Reduce screen time',
     3,
     'Academics',
     now()
);

call CreatePostWithCategory(
    'Best Coding Practices',
    'In this post, we explore 10 best practices for coding that improve code quality, readability, and maintainability. \
     This includes using meaningful variable names, keeping functions small, and adding comments where necessary.',
    3,                
    'Technology',  
    now()
);

call CreatePostWithCategory(
    'Meditation for Beginners',
    'Meditation helps relax and reduce stress. Steps for beginners: 
     1. Find a quiet place
     2. Clear your mind
     3. Relax your body',
    4,
    'Health & Wellness', 
    now()
);

call CreatePostWithCategory(
    'Intro to C',
    'C is a general-purpose programming language used to build software. 
	 It is not object-oriented language.
	 C is one of the most popular programming languages and is used in many industries',
    4,                
    'Programming',
    now()
);
select * from post;

call CreatePostWithCategory(
    'Data Privacy',
    'With growing concerns over online privacy, it is crucial to understand how to protect your personal data. 
     This post discusses essential steps like using strong passwords and enabling two-factor authentication.',
    5,
    'Technology',
    now()
);

call CreatePostWithCategory(
    'Exploring Italian Cuisine',
    'Italian cuisine is beloved worldwide for its delicious dishes. 
     Pizza, pasta, lasagna and risotto are some of the most popular dishes in this cuisine.',
    5,
    'Cooking',
    now()
);

call CreatePostWithCategory(
    'Benefits of Physical Exercise',
    'Physical exercise offers numerous health benefits.
     These benefits include improved mental health, cardiovascular health, and strength. 
     This post explores these benefits and shares tips for incorporating exercise into your daily routine.',
    6,
    'Health & Wellness',
    now()
);

call CreatePostWithCategory(
    'Investing in Stocks',
    'Investing in stocks can be a great way to build wealth over time. 
     This post explores how you can venture beyond simple investments such as Fixed deposits by diving into the world of stocks.',
    6,
    'Finance',
    now()
);

call CreatePostWithCategory(
    'The Rise of AI',
    'Artificial Intelligence (AI) is transforming industries across the globe. 
     This post discusses recent advancements in AI and its impact on jobs, healthcare, and automation.',
    7,
    'Technology',
    now()
);

call CreatePostWithCategory(
    'Mastering the Basics of French Language',
    'Learning French can be exciting and beneficial for travel or career advancement. 
     This post shares tips for mastering the basics, including common phrases, pronunciation tips, and resources.',
    7,
    'Language Learning',
    now()
);

call CreatePostWithCategory(
    'Budget-Friendly Travel Destinations',
    'Discover some of the world’s most beautiful yet budget-friendly travel destinations. 
     This post includes tips on finding affordable accommodations and activities in these destinations.',
    7,
    'Travel',
    now()
);

call CreatePostWithCategory(
    'History of the Internet',
    'The internet has evolved rapidly since its inception. 
     This post provides an overview of the internet’s history, major milestones, and how it has changed our lives.',
    8,
    'Technology',
    now()
);

call CreatePostWithCategory(
    'The Benefits of Learning Multiple Languages',
    'Learning multiple languages has numerous cognitive and social benefits. 
     In this post, we discuss how multilingualism can improve memory, problem-solving skills, and cultural awareness.',
    8,
    'Education',
    now()
);

call CreatePostWithCategory(
    'Best Practices for Remote Work',
    'With remote work becoming the new norm, it’s essential to stay productive and balanced. 
     Here are some of the best practices for setting up a home office, managing time effectively, and maintaining work-life balance.',
    9,
    'Career',
    now()
);

call CreatePostWithCategory(
    'Top 5 Adventure Sports to Try',
    'Adventure sports are a great way to push your limits and experience thrills. 
     Here are some popular adventure sports such as bungee jumping, skydiving, and white-water rafting, along with safety tips.',
    9,
    'Sports',
    now()
);

call CreatePostWithCategory(
    'Introduction to Blockchain Technology',
    'Blockchain is a foundational technology behind cryptocurrencies and decentralized finance. 
     Let us explore the blockchain fundamentals, its benefits, and its potential applications across industries.',
    10,
    'Technology',
    now()
);

call CreatePostWithCategory(
    'Essential Tips for First-Time Home Buyers',
    'Buying a home is a major financial decision, especially for first-time buyers. 
     This guide covers essential tips, including budgeting, finding the right mortgage, and understanding the housing market.',
    10,
    'Finance',
    now()
);

-- *****************************************************************************************

-- Adding comments to the posts

call CommentOnPost(
    1,
    'Great Post. Very well-written.',
    10
);

call CommentOnPost(
    2,
    'Amazing! Thanks for the information.',
    9
);

call CommentOnPost(
    3,
    'C++ is challenging, but it’s great for systems programming.',
    8
);

call CommentOnPost(
    4,
    'Just tried making Maggi this way, and it turned out perfect!',
    7
);

call CommentOnPost(
    5,
    'Thanks for these tips! My grades have improved a lot!',
    6
);

call CommentOnPost(
    6,
    'Coding best practices make such a big difference in team projects.',
    5
);

call CommentOnPost(
    7,
    'Wow! This has really helped me. Great content.',
    4
);

call CommentOnPost(
    8,
    'Keep up the good work.',
    3
);

call CommentOnPost(
    9,
    'Italian cuisine is amazing! I could eat pasta every day.',
    2
);

call CommentOnPost(
    10,
    'Regular exercise has helped me feel so much healthier!',
    2
);

call CommentOnPost(
    11,
    'I’m just starting with stocks. This post was really helpful!',
    1
);

call CommentOnPost(
    12,
    'AI is so fascinating! It’s incredible how fast it’s advancing.',
    1
);

call CommentOnPost(
    13,
    'Learning French has been a fun challenge. Thanks for the tips!',
    2
);

call CommentOnPost(
    14,
    'I’d love to visit some of these budget-friendly travel spots!',
    3
);

call CommentOnPost(
    15,
    'I never realized how far the internet has come. Very insightful!',
    4
);

call CommentOnPost(
    16,
    'Being bilingual has really benefited me in my career. Great post!',
    5
);

call CommentOnPost(
    17,
    'Remote work has changed the way I think about productivity.',
    5
);

call CommentOnPost(
    18,
    'Adventure sports sound thrilling but also a little scary!',
    6
);

call CommentOnPost(
    19,
    'Blockchain technology is the future. So much potential!',
    7
);

call CommentOnPost(
    20,
    'These tips are very useful for someone who’s buying their first home.',
    8
);


-- *****************************************************************************************

-- Adding likes to the posts

call LikePost(1, 10);
call LikePost(2, 10);
call LikePost(3, 9);
call LikePost(4, 9);
call LikePost(5, 8);
call LikePost(6, 8);
call LikePost(7, 7);
call LikePost(8, 7);
call LikePost(9, 6);
call LikePost(10, 6);
call LikePost(11, 5);
call LikePost(12, 5);
call LikePost(13, 4);
call LikePost(14, 4);
call LikePost(15, 3);
call LikePost(16, 3);
call LikePost(17, 2);
call LikePost(18, 2);
call LikePost(19, 1);
call LikePost(20, 1);
call LikePost(19, 2);
call LikePost(24, 2);
select * from post_likes;
select * from post;
-- *****************************************************************************************

