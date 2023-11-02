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



