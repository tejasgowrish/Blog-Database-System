use blog_site;

-- *****************************************************************************************

-- user table
create table user (
    user_id int primary key auto_increment,
    phone_no varchar(15),
    srn varchar(20),
    name varchar(100),
    password varchar(100),
    email varchar(100)
);

-- *****************************************************************************************

-- post table
create table post (
    post_id int primary key auto_increment,
    title varchar(255),
    content text,
    user_id int,
    post_date datetime,
    no_of_likes int default 0,
    post_time datetime,
    foreign key (user_id) references user(user_id) on delete cascade
);

-- *****************************************************************************************

-- comment table
create table comment (
    comment_id int primary key auto_increment,
    comment_content text,
    user_id int,
    post_id int,
    comment_time datetime,
    foreign key (user_id) references user(user_id) on delete cascade,
    foreign key (post_id) references post(post_id) on delete cascade
);

-- *****************************************************************************************

-- category table
create table category (
    category_id int primary key auto_increment,
    category_name varchar(100) unique
);
-- this table only stores the categories and their ids

-- *****************************************************************************************

-- post_category junction table
create table post_category (
    post_id int,
    category_id int,
    primary key (post_id, category_id),
    foreign key (post_id) references post(post_id) on delete cascade,
    foreign key (category_id) references category(category_id) on delete cascade
);
-- this table is meant to associate the posts in the database with categories based on category id

-- *****************************************************************************************

-- post_likes table
create table post_likes (
    post_id int,
    user_id int,
    time_of_like datetime,
    primary key (post_id, user_id),
    foreign key (post_id) references post(post_id) on delete cascade,
    foreign key (user_id) references user(user_id) on delete cascade
);

-- *****************************************************************************************

show tables;
