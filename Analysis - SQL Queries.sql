/* A) MARKETING */
# Task 1 - Find the 5 oldest users of the Instagram from the database provided.

WITH base AS (
	SELECT username, created_at
    FROM ig_clone.users
    ORDER BY created_at
    LIMIT 5comments
    )
    SELECT *
    FROM base;
    
    
# Task 2 - Find the users who have never posted a single photo on Instagram.

SELECT u.username
FROM ig_clone.users u
LEFT JOIN ig_clone.photos p
ON u.id = p.user_id
WHERE p.user_id IS null
ORDER BY u.username;


#Task 3 - Identify the winner of the contest and provide their details to the team.

WITH base AS (
	SELECT likes.photo_id, users.username,
	COUNT(likes.user_id) AS like_user
	FROM ig_clone.likes likes
	INNER JOIN ig_clone.photos photos
	On likes.photo_id = photos.id
	INNER JOIN ig_clone.users users
	ON photos.user_id = users.id
	GROUP BY likes.photo_id, users.username
	ORDER BY like_user DESC
	LIMIT 1
	)
SELECT username FROM base;


# Task 4 - Identify and suggest the top 5 most commonly used hashtags on the platform.

SELECT t.tag_name,
	COUNT(p.photo_id) AS num_tags
FROM ig_clone.photo_tags p
	INNER JOIN ig_clone.tags t
	ON p.tag_id = t.id
GROUP BY tag_name
ORDER BY num_tags DESC
LIMIT 5;


# Task 5 - What day of the week do most users register on? Provide insights on when to schedule an ad campaign.

/* 0- Monday; 1- Tuesday; 2- Wednesday; 3- Thursday; 4- Friday; 5- Saturday; 6- Sunday; */

SELECT weekday(created_at) AS weekday,
COUNT(username) AS num_users
FROM ig_clone.users
GROUP BY 1
ORDER BY 1;


/* B) Investor Metrics */
# Task 1- Provide how many times does average user posts on Instagram. Also, provide the total number of photos on Instagram/total number of users.

WITH CTE AS (
SELECT u.id AS user_id,
COUNT (p.id) AS photo_id
FROM ig_clone.users AS u
LEFT JOIN ig_clone.photos p
ON u.id = p.user_id
GROUP BY u.id
	)
SELECT SUM (photo_id) AS total photos,
COUNT (user_id) AS total_users,
SUM (photo_id)/COUNT(user_id) AS total_posts_by_user
FROM CTE;


# Task 2- Provide data on users (bots) who have liked every single photo on the site (since any normal user would not be able to do this).

WITH photo_count AS (SELECT user_id,
					COUNT(photo_id) AS num_like
FROM ig_clone.likes
					GROUP BY user_id 
					ORDER BY num_like DESC )
SELECT *
FROM photo_count
WHERE num like =
	COUNT(photo_id) AS num_like
	(SELECT count(*) FROM ig_clone.photos)

