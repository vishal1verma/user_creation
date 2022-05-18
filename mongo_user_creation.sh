echo -n "Enter the MongoHost :"
read -r mongohost
echo -n "Enter the Mongo Port :"
read -r mongoport
echo -n "Enter the dbowner name : "
read -r owner
#echo -n "enter Its Passwd : "
#read -r rootpasswd
PASSWD="$(openssl rand -base64 10)"
MONGO="mongo --host=$mongohost -u $owner --port $mongoport --password=${rootpasswd}"
rm -rf file_1.js
echo "show dbs;" > file_1.js
$MONGO < file_1.js
rm -rf file_1.js
echo -n "databasename: "
read -r databasename
echo -n "role [read,readWrite,dbAdmin] : "
read -r role
echo -n "username: "
read -r username
rm -rf file.js
echo "use $databasename;" > file.js
echo "db.createUser({user: '$username', pwd: '$PASSWD', roles: [{role: '$role', db: '$databasename'}]})" >> file.js
MONGO="mongo --host=$mongohost -u $owner --port $mongoport --password=${rootpasswd}"
$MONGO < file.js
rm -rf file.js
echo "Username : "
echo $username
echo "Password : "
echo $PASSWD
rm -rf mongo_file_1.js
echo "use $databasename;" > mongo_file_1.js
echo "db.grantRolesToUser('$username',[{ role: '$role', db: '$databasename' }]);" >> mongo_file_1.js
$MONGO < mongo_file_1.js
echo "Grant Succeded"
