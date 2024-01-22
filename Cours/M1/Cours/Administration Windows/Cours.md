# Administration et sécurité Windows

# SIDs

*Un SID (Security Identifier) en informatique, notamment dans les environnements Windows, est un identifiant unique utilisé pour gérer les permissions de sécurité. Chaque compte d'utilisateur, groupe d'utilisateurs, et même certains processus ou composants dans le système d'exploitation Windows, se voient attribuer un SID qui les identifie de manière unique. - ChatGPT*

![Microsoft Windows Security: Security Identifiers in Microsoft Windows](./assets/img1.jpeg)

| Well-known SID | Description                       |
| -------------- | --------------------------------- |
| S-1-5-18       | Local System Account              |
| S-1-5-19       | Local Service Account             |
| S-1-5-20       | Network Service Account           |
| S-1-5-32-544   | Administrators Group              |
| S-1-5-32-545   | Users Group                       |
| S-1-5-32-546   | Guests Group                      |
| S-1-5-32-547   | Power Users Group                 |
| S-1-5-32-548   | Account Operators Group           |
| S-1-5-32-549   | Server Operators Group            |
| S-1-5-32-550   | Print Operators Group             |
| S-1-5-32-551   | Backup Operators Group            |
| S-1-5-32-552   | Replicators Group                 |
| S-1-5-11       | Authenticated Users Special Group |
| S-1-5-15       | This Organization Special Group   |

## Access Token

Représente l'identité d'un utilisateur.

Contient : 

- User SID
- Group SIDs
- Privilèges
- Impersonation Level

`whoami /all` : Donne toutes les informations contenues dans le Access Token, dont les privilèges, pour un utilisateur donné (celui logged in).

# SAM

*SAM Access Control est un aspect fondamental de la sécurité et de la gestion des comptes d'utilisateurs dans Windows. Il assure que les informations d'utilisateur sont stockées, gérées et accédées de manière sécurisée, tout en fournissant les mécanismes nécessaires pour l'authentification et la gestion des comptes. - ChatGPT*

La base SAM est représentée par le fichier `"**%SystemRoot%\system32\config\SAM**"` (généralement dans `"C:\Windows\"`) qui est en fait un fichier associé à la base de [Registre Windows](https://www.it-connect.fr/quest-ce-que-la-base-de-registre-windows/) : `HKEY_LOCAL_MACHINE\SAM\`.

![Les domaines de la base SAM](./assets/Les-domaines-de-la-base-SAM.png)

![image-20240122092238306](./assets/image-20240122092238306.png)

# LSA

On peut accéder à ces services via RPC (Remote Procedure Call).

### **RPC (Remote Procedure Call)**

- **Communication inter-processus** : Permet à un programme d'exécuter des fonctions dans un autre programme, souvent sur un autre ordinateur.
- **Abstraction réseau** : Masque la complexité de la communication réseau.
- **Protocoles divers** : Implémentations comme DCOM, Java RMI, XML-RPC.
- **Sécurité** : Authentification, chiffrement, gestion des autorisations.
- **Systèmes distribués** : Utilisé dans architectures distribuées, cloud, services web.
- **Défis** : Gestion des erreurs réseau, latence, sérialisation/désérialisation.

### **LSA (Local Security Authority)**

- **Authentification** : Vérifie les identifiants des utilisateurs.
- **Jetons d'accès** : Crée des jetons après authentification réussie.
- **Politiques de sécurité** : Gère les stratégies de mot de passe, droits utilisateurs.
- **SAM et Active Directory** : Interagit pour informations d'identification.

#### **LSASS (Local Security Authority Subsystem Service)**

- **Processus** : Exécute les fonctions de LSA.
- **Sécurité système** : Gère les politiques de sécurité, les comptes, les mots de passe.
- **Protection** : Fonctionne avec des privilèges élevés pour la sécurité.
- **Cible des attaques** : Souvent visé par des malwares pour accéder aux données de sécurité.

## Exemples de RPC

![image-20240122092956392](./assets/image-20240122092956392.png)

## Exemple de Winlogon

Authentification de l'utilisateur, vérification des credentials, démarrage de userinit.exe…

![image-20240122093432312](./assets/image-20240122093432312.png)

# Authentification

Session:

- Session, Kernel (partitionnement système entre utilisateurs)
- Logon Session (LSASS)
  - Utilisateur authentifié sur la machine (LUID, Localy-…)

![image-20240122094121703](./assets/image-20240122094121703.png)

## Authentifications Packages (DLLs)

![image-20240122094214536](./assets/image-20240122094214536.png)

## Credentials Manager

Permet l'enregistrement de mots de passe.

![image-20240122094342168](./assets/image-20240122094342168.png)

**Note**: Possible de faire 2 types de call pour accéder à ces données, Local RPC ou Named Pipes.

# SSPI (Security Support Provider Interface)

***SSPI (Security Support Provider Interface)** est une interface de programmation dans les systèmes Windows qui offre des services de sécurité tels que l'authentification, l'autorisation, et la gestion des échanges de clés cryptographiques. - ChatGPT*

- **Interface** : Fournit une interface pour la sécurité au niveau du système.
- **Authentification** : Gère l'authentification, l'autorisation, et l'échange de clés cryptographiques.
- **Abstraction** : Cache les détails spécifiques des protocoles de sécurité.
- **Protocoles supportés** : Inclut Kerberos, NTLM, Schannel (SSL/TLS), Digest.
- **Extensible** : Peut intégrer de nouveaux protocoles de sécurité.
- **Utilisation** : Employé par divers services Windows et applications pour sécuriser les communications.
- **Interactions avec LSASS** : SSPI communique avec LSASS pour l'accès aux fonctions de sécurité.

![image-20240122102116641](./assets/image-20240122102116641.png)

## Structure des call dispatch

![image-20240122094726060](./assets/image-20240122094726060.png)

## Fonctionnement de SSPI

![image-20240122094851754](./assets/image-20240122094851754.png)

# UAC (User Account Control)

***UAC (User Account Control)** est une fonctionnalité de sécurité dans les systèmes d'exploitation Windows qui aide à prévenir les modifications non autorisées sur le système. Elle vise à améliorer la sécurité en demandant une autorisation ou des informations d'identification d'administrateur avant de lancer des tâches pouvant affecter le fonctionnement du système ou modifier des paramètres sensibles. - ChatGPT*

- **Contrôle des Modifications Système** : Prévient les changements non autorisés sur le système.
- **Demande d'Élévation de Privileges** : Demande une autorisation pour les tâches nécessitant des droits d'administrateur.
- **Sécurité Renforcée** : Réduit le risque d'infections par des logiciels malveillants et d'actions non autorisées.
- **Modes de Notification** : Plusieurs niveaux de notifications selon les paramètres de l'utilisateur.
- **Utilisateur Standard vs Administrateur** : Fait la distinction entre les droits des utilisateurs standards et ceux des administrateurs.
- **Compatibilité avec les Applications** : Peut nécessiter des ajustements pour les anciennes applications non conçues pour UAC.
- **Gestion Centralisée** : Peut être configuré via des politiques de groupe dans un environnement d'entreprise.

![image-20240122102255146](./assets/image-20240122102255146.png)

## Liste des Filtered Groups

| Groupe d'Utilisateurs                                        | Description                                                  |
| ------------------------------------------------------------ | ------------------------------------------------------------ |
| **Domain Admins**                                            | Administrateurs du domaine avec privilèges complets, restreints sous UAC. |
| **Read-only Domain Controllers**                             | Contrôleurs de domaine en lecture seule, avec des droits limités. |
| **Enterprise Read-only Domain Controllers**                  | Contrôleurs de domaine d'entreprise en lecture seule, avec des droits spécifiques. |
| **Administrators**                                           | Groupe d'administrateurs avec privilèges élevés, limités sous UAC. |
| **Power Users**                                              | Utilisateurs avec certains privilèges administratifs, réduits sous UAC. |
| **Account Operators**                                        | Gère les comptes utilisateurs, avec des privilèges limités sous UAC. |
| **Server Operators**                                         | Opérateurs de serveur avec des droits limités en présence d'UAC. |
| **Print Operators**                                          | Opérateurs d'impression avec des droits restreints sous UAC. |
| **Backup Operators**                                         | Opérateurs de sauvegarde avec des privilèges spéciaux, filtrés par UAC. |
| **Pre-Windows 2000 Compatible Access**                       | Accès compatible avec les versions antérieures à Windows 2000, limité par UAC. |
| **Cert Publishers**                                          | Éditeurs de certificats, avec des droits spécifiques sous UAC. |
| **Schema Admins**                                            | Administrateurs de schéma avec des privilèges élevés, restreints par UAC. |
| **Enterprise Admins**                                        | Administrateurs d'entreprise avec droits complets, filtrés sous UAC. |
| **Group Policy Creator Owners**                              | Propriétaires créateurs de stratégies de groupe, avec des privilèges spéciaux sous UAC. |
| **RAS and IAS Servers Access**                               | Accès limité sous UAC pour les serveurs RAS et IAS.          |
| **Network Configuration Operators**                          | Opérateurs de configuration réseau, avec droits limités sous UAC. |
| **Cryptographic Operators**                                  | Opérateurs cryptographiques avec des privilèges restreints sous UAC. |
| **NT AUTHORITY\Local account and member of Administrators group** | Comptes locaux membres du groupe Administrateurs, avec droits d'administrateur filtrés sous UAC. |

# Service Account

## GSMA (Group Managed Service Account)

**GMSA (Group Managed Service Account)** est une fonctionnalité dans les environnements **Windows Server**, conçue pour offrir une gestion automatisée et sécurisée des comptes de service.

- **Gestion Automatisée des Mots de Passe** : GMSA permet la gestion automatique des mots de passe, éliminant le besoin de les changer manuellement.
- **Sécurité Renforcée** : Améliore la sécurité des applications et des services en évitant la gestion manuelle des mots de passe.
- **Utilisation sur Plusieurs Serveurs** : Contrairement aux MSA (Managed Service Accounts), les GMSA peuvent être utilisés sur plusieurs serveurs.
- **Support d'Applications et Services** : Idéal pour les services Windows, IIS, SQL Server et d'autres applications qui nécessitent des comptes de service.
- **Active Directory** : Nécessite Active Directory pour stocker et gérer les comptes GMSA.
- **Automatisation avec PowerShell** : Géré principalement via PowerShell pour l'automatisation et la configuration.
- **Restrictions et Délégation** : Permet de définir des restrictions et des délégations spécifiques pour les comptes de service.

