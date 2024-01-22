#!/bin/bash
HOSTNAME=localhost
USERNAME=root
PASSWORD=password
DBNAME=sae
PATH=/tmp
ARCHIVE=sae.zip
SQL=sae.sql
TABLES="ligne calendrier itineraire arret lieu trace"

echo "Installation base de donnees $DBNAME"
if [ -f $PATH/$ARCHIVE ]
then
    echo "Extraction tables"
    /usr/bin/unzip -u $PATH/$ARCHIVE -d "${PATH}" > /dev/null 2>&1
else
    echo "Fichier ${ARCHIVE} manquant !"
fi

if [ -f $PATH/$SQL ]
then
    echo "Creation tables"
    /usr/bin/mysql -u$USERNAME -p$PASSWORD -h$HOSTNAME < $PATH/$SQL
    /bin/rm -f $PATH/$SQL
else
    echo "Fichier ${SQL} manquant !"    
fi

for table in $TABLES
do
    if [ -f $PATH/$table.txt ]
    then
        echo "Insertion table $table"
        /bin/chown mysql $PATH/$table.txt
        /usr/bin/mysql -u$USERNAME -p$PASSWORD -h$HOSTNAME $DBNAME -e"LOAD DATA INFILE '$PATH/$table.txt' REPLACE INTO TABLE $table FIELDS TERMINATED BY ',' ENCLOSED BY '\"' LINES TERMINATED BY '\n';"
        /bin/rm -f $PATH/$table.txt
    else
        echo "Fichier $table.txt manquant !"  
    fi
done
