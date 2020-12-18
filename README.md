# Linux-login-shell
The project simulates user login in linux. main.sh displays a menu with the following options:

1-Add new group

adds a new group to groups file (this is a self-created file, similar to /etc/group. It has the following format>> groupname:user1:user2...

2- Delete existing group (only if it doesn't have any users)

3- Test login
- Prompts user for user name and password.
- Compares user input to the contents of users file(which simulates /etc/passwd), with the follwoing format>> username:userpassword:userid:group
