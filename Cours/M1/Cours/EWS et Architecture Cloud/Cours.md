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