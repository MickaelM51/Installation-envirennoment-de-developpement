#!/bin/bash


echo "
    -----------------------------------------------------------------
    | Bienvevue dans l'instalateur d'environnement de developpement |
    -----------------------------------------------------------------
    "
# Debut installation d'apache !
echo -n "Voulez vous installer Apache2 ? y/n : "
read ouinonApache

if [ $ouinonApache = "y" ] || [ $ouinonApache = "Y" ]; then
        sudo apt-get install apache2
        echo "Modification du fichier pour la redirection d'url"
        sudo a2enmod rewrite
# debut modification fichier de redirection !
        echo "
            ----------------------------------------
            |  <Directory /var/www/>               |
            |      Options Indexes FollowSymLinks  |
            |      AllowOverride All               |
            |      Require all granted             |
            |  </Directory>                        |
            |--------------------------------------- 
             "
        echo -n "Etes vous pret a modifier le fichier de redirection avec le texte ci dessus y/n : "
        read modifconfApache
        if [ $modifconfApache = "y" ] || [ $modifconfApache = "Y" ]; then
            sudo nano /etc/apache2/apache2.conf
            
        elif [ $modifconfApache = "n" ] || [ $modifconfApache = "N" ]; then
        echo "Ok, bye! "
        else
        echo "Il faut taper Y ou N!! Pas $modifconfApache "
        fi
# fin modification fichier de redirection !

elif [ $ouinonApache = "n" ] || [ $ouinonApache = "N" ]; then
    echo "Ok, bye! "
else
    echo "Il faut taper Y ou N!! Pas $ouinonApache "
fi
# fin d'installation d'apache !

#debut installation Mysql !
echo -n "Voulez vous installer Mysql ? y/n : "
read ouinonMysql
if [ $ouinonMysql = "y" ] || [ $ouinonMysql = "Y" ]; then
    sudo apt-get install mysql-server
    echo "
        -------------------------------------------------------------------------------------------------
        | MySql Installer                                                                               |
        | Si necessaire pour l'acces root                                                               |
        | https://stackoverflow.com/questions/41645309/mysql-error-access-denied-for-user-rootlocalhost |    
        -------------------------------------------------------------------------------------------------
        "

elif [ $ouinonMysql = "n" ] || [ $ouinonMysql = "N" ]; then
    echo "Ok, bye! "
else
    echo "Il faut taper Y ou N!! Pas $ouinonMysql "
fi
#fin d'installation Mysql !

#Debut installation phppdo
echo -n "Voulez vous installer PHP/PDO et module complementaire y/n :"
read ouinonPDO
if [ $ouinonPDO = "y" ] || [ $ouinonPDO = "Y" ]; then
    sudo apt-get install php-mysql
    sudo apt-get install php-gd
    sudo apt-get install php-xml
    sudo apt-get install zip unzip
    echo "
            ------------------------
            | PHP/PDO installer |
            ------------------------
         "
elif [ $ouinonPDO = "n" ] || [ $ouinonPDO = "N" ]; then
    echo "Ok, bye! "
else
    echo "Il faut taper Y ou N!! Pas $ouinonPDO "
fi

#Fin installation phppdo

#Debut installation phpMyAdmin
echo -n "Voulez vous installer PHPMyAdmin ? y/n :"
read ouinonMyadmin
if [ $ouinonMyadmin = "y" ] || [ $ouinonMyadmin = "Y" ]; then
    sudo apt-get install phpmyadmin
        echo "
            ------------------------
            | PhpMyAdmin installer |
            ------------------------
         "
         echo -n "Voulez vous crée le lien avec votre serveur apache y/n :"
         read ouinonlink
         if [ $ouinonlink = "y" ] || [ $ouinonlink = "Y" ]; then
            sudo ln -s /usr/share/phpmyadmin /var/www/html
            echo "
                    ---------------
                    | Lien crée ! |
                    ---------------           
                "
        elif [ $ouinonlink = "n" ] || [ $ouinonlink = "N" ]; then
            echo "Ok, bye! "
        else
            echo "Il faut taper Y ou N!! Pas $ouinonlink "
        fi
elif [ $ouinonMyadmin = "n" ] || [ $ouinonMyadmin = "N" ]; then
    echo "Ok, bye! "
else
    echo "Il faut taper Y ou N!! Pas $ouinonMyadmin "
fi

#Fin installation phpMyAdmin

# Debut installation de composer 

echo -n " Voulez vous installer Composer ? y/n :"
read ouinoncomposer
if [ $ouinoncomposer = "y" ] || [ $ouinoncomposer = "Y" ]; then
    php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
    php -r "if (hash_file('sha384', 'composer-setup.php') === '48e3236262b34d30969dca3c37281b3b4bbe3221bda826ac6a9a62d6444cdb0dcd0615698a5cbe587c3f0fe57a54d8f5') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"
    php composer-setup.php
    php -r "unlink('composer-setup.php');"
    sudo mv composer.phar /usr/local/bin/composer
    echo "
            ------------------------
            | Composer installer |
            ------------------------
         "
    
elif [ $ouinoncomposer = "n" ] || [ $ouinoncomposer = "N" ]; then
    echo "Ok, bye! "
else
    echo "Il faut taper Y ou N!! Pas $ouinoncomposer "
fi
# Fin installastion de composer !

# droit pour symfony
echo -n "Voulez vous gerer les droits pour symfony ? y/n "
read ouinonSymfo
if [ $ouinonSymfo = "y" ] || [ $ouinonSymfo = "Y" ]; then
    sudo apt-get install acl
    echo "
            ---------------
            | Droits OK ! |
            ---------------           
        "
elif [ $ouinonSymfo = "n" ] || [ $ouinonSymfo = "N" ]; then
    echo "Ok, bye! "
else
    echo "Il faut taper Y ou N!! Pas $ouinonSymfo "
fi

#GIT
 echo -n "voulez vous installer git sur votre machine et creer une clef ssh ? y/n :"
 read ouinonGit
 if [ $ouinonGit = "y" ] || [ $ouinonGit = "Y" ]; then
    sudo apt-get install git
    echo "
        -----------------
        | GIT Installer |
        -----------------           
                "
    echo -n "Vouler vous renseigner les informations de votre compte y/n ?"
    read ouinonInfo
        if [ $ouinonInfo = "y" ] || [ $ouinonInfo = "Y" ]; then
            echo -n "Entrez votre pseudo github :"
            read pseudonyme
            git config --global user.name $pseudonyme
            echo -n "Entrez votre adresse email :"
            read email
            git config --global user.email $email
            echo "
                ---------------------
                | Compte git a jour |
                ---------------------           
                "
            echo -n "Voulez vous créer une clef ssh pour cette machine ? y/n : "
            read ouinonSSH
                if [ $ouinonSSH = "y" ] || [ $ouinonSSH = "Y" ]; then
                    echo "
                        -------------------------------------------------------
                        | Le shell vas vous demandés plusieurs fois           |
                        | pour une passephrase celle ci n'est pas obligatoire |
                        -------------------------------------------------------           
                        "
                    ssh-keygen -t rsa -C $email
                    echo "
                        ----------------------------------------------
                        | Copier la clef ssh sur votre compte GITHUB |
                        | Settings/SSH ang GPG keys => new           |
                        ----------------------------------------------           
                        "
                    cat .ssh/id_rsa.pub
                elif [ $ouinonSSH = "n" ] || [ $ouinonSSH = "N" ]; then
                    echo "Ok, bye! "
                else
                    echo "Il faut taper Y ou N!! Pas $ouinonSSH "
                fi


        elif [ $ouinonInfo = "n" ] || [ $ouinonInfo = "N" ]; then
            echo "Ok, bye! "
        else
            echo "Il faut taper Y ou N!! Pas $ouinon "
        fi

elif [ $ouinonGit = "n" ] || [ $ouinonGit = "N" ]; then
    echo "Ok, bye! "
else
    echo "Il faut taper Y ou N!! Pas $ouinonGit "
fi

# mise a jour du systeme apres les install !

echo -n "Voulez vous mettre a jour votre machine aprés toutes ces installations ? y/n : "*
read ouinonUpdate
if [ $ouinonUpdate = "y" ] || [ $ouinonUpdate = "Y" ]; then
    echo "
        ----------------------------
        | Recherche de mise a jour |
        ----------------------------           
        "
    sudo apt-get update
    echo "
        -------------------------------
        | Installation de mise a jour |
        -------------------------------          
        "
        sudo apt-get upgrade

elif [ $ouinonUpdate = "n" ] || [ $ouinonUpdate = "N" ]; then
    echo "Ok, bye! "
else
    echo "Il faut taper Y ou N!! Pas $ouinonUpdate "
fi
echo "
    --------------------------------------------
    | Votre environnemnt DEV est pret ENJOY xD |
    --------------------------------------------    
    "
