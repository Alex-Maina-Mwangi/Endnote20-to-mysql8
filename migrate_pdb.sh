#!/bash/bin


#remove pdbmigrate.sql file if it already exists
if [ -f "pdbmigrate.sql" ] ; then
    rm "pdbmigrate.sql"
fi
#The line below works in unix/linux distros
#sqlite3 /home/alex/Downloads/sdb/pdb.eni .dump > pdbtestdump.sql

#The line below works in windows subsystems for linux(WSL).
sqlite3 /mnt/c/Users/Amaina/Downloads/latest08042024/pdb.eni .dump > pdbtestdump.sql


#remove pdbmigrate.sql file if it already exists
if [ -f "pdbtestdump.txt" ] ; then
    rm "pdbtestdump.txt"
fi

#error 1
#remove the first three lines from pdbtestdump.sql
tail -n+3 pdbtestdump.sql >> pdbtestdump.txt
file=pdbtestdump.txt
sed -i -e 's/DEFAULT ""/ /g' $file

#error 2
#change SQLite3 syntax for auto increment to that of MySQL
sed -i -e 's/AUTOINCREMENT/AUTO_INCREMENT/g' $file

#change subkey BLOB to subkey INTEGER
sed -i -e 's/subkey BLOB/subkey INTEGER/g' $file

#Remove line 2 because the table pdbmigrate.sqlite_sequence' doesn't exist
sed -i '2d' $file

cat $file >> pdbmigrate.sql
