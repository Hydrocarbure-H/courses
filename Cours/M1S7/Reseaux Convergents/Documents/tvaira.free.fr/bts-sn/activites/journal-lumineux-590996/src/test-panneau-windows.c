/*
 * Test du panneau Mc Crypte-590996 (sous Windows)
 * 
 * Documentation : http://www1.produktinfo.conrad.com/datenblaetter/575000-599999/590996-da-01-en-Communication_protocol_LED_Displ_Board.pdf
 *
 * Tests en fin de fichier
 */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <windows.h>

#define DEBUG_PANNEAU

#define PORT            "COM10" // cf. gestionnaire de périphériques

#define LG_MAX_TRAME    128
#define LG_MAX          16
#define LG_REPONSE      4 // au minimum 3 caractères pour ACK

// cf. code ascii
#define NUL             0x00 // caractère NUL (c'est aussi le code du fin de chaîne)
#define ACK             0x06 // accusé réception positif
#define NACK            0x15 // accusé réception négatif

#define DELAI           1 // en secondes

// Lire: http://ftp.lip6.fr/pub/linux/french/echo-linux/html/ports-series/ports_series.html
HANDLE ouvrirPort(char *nomPort)
{
    HANDLE hPort = INVALID_HANDLE_VALUE; // Handle sur le port série
    DCB old_dcb; // anciens parametres du port série
    DCB dcb; // parametres du port série
    COMMTIMEOUTS comout = {0}; // timeout du port serie ici = MODE BLOQUANT
    COMMTIMEOUTS oldTimeouts; // ancien timeout du port série
    char nomPeripherique[LG_MAX] = { PORT };
    
    // \\.\COM10
    sprintf(nomPeripherique, "\\\\.\\%s", nomPort);
    // Lire https://msdn.microsoft.com/en-us/library/windows/desktop/aa363858%28v=vs.85%29.aspx
    hPort = CreateFile(
                       "\\\\.\\COM10",     
                       GENERIC_READ | GENERIC_WRITE,          
                       0,                  
                       NULL,               
                       OPEN_EXISTING,      
                       0,                  
                       NULL);

    if( hPort == INVALID_HANDLE_VALUE )
    {
        fprintf(stderr, "Erreur d'ouverture du peripherique %s !\n", nomPeripherique);
        return hPort;
    }

    /* Lecture des parametres courants  */
    GetCommState(hPort, &dcb);
    old_dcb = dcb; // sauvegarde l'ancienne configuration

    /* Liaison a 9600 bps, 8 bits de donnees, pas de parite, lecture possible */
    dcb.BaudRate = CBR_9600;
    dcb.ByteSize = 8;
    dcb.StopBits = ONESTOPBIT;
    dcb.Parity = NOPARITY;
    dcb.fBinary = TRUE;
    /* pas de control de flux */
    dcb.fOutxCtsFlow = FALSE;
    dcb.fOutxDsrFlow = FALSE;

    /* Sauvegarde des nouveaux parametres */
    if( !SetCommState(hPort, &dcb) )
    {
      fprintf(stderr, "Impossible de configurer le port %s !", nomPort);
      CloseHandle(hPort);
      return hPort;
    }
    SetupComm(hPort, 2048, 1024);
    GetCommTimeouts(hPort, &oldTimeouts);
    // MODE NON BLOQUANT (timeout)
    // Specify time-out between charactor for receiving.
    comout.ReadIntervalTimeout = 100;
    // Specify value that is multiplied 
    // by the requested number of bytes to be read. 
    comout.ReadTotalTimeoutMultiplier = 1;
    // Specify value is added to the product of the 
    // ReadTotalTimeoutMultiplier member
    comout.ReadTotalTimeoutConstant = 0;
    // Specify value that is multiplied 
    // by the requested number of bytes to be sent. 
    //comout.WriteTotalTimeoutMultiplier = 3;
    // Specify value is added to the product of the 
    // WriteTotalTimeoutMultiplier member
    //comout.WriteTotalTimeoutConstant = 2;
    // set the time-out parameter into device control.
    SetCommTimeouts(hPort, &comout);
    
    return hPort;
}

void fermerPort(HANDLE hPort)
{
    // Lire https://msdn.microsoft.com/en-us/library/windows/desktop/ms724211%28v=vs.85%29.aspx
    CloseHandle(hPort);
}

BOOL envoyer(HANDLE hPort, char *trame, int nb)
{
    BOOL retour = FALSE;
    DWORD nNumberOfBytesToWrite = nb;
    DWORD ecrits;

	if(hPort > 0)
	{
        // Lire https://msdn.microsoft.com/en-us/library/windows/desktop/aa365747%28v=vs.85%29.aspx
		retour = WriteFile(hPort, trame, nNumberOfBytesToWrite, &ecrits, NULL);
		
        #ifdef DEBUG_PANNEAU        
        //debug : affichage
        fprintf(stderr, "-> envoyer (%d/%d) : ", nb, ecrits);
        //fprintf(stderr, "trame : ");
        /*int i; 
        for(i=0;i<nb;i++)
        {
            fprintf(stderr, "0x%02X ", *(trame+i));
        }
        fprintf(stderr, "\n");*/
        fprintf(stderr, "%s\n", trame);
        #endif
        if (retour == FALSE)
        {
            fprintf(stderr, "Erreur écriture port !");
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
    }

	return retour;
}

BOOL recevoir(HANDLE hPort, char *donnees, int nb)
{
	char donnee;
	int n;
    DWORD lus = 0;
    BOOL retour = FALSE;

	if(hPort > 0 && donnees != (char *)NULL)
	{
		if(nb > 0)
		{
			for(n=0;n<nb;n++)
			{
                // Lire https://msdn.microsoft.com/en-us/library/windows/desktop/aa365467%28v=vs.85%29.aspx
                // ATTENTION au mode bloquant !
                retour = ReadFile(hPort, &donnee, 1, &lus, NULL);
				if(retour == TRUE)
				{
                    if(donnee != 0)
                    {
						*(donnees+n) = donnee;
						fprintf(stderr, "donnee : 0x%02X (%d)\n", *(donnees+n), n); 
                    }
                    else n--;
                }
				else	
                {
                    break;
                }
			}
			*(donnees+n) = 0x00; //fin de chaine
            #ifdef DEBUG_PANNEAU
            int i;
            fprintf(stderr, "<- recevoir (%d/%d) : ", nb, n);
            //fprintf(stderr, "trame : ");
            for(i=0;i<nb;i++)
                fprintf(stderr, "0x%02X ", *(donnees+i)); 
            fprintf(stderr, "\n"); 
            #endif
		}
		else
		{
			
		}
	}
	
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
    HANDLE hPort = INVALID_HANDLE_VALUE; // Handle sur le port série
    //Exemple de trame : "<ID01><L1><PA><FE><MA><WC><FE>message1F<E>"
    char trame[LG_MAX_TRAME] = { NUL };
    char protocole[LG_MAX_TRAME] = "<L1><PA><FE><MA><WC><FE>";
    char message[LG_MAX] = "message"; // attention : longueur max du message égale à LG_MAX-1
    char reponse[LG_MAX] = { NUL };
    unsigned char checksum;    
    BOOL retour = FALSE;
    
    // 0. on ajoute le message dans l'en-tete du protocole
    sprintf(protocole, "%s%s", protocole, message);
    
    // 1. on calcule le checksum de la trame
    checksum = calculerChecksum(protocole);
    
    // 2. on fabrique la trame
    sprintf(trame, "<ID01>%s%02X<E>", protocole, checksum);
 
    // 3. on transfere la trame
    
    // 3.1 on ouvre le port
    hPort = ouvrirPort(nomPort);
    if(hPort == INVALID_HANDLE_VALUE)
    {
        fprintf(stderr, "Erreur ouverture !\n");
        //return fd;
    }
    
    // 3.2 on envoie la trame
    retour = envoyer(hPort, &trame[0], strlen(trame));
    if(retour == FALSE)
    {
        fprintf(stderr, "Erreur transmission !\n");
        // ... ?
    }
 
    Sleep(DELAI);
 
    // 3.3 on receptionne l'acquittement
    retour = recevoir(hPort, reponse, LG_REPONSE);
    if(retour == FALSE)
    {
        fprintf(stderr, "Erreur reception !\n");
        // ... ?
    }
    else
    {
        printf("Reponse : %s\n", reponse);
    }
    
    // 3.4 on ferme le port
    fermerPort(hPort);

    // evite que la fenetre se ferme dans Dev-Cpp
    getch();
    
    return 0;
}

/*
 * Trame correcte :
 *
 * data packet :	0x3C 0x4C 0x31 0x3E 0x3C 0x50 0x41 0x3E 0x3C 0x46 0x45 0x3E 0x3C 0x4D 0x41 0x3E 0x3C 0x57 0x43 0x3E 0x3C 0x46 0x45 0x3E 0x6D 0x65 0x73 0x73 0x61 0x67 0x65 
 * checksum :	0x1F
 * -> envoyer (42/42) : <ID01><L1><PA><FE><MA><WC><FE>message1F<E>
 * <- recevoir (4/4) : 0x41 0x43 0x4B 0x4B 
 * Reponse : ACKK
 *
 * Trame incorrecte (mauvais checksum) :
 *
 * -> envoyer (42/42) : <ID01><L1><PA><FE><MA><WC><FE>message00<E>
 * <- recevoir (4/4) : 0x4E 0x41 0x43 0x4B 
 * Reponse : NACK
 */
