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



Quizz

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

