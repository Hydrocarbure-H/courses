# Sécurité Réseaux

# Introduction

## Stormshield

Boîte française, we love our product. Propose plusieurs solutions sur du réseau.

## Définitions

#### NAT

Le Network Address Translation (NAT) est un processus utilisé dans les réseaux informatiques pour traduire les adresses IP d'un réseau en d'autres adresses IP. Cela permet de relier différents réseaux utilisant des adresses IP distinctes.

*Un exemple courant de NAT se produit dans un réseau domestique. Lorsque plusieurs appareils tels que des ordinateurs, des téléphones ou des tablettes se connectent à Internet via un routeur, le routeur utilise le NAT pour attribuer une seule adresse IP publique à l'ensemble de ces appareils. Chaque appareil dans le réseau domestique possède sa propre adresse IP locale, par exemple, 192.168.1.X (où X est un numéro spécifique pour chaque appareil dans le réseau local), et le routeur traduit ces adresses IP locales en une seule adresse IP publique visible sur Internet. Ainsi, le trafic provenant de l'extérieur du réseau est dirigé vers le routeur, qui utilise le NAT pour acheminer les données vers le bon appareil interne en fonction des ports et des adresses IP locales.*

![Protéger vos systèmes - Stormshield Endpoint Security - NRC - Lille](./assets/Stormshield-Endpoint-infographie.jpg)

### Les solutions physiques de firewall

![image-20231102141611151](./assets/image-20231102141611151.png)

### Software

Le logiciel installé sur toutes ces solutions est certifié par l'ANSSI. Il est également possible de faire run des virtual editions.

La solution est utilisable en SaaS ou IaaS avec la formule PayToGo (or something similar…).

![image-20231102142644038](./assets/image-20231102142644038.png)

### Spécificités techniques des solutions

![image-20231102142725559](./assets/image-20231102142725559.png)

Ces informations sont importantes à avoir sous la main lors de la certification. Le 310 permet de faire de la redondance entre deux  modèles identiques, ce qui n'est pas le cas des autres.

![image-20231102143052374](./assets/image-20231102143052374.png)

Il est également possible de faire de l'administration déployée sur plusieurs instances par l'intemédiaire d'un SMC server.

![image-20231102144140310](./assets/image-20231102144140310.png)

# Get started

Après avoir acheté le produit, obligation d'enregistrer le produit sur son compte `mystormshield.eu`.

Le système de LED est documenté dans la documentation : LED orange = OK.

### Configuration Usine

![image-20231102145916148](./assets/image-20231102145916148.png)

### Présentation de l'interface de configuration

![image-20231102150635970](./assets/image-20231102150635970.png)

# Configuration

## Objets réseaux

Il est possible de créer des objets de différents types.

![image-20231103150948527](./assets/image-20231103150948527.png)

Important : Si on crée un objet FQDN, l'adresse par défaut est celle utilisée au début, puis 5 minutes plus tard sera remplacée par la résolution DNS. Si l'IP résolue ne fonctionne pas, il testera l'ancienne valeur et non la valeur par défaut.

## Modes de fonctionnement

Il existe trois modes de fonctionnement principaux.

- Transparent - Bridge

  - Regarde tous les paquets en temps réel. Se place en man-in-the-middle, et détermine selon ses règles si le paquet doit être droppé ou non. 

  - Il est également possible de le mettre entre deux routeurs.

    ![image-20231103151811803](./assets/image-20231103151811803.png)

    Le point positif de ce montage est que chaque élément de cette infrastructure se résume à sa fonction première. Le routeur ne fait que du routage, et le firewall que de l'analyse/drop.

- Avancé - Routeur

  - Le firewall fonctionne comme un routeur en gérant plusieurs réseaux réseaux.

- Hybride

  - Un mix entre les deux modes.

## Interfaces

Les différents types d'interfaces qui existent sont les suivants.

**Note:** Le LACP est un protocole d'arggrégation de ports.

![image-20231103153004310](./assets/image-20231103153004310.png)

*Attention*: L'interface sur laquelle l'administrateur est connecté en ce moment-même possède une petite icône de type Porte de sortie. Si cette interface est modifiée, cela peut créer des problèmes immédiatement pour l'administrateur.

*Attention*: En cas de modification de l'IP/du réseau de la machine de l'administrateur connectée au Firewall, il est possible que la connexion soit refusée si l'IP de la machine est toujours en 10.0.0.N alors que le firewall n'est censé accepter que du 192.168.N.N.

Lors d'une configuration VPN, la MTU est très importante.

Exemple:![image-20231103155030120](./assets/image-20231103155030120.png)

L'encapsulation va rendre les paquets plus gros que le MTU maximum, ces derniers seront donc droppés. La modification de la MTU par défaut peut résoudre ce problème en indiquant que la taille maximale du payload est plus petite.

# Routage

## Routage statique

![image-20231109132451838](./assets/image-20231109132451838.png)

**Routage asymétrique** : Chemin d'aller différent du chemin retour. Problème car Firewall aller démarre la session TCP mais Firewall retour ne la connaît pas.

## Routage avancé

**Policy Based Routing :** 

- 2 Sorties Internet (2 pays par exemple)
- Volonté de sortir depuis l'IP Française si flux entrant est français.

Il est donc possible de faire varier l'IP sortant en fonction d'un ensemble de règles.

![image-20231109135518289](./assets/image-20231109135518289.png)

# Filtrage

Le filtrage permet la définition des flux autorisés et/ou bloqués par le firewall et la définition de critères d'application des différentes règles. Il pemet également les inspections de sécurité selon les flux.

## Statefull

![image-20231110143956142](./assets/image-20231110143956142.png)

Quand on veut autoriser un flux, on autorise la requête **puis la réponse sera automatiquement autorisée**. Ceci en fonction de la règle qui est matchée.

Dans le cas d'une session, les connexions initialisées depuis le serveur seront refusées, mais pas celles initialisées par le client et recevant une réponse du serveur.

![image-20231110144825549](./assets/image-20231110144825549.png)

**Ordre du filtrage:**

![image-20231110145103860](./assets/image-20231110145103860.png)

Lorsqu'un serveur web se trouve derrière une IP publique, c'est en suivant l'ordonnancement précédent que l'IP privée du serveur web sera translaté par le Firewall.

Cet ordonnancement peut varier selon les constructeurs de Firewall.

*Extrait de la documentation :* 

>- **Le filtrage implicite** : Regroupe les règles de filtrage préconfigurées ou ajoutées dynamiquement par le firewall pour autoriser ou bloquer certains flux après l’activation d’un service. Par exemple, une règle implicite autorise les connexions à destination des interfaces internes de l’UTM sur le port HTTPS (443/TCP) afin d’assurer un accès continu à l’interface d’administration Web. Autre exemple, dès l’activation du service SSH, un ensemble de règles implicites sera ajouté pour autoriser ces connexions depuis toutes les machines des réseaux internes.
>
>- **Le filtrage global** : Regroupe les règles de filtrage injectées au firewall depuis l’outil d’administration « Stormshield Management Server » (SMC) ou après affichage des politiques globales.
>
>- **Le filtrage local** : Représente les règles de filtrage ajoutées par l’administrateur depuis l’interface d’administration.
>
>- **Le NAT implicite** : Regroupe les règles de NAT ajoutées dynamiquement par le firewall. Ces règles sont utilisées principalement lors de l’activation de la haute disponibilité.
>
>- **Le NAT global** : À l’instar du filtrage global, il regroupe les règle de NAT injectées au firewall depuis l’outil d’administration « Stormshield Management Server » (SMC) ou après affichage des politiques globales.
>
>- **Le NAT local** : Regroupe les règles de NAT ajoutées par l’administrateur depuis l’interface d’administration.

![image-20231110151355514](./assets/image-20231110151355514.png)

Use `tcpdump`.

# Proxy

## Mode Proxy

Permet de faire du filtrage d'URL fin. Peut faire en fonction de mots-clés ou faire appel à EWC (sous license) pour avoir simplement des catégories à filtrer. L'analyse de l'URL se fait sur les serveurs distants CloudURL.

![image-20231207143454764](./assets/image-20231207143454764.png)

**Note : ** Il n'est pas possible de savoir si une URL est présente ou non dans le cache.

**IPS :** Intrusion Prevention System

**IDS **: Intrusion Detection System

# VPN

Trois familles de VPN :

- **PPTP**
- **VPN SSL**
- **VPN IPsec**

## **IPSec**

![image-20231208111430005](./assets/image-20231208111430005.png)



# Quizz

![image-20231222100336372](./assets/image-20231222100336372.png)

![image-20231222100440443](./assets/image-20231222100440443.png)

![image-20231222100521429](./assets/image-20231222100521429.png)

![image-20231222100623281](./assets/image-20231222100623281.png)

![image-20231222100803307](./assets/image-20231222100803307.png)

![image-20231222102654130](./assets/image-20231222102654130.png)

![image-20231222102806918](./assets/image-20231222102806918.png)

![image-20231222103046986](./assets/image-20231222103046986.png)

![image-20231222103126303](./assets/image-20231222103126303.png)

![image-20231222103143920](./assets/image-20231222103143920.png)

![image-20231222103150581](./assets/image-20231222103150581.png)

![image-20231222103228309](./assets/image-20231222103228309.png)

![image-20231222103246623](./assets/image-20231222103246623.png)

![image-20231222103253970](./assets/image-20231222103253970.png)

![image-20231222103342910](./assets/image-20231222103342910.png)

![image-20231222103406999](./assets/image-20231222103406999.png)

![image-20231222103428342](./assets/image-20231222103428342.png)

![image-20231222103507660](./assets/image-20231222103507660.png)

![image-20231222103524302](./assets/image-20231222103524302.png)

![image-20231222103611312](./assets/image-20231222103611312.png)

![image-20231222103641482](./assets/image-20231222103641482.png)

![image-20231222103718438](./assets/image-20231222103718438.png)

![image-20231222103755135](./assets/image-20231222103755135.png)

![image-20231222103826065](./assets/image-20231222103826065.png)

![image-20231222103835191](./assets/image-20231222103835191.png)

![image-20231222103849570](./assets/image-20231222103849570.png)

![image-20231222103923610](./assets/image-20231222103923610.png)

![image-20231222103955529](./assets/image-20231222103955529.png)

![image-20231222104025032](./assets/image-20231222104025032.png)

![image-20231222104057062](./assets/image-20231222104057062.png)

# Questions

*GPT Generated*

**Question 1 :**
Dans un pare-feu Stormshield, quelle est la fonction principale de la mise en œuvre d'une politique QoS (Quality of Service) ?
a. Filtrer le contenu du trafic
b. Prioriser certains types de trafic
c. Crypter le trafic réseau
d. Traduire les adresses réseau

Réponse : **b. Prioriser certains types de trafic**  
*Explication : La QoS permet de prioriser certains types de trafic réseau pour assurer une meilleure performance des applications critiques.*

**Question 2 :**
Quel est le rôle principal d'un groupe HA (High Availability) dans un environnement de pare-feu Stormshield ?
a. Augmenter la bande passante disponible
b. Fournir une tolérance de panne
c. Réduire la charge du processeur
d. Augmenter la capacité de stockage

Réponse : **b. Fournir une tolérance de panne**  
*Explication : Le groupe HA assure la continuité de service en cas de défaillance d'un pare-feu.*

**Question 3 :**
Quelle affirmation est correcte concernant le filtrage basé sur les rôles dans Stormshield ?
a. Il ne peut être appliqué qu'aux utilisateurs VPN
b. Il est basé exclusivement sur les adresses IP
c. Il permet d'attribuer des politiques de sécurité en fonction des rôles d'utilisateur
d. Il nécessite un équipement supplémentaire pour fonctionner

Réponse : **c. Il permet d'attribuer des politiques de sécurité en fonction des rôles d'utilisateur**  
*Explication : Le filtrage basé sur les rôles permet d'appliquer des règles de sécurité en fonction du rôle ou de l'identité de l'utilisateur.*

**Question 4 :**
Pour qu'un tunnel VPN IPsec soit établi, quel paramètre doit correspondre des deux côtés du tunnel ?
a. La version du pare-feu
b. L'adresse IP de la passerelle
c. Les paramètres de phase 1
d. La politique de QoS

Réponse : **c. Les paramètres de phase 1**  
*Explication : Les paramètres de phase 1 (comme l'algorithme de chiffrement et la méthode d'authentification) doivent être identiques des deux côtés pour établir un tunnel VPN IPsec.*

**Question 5 :**
Quelle technologie est utilisée par Stormshield pour la prévention d'intrusion (IPS) ?
a. Filtrage d'URL
b. Analyse comportementale
c. Signature de paquets
d. Contrôle d'accès basé sur le rôle

Réponse : **c. Signature de paquets**  
*Explication : L'IPS de Stormshield utilise principalement des signatures de paquets pour détecter et prévenir les intrusions.*

Souhaitez-vous que je continue avec les prochaines 5 questions ?

Parfait, voici les prochaines 5 questions :

**Question 6 :**
Dans la configuration du pare-feu Stormshield, que signifie activer le mode "transparent" ?
a. Le pare-feu agit comme un routeur
b. Le pare-feu n'effectue aucun filtrage
c. Le pare-feu fonctionne comme un pont
d. Toutes les règles de filtrage sont désactivées

Réponse : **c. Le pare-feu fonctionne comme un pont**  
*Explication : En mode transparent, le pare-feu fonctionne comme un pont, passant le trafic tout en appliquant des politiques de sécurité.*

**Question 7 :**
Qu'est-ce qu'une "zone démilitarisée" (DMZ) dans un réseau utilisant un pare-feu Stormshield ?
a. Un sous-réseau isolé pour les serveurs publics
b. Un réseau entièrement ouvert sans filtrage
c. Une zone pour les invités avec accès Internet limité
d. Un sous-réseau pour la gestion administrative du pare-feu

Réponse : **a. Un sous-réseau isolé pour les serveurs publics**  
*Explication : Une DMZ est un sous-réseau isolé pour héberger des services accessibles depuis Internet, tout en étant séparé du réseau interne.*

**Question 8 :**
Comment les pare-feu Stormshield gèrent-ils le trafic entrant non sollicité ?
a. Ils l'autorisent par défaut
b. Ils le rejettent par défaut
c. Ils le redirigent vers la DMZ
d. Ils le marquent pour révision

Réponse : **b. Ils le rejettent par défaut**  
*Explication : Par mesure de sécurité, les pare-feu Stormshield rejettent par défaut le trafic entrant non sollicité.*

**Question 9 :**
Quelle méthode Stormshield utilise-t-il pour gérer les mises à jour de ses pare-feu ?
a. Mises à jour manuelles uniquement
b. Mises à jour automatiques planifiées
c. Mises à jour en temps réel
d. Mises à jour via un serveur dédié

Réponse : **b. Mises à jour automatiques planifiées**  
*Explication : Les pare-feu Stormshield peuvent être configurés pour recevoir des mises à jour automatiques à des moments planifiés.*

**Question 10 :**
Quel avantage offre la segmentation de réseau avec des VLANs sur un pare-feu Stormshield ?
a. Augmentation de la bande passante
b. Meilleure résilience aux pannes
c. Isolation et contrôle de sécurité améliorés
d. Diminution des coûts d'infrastructure

Réponse : **c. Isolation et contrôle de sécurité améliorés**  
*Explication : La segmentation de réseau avec des VLANs permet une meilleure isolation et un contrôle de sécurité plus granulaire.*

Souhaitez-vous que je continue avec les prochaines questions ?

Très bien, voici les 5 questions suivantes :

**Question 11 :**
Pour un pare-feu Stormshield, qu'est-ce qu'une règle de filtrage "stateful" ?
a. Une règle qui ne tient compte que des états de connexion
b. Une règle qui analyse l'état de chaque paquet individuellement
c. Une règle qui prend en compte l'état de la connexion (ouverte, fermée, etc.)
d. Une règle basée uniquement sur les adresses IP et les ports

Réponse : **c. Une règle qui prend en compte l'état de la connexion (ouverte, fermée, etc.)**  
*Explication : Une règle de filtrage "stateful" tient compte de l'état de la connexion, permettant une gestion plus dynamique et sécurisée du trafic.*

**Question 12 :**
Quelle est la principale différence entre un pare-feu réseau (NFW) et un pare-feu d'application web (WAF) dans l'environnement Stormshield ?
a. NFW filtre par adresses IP, tandis que WAF filtre par contenu d'application
b. NFW est pour les réseaux internes, WAF est pour les réseaux externes
c. NFW utilise des VLANs, tandis que WAF utilise des DMZ
d. NFW est basé sur le matériel, tandis que WAF est basé sur le logiciel

Réponse : **a. NFW filtre par adresses IP, tandis que WAF filtre par contenu d'application**  
*Explication : Le NFW filtre principalement le trafic basé sur les adresses IP et les ports, tandis que le WAF se concentre sur le filtrage et la protection du contenu spécifique des applications web.*

**Question 13 :**
Dans un environnement Stormshield, à quoi sert un "objet réseau" dans la configuration du pare-feu ?
a. À définir des règles de QoS spécifiques
b. À simplifier la gestion des adresses IP ou des plages d'adresses
c. À surveiller le trafic réseau en temps réel
d. À allouer dynamiquement des adresses IP aux dispositifs

Réponse : **b. À simplifier la gestion des adresses IP ou des plages d'adresses**  
*Explication : Les objets réseau permettent de regrouper et de gérer facilement des adresses IP ou des plages d'adresses dans les règles de filtrage.*

**Question 14 :**
Quelle fonctionnalité est généralement activée par défaut sur un pare-feu Stormshield pour améliorer la sécurité ?
a. NAT dynamique
b. Inspection SSL
c. Détection d'intrusion
d. Filtrage d'URL

Réponse : **c. Détection d'intrusion**  
*Explication : La détection d'intrusion est souvent activée par défaut pour fournir une couche supplémentaire de sécurité contre les menaces non autorisées.*

**Question 15 :**
Dans le contexte d'un pare-feu Stormshield, qu'est-ce que le "masquerading" ?
a. Masquer l'adresse IP de destination d'un paquet
b. Traduction d'adresses pour masquer les adresses IP internes
c. Cryptage des paquets pour la confidentialité
d. Modification des en-têtes de paquets pour la sécurité

Réponse : **b. Traduction d'adresses pour masquer les adresses IP internes**  
*Explication : Le "masquerading" est une forme de NAT qui cache les adresses IP internes derrière une adresse IP publique pour la sécurité et la confidentialité.*

Souhaitez-vous que je continue avec les prochaines questions ?

Voici les 10 questions suivantes pour votre entraînement à l'examen CSNA :

**Question 16 :**
Quel est le but principal du "port mirroring" sur un pare-feu Stormshield ?
a. Augmenter la redondance des ports
b. Dupliquer le trafic pour l'analyse
c. Répartir le trafic entre plusieurs ports
d. Basculer le trafic en cas de défaillance d'un port

Réponse : **b. Dupliquer le trafic pour l'analyse**  
*Explication : Le "port mirroring" est utilisé pour copier le trafic d'un port à un autre pour l'analyse ou le débogage.*

**Question 17 :**
Dans un VPN IPsec, que signifie une "SA" (Security Association) ?
a. Un accord sur les paramètres de sécurité entre les dispositifs
b. Une association d'utilisateurs sécurisée pour l'accès VPN
c. Un accord de service entre l'entreprise et le fournisseur VPN
d. Une association spéciale pour les règles de pare-feu

Réponse : **a. Un accord sur les paramètres de sécurité entre les dispositifs**  
*Explication : Dans un VPN IPsec, une SA est un accord entre deux dispositifs réseau sur les paramètres de sécurité à utiliser pour la communication.*

**Question 18 :**
Quelle est la principale fonction d'un "serveur proxy" sur un pare-feu Stormshield ?
a. Rediriger toutes les demandes Internet
b. Filtrer et contrôler l'accès à Internet
c. Assigner des adresses IP dynamiques
d. Crypter le trafic sortant

Réponse : **b. Filtrer et contrôler l'accès à Internet**  
*Explication : Un serveur proxy sur un pare-feu sert à filtrer et à contrôler l'accès au contenu sur Internet.*

**Question 19 :**
Comment un pare-feu Stormshield gère-t-il le trafic IPv6 par rapport à IPv4 ?
a. Il traite uniquement le trafic IPv4
b. Il gère séparément IPv6 et IPv4
c. Il convertit IPv6 en IPv4
d. Il n'accepte pas le trafic IPv6

Réponse : **b. Il gère séparément IPv6 et IPv4**  
*Explication : Les pare-feu Stormshield sont capables de gérer le trafic IPv6 et IPv4 séparément, permettant ainsi une sécurité flexible sur les deux protocoles.*

**Question 20 :**
Qu'est-ce qu'un "cluster" dans le contexte des pare-feu Stormshield ?
a. Un ensemble de règles de filtrage
b. Un groupe de pare-feu travaillant ensemble
c. Un ensemble de serveurs protégés par le pare-feu
d. Une collection de signatures d'intrusion

Réponse : **b. Un groupe de pare-feu travaillant ensemble**  
*Explication : Un "cluster" dans ce contexte est un groupe de pare-feu configurés pour travailler ensemble, améliorant la redondance et la disponibilité.*

**Question 21 :**
Dans Stormshield, que signifie un "profil de sécurité" ?
a. Un ensemble de règles de pare-feu
b. Les paramètres de configuration d'un utilisateur
c. Un ensemble de paramètres de sécurité appliqués à une politique
d. La configuration de base du pare-feu

Réponse : **c. Un ensemble de paramètres de sécurité appliqués à une politique**  
*Explication : Un profil de sécurité est un ensemble de paramètres de sécurité qui peuvent être appliqués à une ou plusieurs politiques de pare-feu.*

**Question 22 :**
Pourquoi utiliserait-on le "routage basé sur les politiques" (PBR) dans un pare-feu Stormshield ?
a. Pour rediriger le trafic en fonction de l'adresse IP de destination
b. Pour augmenter la vitesse de traitement du pare-feu
c. Pour rediriger le trafic en fonction de règles spécifiques autres que l'adresse de destination
d. Pour définir des routes statiques vers des destinations spécifiques

Réponse : **c. Pour rediriger le trafic en fonction de règles spécifiques autres que l'adresse de destination**  
*Explication : Le PBR permet de rediriger le trafic en fonction de critères spécifiques tels que le type de protocole, le port ou d'autres attributs de trafic.*

**Question 23 :**
Quel type de NAT est typiquement utilisé pour permettre

 à de multiples dispositifs dans un réseau privé d'accéder à Internet via une seule adresse IP publique ?
a. NAT statique
b. NAT dynamique
c. NAT Overload (PAT)
d. NAT réfléchi

Réponse : **c. NAT Overload (PAT)**  
*Explication : Le NAT Overload, aussi appelé PAT (Port Address Translation), permet à de nombreux dispositifs d'utiliser une seule adresse IP publique en assignant des ports uniques à chaque session de communication.*

**Question 24 :**
Dans Stormshield, quel est le rôle d'une "politique de filtrage local" ?
a. Contrôler le trafic passant par le pare-feu
b. Appliquer des règles de sécurité au trafic sortant du pare-feu
c. Filtrer le trafic entrant dans le réseau local
d. Définir des règles spécifiques pour les dispositifs locaux

Réponse : **b. Appliquer des règles de sécurité au trafic sortant du pare-feu**  
*Explication : Les politiques de filtrage local sont utilisées pour contrôler et sécuriser le trafic sortant du pare-feu lui-même.*

**Question 25 :**
Qu'est-ce qu'une "signature IPS" dans un pare-feu Stormshield ?
a. Un identifiant unique pour chaque utilisateur
b. Un modèle de trafic spécifique utilisé pour détecter les menaces
c. La certification digitale du pare-feu
d. Un code pour identifier les versions de firmware

Réponse : **b. Un modèle de trafic spécifique utilisé pour détecter les menaces**  
*Explication : Une signature IPS est un modèle ou un ensemble de règles utilisé par le système de prévention d'intrusion pour identifier et bloquer les menaces spécifiques.*

Voulez-vous que je continue avec les prochaines 10 questions ?

Parfait, voici les 10 questions suivantes pour votre entraînement :

**Question 26 :**
Quelle est la fonction d'une "liste d'accès" dans un pare-feu Stormshield ?
a. Définir les utilisateurs autorisés à accéder au pare-feu
b. Énumérer les sites Web autorisés ou bloqués
c. Spécifier des règles de contrôle d'accès pour le trafic réseau
d. Lister les appareils autorisés sur le réseau

Réponse : **c. Spécifier des règles de contrôle d'accès pour le trafic réseau**  
*Explication : Une liste d'accès spécifie des règles qui permettent ou refusent le trafic en fonction de critères définis.*

**Question 27 :**
Quel est le principal avantage de l'utilisation du protocole LDAP avec un pare-feu Stormshield ?
a. Il chiffre tout le trafic passant par le pare-feu
b. Il permet l'intégration avec les systèmes de gestion d'identité
c. Il augmente la vitesse du pare-feu
d. Il est utilisé pour la configuration à distance du pare-feu

Réponse : **b. Il permet l'intégration avec les systèmes de gestion d'identité**  
*Explication : LDAP permet d'intégrer le pare-feu avec des systèmes de gestion d'identité pour une authentification et une autorisation centralisées.*

**Question 28 :**
Dans un pare-feu Stormshield, que signifie le terme "full logging" ?
a. Enregistrer uniquement les tentatives de connexion réussies
b. Enregistrer toutes les activités passant par le pare-feu
c. Enregistrer uniquement les alertes de sécurité
d. Enregistrer les configurations de pare-feu

Réponse : **b. Enregistrer toutes les activités passant par le pare-feu**  
*Explication : "Full logging" signifie enregistrer toutes les activités, y compris les tentatives de connexion réussies et échouées, pour une analyse détaillée.*

**Question 29 :**
Quelle caractéristique est spécifique aux pare-feu de nouvelle génération (NGFW) comme Stormshield ?
a. Filtrage basé uniquement sur les ports et protocoles
b. Inspections de paquets stateful et stateless
c. Intégration de fonctionnalités avancées comme l'IPS et le contrôle d'applications
d. Aucune capacité de filtrage Web

Réponse : **c. Intégration de fonctionnalités avancées comme l'IPS et le contrôle d'applications**  
*Explication : Les NGFW intègrent des fonctionnalités avancées telles que l'IPS, le contrôle d'applications et parfois le filtrage de contenu.*

**Question 30 :**
Quelle méthode est utilisée par les pare-feu Stormshield pour assurer la continuité de service ?
a. Redondance de matériel uniquement
b. Basculement automatique (failover)
c. Duplication de toutes les sessions de trafic
d. Utilisation exclusive de composants non échouables

Réponse : **b. Basculement automatique (failover)**  
*Explication : La redondance et le basculement automatique sont utilisés pour maintenir la continuité de service en cas de défaillance d'un composant.*

**Question 31 :**
Comment un pare-feu Stormshield gère-t-il les mises à jour des signatures IPS ?
a. Manuellement par l'administrateur réseau
b. Automatiquement à partir d'un serveur central
c. À travers des mises à jour de firmware régulières
d. Par téléchargement à partir d'un site Web dédié

Réponse : **b. Automatiquement à partir d'un serveur central**  
*Explication : Les mises à jour des signatures IPS sont généralement automatiques, téléchargées à partir d'un serveur central pour maintenir le système à jour.*

**Question 32 :**
Qu'est-ce qu'un "Virtual IP" (VIP) dans un pare-feu Stormshield ?
a. Une IP assignée à un utilisateur spécifique
b. Une adresse IP utilisée pour le NAT
c. Une adresse IP réservée pour l'administration du pare-feu
d. Une IP utilisée pour la haute disponibilité

Réponse : **b. Une adresse IP utilisée pour le NAT**  
*Explication : Un VIP est souvent utilisé dans le cadre du

 NAT pour rediriger le trafic vers une adresse IP spécifique dans le réseau interne.*

**Question 33 :**
Pourquoi utiliserait-on un VPN SSL avec un pare-feu Stormshield ?
a. Pour accélérer le trafic réseau
b. Pour crypter les communications entre le client et le réseau
c. Pour bloquer tout le trafic non chiffré
d. Pour augmenter la bande passante disponible

Réponse : **b. Pour crypter les communications entre le client et le réseau**  
*Explication : Un VPN SSL est utilisé pour sécuriser les communications entre un client distant et le réseau de l'entreprise en cryptant le trafic.*

**Question 34 :**
Quel est l'objectif de l'authentification multifacteur (MFA) dans un environnement de pare-feu Stormshield ?
a. Réduire la complexité de la gestion des mots de passe
b. Accroître la sécurité en vérifiant l'identité de l'utilisateur par plusieurs moyens
c. Permettre aux utilisateurs de choisir plusieurs mots de passe
d. Diminuer le temps nécessaire pour se connecter au réseau

Réponse : **b. Accroître la sécurité en vérifiant l'identité de l'utilisateur par plusieurs moyens**  
*Explication : L'MFA augmente la sécurité en nécessitant plusieurs formes de vérification pour authentifier un utilisateur.*

**Question 35 :**
Dans un pare-feu Stormshield, que signifie le "filtrage basé sur le contexte" ?
a. Filtrer le trafic en fonction de l'heure de la journée
b. Filtrer le trafic en fonction de l'utilisateur ou du groupe
c. Filtrer le trafic en fonction de la localisation géographique
d. Filtrer le trafic en fonction du type d'application

Réponse : **b. Filtrer le trafic en fonction de l'utilisateur ou du groupe**  
*Explication : Le filtrage basé sur le contexte prend en compte l'identité de l'utilisateur ou du groupe pour appliquer des politiques de sécurité.*



