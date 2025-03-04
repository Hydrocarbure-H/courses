# Infrastructure Cloud

Ces notes de cours ont été réalisées par `Thomas PEUGNET` assisté par `Mistral AI`.

### Mise en place d’une PKI (TP PKI)

- Outils :
  - cfssl / cfssljson pour générer et signer les certificats.
  - multirootca pour publier un service d’émission de certificats en HTTPS.
- Étapes principales :
  1. Création CA racine (root-ca) via `cfssl gencert -initca`.
  2. Création CA intermédiaire signée par la racine (réduit les risques en cas de compromission).
  3. Configuration de profils (host, intermediate…) dans `config.json` pour préciser usages (server auth, client auth, etc.).
  4. Démarrage du service web (multirootca) sur un port (ex. 8000) avec certificat TLS dédié.
  5. Validation : on envoie un CSR (my-cert-request-csr.json) et on récupère un certificat signé.

Points clés à retenir :

- Une CA intermédiaire limite l’exposition de la racine.
- On peut associer un `auth_key` pour protéger le profil et éviter la signature libre.
- Commandes OpenSSL (ex. `openssl x509 -in cert.pem -noout -subject -issuer`) pour vérifier l’émetteur et la date d’expiration.

------

### Tailscale (TP Tailscale)

- Objectif : Créer un VPN maillé (Zero-Trust) entre plusieurs machines sans configurer manuellement un tunnel.
- Installation :
  1. Sur Linux : `curl -fsSL https://tailscale.com/install.sh | sh`
  2. Sur Windows : Installation MSI + `tailscale up --auth-key=...`
- Authentification : On génère une clé (Auth Key) dans l’interface Tailscale et on l’utilise pour joindre chaque machine au réseau.
- Contrôle :
  - `tailscale status` pour lister les nœuds connectés.
  - Ping entre machines via leurs IP Tailscale (ex. `100.x.y.z`) ou via `<hostname>.ts.net`.
- Intérêt :
  - Pas de config de pare-feu compliquée, tout passe par le réseau privé Tailscale.
  - Gestion ACL sur [https://login.tailscale.com](https://login.tailscale.com/).

------

### Gestionnaire d’identités avec Authentik (TP IPDAuthentik)

- But : Déployer un IdP (Identity Provider) pour centraliser l’authentification (SAML, OIDC).
- Installation :
  - Récupération du `docker-compose.yml` depuis goauthentik.io.
  - Configuration d’un `.env` (mot de passe Postgres, clé secrète Authentik, ports HTTP/HTTPS).
- Certificats :
  - Génération d’un certificat pour le FQDN Tailscale via cfssl.
  - Import du certificat privé et public dans Authentik.
- Création de providers :
  - Un provider (par ex. OIDC) pour relier Authentik à des applications externes.
  - Configuration d’applications Authentik → Liaison pour authentification.
- Utilisation dans Kubernetes :
  - Installez `kubectl`, le plugin `oidc-kubelogin` (brew install int128/kubelogin/oidc-kubelogin).
  - Configurez un user OIDC pour interagir avec le cluster en se connectant via Authentik.

------

### MicroK8S + Cozystack (TP ComputeCozystack)

- MicroK8S :
  - Installation via `snap install microk8s --classic`.
  - Activation de services : `microk8s enable dns hostpath-storage`.
  - Alias locaux : `kubectl`, `helm`, etc.
  - Visualisation : k9s pour surveiller les ressources Kubernetes.
- Cozystack :
  - Plateforme simplifiant le déploiement d’applications “as a Service” (gestion de services managés type MySQL, NATS, etc.).
  - Installation : téléchargement `cozystack-installer.yaml` + config d’un NodePort ou Ingress pour y accéder.
  - NodePort : expose un service sur un port statique de chaque nœud.
  - Dashboard : accessible via un token récupéré dans un secret K8S.
- Intégration Tailscale :
  - On peut installer l’opérateur Tailscale (helm chart) pour exposer le cluster sur le mesh Tailscale (remplace partiellement NodePort).
  - Avantage : pas besoin d’ouverture de ports sur l’IP publique, le cluster est accessible via le réseau Tailscale.
- Intégration de la PKI :
  - Déploiement de cert-manager ou de CFSSL-issuer pour que Kubernetes obtienne des certificats signés par la CA intermédiaire.
  - CRD `ClusterIssuer` pointant vers le service CFSSL.

------

### Préparation et organisation (TP Preparation)

- Questions préliminaires :
  - jq / yq : outils pour manipuler et transformer du JSON/YAML en CLI.
  - tmux : terminal multiplexé (sessions persistantes), très utile en SSH.
  - nload : surveillance de la bande passante en temps réel.
- Fiches d’architecture :
  - Fonctionnelle : DSI EFREI fournit les VMs + VPN, PKI sécurise les échanges, IDP gère l’authentification, Cozystack facilite l’orchestration.
  - Technique : description IP, schémas, liaisons entre machines et services (DNS, PKI, Tailscale, etc.).
- Vérifications :
  - htop, nload pour confirmer CPU/RAM/Traffic.
  - Configuration IP contiguë pour la publication de services.
