# Orchestration

Notes de cours par `Thomas PEUGNET`.

### Kubernetes Cheat Sheet

#### 1. **Concepts de Base**

- **Cluster** : Ensemble de nœuds contrôlés par Kubernetes.
- **Node** : Machine (physique ou virtuelle) dans un cluster.
- **Pod** : Plus petite unité déployable, contient un ou plusieurs conteneurs.
- **Namespace** : Isolation logique des ressources dans un cluster.
- **Deployment** : Contrôle le déploiement des Pods (scaling, rolling updates).
- **Service** : Expose les Pods à d’autres applications ou au réseau externe.

#### 2. **Composants du Cluster**

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

#### 3. **Commandes kubectl Essentielles**

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

#### 4. **Manifest YAML Exemple**

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

#### 5. **Objets Principaux**

- **ConfigMap** : Stocke les configurations non sensibles.
- **Secret** : Stocke les informations sensibles (ex. mots de passe).
- **Ingress** : Gère l’accès HTTP/HTTPS au cluster.
- **PersistentVolume (PV)** : Définit un espace de stockage.
- **PersistentVolumeClaim (PVC)** : Requête pour un PV.

#### 6. **Networking**

- **ClusterIP** : Service interne au cluster.
- **NodePort** : Expose le Service sur un port de chaque Node.
- **LoadBalancer** : Expose le Service via un load balancer externe.
- **Ingress** : Point d’entrée unique basé sur des règles.

#### 7. **Troubleshooting**

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