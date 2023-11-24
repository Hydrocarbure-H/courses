# AWS et Architecture Cloud

# Cloud Computing

**On Demand Cloud Service**

L'utilisateur peut, quand il en a besoin, provisionner ou modiffier de la puissance informatique.

**Broad Network Access**

Toutes ces possibilités sont disponibles à travers un réseau par des mácanismes standards depuis des postes hétérogènes.

**Resource pooling**

Les ressources informatiques sont regroupées pour plusieurs utilisateurs de différentes sociétés assignées dynamiquement et réassignées selon la demande.

**Rapid Elasticity**

Les capacités informqtiques peuvent être provisionnées ou dé-prévisionnées automatiquement le plus souvent.

**Measured Service**

-- Notes manquantes -- 

1. **Cloud Privé :**

   - Propriété et gestion : Un cloud privé est géré et détenu par une seule organisation, ce qui signifie que l'entreprise contrôle l'ensemble de l'infrastructure cloud.
   - Isolation : Les ressources cloud d'un cloud privé sont dédiées exclusivement à l'organisation cliente, ce qui garantit une isolation complète par rapport aux autres utilisateurs.
   - Sécurité et conformité : Les entreprises ont un contrôle total sur la sécurité et la conformité de leurs données et applications dans un cloud privé, ce qui peut être essentiel pour les industries soumises à des réglementations strictes.
   - Coût : Les coûts de mise en place et de gestion d'un cloud privé sont généralement plus élevés que ceux d'autres modèles en raison de la nécessité d'acquérir et de maintenir l'infrastructure.

2. **Cloud Public :**

   - Propriété et gestion : Dans un cloud public, les ressources informatiques sont détenues et gérées par un fournisseur de services cloud tiers, comme Amazon Web Services (AWS), Microsoft Azure ou Google Cloud Platform (GCP).
   - Partage : Les ressources sont partagées entre de multiples clients, ce qui permet une utilisation plus économique des infrastructures, mais peut entraîner une moins grande isolation.
   - Évolutivité : Les services cloud publics sont hautement évolutifs, ce qui signifie que les clients peuvent augmenter ou réduire rapidement leurs ressources en fonction de leurs besoins.
   - Coût : Les coûts de fonctionnement d'un cloud public sont généralement basés sur l'utilisation réelle, ce qui peut être plus rentable pour de nombreuses organisations.

3. **Cloud Communautaire :**

   - Propriété et gestion : Le cloud communautaire est partagé par plusieurs organisations appartenant à un même secteur ou à une même communauté spécifique, comme une industrie ou une organisation gouvernementale.
   - Partage limité : Bien que les ressources soient partagées, le cloud communautaire offre une plus grande isolation et une meilleure sécurité que le cloud public, car les organisations participantes ont souvent des besoins similaires en matière de sécurité et de conformité.
   - Coopération : Les organisations au sein d'un cloud communautaire collaborent souvent pour élaborer des politiques de sécurité et de conformité communes.
   - Coût : Les coûts sont généralement partagés entre les organisations membres, ce qui peut rendre le cloud communautaire plus économique que le cloud privé.

4. **Cloud Hybride** :

   Bien sûr, le cloud hybride est un autre modèle de cloud computing qui mérite d'être mentionné, car il combine des éléments du cloud privé et du cloud public pour offrir une solution plus flexible et adaptée aux besoins changeants des organisations. Voici ce qu'il faut savoir sur le cloud hybride :

   Cloud Hybride :

   - Combinaison : Le cloud hybride intègre à la fois des ressources informatiques locales (sur site, généralement dans les locaux de l'entreprise) et des ressources cloud (privées ou publiques). Cela permet aux entreprises de conserver certaines données et applications sensibles sur site tout en utilisant le cloud pour des charges de travail moins critiques ou pour éviter de surcharger leur infrastructure locale.
   - Flexibilité : Le cloud hybride offre une grande flexibilité, permettant aux organisations de déplacer des charges de travail entre le cloud privé et le cloud public en fonction des besoins. Cela peut être particulièrement utile pour faire face à des pics de demande temporaires ou pour répondre à des exigences de conformité spécifiques.
   - Isolation et contrôle : Les entreprises ont un contrôle total sur les ressources locales dans un cloud hybride, ce qui peut être essentiel pour les données sensibles ou les réglementations strictes. En même temps, elles peuvent profiter de l'évolutivité et de la rentabilité du cloud public pour d'autres charges de travail.
   - Gestion centralisée : Un avantage clé du cloud hybride est la possibilité de gérer l'ensemble de l'infrastructure, y compris les ressources locales et cloud, à partir d'une console de gestion centralisée.
   - Complexité : La gestion d'un environnement de cloud hybride peut être plus complexe que celle d'un seul modèle cloud. Il nécessite une planification, une intégration et une gestion soignées pour s'assurer que toutes les composantes fonctionnent de manière transparente.

Le choix entre un cloud privé, un cloud public ou un cloud communautaire dépend des besoins spécifiques de chaque organisation en matière de sécurité, de conformité, d'évolutivité et de coûts. Certaines entreprises optent même pour une approche de cloud hybride, qui combine plusieurs de ces modèles pour répondre à différents besoins.

## 3 modèles de services

### SaaS - Software as a Service

### PaaS - Platform as a Service

C'est une plateforme complète de développement et de déploiement pour les applications en mode SaaS et services Web.

- Conception, intégration de web services, développement, test, versionning...
- Gestion des instances, scalable sur demande, gestion, monitoring..

# Docker

![Docker vs Virtual Machines (VMs) : A Practical Guide to Docker Containers  and VMs](./assets/containers-vs-virtual-machines.jpg)

![Containerized Neo4j: Automating Deployments with Docker on Azure](./assets/linux-container-ecosystem-3922385.png)

### Ecosysteme Kubernetes

![CNCF Cloud Native Interactive Landscape visual](./assets/cncf-landscape-map-2020.jpg)

## Nouveaux modèles de services

![Hébergement cloud Kubernetes - Datailor, solution Devops sur mesure.](./assets/herbergement-cloud-datailor.jpg)

## FaaS - Serverless

Stands for Function as a Service.

Le principe du serverless conciste à déclencher la fonction requise à la demande via un céclencheur logiciel.

Le principal bénéfice du FaaS cnciste à permettre la scalabilité à zéro !

Ce mode de fonctionnement est particulièrement intéressant en termes de coût vis à vis des cloud providers et en terme d'optimisation des ressources en cloud privé.

# Principaux acteurs du marché

## Gartner Magic Quadrant

En 2017 : ![gartner-iaas-magic-quadrant.png](./assets/gartner-iaas-magic-quadrant.jpeg)

C'est durant cette année que les premiers acteurs chinois ont fait leur apparition.

## Amazon Web Services

En 2006, démarrage de la propositions de différents services web pour différentes entreprises.

En 2017, premier datacenter d'AWS en France.

Propose plus de 200 services. Problème principal : Prix.

### Interface de gestion

Utilise le concept du moindre privilège.

**Prochain cours :** Présentation des différents services

### Comparaison des architectures on-premises et AWS (IaaS)

![AWS Technical Essentials – Module 1: Introduction & History of AWS (Part 2)  – DevOps24h](./assets/43777130035_8a953e4dd7_h.jpg)

## Accounting

Comte root - Compte de gestion pour une activité spécifique.

- Permet de créer plusieurs comptes
- Contient une @mail et un pwd.

![AWS Root Account Best Practices | Logicata](./assets/image1-2.png)

![AWS Root User Considerations | ACAI Consulting](./assets/RootUserMetamodel-1024x770.jpg)

**SLA** - Service Level Agreement : Niveau de sécurité qui va être établi pour protéger le contenu des données.

### Composants fondamentaux

#### Les services réseaux

**VPC :** - Virtual Private Cloud 

- Provisionne un réseua (privé, virtuel, isolé)
- Permet d'avoir le contrôle complet sur lénvironnement virtual du réseau de votre cloud privé.

Le subnet d'un VPC permet le lancement de resources AWS au sein d'un sous-réseau.

![Example: VPC with servers in private subnets and NAT - Amazon Virtual  Private Cloud](./assets/vpc-example-private-subnets.png)

Il est possible de faire du VPC peering.

![Transitive Routing Overview - DCLessons](./assets/mceu_692259411646725599817.png)

Non transitif, et il sera nécessaire d'avoir des adresses disjoinctes.

## EC2

Les instances EC2 sont des serveurs virtualisés dans les datacenters AWS, ayant un contrôle complet des ressources (redimensionnables).

![Choosing the Right EC2 Instance Type for Your Application | AWS News Blog](./assets/ec2_instance_types_table_1.png)

### Serverless

Site web : créer une nouvelle instance à chaque nouvel utilisateur. Si peu de visites dans le mois, facture basse, sinon haute.

Mais mieux que pratiquement max chaque mois dû à une infra en static bare metal.

Ce qui permet donc aussi d'utiliser la technologie d'autoscaling si jamais le besoin est + ou - important.

## Stockage

1. **Stockage par bloc :**
   - Le stockage par bloc divise un support de stockage en blocs de taille fixe (généralement de quelques kilooctets à plusieurs mégaoctets).
   - Chaque bloc est identifié par une adresse physique unique.
   - Les données sont stockées sans aucune structure de fichier ou de système de fichiers. Les blocs sont simplement des unités de données brutes.
   - Ce type de stockage est couramment utilisé dans les disques durs, les SSD (Solid State Drives) et les systèmes de stockage en réseau (SAN).
   - Il est souvent utilisé dans des environnements qui nécessitent une performance élevée et une gestion fine du stockage, tels que les bases de données.
2. **Stockage par fichiers :**
   - Le stockage par fichiers organise les données en utilisant une structure de système de fichiers. Les fichiers sont des ensembles de données logiquement organisées.
   - Chaque fichier a un nom, un type et une hiérarchie de dossiers qui le place dans une structure arborescente.
   - Les données sont stockées de manière plus conviviale pour les utilisateurs, ce qui permet de les organiser et de les récupérer plus facilement.
   - Ce type de stockage est couramment utilisé dans les systèmes d'exploitation, les serveurs de fichiers, et les services de stockage en réseau tels que le NAS (Network-Attached Storage).
   - Il est adapté aux besoins des utilisateurs et des applications qui gèrent des données de manière plus traditionnelle, comme les documents, les images, les vidéos, etc.

En résumé, la principale différence réside dans la manière dont les données sont organisées. Le stockage par blocs est plus adapté aux applications nécessitant une performance élevée et une gestion fine du stockage, tandis que le stockage par fichiers est plus adapté aux besoins des utilisateurs et des applications qui nécessitent une organisation logique des données en fichiers et dossiers. En pratique, de nombreuses solutions de stockage combinent ces deux approches pour répondre aux différents besoins des utilisateurs et des applications.

## Amazon Simple Stoage Service

1. **S3 Reduced Redundancy Storage (RRS)** :
   - RRS est une classe de stockage qui offre une réduction des coûts par rapport à la classe de stockage Standard en échange d'une réduction légère de la redondance des données.
   - Conçue pour stocker des données non critiques ou répliquées ailleurs, RRS présente un niveau de redondance moindre par rapport à la classe de stockage Standard, ce qui signifie qu'il existe un risque légèrement plus élevé de perte de données.
   - Elle convient aux données qui peuvent être reconstituées facilement en cas de perte.
2. **S3 Standard** :
   - La classe de stockage S3 Standard offre une durabilité élevée des données grâce à la réplication multi-site des données.
   - Les données stockées dans la classe S3 Standard sont conçues pour être accessibles avec une latence faible.
   - Cette classe de stockage convient aux données fréquemment utilisées et aux applications nécessitant un accès rapide aux données.
3. **S3 Standard-IA (Infrequent Access)** :
   - S3 Standard-IA est une classe de stockage conçue pour stocker des données qui ne sont pas fréquemment utilisées, mais qui doivent être accessibles avec une latence relativement faible.
   - Elle offre une réduction des coûts par rapport à la classe de stockage Standard tout en maintenant une durabilité élevée.
   - Convient aux données auxquelles on accède moins fréquemment, mais qui doivent être rapidement disponibles lorsque nécessaire.
4. **S3 Intelligent-Tiering** :
   - S3 Intelligent-Tiering est une classe de stockage qui automatise le déplacement des objets entre les classes de stockage en fonction de leur fréquence d'accès.
   - Il peut basculer automatiquement entre les classes S3 Standard et S3 Standard-IA, offrant ainsi un équilibre entre performance et coût en fonction du comportement d'accès réel des objets.
   - Convient aux cas d'utilisation où les besoins en matière de stockage peuvent varier avec le temps.

# Stockage objet

**Amazon Simple Storage Service - S3** 

> *Amazon Simple Storage Service (Amazon S3) est un service de stockage d'objets qui offre une capacité de mise à l'échelle, une disponibilité des données, une sécurité et des performances de pointe. Les clients de toutes les tailles et de tous les secteurs peuvent stocker et protéger n'importe quelle quantité de données pour la quasi-totalité des cas d'utilisation, par exemple les lacs de données ainsi que les applications natives cloud et mobiles. Grâce à des classes de stockage économiques et à des fonctions de gestion faciles à utiliser, vous pouvez optimiser les coûts, organiser les données et configurer des contrôles d'accès précis pour répondre à des exigences opérationnelles, organisationnelles et de conformité spécifiques.* - **aws.amazon.com**

![Diagramme qui montre comment d&eacute;placer, stocker et analyser les donn&eacute;es avec Amazon S3. D&eacute;crit dans le lien &laquo;&nbsp;Agrandir et lire la description de l'image.&nbsp;&raquo;](./assets/product-page-diagram_Amazon-S3_HIW.cf4c2bd7aa02f1fe77be8aa120393993e08ac86d.png)

**Règle des 3-2-1** : Avoir au moins une sauvegarde hors site.

## Classes de stocages d'objets

- **S3 Standard**
  - Accès performants et fréquents aux données
- **S3 Reduced Redundancy Storage**
  - Non recommandé, classe suivante remplaçante, plus sécurisée et plus performante.
- **S3 Standard infrequent Access**
  - Données longues vies, backups. Moins cher que classe Standard
- **S3 Glacier Instant Retrieval**
  - Archivage de données
  - Aucun accès temps réel
  - Coût très faible

## Stockage Amazon EC2

- Stockage Local : Ephémère sur l'hôte
- Stockage extérieur à l'hôte

# Identity / Access Management

Il existe deux types de policies :

- Resources-based policies
- Users-based policies

