#!/bin/bash
echo "Creating MySQL user and database"
echo -n "Enter Mysql Host Name[localhost,Ip] :"
read -r hostname
echo -n "Enter the Mysqldb Port :"
read -r mysqlport
echo -n "Enter master user name :"
read -r masterusername
MYSQL="mysql -h$hostname -u$masterusername -p --port $mysqlport"
$MYSQL -e "show databases;"
echo -n "dbname: "
read -r dbname
echo -n "username: "
read -r username
echo -n "allowedhosts: "
read -r allowedhosts
echo -n "Privileges Required :[select,insert,update,alter,all] "
read -r privileges
userpass="$(openssl rand -base64 10)"
echo "Creating new user..."
$MYSQL -e "CREATE USER '${username}'@'${allowedhosts}' IDENTIFIED BY '$userpass';"
#echo "User successfully created!"

echo "Granting  ${privileges} on ${dbname} to ${username}!"
$MYSQL -e "GRANT ${privileges} ON ${dbname}.* TO '${username}'@'${allowedhosts}';"
$MYSQL -e "FLUSH PRIVILEGES;"
echo "user creation done"
echo "Username : $username"
echo "Password : $userpass"
exit
