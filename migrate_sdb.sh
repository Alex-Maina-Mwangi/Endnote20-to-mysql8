#!/bash/bin
sqlite3 /home/alex/Downloads/latest08042024/sdb.eni .dump > testdump.sql

#error 1
sed -i d testdump.txt
tail -n+3 testdump.sql >> testdump.txt
file=testdump.txt


sed -i -e 's/DEFAULT ""/ /g' $file
#error 2
sed -i -e 's/AUTOINCREMENT/AUTO_INCREMENT/g' $file

#error 3 
sed -i -e 's/ENCI_Base/utf8mb4_unicode_ci/g' $file

#error 4
sed -i -e 's/ENCIN_Base/utf8mb4_unicode_ci/g' $file

########################################################################
#mysql8 errors. "groups" is a mysql8 keyword
sed -i -e 's/TABLE groups/TABLE groups1/g' $file

#sed -i -e 's/spec BLOB NOT NULL DEFAULT ""/spec BLOB NOT NULL/g' $file
#sed -i -e 's/members BLOB NOT NULL DEFAULT ""/members BLOB NOT NULL/g' $file

sed -i -e 's/INSERT INTO "groups"/INSERT INTO groups1/g' $file
########################################################################
#error 5
sed -i '/sqlite_sequence/d' $file

#error 6
sed -i -e 's/year TEXT/year char(4)/g' $file 

#error 7
sed -i -e 's/file_path TEXT/file_path char(255)/g' $file

#error 7 - miscelleneous
#sed -i -e 's/INSERT INTO "groups"/INSERT INTO groups1/g' $file

#error 8
sed -i -e 's/term TEXT/term char(255)/g' $file

#error 9
sed -i -e 's/term  TEXT/term  char(255)/g' $file

#error 10
sed -i -e 's/abbr1 TEXT/abbr1 char(255)/g' $file 

#error 11
sed -i -e 's/abbr2 TEXT/abbr2 char(255)/g' $file

#error 12
sed -i -e 's/abbr3 TEXT/abbr3 char(255)/g' $file

#error 13
sed -i -e 's/ro_key_2 TEXT/ro_key_2 varchar(300)/g' $file
sed -i -e 's/ro_key_3 TEXT/ro_key_3 char(255)/g' $file

#error 14
sed -i -e 's/CREATE TRIGGER/delimiter \/\/ CREATE TRIGGER/g' $file

sed -i -e 's/\; END/ END \/\/ delimiter/g' $file

cat $file >> migratesdb.sql
