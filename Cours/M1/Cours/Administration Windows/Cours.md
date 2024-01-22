# Administration et sécurité Windows

# SIDs

> *Un SID (Security Identifier) en informatique, notamment dans les environnements Windows, est un identifiant unique utilisé pour gérer les permissions de sécurité. Chaque compte d'utilisateur, groupe d'utilisateurs, et même certains processus ou composants dans le système d'exploitation Windows, se voient attribuer un SID qui les identifie de manière unique. - ChatGPT*

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

> *SAM Access Control est un aspect fondamental de la sécurité et de la gestion des comptes d'utilisateurs dans Windows. Il assure que les informations d'utilisateur sont stockées, gérées et accédées de manière sécurisée, tout en fournissant les mécanismes nécessaires pour l'authentification et la gestion des comptes. - ChatGPT*

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

> ***SSPI (Security Support Provider Interface)** est une interface de programmation dans les systèmes Windows qui offre des services de sécurité tels que l'authentification, l'autorisation, et la gestion des échanges de clés cryptographiques. - ChatGPT*

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

> ***UAC (User Account Control)** est une fonctionnalité de sécurité dans les systèmes d'exploitation Windows qui aide à prévenir les modifications non autorisées sur le système. Elle vise à améliorer la sécurité en demandant une autorisation ou des informations d'identification d'administrateur avant de lancer des tâches pouvant affecter le fonctionnement du système ou modifier des paramètres sensibles. - ChatGPT*

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

> ***GMSA (Group Managed Service Account)** est une fonctionnalité dans les environnements **Windows Server**, conçue pour offrir une gestion automatisée et sécurisée des comptes de service. - ChatGPT*

- **Gestion Automatisée des Mots de Passe** : GMSA permet la gestion automatique des mots de passe, éliminant le besoin de les changer manuellement.
- **Sécurité Renforcée** : Améliore la sécurité des applications et des services en évitant la gestion manuelle des mots de passe.
- **Utilisation sur Plusieurs Serveurs** : Contrairement aux MSA (Managed Service Accounts), les GMSA peuvent être utilisés sur plusieurs serveurs.
- **Support d'Applications et Services** : Idéal pour les services Windows, IIS, SQL Server et d'autres applications qui nécessitent des comptes de service.
- **Active Directory** : Nécessite Active Directory pour stocker et gérer les comptes GMSA.
- **Automatisation avec PowerShell** : Géré principalement via PowerShell pour l'automatisation et la configuration.
- **Restrictions et Délégation** : Permet de définir des restrictions et des délégations spécifiques pour les comptes de service.

### gSMA Operations

> *Les opérations avec `Group Managed Service Accounts` (`gMSA`) dans Windows Server sont conçues pour simplifier la gestion des comptes de service, en particulier pour les mots de passe automatiquement gérés et synchronisés. - ChatGPT*

**Fonctionnement:**

1. **Création de `gMSA`** : Les administrateurs créent un `gMSA` dans Active Directory. Ils spécifient les systèmes où le `gMSA` peut être utilisé.

2. **Automatisation des Mots de Passe** : `gMSA` gère automatiquement les changements de mot de passe, éliminant le besoin pour les administrateurs de les mettre à jour manuellement.

3. **Utilisation sur Plusieurs Serveurs** : Contrairement à un `Managed Service Account` (`MSA`), un `gMSA` peut être utilisé sur plusieurs serveurs, ce qui est idéal pour des services équilibrés sur plusieurs machines.

4. **Sécurité Renforcée** : Les mots de passe `gMSA` sont complexes et régulièrement renouvelés, améliorant ainsi la sécurité.

5. **Configuration des Services** : Les services ou applications sur les serveurs sont configurés pour utiliser le `gMSA` pour l'authentification. Cela inclut des services comme IIS, SQL Server ou des tâches planifiées.

6. **Accès aux Ressources** : Les services utilisant `gMSA` peuvent accéder aux ressources du réseau de manière sécurisée sans nécessiter une intervention pour la gestion des mots de passe.

7. **Dépendance Active Directory** : `gMSA` nécessite une infrastructure Active Directory et est principalement géré via PowerShell.

8. **Restrictions et Politiques** : Les administrateurs peuvent définir des politiques de sécurité et des restrictions spécifiques pour les `gMSA` dans Active Directory.

# Windows Privileges

> *Les privilèges de type session dans Windows sont des autorisations spécifiques accordées à un utilisateur ou à un processus pour une session donnée. Ces privilèges déterminent les actions que l'utilisateur ou le processus peut effectuer pendant la durée de la session. - ChatGPT* 

- **Attribution Dynamique** : Les privilèges de type session sont attribués dynamiquement lorsqu'une session utilisateur est créée. Ils varient en fonction du niveau d'accès de l'utilisateur ou du rôle du processus.

- **Gestion de la Sécurité** : Ces privilèges sont essentiels pour la gestion de la sécurité au niveau des sessions, limitant ou étendant les capacités des utilisateurs ou des processus en fonction de leurs besoins et de leur niveau de confiance.

- **Exemples de Privilèges** : Parmi les privilèges de type session, on trouve le droit de déboguer des programmes (`SeDebugPrivilege`), de charger ou de décharger des pilotes de périphériques (`SeLoadDriverPrivilege`), et de gérer l'audit et les journaux de sécurité (`SeSecurityPrivilege`).

- **Contrôle d'Accès** : Les privilèges de session jouent un rôle crucial dans le contrôle d'accès, en s'assurant que seules les actions autorisées peuvent être effectuées par un utilisateur ou un processus donné pendant une session.

- **Importance pour la Sécurité** : La gestion correcte de ces privilèges est vitale pour maintenir la sécurité du système, en prévenant les abus de droits et en limitant les risques d'actions malveillantes.

*En résumé, les privilèges de type session sont une partie intégrante du modèle de sécurité de Windows, permettant une gestion flexible et sécurisée des autorisations au niveau des sessions individuelles.*

## Tableaux détaillés

| Type de Privilège de Session        | Description                                                  |
| ----------------------------------- | ------------------------------------------------------------ |
| **SeCreateTokenPrivilege**          | Permet à un processus de créer un jeton d'accès.             |
| **SeAssignPrimaryTokenPrivilege**   | Permet à un processus de modifier le jeton d'accès d'un processus. |
| **SeLockMemoryPrivilege**           | Autorise le verrouillage des pages en mémoire.               |
| **SeIncreaseQuotaPrivilege**        | Permet d'augmenter les quotas de mémoire pour un processus.  |
| **SeMachineAccountPrivilege**       | Autorise la création d'un compte machine dans le domaine.    |
| **SeTcbPrivilege**                  | Permet de se comporter comme une partie du système d'exploitation. |
| **SeSecurityPrivilege**             | Autorise la modification des paramètres de sécurité et des journaux d'audit. |
| **SeTakeOwnershipPrivilege**        | Permet de prendre possession d'un objet sans autorisation.   |
| **SeLoadDriverPrivilege**           | Autorise le chargement ou le déchargement des pilotes de périphériques. |
| **SeSystemProfilePrivilege**        | Permet de profiler les performances du système.              |
| **SeSystemtimePrivilege**           | Autorise la modification de l'heure du système.              |
| **SeProfileSingleProcessPrivilege** | Permet de profiler les performances d'un processus unique.   |
| **SeIncreaseBasePriorityPrivilege** | Permet d'augmenter la priorité d'exécution d'un processus.   |
| **SeCreatePagefilePrivilege**       | Autorise la création d'un fichier d'échange.                 |
| **SeCreatePermanentPrivilege**      | Permet de créer des objets permanents dans le noyau.         |
| **SeBackupPrivilege**               | Autorise la sauvegarde de fichiers et de dossiers.           |
| **SeRestorePrivilege**              | Permet de restaurer des fichiers et des dossiers.            |
| **SeShutdownPrivilege**             | Autorise l'arrêt et le redémarrage du système.               |
| **SeDebugPrivilege**                | Permet d'accéder à des informations sensibles dans d'autres processus. |
| **SeAuditPrivilege**                | Autorise l'activation des journaux d'audit.                  |
| **SeSystemEnvironmentPrivilege**    | Permet de modifier les variables d'environnement du système. |
| **SeChangeNotifyPrivilege**         | Autorise la réception de notifications de modification de fichiers ou de dossiers. |
| **SeRemoteShutdownPrivilege**       | Autorise l'arrêt à distance d'un ordinateur.                 |
| **SeUndockPrivilege**               | Permet de détacher un ordinateur portable de sa station d'accueil. |
| **SeSyncAgentPrivilege**            | Permet d'effectuer des synchronisations de fichiers en tant qu'agent. |
| **SeEnableDelegationPrivilege**     | Permet d'activer la délégation de sécurité.                  |

# Privileges Management

> *La gestion des privilèges, ou `Privileges Management`, dans les systèmes informatiques, est un aspect crucial de la sécurité et de l'administration système. Elle implique l'attribution, la gestion et le contrôle des privilèges (droits) accordés aux utilisateurs, aux comptes de service et aux processus. - ChatGPT*

1. **Contrôle d'Accès** : La gestion des privilèges est essentielle pour contrôler l'accès aux ressources et fonctions du système. Elle détermine qui peut effectuer quelles actions et sur quels objets.

2. **Prévention des Abus** : En limitant les privilèges au strict nécessaire, on réduit le risque d'abus ou d'exploitation malveillante des droits étendus.

3. **Principe du Moindre Privilège** : Il s'agit d'une pratique de sécurité consistant à accorder aux utilisateurs uniquement les privilèges nécessaires pour effectuer leurs tâches, réduisant ainsi la surface d'attaque potentielle.

4. **Gestion des Comptes Utilisateur** : Implique de définir des rôles et des responsabilités, et d'associer les privilèges appropriés à ces rôles.

5. **Audit et Suivi** : La surveillance et l'audit des privilèges permettent de détecter les anomalies de sécurité et de conformité, en enregistrant qui a fait quoi, quand et où.

6. **Outils de Gestion des Privilèges** : Des logiciels spécialisés aident à gérer les privilèges, offrant des fonctionnalités comme la gestion automatisée des privilèges, l'analyse des droits et la délégation de droits.

7. **Mises à Jour et Révisions** : Les privilèges doivent être régulièrement revus et ajustés en fonction des changements de rôle, des départs d'employés ou de l'évolution des politiques de sécurité.

8. **Intégration avec la Gestion des Identités** : La gestion des privilèges est souvent intégrée à des solutions plus larges de gestion des identités et des accès (IAM) pour une administration cohérente des droits d'utilisateur.

![image-20240122103108062](./assets/image-20240122103108062.png)

# Local Security Database

> *La `Local Security Database` dans les systèmes Windows est un composant essentiel qui stocke les informations de sécurité locales pour un ordinateur. - ChatGPT*

1. **Stockage d'Informations de Sécurité** : Contient des données telles que les comptes d'utilisateurs, les groupes, les politiques de sécurité et les mots de passe.

2. **Gérée par SAM (`Security Account Manager`)** : La base de données est gérée par le SAM, qui contrôle l'accès et la gestion des comptes utilisateurs et des groupes.

3. **Utilisée pour l'Authentification Locale** : Permet l'authentification des utilisateurs sur l'ordinateur local sans nécessiter de connexion à un serveur Active Directory.

4. **Politiques de Sécurité** : Inclut des politiques telles que les exigences de mot de passe, les droits de connexion et les paramètres d'audit.

5. **Gestion des Comptes** : Permet aux administrateurs de créer, modifier et supprimer des comptes locaux et des groupes.

6. **Indépendante de l'Active Directory** : Fonctionne indépendamment d'Active Directory, importante pour les systèmes qui ne sont pas membres d'un domaine.

7. **Outil de Gestion** : Accessible via des outils comme l'`Local Users and Groups` du `Computer Management` ou via des commandes PowerShell.

8. **Sécurité** : Essentielle pour la sécurité de l'ordinateur, notamment en termes de gestion des accès et des droits des utilisateurs.

![image-20240122104215363](./assets/image-20240122104215363.png)

​	