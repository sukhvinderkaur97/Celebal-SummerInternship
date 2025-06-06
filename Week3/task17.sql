-- Task 17: Create user and grant DB owner

USE celebal_tasks;

-- query
CREATE USER new_user WITH PASSWORD = 'password123';
CREATE LOGIN new_user WITH PASSWORD = 'password123';
ALTER ROLE db_owner ADD MEMBER new_user;