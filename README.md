# README

A simple Project history app, where we can create projects, post comments and change statuses of the Project.

Associations:
- Project can have multiple statuses and comments but can only have one owner(user)
- User can have many projects, statuses and comments

While making it, I've made some assumptions:
* Status can change in ascending order, from pending -> in progress -> completed
* By loging the history of project, we only need to mantain comments(with timestamps) and latest statuses. However, if we need to enhance this than we can as I have made the architecture based on this

Points to improve
* Adding authentication to get the proper user association
* Add functionality to track old and new status
* Add feature to reply to other user's comment
