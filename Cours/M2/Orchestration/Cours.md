# Orchestration

Notes de cours par `Thomas PEUGNET`.

### Kubernetes Cheat Sheet

#### 1. Concepts de Base

- Cluster : Ensemble de nœuds contrôlés par Kubernetes.
- Node : Machine (physique ou virtuelle) dans un cluster.
- Pod : Plus petite unité déployable, contient un ou plusieurs conteneurs.
- Namespace : Isolation logique des ressources dans un cluster.
- Deployment : Contrôle le déploiement des Pods (scaling, rolling updates).
- Service : Expose les Pods à d’autres applications ou au réseau externe.

#### 2. Composants du Cluster

- Control Plane :
  - API Server : Interface RESTful pour interagir avec Kubernetes.
  - etcd : Base de données clé-valeur pour la configuration et l'état du cluster.
  - Scheduler : Planifie les Pods sur les nœuds disponibles.
  - Controller Manager : Contrôleurs pour gérer l’état désiré.
- Node Components :
  - kubelet : Agent sur chaque nœud pour gérer les Pods.
  - kube-proxy : Gère le réseau du cluster.
  - Container Runtime : Exécute les conteneurs (Docker, containerd, etc.).

![Learn About Kubernetes Concepts and Architecture](./assets/kubernetes-constructs-concepts-architecture.jpg)

#### 3. Commandes kubectl Essentielles

```bash
# Informations générales
kubectl cluster-info          # Infos sur le cluster
kubectl get nodes             # Liste des nœuds
kubectl get pods              # Liste des Pods
kubectl get svc               # Liste des Services
kubectl get deployments       # Liste des Deployments

# Débogage
kubectl describe pod <name>   # Infos détaillées sur un Pod
kubectl logs <pod>            # Logs d’un Pod
kubectl exec -it <pod> -- bash # Accès au shell dans un conteneur

# Gestion des ressources
kubectl apply -f <file>.yaml  # Applique une configuration
kubectl delete -f <file>.yaml # Supprime une ressource
kubectl scale deployment <name> --replicas=<num>  # Change le nombre de réplicas

# Namespaces
kubectl get namespaces        # Liste les namespaces
kubectl create namespace <name>  # Crée un namespace
kubectl delete namespace <name>  # Supprime un namespace
```

#### 4. Manifest YAML Exemple

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: my-app
  labels:
    app: my-app
spec:
  replicas: 3
  selector:
    matchLabels:
      app: my-app
  template:
    metadata:
      labels:
        app: my-app
    spec:
      containers:
      - name: my-container
        image: nginx:1.21
        ports:
        - containerPort: 80
---
apiVersion: v1
kind: Service
metadata:
  name: my-service
spec:
  selector:
    app: my-app
  ports:
  - protocol: TCP
    port: 80
    targetPort: 80
  type: ClusterIP
```

#### 5. Objets Principaux

- ConfigMap : Stocke les configurations non sensibles.
- Secret : Stocke les informations sensibles (ex. mots de passe).
- Ingress : Gère l’accès HTTP/HTTPS au cluster.
- PersistentVolume (PV) : Définit un espace de stockage.
- PersistentVolumeClaim (PVC) : Requête pour un PV.

#### 6. Networking

- ClusterIP : Service interne au cluster.
- NodePort : Expose le Service sur un port de chaque Node.
- LoadBalancer : Expose le Service via un load balancer externe.
- Ingress : Point d’entrée unique basé sur des règles.

#### 7. Troubleshooting

- Vérifiez l'état des Pods :

  ```bash
  kubectl get pods --all-namespaces
  ```

- Inspectez les logs :

  ```bash
  kubectl logs <pod-name>
  ```

- Testez la connectivité :

  ```bash
  kubectl exec -it <pod-name> -- curl http://<service-name>
  ```

# Cours Officiel

Notes de cours par `Thomas Peugnet` assisté par `Mistral AI`.

### Introduction Générale à la Sécurité des Conteneurs

Montée en puissance des conteneurs

- Du Cloud à l’ère Cloud-Native : Avec l’adoption croissante de l’informatique en mode Cloud, les entreprises ont cherché des moyens plus efficaces de déployer et scaler leurs applications.
- Container Security : Les conteneurs, bien plus légers que les machines virtuelles, se sont imposés comme un pilier essentiel de la modernisation des infrastructures informatiques.

Les enjeux de sécurité

- Isolation et multitenancy : Les conteneurs doivent être suffisamment isolés pour qu’une compromission dans un conteneur ne se propage pas à l’hôte ou à d’autres conteneurs.
- Surface d’attaque plus étendue : Avec la prolifération des microservices et des conteneurs, le risque d’erreurs de configuration et de failles grandit.

### Fondamentaux de la Containerisation

#### Définition et Bénéfices

- Containerisation: Processus d’empaqueter une application et ses dépendances dans un seul artefact exécutable.
  - Isolation : Chaque conteneur s’exécute dans son propre espace (namespace) sans interférer avec les autres.
  - Léger : Contrairement à une VM qui embarque un système d’exploitation complet, le conteneur partage le noyau de l’hôte.
  - Efficient : Démarrage/arrêt quasi instantané, flexibilité de déploiement et montée/descente en charge rapide.
  - Microservices : Favorise l’architecture microservices où chaque service est contenu de façon indépendante.

#### Virtualisation vs Containerisation

- Machines virtuelles (VM) : Hyperviseur, chaque VM possède son OS invité, plus lourde en ressources.
- Conteneurs : Partagent le même OS, démarrages très rapides et utilisation mémoire réduite.

### Docker

#### Architecture Docker

- Docker Engine : Moteur principal qui gère la création, l’exécution et la supervision des conteneurs.
- Docker Client : Interface utilisateur qui envoie des commandes (build, run, pull, push) au daemon Docker.
- Docker Registry : Stocke et distribue les images Docker (ex. Docker Hub ou registre privé).
- Images vs Conteneurs:
  - Image : « Modèle » en lecture seule qui contient tout le nécessaire pour faire tourner l’application.
  - Conteneur : Instance de l’image en exécution, avec un système de fichiers en écriture propre.

#### Dockerfile et Sécurité

- Dockerfile: Script détaillant les étapes pour construire une image.

  - Minimiser la surface d’attaque : Utiliser des images de base légères (Alpine, Distroless...), enlever les paquets inutiles.
  - Pin des versions : Verrouiller les versions des dépendances pour éviter des mises à jour intempestives non maîtrisées.
  - COPY vs ADD : Préférer COPY pour des fichiers locaux. ADD peut involontairement extraire du contenu depuis une URL externe.

#### Sécuriser Docker et l’OS Hôte

1. Tenir Docker et le système hôte à jour : Correctifs de sécurité fréquents pour le moteur Docker et le noyau hôte.
2. Éviter d’exposer la socket Docker : `/var/run/docker.sock` donne l’équivalent d’un accès root si exposé.
3. Éviter le mode `--privileged` : Ne jamais donner plus de privilèges que nécessaire.
4. Exécuter en non-root : Ajouter dans la Dockerfile `USER myuser` ou bien utiliser `-u myuser`.
5. Isolation supplémentaire : Activer SELinux ou AppArmor, paramétrer seccomp.

### Sécurité des Conteneurs : Concepts Avancés

#### Hardening du Conteneur

- Système de fichiers en lecture seule : Empêche l’écriture dans le conteneur, limite grandement l’impact d’une compromission.
- Limitation des ressources : `--memory`, `--cpus`, et `--ulimit` pour éviter la surconsommation (DoS interne).

#### Réduction des privilèges

- Capabilities Linux : Retirer les capacités non nécessaires (`--cap-drop all --cap-add CHOWN` par exemple).
- No-new-privileges : Empêche d’hériter de privilèges supplémentaires via setuid.
- User namespaces : Mappe l’utilisateur root du conteneur à un utilisateur non-root sur l’hôte.

#### Seccomp et AppArmor

- Seccomp : Filtrage des appels système ; on autorise uniquement les appels nécessaires, limitant les actions dangereuses (ex. `mount`, `ptrace`, etc.).
- AppArmor : Module de sécurité Linux décrivant précisément les droits d’accès fichiers/réseau/capabilités de chaque conteneur.

#### Scans de vulnérabilités

- Outils : Trivy, Clair, Snyk pour scanner les images avant déploiement.
- Pipeline CI/CD : Intégrer automatiquement le scanning à chaque nouvelle build.

### Introduction à Kubernetes

#### Présentation Générale

- Kubernetes (K8s) : Orchestrateur open-source pour automatiser le déploiement, la mise à l’échelle et la gestion de conteneurs.
- Principaux avantages : Scalabilité horizontale, haute disponibilité, auto-réparation (self-healing), portabilité multi-cloud.

#### Architecture et Composants Clés

- Control Plane :
  - *API Server* : Point d’entrée unique, gère toutes les requêtes.
  - *etcd* : Base de données clé-valeur, stocke la configuration et l’état du cluster.
  - *Controller Manager* : Surveille l’état du cluster et applique le state désiré (ex. gère les ReplicaSets).
  - *Scheduler* : Assigne les Pods aux nœuds selon ressources et contraintes.
- Worker Nodes :
  - *Kubelet* : Agent local gérant les Pods sur chaque nœud.
  - *Kube-proxy* : Gère la configuration réseau, le routage, et la traduction de ports.
  - *Container Runtime* : Docker, containerd, CRI-O...

#### Fonctionnalités Majeures

- Service Discovery et Load Balancing : Kubernetes Services (ClusterIP, NodePort, LoadBalancer, Ingress).
- Storage orchestration : Volumes, Persistent Volumes, Persistent Volume Claims.
- Auto-scaling : Horizontal Pod Autoscaler (HPA) pour ajuster la charge en fonction d’indicateurs (CPU, mémoire...).
- Rollout / Rollback : Mises à jour progressives et possibilité de revenir à une version précédente.
- Écosystème : Helm pour la gestion des déploiements, Operators, CRD (Custom Resource Definition) pour étendre K8s.



### Sécurité Kubernetes : Approche Globale

#### Principales Menaces

- Accès non autorisé au Control Plane : Si un attaquant obtient l’accès à l’API Server, il contrôle tout.
- Pods mal configurés : Privileged containers, montages hostPath non nécessaires, images vulnérables.
- Failles dans les Applications : Attaques exploitant une vulnérabilité dans le code de l’appli ou une librairie externe.
- Évasion de Conteneur : Exploiter des failles du noyau ou des permissions trop larges pour s’échapper vers l’hôte.

#### Sécurité du Cluster

1. Kubeconfig : Fichiers sensibles stockant les credentials d’accès (clés, tokens) : à protéger et chiffrer.
2. API Server : Activer TLS partout, limiter l’exposition sur Internet, authentifications et contrôles RBAC stricts.
3. etcd : Toujours chiffrer et restreindre l’accès (certificats mutuels, firewall).
4. Patcher régulièrement : Mettre à jour Kubernetes, les nœuds, le runtime conteneur et l’OS.

#### Sécurité des Workloads

- Pods :
  - *Security Context* : Configurer `runAsNonRoot`, `readOnlyRootFilesystem`, etc.
  - *Pod Security Policies (PSP)* : Exiger le respect de contraintes (privileges, hostPID, volumes...).
  - *Admission Controllers* : Analyser les Pods lors de leur création (scanner images, vérifier labels...).
- Deployments, StatefulSet, DaemonSet : Choisir le bon type de workload pour limiter les risques (risques d’état, de configuration...).
- Volumes et Secrets :
  - *ConfigMaps vs Secrets* : Séparer la configuration générale des données sensibles, chiffrer les secrets côté etcd.
  - *Volumes* : Restreindre hostPath, préférer des volumes managés type PVC.

#### Contrôle des Accès

1. Authentification : OIDC, x509, tokens, Webhook...
2. Service Accounts : Identité pour les processus dans les Pods, montent un token JWT pour accéder à l’API.
3. RBAC : Définir précisément qui peut faire quoi (Roles / ClusterRoles) + Bindings.
4. Certificate Management : Rotation automatique des certificats kubelet, usage d’une CA interne ou externe.

#### Sécurité Réseau

- Network Policies : Micro-segmentation L3/L4 pour n’autoriser que le trafic nécessaire (ingress/egress).
- Services : Différents modes d’exposition (NodePort, LoadBalancer, etc.), usage d’Ingress pour un routage HTTP(s) avancé.
- mTLS : Authentification mutuelle entre services ; indispensable pour chiffrer et vérifier l’identité des communications internes.
- Service Mesh : (Istio, Linkerd...) : gestion de la connectivité via sidecars et contrôleurs — centralisation du chiffrement, des politiques et de l’observabilité.

#### Monitoring et Audit

- Audit Logs Kubernetes : Traçage complet des appels à l’API server, paramétrable via une audit-policy.
- Logs conteneurs : Collecte via Fluentd/Logstash/Beats, centralisation dans Elasticsearch, Splunk ou tout autre SIEM.
- Falco : Détection en temps réel d’activités anormales via un monitoring des appels systèmes (eBPF), règles de détection personnalisables.

#### Gestion des Incidents et Remédiation

- Plan de réponse : Processus pour limiter la propagation d’un incident, isoler des nœuds compromis, révoquer des credentials (tokens, certificats).
- Sauvegardes : Backups réguliers d’etcd, des Persistent Volumes, stockage hors site.
- Récupération : Rétablir l’état stable du cluster, redéployer les workloads, réimporter les volumes.



### Synthèse : Alignement avec le NIST CSF

Pour structurer la posture de sécurité, la démarche se cale souvent sur le NIST Cybersecurity Framework :

1. Identify : Inventaire des ressources, classification, identification des risques (ex. audits de configuration, scans d’images).
2. Protect : Mise en place de mesures préventives (RBAC, PSP, réseau, TLS/mTLS).
3. Detect : Outils de monitoring, logs, Falco pour détection temps réel d’événements malveillants.
4. Respond : Automatiser la réponse (isolation, suppression de privilèges, alerting) et procédures d’urgence.
5. Recover : Sauvegardes, résilience, retours d’expérience et amélioration continue.

Voici divers exemples de configurations Kubernetes (en YAML) couvrant les sujets principaux : orchestration, RBAC, NetworkPolicies, secrets/configmaps, bonnes pratiques de sécurité des Pods, audit, etc.
 Pour chacun, je donne une courte explication de ce que fait la ressource et pourquoi elle est utile dans le cadre indiqué.

## Deployment avec bonnes pratiques de sécurité (orchestration & container security)

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: secure-deployment
  labels:
    app: secure-app
spec:
  replicas: 2
  selector:
    matchLabels:
      app: secure-app
  template:
    metadata:
      labels:
        app: secure-app
    spec:
      # -- Sécurité Pod --
      securityContext:
        runAsNonRoot: true      # Évite l’exécution en root
        runAsUser: 1001         # UID pour l’utilisateur dans le conteneur
        fsGroup: 2001          # GID pour les volumes montés en écriture
      containers:
      - name: secure-container
        image: nginx:1.23-alpine
        ports:
        - containerPort: 80
        securityContext:
          allowPrivilegeEscalation: false    # Empêche l’élévation de privilèges
          capabilities:
            drop:
              - ALL                         # Retire toutes les capacités Linux inutiles
          readOnlyRootFilesystem: true      # Système de fichiers en lecture seule
        resources:
          limits:
            cpu: "200m"
            memory: "256Mi"
          requests:
            cpu: "100m"
            memory: "128Mi"
        livenessProbe:
          httpGet:
            path: /
            port: 80
        readinessProbe:
          httpGet:
            path: /
            port: 80
```

### Explication

- Deployment : orchestre la mise à l’échelle et les mises à jour de pods.
- securityContext : paramètre la sécurité (ex. `runAsNonRoot`, `allowPrivilegeEscalation: false`, etc.).
- readOnlyRootFilesystem : limite l’impact d’une compromission en interdisant l’écriture dans le conteneur.
- capabilities: drop: ALL : réduit la surface d’attaque.

------

## RBAC : Gestion des accès & Permissions

### Role et RoleBinding (exemple namespacé)

```yaml
# Role avec des permissions de lecture sur les Pods dans un namespace
apiVersion: rbac.authorization.k8s.io/v1
kind: Role
metadata:
  name: pod-reader
  namespace: my-namespace
rules:
- apiGroups: [""]
  resources: ["pods"]
  verbs: ["get", "list", "watch"]

---
# RoleBinding qui attache ce rôle à un user précis
apiVersion: rbac.authorization.k8s.io/v1
kind: RoleBinding
metadata:
  name: read-pods-binding
  namespace: my-namespace
subjects:
- kind: User
  name: johndoe   # Nom d’utilisateur
  apiGroup: rbac.authorization.k8s.io
roleRef:
  kind: Role
  name: pod-reader
  apiGroup: rbac.authorization.k8s.io
```

### ClusterRole et ClusterRoleBinding (exemple global)

```yaml
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRole
metadata:
  name: cluster-pod-reader
rules:
- apiGroups: [""]
  resources: ["pods"]
  verbs: ["get", "list", "watch"]

---
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRoleBinding
metadata:
  name: cluster-read-pods-binding
subjects:
- kind: User
  name: adminuser
  apiGroup: rbac.authorization.k8s.io
roleRef:
  kind: ClusterRole
  name: cluster-pod-reader
  apiGroup: rbac.authorization.k8s.io
```

### Explication

- Role vs ClusterRole : le premier est limité à un namespace, le second est global au cluster.
- RoleBinding vs ClusterRoleBinding : permet d’associer un rôle (ou clusterRole) à un user, un groupe ou un ServiceAccount.
- Important pour appliquer la loi du moindre privilège et contrôler précisément qui fait quoi.

------

## NetworkPolicies : Politiques de Sécurité Réseau

Exemple de NetworkPolicy pour autoriser seulement le trafic depuis un Pod “frontend” vers un Pod “backend”, en bloquant tout le reste.

```yaml
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: allow-frontend-to-backend
  namespace: my-namespace
spec:
  podSelector:
    matchLabels:
      app: backend        # S’applique aux pods “backend”
  policyTypes:
  - Ingress
  ingress:
  - from:
    - podSelector:
        matchLabels:
          app: frontend  # Seul le Pod “frontend” peut accéder au backend
    ports:
    - protocol: TCP
      port: 8080         # Autorise seulement le port 8080
```

### Explication

- La NetworkPolicy agit comme un pare-feu L3/L4 entre Pods.
- `podSelector` = à quels Pods s’applique la règle.
- `ingress.from` = qui est autorisé à communiquer avec ces Pods.
- Bloque le trafic par défaut si aucune policy ne l’autorise (dépend du CNI implémenté et de la logique “deny by default” une fois qu’on a au moins une Policy).

------

## Gestion des Secrets & de la Configuration

### ConfigMap : stocker de la config non-sensible

```yaml
apiVersion: v1
kind: ConfigMap
metadata:
  name: my-config
  namespace: my-namespace
data:
  APP_ENV: "production"
  LOG_LEVEL: "info"
  config.json: |
    {
      "maxThreads": 10,
      "enableFeatureX": true
    }
```

### Secret : stocker des données sensibles (tokens, mots de passe)

```yaml
apiVersion: v1
kind: Secret
metadata:
  name: my-secret
  namespace: my-namespace
type: Opaque
data:
  # Valeurs encodées en base64 (echo -n 'superpassword' | base64)
  db-password: c3VwZXJwYXNzd29yZA==
  api-key: NjQzN0FQSUtleQ==
```

### Injection dans un Pod

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: app-with-config
spec:
  replicas: 1
  selector:
    matchLabels:
      app: config-app
  template:
    metadata:
      labels:
        app: config-app
    spec:
      containers:
      - name: demo
        image: some-image:latest
        env:
        - name: APP_ENV
          valueFrom:
            configMapKeyRef:
              name: my-config
              key: APP_ENV
        - name: DB_PASSWORD
          valueFrom:
            secretKeyRef:
              name: my-secret
              key: db-password
```

### Explication

- ConfigMap : variables d’environnement ou fichiers de config.
- Secret : identique mais pour infos sensibles (mots de passe, clés API). En base64 par défaut (à chiffrer côté etcd si possible).
- Possibilité de monter ConfigMaps/Secrets en volume, ou via `env`.

------

## Bonnes Pratiques de Sécurité des Pods et Conteneurs

1. runAsNonRoot et allowPrivilegeEscalation: false (vu dans l’exemple du Deployment plus haut).
2. readOnlyRootFilesystem pour empêcher les écritures.
3. Ne pas utiliser :latest en production (versions fixes).
4. Limites CPU/Mémoire pour éviter le déni de service.
5. Ne pas donner de privilèges root ou capabilities excessives.
6. Scanner régulièrement les images (Trivy, etc.).

*(Cf. l’exemple de Deployment #1 qui illustre la plupart de ces points.)*

------

## Audit et Surveillance d’un Cluster

### Audit Policy (exemple minimaliste)

```yaml
# audit-policy.yaml
apiVersion: audit.k8s.io/v1
kind: Policy
rules:
  # Log tout ce qui est 'create', 'update', 'delete' sur pods
  - level: RequestResponse
    verbs: ["create", "update", "delete"]
    resources:
      - group: ""
        resources: ["pods"]
  # Par défaut, log en "Metadata" pour tout le reste
  - level: Metadata
    resources:
      - group: "*"
        resources: ["*"]
```

> Cette policy se place dans le fichier de config du kube-apiserver, par exemple avec `--audit-policy-file=/etc/kubernetes/audit-policy.yaml`.

### Explication

- Permet d’enregistrer toutes les requêtes au niveau de l’API server.
- On peut personnaliser le `level` (Metadata, Request, RequestResponse) selon le besoin.
- Indispensable pour traquer les actions sur le cluster et investiguer en cas d’incident.

------

## Analyse de Fichiers YAML pour Identifier Erreurs ou Failles

### Points de Vigilance

1. Indentation : une mauvaise indentation brise souvent le manifest.
2. apiVersion obsolète : ex. `extensions/v1beta1` n’est plus utilisé pour les Deployments.
3. Sécurité :
   - Oubli de `runAsNonRoot`, usage de `privileged: true` sans raison.
   - Manque de ressources `limits/requests`.
   - Secrets en clair dans un ConfigMap au lieu d’un Secret.
4. RBAC : donner trop de droits (`verbs: ["*"]`) peut être risqué.
5. NetworkPolicy : mal configurer `podSelector` ou ignorer `policyTypes` peut tout autoriser ou tout bloquer.
6. Expose : utiliser un NodePort/LoadBalancer de façon inappropriée.

# Résumé des TPs

`GPT-Generated`, à partir de tous les TPs effectués.

## Construction et Sécurisation d’Images Docker (TP01)

### Préparation de l’Environnement

- Installation de Docker
  - Ajout du dépôt officiel Docker, installation via `apt install docker-ce...` ou similaire.
  - Vérification avec `docker -v`.
- Installation de Trivy
  - Outil d’audit de vulnérabilités dans les images.
  - Installation via `apt-get install trivy`, puis vérification `trivy -h`.

### Construction d’une Image Docker

1. Dockerfile :

   - Choix d’une image de base (ex. `debian:12`, `alpine:3.21`) en fonction des besoins.
   - Ajout d’un fichier `myfile.tar` dans l’image via `ADD` ou `COPY`.
   - Installation de paquets nécessaires (avec `RUN apt-get update && apt-get install ...` ou `apk add ...` en Alpine).
   - Création d’un utilisateur non-root (`useradd -ms /bin/bash appuser`) et utilisation de `USER appuser` pour réduire les privilèges.

2. Construction :

   ```bash
   docker build -t mytestimage:0.1 ./ -f Dockerfile
   ```

3. Analyse avec Trivy :

   - Scan d’image :

     ```bash
     trivy image -f json -o mytestimage_results.txt mytestimage:0.1
     ```

   - Le rapport identifie les vulnérabilités présentes (CVEs, lib version outdated, etc.).

### Bonnes Pratiques et Résultats

- Minimiser l’image : passer sur `alpine` ou `distroless` pour réduire la surface d’attaque et obtenir parfois 0 vulnérabilité connue.
- Utiliser `USER` non-root : limite l’impact d’une compromission.
- Nettoyage (`apt-get clean`, suppression de `/var/lib/apt/lists/\*`) : réduit la taille de l’image et le nombre potentiel de failles.
- Éviter `ADD` : sauf pour des archives locales, préférer `COPY` pour plus de contrôle.

## Application Web Vulnérable, Tests d’Attaque, et Limites de Falco (TP02)

### Mise en place de l’App (Docker Compose)

- docker-compose.yml qui lance :

  - Un conteneur `web` (Flask, Python) + `app.py` vulnérable (injections SQL).
  - Un conteneur `db` (PostgreSQL) initialisé avec `init.sql` (table `users`, stockage mdp en clair, etc.).

- endpoints vulnérables :

  - `/login`: requête SQL concaténée (pas de requête paramétrée).
  - `/search`: utilisation d’un `LIKE '%{search}%'` directement inséré dans la requête.
  - `/logs`: idem, pas d’escaping.

### Tests d’Attaque

- Injection SQL via HTTP: 

  ```
  curl -X POST http://.../login -d '{"username":"admin' OR '1'='1", "password":"..." }'
  ```

  - La requête renvoie tous les utilisateurs => injection fonctionnelle.

- Observation Falco:

  - Par défaut, Falco ne génère pas d’alerte sur l’injection SQL via requête HTTP, car Falco se base sur l’observation des syscalls, non sur l’inspection du contenu des requêtes web.

- Connexion en shell : 

  ```
  docker exec -it flaskapp-web-1 /bin/bash
  ```

  - Ceci, Falco le détecte : l’ouverture d’un shell dans un conteneur, lancement d’un process interactif en root => Falco alerte immédiatement.

- Injection SQL via psql

  (docker exec sur le conteneur `db`) :

  - Falco ne le détecte pas comme une injection. Il voit juste un process `psql`, rien d’anormal par défaut.

### Conclusion et Pistes d’Amélioration

- Falco n’est pas un WAF ni un IDS applicatif ; il surveille principalement le comportement système.
- Pour détecter des injections SQL en plus haut niveau, on peut :
  - Configurer des règles Falco custom pour analyser les logs d’app en temps réel.
  - Brancher un outil d’inspection HTTP (mod_security, WAF).
  - Mettre en place un SIEM (Security Information and Event Management) pour corréler logs.

## Orchestration Kubernetes | Cluster et Network Policies (TP03)

Dans le deuxième TP, on s’intéresse à la configuration d’un cluster Kubernetes (via `kubeadm`) et à la mise en œuvre de Network Policies pour maîtriser les flux réseau.

### Configuration du Cluster

1. Désactiver le swap : `sudo swapoff -a` nécessaire pour K8s (améliore la gestion mémoire par le scheduler).

2. Runtime conteneur : installation de `containerd` (ou Docker).

3. Installation Kubeadm, kubelet, kubectl : ajout du dépôt officiel Kubernetes, puis `apt-get install -y kubelet kubeadm kubectl`.

4. Initialisation du nœud maître :

   ```bash
   sudo kubeadm init --pod-network-cidr=...
   ```

   Puis récupération du join token pour que les nœuds workers rejoignent le cluster.

5. Vérification:

   - `kubectl get nodes` pour voir le maître et les workers.
   - `kubectl get pods -A` pour vérifier les pods systèmes (CoreDNS, etc.).

### Déploiements et Network Policies

- Exposition de services : selon la config, on utilise un Service (NodePort, ClusterIP…) pour exposer les apps (vote, result-service, redis, db...).

- NetworkPolicy : Ressource Kubernetes qui permet de définir des règles d’ingress et d’egress au niveau Pod.

  - Cas 1 : Accès web

    - On autorise le trafic entrant depuis `0.0.0.0/0` sur les ports 80/443, ou sur un `NodePort`.

  - Cas 2 : Communication inter-pods

    - Autoriser pods « vote » à communiquer avec Redis ou DB, etc.

    - Exemples :

      ```yaml
      apiVersion: networking.k8s.io/v1
      kind: NetworkPolicy
      metadata:
        name: allow-redis-access
      spec:
        podSelector:
          matchLabels:
            app: redis
        policyTypes:
          - Ingress
        ingress:
          - from:
              - podSelector: {} # tous pods internes
            ports:
              - protocol: TCP
                port: 6379
      ```

  - Cas Bonus : Politiques plus fines

    - Par exemple, autoriser le trafic egress de `worker` uniquement vers Redis:6379 et DB:5432 ; pas le reste.
    - Bloquer tout trafic non déclaré.

### Bilan

- Les Network Policies segmente le trafic entre microservices, renforce la sécurité.
- Permet d’éviter qu’une compromission d’un pod n’ait accès à toutes les autres ressources.



## Détection en Temps Réel : Falco & Atomic Red Team

Le troisième document illustre l’intégration de Falco dans un cluster K8s et l’utilisation d’Atomic Red Team pour simuler des techniques d’attaque MITRE ATT&CK.

### Installation de Falco

- Via Helm :

  ```bash
  helm repo add falcosecurity https://falcosecurity.github.io/charts
  helm repo update
  helm install falco falcosecurity/falco --namespace falco --create-namespace
  ```

- On surveille les logs du pod Falco :

  ```bash
  kubectl logs -f -n falco -c falco -l app.kubernetes.io/name=falco
  ```

### Déploiement d’Atomic Red Team

- But : Lancer des « tests d’attaque » (TTP) sur un pod pour voir si Falco génère des alertes.
- Procédure :
  1. Créer un namespace `atomic-red`.
  2. Déployer un pod avec l’image `issif/atomic-red:latest` (souvent un conteneur Linux + scripts PowerShell).
  3. Se connecter au pod (`kubectl exec -it`) et exécuter des commandes (Invoke-AtomicTest ...).

### Tests et Observations

- Exemples de techniques :
  - *T1070.004 – File Deletion* : supprime des logs, Falco repère « Bulk data has been removed from disk ».
  - *T1556.003 – Modification PAM* : Falco repère « Sensitive file opened for reading by non-trusted program ».
  - *T1036.005 – Masquerading* : exécuter un binaire malicieux déguisé, Falco alerte sur un exécutable inhabituel.
  - *T1070.002 – Log tampering* : Falco détecte la modification/suppression de journaux.
  - *T1014 – Loadable Kernel Module Rootkit* : injection de module noyau, Falco peut le repérer s’il y a chargement suspect.

Grâce à Falco + Atomic Red Team, on teste la visibilité que l’outil apporte face à des scénarios d’attaque courants.



## Récapitulatif : Approche Sécurité « Defense in Depth »

À travers ces TPs, on retrouve plusieurs briques formant une défense en profondeur pour les conteneurs et la couche d’orchestration :

1. Build & Image Scanning
   - Réduire la surface d’attaque, éviter les vulnérabilités connues (Trivy, mises à jour, Dockerfile minimal).
2. Configuration de l’Orchestrateur (Kubernetes)
   - Isolation via Network Policies.
   - Règles RBAC (non détaillées ici mais conseillées).
   - Mises à jour, monitoring, logs du cluster.
3. Monitoring & Detection (Falco)
   - Détecter les comportements anormaux au niveau système.
   - Compléter Falco par d’autres solutions si besoin (WAF, IDS, etc.).
4. Test d’Attaques / Simulations
   - Atomic Red Team : couverture large de TTP MITRE ATT&CK.
   - Permet de valider l’efficacité des règles Falco ou tout autre système de détection.

# DE - Mistral Generated

Généré par Mistral en respectant la description donnée par le professeur.

## **Partie 1 : Questions à Choix Multiples (QCM)**

*(20 QCM, 1 point chacun. Réponse unique.)*

### **QCM 1**

Dans un cluster Kubernetes, quel composant est chargé de faire correspondre les Pods aux nœuds disponibles en tenant compte des ressources et des contraintes ?

A. Kubelet
 B. Controller Manager
 C. Scheduler
 D. Etcd

**Réponse : C**

> Le Scheduler est responsable d’assigner les Pods aux nœuds en fonction des ressources disponibles et des contraintes configurées.

------

### **QCM 2**

Vous inspectez un fichier YAML (en annexe) définissant un **Role** dans le namespace `biosense-production`. Quel **autre** objet est **nécessaire** pour accorder effectivement ce rôle à un utilisateur ou un groupe ?

A. ClusterRoleBinding
 B. RoleBinding
 C. ServiceAccount
 D. Node Selector

**Réponse : B**

> Un RoleBinding associe un Role namespacé à un utilisateur, un groupe ou un ServiceAccount dans un namespace précis.

------

### **QCM 3**

En analysant le YAML d’une NetworkPolicy, vous voulez **autoriser uniquement** les pods `app=frontend` à communiquer avec `app=backend` sur le port 8080. Quel champ est indispensable ?

A. `ingress.from.podSelector`
 B. `serviceAccountName`
 C. `allowPrivilegeEscalation`
 D. `runtimeClassName`

**Réponse : A**

> On filtre via `ingress.from` + `podSelector: app=frontend` pour autoriser le trafic sur 8080.

------

### **QCM 4**

Où sont stockées les données de configuration et l’état du cluster (Pods, Secrets, ConfigMaps…) ?

A. Dans un volume local sur le nœud master
 B. Dans etcd
 C. Dans un Bucket S3
 D. Dans un fichier kubeconfig

**Réponse : B**

> etcd est la base de données clé-valeur où Kubernetes sauvegarde toutes les ressources du cluster.

------

### **QCM 5**

Pour chiffrer les secrets stockés dans etcd, on configure typiquement :

A. `--encryption-provider-config` au niveau de l’API Server
 B. `allowPrivilegeEscalation: false` dans le container
 C. Un PersistentVolume chiffré avec LUKS
 D. Des restrictions sur l’Ingress

**Réponse : A**

> L’API Server gère le chiffrement at rest via un fichier d’encryption-provider.

------

### **QCM 6**

Vous consultez un Dockerfile dans un des fichiers annexes et constatez qu’il utilise le tag `:latest`. Que recommanderiez-vous ?

A. Garder `latest` pour être toujours à jour
 B. Spécifier un tag versionné (ex. :1.2.3) et mettre en place un scanning régulier
 C. Supprimer l’étiquette pour forcer l’usage d’une image random
 D. Ajouter la directive `EXPOSE 22` pour le debugging

**Réponse : B**

> Toujours préférer un tag versionné pour éviter les mises à jour imprévues, et scanner l’image pour les vulnérabilités.

------

### **QCM 7**

Concernant la **policy d’audit** Kubernetes, il est possible de choisir des niveaux de détail. Parmi les propositions suivantes, **lequel** n’est pas un niveau d’audit ?

A. Metadata
 B. Request
 C. RequestResponse
 D. NetworkFlow

**Réponse : D**

> Les niveaux existants sont `Metadata`, `Request`, `RequestResponse`. “NetworkFlow” n’existe pas dans les niveaux d’audit de l’API Server.

------

### **QCM 8**

Le champ `runAsNonRoot: true` dans `securityContext` d’un Pod :

A. Force la lecture seule du root filesystem
 B. Interdit la montée d’un volume hostPath
 C. Impose de lancer le conteneur avec un UID non-root
 D. Bloque les connexions sortantes vers l’API Server

**Réponse : C**

> `runAsNonRoot: true` empêche tout lancement du conteneur en root.

------

### **QCM 9**

Dans un fichier YAML déployé en annexe, vous voyez un **ServiceAccount**. Qu’est-ce qui est généralement **fourni** au Pod via ce ServiceAccount ?

A. Un token JWT pour s’authentifier à l’API Server
 B. L’adresse IP du cluster
 C. Un accès root sur l’hôte
 D. Une configuration de logging

**Réponse : A**

> Le ServiceAccount est monté par défaut dans le Pod sous forme de token.

------

### **QCM 10**

`policyTypes` dans une NetworkPolicy peuvent inclure :

A. Ingress, Egress
 B. Bindings, Resources
 C. Create, Delete
 D. DNS, IPAM

**Réponse : A**

> On peut définir des règles `Ingress` et/ou `Egress` pour autoriser ou interdire certains flux.

------

### **QCM 11**

Vous voulez valider un manifest YAML **sans** vraiment l’appliquer. Quelle commande utiliser ?

A. `kubectl explain -f manifest.yaml`
 B. `kubectl apply -f manifest.yaml --dry-run=client --validate=true`
 C. `kubectl logs manifest.yaml`
 D. `kubectl patch manifest.yaml -o yaml`

**Réponse : B**

> La commande `--dry-run=client --validate=true` permet une validation locale du manifest.

------

### **QCM 12**

`allowPrivilegeEscalation: false` dans le `securityContext` d’un conteneur :

A. Permet de donner tous les droits root
 B. Empêche toute exécution en root, même à la base
 C. Empêche l’obtention de privilèges supérieurs en cours de route (ex. setuid)
 D. Active la rotation des logs

**Réponse : C**

> Cela bloque l’élévation de privilèges par des binaires setuid.

------

### **QCM 13**

Pour restreindre l’accès à l’API Server dans tout le cluster, on va plutôt :

A. Créer un RoleBinding local dans le namespace `default`
 B. Donner cluster-admin à tous les utilisateurs
 C. Configurer un ClusterRoleBinding pointant vers un compte admin dédié
 D. Spécifier `hostNetwork: true` dans les Pods

**Réponse : C**

> Un ClusterRoleBinding permet de définir des droits globaux (ou de restreindre qui a accès). On ne veut pas donner trop de privilèges à tout le monde.

------

### **QCM 14**

Pour gérer en production les identifiants d’une base de données, la pratique recommandée est :

A. Les stocker directement dans le code de l’image Docker
 B. Les placer dans un Secret Kubernetes (et chiffrer etcd côté API Server)
 C. Publier le mot de passe sur Slack interne
 D. Utiliser un volume hostPath sans contrôle

**Réponse : B**

> Le Secret est la ressource prévue pour les données sensibles, complétée par le chiffrement at rest.

------

### **QCM 15**

Le **Controller Manager** gère :

A. La planification des Pods
 B. L’authentification utilisateur
 C. Les boucles de contrôle pour aligner l’état désiré : Deployments, Replicasets, etc.
 D. Le routage L7 (HTTP)

**Réponse : C**

> Il regroupe plusieurs contrôleurs (ex. ReplicationController, NodeController…) maintenant l’état désiré.

------

### **QCM 16**

Pour **décrire** les NetworkPolicies d’un namespace, on peut :

A. `kubectl describe netpol -n <namespace>`
 B. `kubectl get clusterrole netpol`
 C. `kubectl expose netpol --type=NodePort`
 D. `kubectl logs netpol -n <namespace>`

**Réponse : A**

> `kubectl describe netpol -n my-namespace` donne des détails sur les politiques réseau.

------

### **QCM 17**

Un outil qui détecte, **en temps réel**, la création d’un shell dans un conteneur ou une tentative de rootkit ?

A. Docker Compose
 B. Falco
 C. Kubespray
 D. Helm

**Réponse : B**

> Falco surveille les syscalls en temps réel.

------

### **QCM 18**

**CrashLoopBackOff** indique :

A. Que le Pod est bloqué en “Pending”
 B. Qu’une ResourceQuota empêche le déploiement
 C. Que l’appli se lance mais crash sans cesse
 D. Qu’un Ingress n’est pas configuré

**Réponse : C**

> Le Pod démarre puis s’arrête brusquement, Kubernetes le redémarre en boucle.

------

### **QCM 19**

Pour bien séparer un environnement **“staging”** et un **“production”** dans le **même** cluster :

A. Utiliser des namespaces distincts (ex. “staging”, “production”)
 B. Créer un Pod unique rassemblant les deux environnements
 C. Stocker les binaires dans un ConfigMap
 D. Partager le même RoleBinding

**Réponse : A**

> Les namespaces sont la méthode standard d’isolation logique.

------

### **QCM 20**

Une **ResourceQuota** peut limiter :

A. Les volumes de type hostPath
 B. Les ressources (CPU, mémoire) consommées et le nombre de Pods dans un namespace
 C. L’accès en lecture aux logs
 D. Les déploiements de type RollingUpdate

**Réponse : B**

> ResourceQuota définit les limites de ressources (pod count, cpu, ram, etc.) dans un namespace.

------

## **Partie 2 : Questions Ouvertes**

*(10 questions, 2 points chacune.)*

> Vous trouverez dans **l’annexe** les manifestes YAML complets d’architecture. Certains indices se trouvent dans ces fichiers (ex. Role, RoleBinding, Deployment, NetworkPolicy, Secrets).

### **QO 1**

Dans l’architecture BioSense, un fichier YAML **ClusterRole** accorde `get, list, watch, create, delete` sur tous les “pods” et “deployments” du cluster. Pourquoi cela pose-t-il un **problème de moindre privilège** ? Proposez une **amélioration**.

**Réponse attendue (synthèse)**

- Risque d’excès de privilèges : un utilisateur malveillant ou mal configurer peut déployer/supprimer n’importe quoi dans le cluster.
- Suggestion : passer à un Role namespacé ou réduire les verbes (par ex. retirer `delete`), scope plus restreint.

------

### **QO 2**

Vous repérez un Deployment “critical-service” avec `privileged: true` et `image: myapp:latest`. Expliquez pourquoi ces choix sont risqués. Proposez comment les corriger.

**Réponse attendue (synthèse)**

- `privileged: true` donne un accès quasi total à l’hôte, vecteur d’attaque.
- `image: latest` empêche de contrôler la version exacte, risque de build inattendu.
- Correction : retirer `privileged: true` (ou réduire via capabilities), tagger une version fixe (`myapp:2.3.1`).

------

### **QO 3**

Un Secret apparaît en clair dans un YAML (mot de passe `postgres` visible). Quelles sont les conséquences et que recommandez-vous ?

**Réponse attendue (synthèse)**

- Toute personne ayant accès au repo YAML voit le mot de passe en clair.
- Recommandation : stocker dans un type “Opaque” encodé en base64 et activer le chiffrement at rest au niveau etcd. Éviter d’exposer ce fichier en clair dans un VCS public.

------

### **QO 4**

Donnez la structure générale d’une NetworkPolicy qui autorise seulement :

1. L’Ingress du Pod `frontend` vers le Pod `backend` (port 8080).
2. L’Egress du Pod `backend` vers un Pod `db` (port 5432).

**Réponse attendue (synthèse)**

- `kind: NetworkPolicy`,
- `podSelector: app=backend`,
- `policyTypes: Ingress, Egress`,
- `ingress.from: podSelector: app=frontend`, `ports: 8080`,
- `egress.to: podSelector: app=db`, `ports: 5432`.

------

### **QO 5**

Quelle différence entre un **Role** et un **ClusterRole** dans Kubernetes ?

**Réponse attendue (synthèse)**

- Role : scope namespace, ex. “pod-reader” dans un namespace
- ClusterRole : scope global, y compris ressources non-namespacées (nodes, PV...).
- Ex : pour un dev qui doit lire des Pods seulement dans “staging”, on utilise un Role + RoleBinding.

------

### **QO 6**

Pour l’audit du cluster, quels outils/logs recommandez-vous en plus de l’audit de l’API Server ?

**Réponse attendue (synthèse)**

- Falco pour la détection runtime (shell, rootkit…)
- Stack de logs centralisée (Fluentd + Elasticsearch ou Splunk)
- Un SIEM pour corréler les événements (accès, syscalls, logs d’appli)
- Approches de scanning d’images (Trivy, Clair)

------

### **QO 7**

Un Pod doit récupérer un secret pour se connecter à un service externe. Donnez 2 méthodes d’injection, en précisant les implications de sécurité.

**Réponse attendue (synthèse)**

- Via `env.valueFrom.secretKeyRef`, mot de passe dans une variable d’environnement. Simple mais visible dans un `env`.
- Via un volume monté depuis le Secret, stocké dans un fichier. Limite l’exposition dans `env`.
- Sécurité : rotation, chiffrement, policy d’accès restreinte.

------

### **QO 8**

Pourquoi et comment configurer **le chiffrement** des secrets “at rest” (API Server) ?

**Réponse attendue (synthèse)**

- Pourquoi : si un attaquant vole etcd, il ne doit pas lire les secrets en clair. Obligatoire dans un contexte healthtech (compliance).
- Comment : `encryption-config.yaml` + `--encryption-provider-config` sur l’API Server.

------

### **QO 9**

Sans **limits** CPU/mémoire, un Pod “tout-venant” peut consommer beaucoup de ressources. Expliquez le risque et pourquoi `requests` & `limits` sont utiles.

**Réponse attendue (synthèse)**

- Risque de “noisy neighbor” : un conteneur affame les autres, surcharge.
- `requests` = planification, `limits` = plafond. Gage de stabilité et de QoS.

------

### **QO 10**

Falco détecte l’exécution de shells dans un conteneur. Donnez un exemple d’attaque **non** détectée par Falco et une solution complémentaire.

**Réponse attendue (synthèse)**

- Ex : Injection SQL dans l’application via HTTP (niveau applicatif). Falco ne lève pas d’alerte sur les requêtes SQL internes.
- Solution : un WAF, l’analyse des logs applicatifs, ou des règles Falco custom scrutant les logs s’il y a suspicion.

# DE - Annexes YAML

# Annexe A : cluster-rbac.yaml

```yaml
# cluster-rbac.yaml
# Ce fichier définit un ClusterRole trop permissif et son Binding.

apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRole
metadata:
  name: broad-operator
  labels:
    app: biosense
rules:
  # Autorise la gestion complète des pods et deployments pour tout le cluster
  - apiGroups: [""]               # pods appartiennent à l’apiGroup vide
    resources: ["pods"]
    verbs: ["get", "list", "watch", "create", "delete"]
  - apiGroups: ["apps"]           # deployments dans l’apiGroup apps
    resources: ["deployments"]
    verbs: ["get", "list", "watch", "create", "delete"]

---
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRoleBinding
metadata:
  name: broad-operator-binding
subjects:
  - kind: User
    name: john.leroy@example.com
    apiGroup: rbac.authorization.k8s.io
roleRef:
  kind: ClusterRole
  name: broad-operator
  apiGroup: rbac.authorization.k8s.io
```

Notes :

- Ce `ClusterRole` accorde des droits très larges sur les Pods et Deployments, dans tous les namespaces.
- Le `ClusterRoleBinding` associe ces droits à l’utilisateur `john.leroy@example.com`.
- À analyser : Est-ce conforme au principe du moindre privilège ?

------

# Annexe B : netpol.yaml

```yaml
# netpol.yaml
# Contient des politiques réseau dans le namespace biosense-production

apiVersion: v1
kind: Namespace
metadata:
  name: biosense-production
---
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: deny-all
  namespace: biosense-production
spec:
  podSelector: {}
  policyTypes:
    - Ingress
    - Egress
  # Pas de règles from/to => bloque tout trafic entrant et sortant
---
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: allow-frontend-to-backend
  namespace: biosense-production
spec:
  podSelector:
    matchLabels:
      app: backend
  policyTypes:
    - Ingress
  ingress:
    - from:
      - podSelector:
          matchLabels:
            app: frontend
      ports:
        - protocol: TCP
          port: 8080
```

Notes :

- Première NetworkPolicy : `deny-all` bloque tout trafic dans le namespace `biosense-production`.
- Deuxième : autorise seulement le trafic de `frontend` vers `backend` sur le port 8080.
- À analyser : Quid des autres flux (ex. egress DB) ? Sont-ils autorisés ?

------

# Annexe C : deployment-critical-service.yaml

```yaml
# deployment-critical-service.yaml
# Déploiement critique avec des choix potentiellement risqués

apiVersion: apps/v1
kind: Deployment
metadata:
  name: critical-service
  namespace: biosense-production
  labels:
    app: critical-service
spec:
  replicas: 2
  selector:
    matchLabels:
      app: critical-service
  template:
    metadata:
      labels:
        app: critical-service
    spec:
      securityContext:
        runAsUser: 0            # Exécution en root
      containers:
      - name: app-container
        image: myrepo/myapp:latest  # Tag "latest" non figé
        securityContext:
          privileged: true           # Conteneur privilégié
          allowPrivilegeEscalation: true
        ports:
        - containerPort: 8080
        env:
        - name: ENV
          value: "production"
        # Aucune ressource requests/limits
        # Pas de liveness/readiness probe
```

Notes :

- `privileged: true` + `runAsUser: 0` => conteneur avec droits élevés (risque majeur si compromis).
- `image:latest` => version non déterministe.
- Absence de `resources` (limits, requests).
- Manque de probes pour la santé.
- À analyser : Quelles améliorations recommander pour sécuriser ce service ?

------

# Annexe D : secrets-configmaps.yaml

```yaml
# secrets-configmaps.yaml
# Contient un ConfigMap et deux Secrets (dont un mal formaté)

apiVersion: v1
kind: ConfigMap
metadata:
  name: biosense-app-config
  namespace: biosense-production
data:
  APP_LOG_LEVEL: "debug"
  FEATURE_X_ENABLED: "true"

---
apiVersion: v1
kind: Secret
metadata:
  name: db-secret-bad
  namespace: biosense-production
type: Opaque
data:
  # Erreur de configuration : le mot de passe est en clair au lieu d’être en base64
  db-password: "postgrespassword"  # => Non encodé ! Problème potentiel

---
apiVersion: v1
kind: Secret
metadata:
  name: db-secret-correct
  namespace: biosense-production
type: Opaque
data:
  # Exemple correct en base64 => echo -n "postgrespassword" | base64
  db-password: "cG9zdGdyZXNwYXNzd29yZA=="
```

Notes :

- `db-secret-bad` montre un mot de passe stocké en clair, ce qui est non conforme au format `Opaque` (qui nécessite base64).
- `db-secret-correct` encode correctement le mot de passe.
- Le ConfigMap “biosense-app-config” stocke des variables non sensibles.
- À analyser : Quelles conséquences si quelqu’un lit le YAML ? Quelles bonnes pratiques de chiffrement dans etcd ?

------

# Annexe E : resourcequota.yaml

```yaml
# resourcequota.yaml
# Une ResourceQuota pour limiter la consommation dans biosense-production

apiVersion: v1
kind: ResourceQuota
metadata:
  name: rq-limits
  namespace: biosense-production
spec:
  hard:
    pods: "10"            # Max 10 Pods dans ce namespace
    requests.cpu: "4"     # Total CPU demandé <= 4 cores
    requests.memory: "8Gi"
    limits.cpu: "8"       # CPU max
    limits.memory: "16Gi"
```

Notes :

- Limite le nombre de Pods et les ressources (CPU/mémoire).
- À analyser : Impact sur l’auto-scaling d’un Deployment ? Sur la sécurité ?

# Rendu TP01

Compte-rendu du TP01 effectué par `Thomas PEUGNET`.

## Préparation

Nous mettons en place notre environnement avec le script suivant.

```bash
#!/bin/bash

# Met à jour les dépôts et met à niveau les paquets
apt update && apt upgrade -y

# Installe les outils nécessaires
apt install -y open-vm-tools net-tools ca-certificates curl

truncate -s 0 /etc/machine-id
rm /var/lib/dbus/machine-id
ln -s /etc/machine-id /var/lib/dbus/machine-id

# Installe Docker
install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
chmod a+r /etc/apt/keyrings/docker.asc
echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] \
https://download.docker.com/linux/ubuntu \
$(. /etc/os-release && echo \"$VERSION_CODENAME\") stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null
apt-get update -y
apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# Vérifie l'installation de Docker
docker -v

# Installe Trivy
wget -qO - https://aquasecurity.github.io/trivy-repo/deb/public.key | gpg --dearmor | tee /usr/share/keyrings/trivy.gpg > /dev/null
echo "deb [signed-by=/usr/share/keyrings/trivy.gpg] https://aquasecurity.github.io/trivy-repo/deb $(lsb_release -sc) main" | tee /etc/apt/sources.list.d/trivy.list > /dev/null
apt-get update -y
apt-get install -y trivy
trivy -h

# Crée un fichier et un Dockerfile d'exemple
mkdir archive
echo "this is some text" > ./archive/file.txt
tar cvf myfile.tar archive
cat << 'EOF' > Dockerfile
FROM debian:10.0
RUN apt-get -y install bash
ADD ./myfile.tar /tmp
EXPOSE 22
EOF

# Construit une image Docker
sudo docker build -t mytestimage:0.1 ./ -f Dockerfile

# Lance le service Docker
sudo service docker start

# Vérifie les conteneurs en cours d'exécution
docker ps

# Exécute un scan Trivy sur l'image créée
trivy image -f json -o mytestimage_results_"$(date +"%H%M%S")".txt mytestimage:0.1

# Archive un historique des fichiers générés
mkdir -p /root/scan_results
mv mytestimage_results_*.txt /root/scan_results/
echo "Scan terminé. Résultats sauvegardés dans /root/scan_results."
```

Exécuter le script en `sudo`.

## Envoi des données

Nous envoyons le résultat de l'analyse sur `dbsystel.github.io`.

![image-20241211152342858](./assets/image-20241211152342858.png)

Nous changeons la version de Debian et faisons quelques changements sur le Dockerfile.

![image-20241211154538683](./assets/image-20241211154538683.png)

Notre Dockerfile, à cet instant, est le suivant.

```dockerfile
FROM debian:12

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y --no-install-recommends \
    bash \
    openssh-server \
    curl \
    ca-certificates && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

ADD ./myfile.tar /tmp

RUN useradd -ms /bin/bash appuser && \
    mkdir -p /home/appuser/.ssh && \
    chmod 700 /home/appuser/.ssh

USER appuser

EXPOSE 22

CMD ["bash"]
```

Les changements que nous avons fait:

- `apt-get update` et `apt-get upgrade` pour mettre à jour les paquets, suivi d'une installation des paquets nécessaires (`bash`, `openssh-server`, `curl`, `ca-certificates`), avec nettoyage du cache pour réduire la taille de l'image.

-  Plus une bonne pratique qu'une vulnérabilité: `myfile.tar`  déplacé à `/tmp`.

- SSH: Création de l'utilisateur `appuser`, configuration du répertoire `.ssh` et passage à cet utilisateur pour exécuter les commandes.

Puis, nous avons décidé de passer sur une image `alpine`, moins complète donc moins vulnérable.

Notre Dockerfile est à présent le suivant:

```Dockerfile
FROM alpine:3.21

RUN apk add --no-cache bash

ADD ./myfile.tar /tmp

EXPOSE 22
```

Et là nous obtenons un total de 0 vulnérabilité.

![image-20241211155044195](./assets/image-20241211155044195.png)

Nous avons, cette fois-ci, complètement changé notre fusil d'épaule en changeant le nom de l'image. Sans changer d'OS, nous sommes toujours sur un debian et n'avons pas impacté le fonctionnement de l'image.

Nous ne l'avons pas détaillé plus haut, mais nous effectuons systématiquement les commandes suivantes:

```bash
sudo  docker build -t mytestimage:0.6 ./ -f Dockerfile
```

```bash
sudo trivy image -f json -o mytestimage_result.json mytestimage:0.6
```

Nous envoyons ensuite le résultat json sur le site indiqué pour obtenir les informations sur les vulnérabilités.

## Analyse

Nous lançons la commande `trivy config Dockerfile` depuis notre répertoire `/hom/studenlab`.

![image-20241211160108547](./assets/image-20241211160108547.png)

Nous modifions notre Dockerfile pour avoir le contenu suivant.

```dockerfile
FROM alpine:3.21

RUN apk add --no-cache bash

ADD ./myfile.tar /tmp

RUN adduser -D appuser

USER appuser

CMD ["bash"]
```

![image-20241211160545218](./assets/image-20241211160545218.png)

Nous obtenons une seule vulnérabilité, qui est le fait d'avoir un Healthcheck sur notre Dockerfile. Étant donné que nous ne runnons aucun service et que ce conteneur est simplement une image linux qui tourne toute seule, un Healthcheck n'est pas forcément nécessaire. De plus, le résultat demeure satisfaisant même si nous n'avons pas obtenu 0 Failures..

# Rendu TP02

Rendu du TP02 par `Vincent LAGOGUE` et `Thomas PEUGNET`.

## Mise en place de l'environnement de travail

Nous créons notre environnement et obtenons l'architcture suivante.

![image-20250129132951100](./assets/image-20250129132951100.png)

Notre `docker-compose.yml` a le contenu suivant.

![image-20250129133500641](./assets/image-20250129133500641.png)

Nous lançons notre application avec le démarrage de nos conteneurs.

```
docker compose up -d --build
```

Nous constatons que l'application tourne correctement et que la base de données fonctionne correctement.

![image-20250129142128115](./assets/image-20250129142128115.png)

Nous modifions notre fichier `init.sql` pour avoir le contenu suivant. Ce contenu a été généré volontairement par Mistra AI.

```sql
-- Empty initialization file for now
-- Création de la base de données si elle n'existe pas
-- CREATE DATABASE mydb;
\c mydb;

-- Création de la table des utilisateurs avec une vulnérabilité classique (pas de préparation de requête)
DROP TABLE IF EXISTS users;
CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    username VARCHAR(50) NOT NULL,
    password VARCHAR(255) NOT NULL,  -- Mauvaise pratique : stockage en clair
    email VARCHAR(100),
    role VARCHAR(20) DEFAULT 'user'
);

-- Insertion de quelques utilisateurs
INSERT INTO users (username, password, email, role) VALUES
('admin', 'admin123', 'admin@example.com', 'admin'),
('user1', 'password', 'user1@example.com', 'user'),
('user2', '123456', 'user2@example.com', 'user'),
('evil_hacker', 'p@ssw0rd', 'hacker@darkweb.com', 'user');

-- Table des logs (idéal pour tester l'injection dans les recherches)
DROP TABLE IF EXISTS logs;
CREATE TABLE logs (
    id SERIAL PRIMARY KEY,
    action TEXT,
    user_id INT REFERENCES users(id),
    timestamp TIMESTAMP DEFAULT NOW()
);

-- Exemples d'entrées de logs
INSERT INTO logs (action, user_id) VALUES
('User admin logged in', 1),
('User user1 changed password', 2),
('User user2 attempted login', 3),
('Evil hacker tried SQL injection', 4);
```

Nous modifions également notre fichier `app.py` pour avoir le contenu suivant.

```python
from flask import Flask, request, jsonify
import psycopg2
import logging

logging.basicConfig(filename='/app/logs/access.log', level=logging.INFO)

app = Flask(__name__)

# Connexion à PostgreSQL (⚠️ vulnérable car pas de paramètre sécurisé)
DB_CONFIG = {
    "dbname": "mydb",
    "user": "user",
    "password": "password",
    "host": "db",
    "port": 5432
}

def get_db_connection():
    return psycopg2.connect(DB_CONFIG)

@app.route('/')
def home():
    return "🚀 API Flask vulnérable aux injections SQL"

# 🔥 1️⃣ Authentification vulnérable 🔥
@app.route('/login', methods=['POST'])
def login():
    data = request.json
    username = data.get('username', '')
    password = data.get('password', '')

    conn = get_db_connection()
    cursor = conn.cursor()

    # ⚠️ Vulnérable aux injections SQL
    query = f"SELECT id, username, role FROM users WHERE username = '{username}' AND password = '{password}'"
    logging.info(f"[DEBUG] Query exécutée: {query}")  # Pour voir ce qui est injecté
    cursor.execute(query)
    user = cursor.fetchone()

    cursor.close()
    conn.close()

    if user:
        return jsonify({"message": "Connexion réussie", "user": user}), 200
    return jsonify({"message": "Échec de l'authentification"}), 401

# 🔥 2️⃣ Recherche d'utilisateurs vulnérable 🔥
@app.route('/search', methods=['GET'])
def search_users():
    search = request.args.get('q', '')

    conn = get_db_connection()
    cursor = conn.cursor()

    # ⚠️ Vulnérable aux injections SQL
    query = f"SELECT id, username, email FROM users WHERE username LIKE '%{search}%'"
    logging.info(f"[DEBUG] Query exécutée: {query}")
    cursor.execute(query)
    results = cursor.fetchall()

    cursor.close()
    conn.close()

    return jsonify(results), 200

# 🔥 3️⃣ Affichage des logs vulnérable 🔥
@app.route('/logs', methods=['GET'])
def get_logs():
    filter_log = request.args.get('filter', '')

    conn = get_db_connection()
    cursor = conn.cursor()

    # ⚠️ Vulnérable aux injections SQL
    query = f"SELECT id, action, timestamp FROM logs WHERE action LIKE '%{filter_log}%'"
    logging.info(f"[DEBUG] Query exécutée: {query}")
    cursor.execute(query)
    logs = cursor.fetchall()

    cursor.close()
    conn.close()

    return jsonify(logs), 200

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000, debug=True)
```

## Falco

Nous lançons Falco à l'aide de la commande suivante.

```
docker run --rm -it \
  --privileged \
  -v /var/run/docker.sock:/var/run/docker.sock \
  -v /dev:/host/dev \
  -v /proc:/host/proc:ro \
  -v /boot:/host/boot:ro \
  -v /lib/modules:/host/lib/modules:ro \
  -e FALCO_UI_OUTPUT=/tmp/falco-events.json \
  falcosecurity/falco:latest
```

Nous remarquons que, après plusieurs tentatives, `falco` ne peut pas fonctionner sur un système macOS. Nous nous connectons donc à une VM sur un hyperviseur Proxmox pour continuer la suite du TP.

![image-20250129135546763](./assets/image-20250129135546763.png)



Nous relançons la commande Docker.

![image-20250129141454842](./assets/image-20250129141454842.png)

## Attaques

### Injection SQL via HTTP

Nous lançons une première attaque, étant la requête `curl` suivante. Cette attaque fait une requête SQL au travers d'une requête POST faite à notre serveur web.

![image-20250129144415145](./assets/image-20250129144415145.png)

Nous constatons que l'attaque n'a pas été détectée par Falco (absence de changement dans les logs, fenêtre en haut à droite).

### Connexion en shell

Nous effetuons maintenant une connexion via un `docker exec` sur le conteneur de notre application web à l'aide de la commande suivante.

```
sudo docker exec -it flaskapp-web-1 /bin/bash
```

![image-20250129151354610](./assets/image-20250129151354610.png)

Nous constatons cette fois-ci que cette manipulation a bien été détectée par Falco, nous avons le résultat suivant.

```
2025-01-29T14:11:41.919363331+0000: Notice A shell was spawned in a container with an attached terminal (evt_type=execve user=root user_uid=0 user_loginuid=-1 process=bash proc_exepath=/usr/bin/bash parent=containerd-shim command=bash terminal=34816 exe_flags=EXE_WRITABLE|EXE_LOWER_LAYER container_id=21090e8b304a container_name=<NA>)
```

Un shell (`bash`) a été lancé à l'intérieur d'un conteneur.

- L’utilisateur `root` (`user=root user_uid=0`) a exécuté cette commande, ce qui indique un accès avec des privilèges root.

- Le processus parent est `containerd-shim`, ce qui signifie que le shell a été lancé directement via Docker ou un runtime de conteneur.

- Le terminal est attaché (`terminal=34816`), ce qui veut dire que la session est interactive.

- Le fichier exécutable (`proc_exepath=/usr/bin/bash`) est situé dans `/usr/bin/`.

### Injection SQL via un Shell

Nous tentons une nouvelle façon de faire une injection, avec une commande `docker exec`.

```shell
sudo docker exec -it flaskapp-db-1 psql -U user -d mydb -c "SELECT * FROM users WHERE username = 'admin' OR '1'='1';"
```

![image-20250129152247851](./assets/image-20250129152247851.png)

Nous constatons là encore que l'attaque n'est pas détectée, malgré une réussite évidente (liste de tous les users et leur mot de passe).

## Conclusion

Il semblerait donc que Falco, en fonctionnant avec ses règles par défaut ne soit pas capable de détecter des injections SQL passant par une requête HTTP.

Nous avons longuement investigué sur la façon de gérer les règles pour améliorer ses capacités de détection, mais avons constaté que c'était le programme du TP03.

Nous ajoutons simplement une note ici, permettant de monter notre fichier de règles depuis notre host vers notre conteneur Falco.

```shell
sudo docker run --rm -it \
  --privileged \
  -v /var/run/docker.sock:/var/run/docker.sock \
  -v /dev:/host/dev \
  -v /proc:/host/proc:ro \
  -v /boot:/host/boot:ro \
  -v /lib/modules:/host/lib/modules:ro \
  -v /home/user/flaskapp/falco_rules.local.yaml:/etc/falco/falco_rules.local.yaml:ro \
  -v /home/user/flaskapp/logs/access.log:/var/log/falco/flask_access.log:ro \
  -e FALCO_UI_OUTPUT=/tmp/falco-events.json \
  falcosecurity/falco:latest
```

À noter que la suite de nos tentatives étaient de rediriger l'output des logs de notre application Flask vers un fichier à lire par Falco lors de la création et du lancement du conteneur. Ensuite, nous aurions fait une règle analysant le contenu de notre fichier de log et vérifiant si une regex est validée par une des lignes du fichier de logs.

D'après la capture d'écran suivante, il ne serait pas forcément très difficile de détecter ce genre d'intrusion.

![image-20250129153021976](./assets/image-20250129153021976.png)

