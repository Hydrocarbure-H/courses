# Réseaux Convergents

# Introduction

## Définition

Un réseau covergent permet de faire coexister différents types de trafic sur un même réseau IP […].

- **Intégration des services** : Transition de différents types de trafic (voix, vidé, data..)
- **Utilisation efficace des ressources** : Réduction des coût par optimisation.
- **Qualité de service** : Avec l'utilisation d'un ensemble de capteur, permettant de capturer des traces d'erreurs etc.

### Réseaux informatiques

![image-20230915135214319](./assets/image-20230915135214319.png)

### Réseaux étendus

**Définition : ** Un réseau étendu est un réseau de communication de données qui fonctionne au-delà de la portée géographique d’un réseau local.	

![image-20230915135236619](./assets/image-20230915135236619.png)

###    WAN

 ![Wide Area Network](./assets/image-20230915135940333.png)

## Avantages et inconvénients

### xDSL

![ADSL, dégroupage et services IP](./assets/juillet04.gif)

![image-20230915145807268](./assets/image-20230915145807268.png)

#### Client ADSL

- La machine que l'abonné connecte à l'internet. Peu importent la plate forme matérielle et le système

d'exploitation, pourvu que ce dernier supporte le réseau TCP/IP.

![image-20231124144310431](./assets/image-20231124144310431.png)

#### Modem

- Modulateur/Démodulateur. Une boîte dont la fonction est assez similaire à celle du modem RTC, à part

qu'ici, elle est conçue pour la technologie DSL.

#### DSLAM

- Digital Subscriber Line Access Multiplexer. C'est une sorte d'entonnoir ou de gouttière, qui ramasse les flux

numériques de chaque abonné et les fait converger par multiplexage sur un seul lien à fort débit.

#### BAS

- Broadband Access Server

- Lorsque l'on a réussi une connexion avec son FAI, on a établi un lien PPP (Point to Point Protocol) entre son ordinateur et le BAS. Ce lien PPP va transporter les protocoles supérieurs IP, TCP, UDP, ICMP...

C'est au niveau du BAS que l'authentification du client va se faire et que les paramètres IP vont être transmis (serveur RADIUS, généralement).

#### Routeur

- C'est l'équipement qui va assurer la liaison entre le BAS et le réseau du fournisseur d'accès.

- Le lien n°4 relie le BAS à ce routeur et les données circulent dans un tunnel de type L2TP (Layer 2 Tunnel Protocol). Il s'agit de construire un VPN (Virtual Private Network : réseau privé virtuel) entre le BAS et le réseau du fournisseur d'accès.

# Cheat Sheet Cisco

## Configuration statique

On possède l'infrastructure suivante :

![image-20231013105223147](./assets/image-20231013105223147.png)

Les subnets à créer sont les suivants :

![image-20231013105354886](./assets/image-20231013105354886.png)

Le subnet 0 n'est pas utilisé, le subnet 1 est pour les HeadQuarters, le subnet 2 est pour le WAN HeadQuarter - Agence et le subnet 3 est pour l'agance. L'utilisation d'un /26 nous donnant donc la possibilité d'utiliser 62 hôtes hors Broadcast et Network Address.



# Routage

Utilisation d'un routeur contre un switch permet de router les paquets d'un réseau à un autre en fonction d'une adresse IP. A chaque interface réseau d'un routeur est assignée une adresse IP.

Le protocole de routage utilisé va faire varier comment sera choisi le prochain routeur.

![image-20231124144731191](./assets/image-20231124144731191.png)

Le prochain routeur est choisi en fonction d'une table de routage, qui contient les prochains HOP à faire pour atteindre un autre réseau.

La table de routage contient les adresse réseaux de destination, les adresses des passerelles et l'interface de sortie.

![image-20231124144947088](./assets/image-20231124144947088.png)



![image-20231124144926241](./assets/image-20231124144926241.png)

Lorsqu'un chemin n'est pas dans la table de routage de façon explicite, on utilise la passerelle par défaut.

- **Routage statique**

Les tables de routage sont mises à jour manuellement à chaque modification de la structure du réseau.

![image-20231124145303485](./assets/image-20231124145303485.png)

- **Routage dynamique**

Les tables de routage sont mises à jour automatiquement selon le protocole chois (RIP, OSPF, etc.). A cet instant, le meilleur chemin est déterminé par un algorithme :

- RIP - Bellman
- OSPF - Dijkstra

Le `Distance Vector` transmet les tables de routage reçues de ses voisins à ses voisins immédiats et fusionne la sienne avec celles reçues.

Le `Link State` transmet les tables de routage à ses voisins immédias et retransmet les informations reçues des ses voisins à ses autres voisins. Puis, calcule sa table de routage.

---

Distance administrative définit la préférence d'une source de routage. Pour chaque route une valeur de 0 à 255 est attribuée. Plus la valeur est faible, plus la rotue est privilégiée.

## OSPF - Open Shortest Path First

RFC 1247 - 1583

L'algotihme est dynamique, s'adapte aux changements de topoligie du réseau. Le routage est accepté par type de service (traitemment du champ service du datagramme IP).

Un état de liens dans OSPF est une description de l’interface d’un routeur avec les éléments suivants :

- Son adresse IP

- Son masque

- Le type de réseau

- Son voisin (un routeur)

- L’ensemble des liens OSPF est enregistré dans une base de données appelée link-state database, qui est identique sur tous les routeurs d’une même aire.

Le routage fonctionne avec la création d'areas étant un ensemble de réseaux contigues. Chaque ensemble de réseaux ne connaît que sa propre zone.

Cet aspect permet de ne pas avoir besoin de reconstruire toutes les tables à chaque changement dans une zone. Intéressant également sur le point de vue des performances CPU/RAM.

## MPLS - Multi Protocol Label Switching

Les intérêts de cette technologie est que le routage se fait à l'entrée du réseau, et que le coeur de réseau est plus rapide.

Le réseau "interne" est composé de commutateurs et de routeurs, et l'intelligence du routage se fait à l'extérieur. L'extérieur, ce sont les labels (?).

![image-20231124151359664](./assets/image-20231124151359664.png)

Fait intervenir la QoS dans le routage, simplifie le fonctionnement par l'absence de superposition et de cumul des technologies.

### Fonctionnement

LSP (Label Switch Path), les chemis prédéfinis relient les extrémités du réseau. Un LSP est unidirectionnel. Les équipements MPLS sont nommés LSR pour Label Switch Router.

1. À l'entrée du réseau, le premier LSR insère un label devant le paquet IP. 
   ![image-20231124152644878](./assets/image-20231124152644878.png)
2. Le paquet est ensuite redirigé en fonction du label.
   ![image-20231124152746826](./assets/image-20231124152746826.png)

3. Le LSR de sortie retire le label.
   ![image-20231124152814902](./assets/image-20231124152814902.png)
4. Le paquet est ensuite routé selon le fonctionnement IP traditionnel.

![MPLS - Exposé NT réseaux](https://external-content.duckduckgo.com/iu/?u=http%3A%2F%2Figm.univ-mlv.fr%2F~dr%2FXPOSE2006%2Fmarot%2Fimages%2Fmpls_term.png&f=1&nofb=1&ipt=1f2468bf739d41542fda8a8bab5343f33ef139e2a98362e05742112382cd6bea&ipo=images)

- **MPLS** Multiple Protocol Label Switching;

- **iLER** ingress Label Edge Router (routeur d’entrée)

- **eLER** egress Label Edge Router 

Il est également possible d'empiler les lables pour permettre un traffic tunneled au travers de plusieurs réseaux.

![image-20231124152233569](./assets/image-20231124152233569.png)

Le **LSP** est l'ensemble des équipements touchés entre les deux E-LSR.

Le MPLS permet la simplification du coeur de réseau, l'utilisation de plusieurs services et protocoles différents et est indépendant du protocole utilisé dans la couche 2.

Un label peut signifier plusieurs choses, un chemin, une source, une destination, une application ou un QoS.

# Fiches

# Routage

### Routage Statique

- **Définition** : Le routage statique implique la configuration manuelle des itinéraires dans un routeur. Ces itinéraires ne changent pas à moins d'une intervention manuelle.
- **Utilisation** : Souvent utilisé dans des réseaux plus petits ou pour des chemins spécifiques nécessitant un contrôle constant.
- **Avantages** : Simplicité, contrôle, moins de surcharge de bande passante.
- **Inconvénients** : Manque de flexibilité, difficile à gérer dans de grands réseaux.

### Routage Dynamique

- **Définition** : Le routage dynamique utilise des protocoles qui permettent aux routeurs de communiquer entre eux pour adapter automatiquement les itinéraires en fonction des changements dans le réseau.
- **Protocoles de Routage** : OSPF, EIGRP, BGP sont quelques exemples de protocoles de routage dynamique.
- **Avantages** : Flexibilité, adaptabilité aux changements de réseau, échelle bien avec la taille du réseau.
- **Inconvénients** : Plus complexe, nécessite plus de ressources de traitement.

### Protocoles de Routage Dynamique

- **OSPF (Open Shortest Path First)** : Un protocole de routage basé sur l'état des liens utilisé dans les grands réseaux IP internes.
  - **Fonctionnement** : OSPF est un protocole de routage interne basé sur l'état des liens.
  - **Principe** : OSPF utilise une méthode de diffusion des informations sur l'état des liens à tous les routeurs dans une zone. Chaque routeur construit ensuite une carte topologique du réseau et détermine le chemin le plus court vers chaque destination.
- **BGP (Border Gateway Protocol)** : Utilisé pour le routage entre différents réseaux autonomes sur Internet.
  - **Fonctionnement** : BGP est utilisé pour le routage entre différents systèmes autonomes (AS) sur Internet.
  - **Principe** : BGP établit des sessions TCP avec des routeurs voisins pour échanger des informations de routage, sélectionnant le meilleur chemin en fonction de divers attributs comme la distance, la politique du réseau, etc.

### Routage dans les Réseaux 4G et 5G

- **Importance** : Le routage dynamique est essentiel dans les réseaux mobiles 4G et 5G pour gérer efficacement les chemins dans un environnement en constante évolution.
- **Application** : Les protocoles de routage dynamique permettent une gestion optimisée du trafic et une meilleure qualité de service dans les réseaux mobiles.

# Réseaux d'Accès et Mobiles : 4G et 5G

#### 1. Introduction aux Réseaux Mobiles

- **Évolution** : Transition de la 2G à la 5G, marquant des avancées significatives en termes de vitesse, de capacité et de services.
- **Rôle** : Fournir une connectivité sans fil pour une variété d'applications, de la voix à l'internet haut débit.

#### 2. Technologie 4G

- **Définition** : La 4G, ou quatrième génération, est conçue pour offrir des vitesses de données plus élevées et une meilleure efficacité du spectre.
- **Caractéristiques clés** : Haut débit, latence réduite, support pour les services multimédias.
- **Architecture** : Comprend les éléments de l'Evolved UMTS Terrestrial Radio Access Network (E-UTRAN) et le System Architecture Evolution (SAE).
- **Normes** : LTE (Long Term Evolution) est la norme la plus répandue pour la 4G.

#### 3. Technologie 5G

- **Définition** : La 5G est la dernière génération de technologie mobile, offrant des vitesses de données encore plus élevées, une latence ultra-faible et une capacité massive.
- **Caractéristiques clés** : Connectivité massive pour l'IoT, faible latence pour les applications en temps réel, haut débit mobile.
- **Architecture** : Utilise des technologies telles que les réseaux de petites cellules, MIMO (multiple-input multiple-output) et le spectre en ondes millimétriques.
- **Applications** : Idéal pour des applications telles que la réalité augmentée/virtuelle, l'IoT, les véhicules autonomes.

#### 4. Différences entre 4G et 5G

- **Vitesse et Capacité** : 5G offre des vitesses nettement plus élevées et peut supporter un plus grand nombre de dispositifs connectés simultanément.
- **Latence** : La 5G a une latence beaucoup plus faible que la 4G, essentielle pour des applications sensibles au temps.
- **Applications** : Alors que la 4G a révolutionné le streaming mobile et l'accès à Internet, la 5G ouvre la voie à des applications plus avancées et diversifiées.

## IPv6

**Caractéristiques Principales d'IPv6 :**

- **Adressage étendu** : IPv6 utilise des adresses de 128 bits, offrant une quantité quasi-illimitée d'adresses IP, résolvant ainsi le problème de la pénurie d'adresses IP dans IPv4.
- **Simplification de l'en-tête** : L'en-tête d'IPv6 est plus simple que celui d'IPv4, ce qui améliore l'efficacité du traitement des paquets.
  - **Exemple** : En IPv6, les champs comme le checksum et les options d'acheminement, présents dans IPv4, sont éliminés ou optionnels, réduisant ainsi la complexité du traitement.
- **Prise en charge de l'autoconfiguration** : IPv6 permet aux dispositifs de configurer automatiquement leur propre adresse IP.
- **Meilleure sécurité** : IPv6 intègre des fonctionnalités de sécurité comme IPSec, qui n'était qu'optionnelle dans IPv4.
  - **Exemple** : IPSec dans IPv6 permet l'authentification et le chiffrement de bout en bout, offrant une sécurité renforcée pour des données sensibles comme les transactions bancaires en ligne.
- **Meilleur support pour QoS (Quality of Service)** : IPv6 permet une meilleure gestion de la qualité de service, ce qui est crucial pour le trafic multimédia et les applications en temps réel.
  - **Exemple** : Pour une vidéoconférence, IPv6 priorise les paquets vidéo et audio, assurant une transmission fluide sans délai perceptible.

**Transition de IPv4 à IPv6 :**
La transition de IPv4 à IPv6 est un processus complexe et progressif. Elle implique plusieurs stratégies :

- **Dual Stack** : Fonctionnement simultané d'IPv4 et d'IPv6.
- **Tunnelling** : Encapsulation des paquets IPv6 dans des paquets IPv4 pour le transit sur des réseaux IPv4.
- **Traduction d'adresses** : Traduction entre les adresses IPv4 et IPv6.

**IPv6 dans les Réseaux d'Accès et Mobiles (4G/5G) :**

- Dans les réseaux 4G et 5G, IPv6 joue un rôle crucial en permettant une multitude de dispositifs connectés (IoT, mobiles, etc.).
- Il facilite la gestion des adresses dans des réseaux de plus en plus denses et hétérogènes.

**Routage avec IPv6 :**

- Les protocoles de routage tels que OSPFv3 et BGP sont adaptés pour prendre en charge IPv6.
- IPv6 implique des changements dans les stratégies de routage et de distribution des adresses.

**Défis et Perspectives :**

- La migration complète vers IPv6 est encore un processus en cours dans de nombreux réseaux.
- IPv6 ouvre la voie à des innovations en matière de connectivité et de services réseau.

Cette synthèse offre une vue d'ensemble des éléments clés d'IPv6, en s'appuyant sur les informations fournies dans vos documents. Pour une compréhension approfondie, il est important de se référer aux documents originaux et aux études supplémentaires sur le sujet.

# Cisco

### TP 1 : Configuration Basique
1. **`enable`** : Passer en mode privilégié.
2. **`configure terminal`** : Entrer en mode de configuration.
3. **`interface [type][numéro]`** : Accéder à l'interface pour la configuration.
4. **`ip address [adresse IP] [masque de sous-réseau]`** : Attribuer une adresse IP à l'interface.
5. **`no shutdown`** : Activer l'interface.

### TP2 : OSPF et RIPV2

#### Commandes pour OSPF
1. **`router ospf [ID]`** : Active OSPF et entre en mode configuration OSPF.
2. **`network [adresse] [masque inverse] area [numéro]`** : Ajoute un réseau à OSPF.
3. **`passive-interface [interface]`** : Empêche l'envoi de mises à jour OSPF sur l'interface.
4. **`no passive-interface [interface]`** : Active l'envoi de mises à jour OSPF.
5. **`area [numéro] range [adresse réseau] [masque]`** : Regroupe des réseaux dans une même area.
6. **`default-information originate`** : Génère une route par défaut dans OSPF.
7. **`show ip ospf neighbor`** : Affiche les informations sur les voisins OSPF.
8. **`show ip ospf interface`** : Affiche les détails des interfaces OSPF.
9. **`clear ip ospf process`** : Réinitialise le processus OSPF.
10. **`ip ospf priority [valeur]`** : Définit la priorité OSPF de l'interface.

#### Commandes pour RIPV2
1. **`router rip`** : Active RIP.
2. **`version 2`** : Sélectionne la version 2 de RIP.
3. **`network [adresse]`** : Ajoute un réseau à RIP.
4. **`passive-interface [interface]`** : Empêche l'envoi de mises à jour RIP sur l'interface.
5. **`no passive-interface [interface]`** : Active l'envoi de mises à jour RIP.
6. **`default-information originate`** : Génère une route par défaut dans RIP.
7. **`show ip rip database`** : Affiche la base de données RIP.
8. **`clear ip route *`** : Efface la table de routage.
9. **`debug ip rip`** : Active le débogage RIP.
10. **`no debug ip rip`** : Désactive le débogage RIP.

### TP IPv6 et DHCPv6 : Configuration IPv6 et DHCPv6

1. **`ipv6 unicast-routing`** : Activer le routage IPv6.
2. **`ipv6 address [adresse IPv6]`** : Attribuer une adresse IPv6 à l'interface.
3. **`ipv6 dhcp pool [nom]`** : Créer un pool DHCPv6.
4. **`dns-server [adresse DNS]`** : Définir le serveur DNS dans le pool DHCPv6.
5. **`ipv6 dhcp server [nom pool]`** : Associer le pool DHCPv6 à l'interface.
