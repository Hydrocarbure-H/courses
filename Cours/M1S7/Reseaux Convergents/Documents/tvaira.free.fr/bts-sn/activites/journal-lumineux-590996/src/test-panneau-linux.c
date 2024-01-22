/*
 * Test du panneau Mc Crypte-590996 (sous Linux)
 * 
 * Documentation : http://www1.produktinfo.conrad.com/datenblaetter/575000-599999/590996-da-01-en-Communication_protocol_LED_Displ_Board.pdf
 *
 * Tests en fin de fichier
 */

#include <stdio.h> 
#include <errno.h> 
#include <termios.h> 
#include <stdlib.h>
#include <string.h> 
#include <unistd.h>
#include <sys/ioctl.h> 
#include <sys/types.h>
#include <sys/stat.h>
#include <sys/signal.h>
#include <fcntl.h> 

#define DEBUG_PANNEAU

#define PORT            "/dev/ttyUSB0"

#define LG_MAX_TRAME    128
#define LG_MAX          16
#define LG_REPONSE      4 // au maximum 4 caractères pour NACK

// cf. man ascii
#define NUL             0x00 // caractère NUL (c'est aussi le code du fin de chaîne)
#define ACK             0x06 // accusé réception positif
#define NACK            0x15 // accusé réception négatif

#define DELAI           1000000 // en micro secondes

// Lire: http://ftp.lip6.fr/pub/linux/french/echo-linux/html/ports-series/ports_series.html
int ouvrirPort(char *nomPort)
{
    int fd = -1;
    struct termios  termios_p;

    #ifdef DEBUG_PANNEAU
    fprintf(stderr, "Ouverture du port %s\n", nomPort);
    #endif

    // cf. man 2 open
	if (( fd=open(nomPort, O_RDWR|O_NONBLOCK )) == -1 )
	{
			perror("open");
			return fd;
	}

    // cf. man tcgetattr
    tcgetattr(fd, &termios_p);

    // configuration du port série : 9600 bits/s, 8 bits, pas de parité
    // remarque : les caractères BREAK et ceux qui comportent une erreur de parité sont ignorés
    termios_p.c_iflag = IGNBRK | IGNPAR;
    // rien de particulier à faire pour l'envoi des caractères
    termios_p.c_oflag = 0;
    // 9600 bits/s, 8 bits, pas de parité
    termios_p.c_cflag = B9600 | CS8;
    termios_p.c_cflag &= ~PARENB;

    // pas d'écho des caractères reçus
    termios_p.c_lflag = ~ECHO;
    // spécifie le nombre de caractéres que doit contenir le tampon pour être accessible à la lecture
    // En général, on fixe cette valeur à 1
    termios_p.c_cc[VMIN] = 1;
    // spécifie en dixièmes de seconde le temps au bout duquel un caractère devient accessible, 
    // même si le tampon ne contient pas [VMIN] caractères
    // Une valeur de 0 représente un temps infini.
    termios_p.c_cc[VTIME] = 0;

    // cf. man tcsetattr
    tcsetattr(fd, TCSANOW, &termios_p);
    
    // cf. man 2 fcntl
    // mode bloquant ?
    //fcntl(fd, F_SETFL, fcntl(fd,F_GETFL)&~O_NONBLOCK);
    
    return fd;
}

void fermerPort(int fd)
{
   // cf. man 2 close
   close(fd);
}

int envoyer(int fd, char *trame, int nb)
{
	int retour = -1;

	if(fd > 0)
	{
        // cf. man 2 write
		retour = write(fd, trame, nb);
		
        #ifdef DEBUG_PANNEAU        
        //debug : affichage
        fprintf(stderr, "-> envoyer (%d/%d) : ", nb, retour);
        //fprintf(stderr, "trame : ");
        /*int i; 
        for(i=0;i<nb;i++)
        {
            fprintf(stderr, "0x%02X ", *(trame+i));
        }
        fprintf(stderr, "\n");*/
        fprintf(stderr, "%s\n", trame);
        #endif
        if (retour == -1)
        {
			perror("write");
        }
    }
    else 
    {
        #ifdef DEBUG_PANNEAU
        //debug : affichage
        fprintf(stderr, "-> envoyer (%d) : ERREUR port !\n", nb);
        fprintf(stderr, "trame : ");
        /*int i; 
        for(i=0;i<nb;i++)
        {
            fprintf(stderr, "0x%02X ", *(trame+i));
        }
        fprintf(stderr, "\n");*/
        fprintf(stderr, "%s\n", trame);
        #endif
        retour = fd;
    }

	return retour;
}

int recevoir(int fd, char *donnees, int nb)
{
	int retour;
	char donnee;
	int lus = 0;

	if(fd > 0 && donnees != (char *)NULL)
	{
		if(nb > 0)
		{
			for(lus=0;lus<nb;lus++)
			{
                // cf. man 2 read
				retour = read(fd, &donnee, 1);
				if(retour > 0)
						*(donnees+lus) = donnee;
				else	
                {
                    /*if (retour == -1)
                    {
                        perror("read");
                    }*/
                    break;
                }
			}
			if(nb == lus && nb > 1)
				*(donnees+lus) = 0x00; //fin de chaine
			retour = lus;
            #ifdef DEBUG_PANNEAU
            int i;
            fprintf(stderr, "<- recevoir (%d/%d) : ", nb, lus);
            //fprintf(stderr, "trame : ");
            for(i=0;i<lus;i++)
                fprintf(stderr, "0x%02X ", *(donnees+i)); 
            fprintf(stderr, "\n"); 
            #endif
		}
		else
		{
			
		}
	}
	else retour = fd;
	
	return retour;
}

unsigned char calculerChecksum(char *trame)
{
   unsigned char checksum = 0;
   int i = 0;
   
   #ifdef DEBUG_PANNEAU
   printf("data packet :\t");
   for(i=0;i<strlen(trame);i++)
      printf("0x%02X ", trame[i]);
   printf("\n");
   #endif
   
   for(i=0;i<strlen(trame);i++)
      checksum ^= trame[i];

   #ifdef DEBUG_PANNEAU 
   printf("checksum :\t0x%02X\n", checksum);
   #endif
   
   return checksum;
}

/* Programme principal */
int main()
{
    char nomPort[LG_MAX] = { PORT };
    int fd = -1;
    //Exemple de trame : "<ID01><L1><PA><FE><MA><WC><FE>message1F<E>"
    char trame[LG_MAX_TRAME] = { NUL };
    char protocole[LG_MAX_TRAME] = "<L1><PA><FE><MA><WC><FE>";
    char message[LG_MAX] = "BTS-SN"; // attention : longueur max du message égale à LG_MAX-1
    char reponse[LG_MAX] = { NUL };
    unsigned char checksum;    
    int retour;
    
    // 0. on ajoute le message dans l'en-tête du protocole
    sprintf(protocole, "%s%s", protocole, message);
    
    // 1. on calcule le checksum de la trame
    checksum = calculerChecksum(protocole);
    
    // 2. on fabrique la trame
    sprintf(trame, "<ID01>%s%02X<E>", protocole, checksum);
 
    // 3. on transfère la trame
    
    // 3.1 on ouvre le port
    fd = ouvrirPort(nomPort);
    if(fd == -1)
    {
        fprintf(stderr, "Erreur ouverture !\n");
        //return fd;
    }
    
    // 3.2 on envoie la trame
    retour = envoyer(fd, &trame[0], strlen(trame));
    if(retour == -1)
    {
        fprintf(stderr, "Erreur transmission !\n");
        // ... ?
    }
 
    usleep(DELAI);
 
    // 3.3 on réceptionne l'acquittement
    retour = recevoir(fd, reponse, LG_REPONSE);
    if(retour < 1)
    {
        fprintf(stderr, "Erreur réception !\n");
        // ... ?
    }
    else
    {
        printf("Réponse : %s\n", reponse);
    }
    
    // 3.4 on ferme le port
    fermerPort(fd);
    
    return 0;
}

/*
 * Trame correcte :
 *
 * data packet :	0x3C 0x4C 0x31 0x3E 0x3C 0x50 0x41 0x3E 0x3C 0x46 0x45 0x3E 0x3C 0x4D 0x41 0x3E 0x3C 0x57 0x43 0x3E 0x3C 0x46 0x45 0x3E 0x6D 0x65 0x73 0x73 0x61 0x67 0x65 
 * checksum :	0x1F
 * Ouverture du port /dev/ttyUSB0
 * -> envoyer (42/42) : <ID01><L1><PA><FE><MA><WC><FE>message1F<E>
 * <- recevoir (4/3) : 0x41 0x43 0x4B 
 * Réponse : ACK
 *
 * Trame incorrecte (mauvais checksum) :
 *
 * Ouverture du port /dev/ttyUSB0
 * -> envoyer (42/42) : <ID01><L1><PA><FE><MA><WC><FE>message00<E>
 * <- recevoir (4/4) : 0x4E 0x41 0x43 0x4B 
 * Réponse : NACK
 */
