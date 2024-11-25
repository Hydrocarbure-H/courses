# Sécurité Cloud

# Rendu TP01

## Préparation

Nous commençons par installer AWS CLI avec les commandes suivantes:

![image-20241113085750529](./assets/image-20241113085750529.png)

Nous poursuivons avec les étapes d'inscription à l'offre gratuite de AWS.

![image-20241113090333514](./assets/image-20241113090333514.png)

Nous activons la MFA depuis les recommandations de la section IAM. Nous configurons notre application Google Authenticator.

![image-20241113092426946](./assets/image-20241113092426946.png)

## Gestion des utilisateurs avec IAM

Nous créons un utilisateur `test-user-1`.

![image-20241113093028033](./assets/image-20241113093028033.png)

Nous activons l'accès à la console.

![image-20241113093135745](./assets/image-20241113093135745.png)

On effectue une connexion sur le lien de connexion fourni lors de l'activation de l'accès console.

![image-20241113093516289](./assets/image-20241113093516289.png)

On se deconnecte du compte `test-user-1`, on se reconnecte avec le compte `root` et on ajoute une politique d'autorisation pour l'utilisateur `test-user-1`.

![image-20241113093814300](./assets/image-20241113093814300.png)

On ajoute le code indiqué dans le sujet du TP, donnant donc le JSON complet suivant:

```json
{
	"Version": "2012-10-17",
	"Statement": [
		{
            "Sid": "s3fullaccess",
            "Effect": "Allow",
            "Action": "s3:*",
            "Resource": "*"
        }
	]
}	
```

Nous créons notre politique `S3FullAccess`.

![image-20241113094152293](./assets/image-20241113094152293.png)

Nous nous connectons ensuite au service IAM Policy Simulator grâce à l'URL https://policysim.aws.amazon.com/home/index.jsp.

![image-20241113094258379](./assets/image-20241113094258379.png)

Après avoir sélectionné notre utilisateur et les 160 actions possibles sur `AmazonS3`, nous avons bien le résultat suivant:

![image-20241113094446434](./assets/image-20241113094446434.png)

Nous ajoutons ensuite la politique d'autorisation `AmazonEC2ReadOnlyAccess` à l'utilisateur `test-user-1`.

![image-20241113094657277](./assets/image-20241113094657277.png)

Nous pouvons constater que notre utilisateur a bien une nouvelle politique d'autorisation.

![image-20241113094749184](./assets/image-20241113094749184.png)

Nous retournons ensuite sur le IAM Policy Simulator et testons les politiques avec notre utilisateur `test-user-1` et `Amazon EC2`.

![image-20241113094915367](./assets/image-20241113094915367.png)

Nous finissons ce TP en supprimant notre utilisateur `test-user-1`.

![image-20241113095144236](./assets/image-20241113095144236.png)

Nous constatons que notre politique `S3FullAccess` a bien été supprimée.

![image-20241113095257077](./assets/image-20241113095257077.png)

# Rendu TP02

Ce TP a été réalisé par `Thomas PEUGNET`.

## Sécurisation du compte AWS

Nous configurons une Alert Preference.

![image-20241113112347043](./assets/image-20241113112347043.png)

Nous mettons à jour la politique par défaut.

![image-20241113112610707](./assets/image-20241113112610707.png)

Nous créons un budget mensuel de 5$.

![image-20241113112743425](./assets/image-20241113112743425.png)

Nous activons l'accès des utilisateurs IAM aux informations de facturation.

![image-20241113112856804](./assets/image-20241113112856804.png)

Nous ajoutons un groupe **facturation** et nous le rattachons aux permissions `Billing`.

![image-20241113113025267](./assets/image-20241113113025267.png)

Nous créons un utilisateur `Mathias` et le mettons dans le groupe **facturation**.

![image-20241113113136605](./assets/image-20241113113136605.png)

Nous activons l'accès console pour notre utilisateur.

![image-20241113113310670](./assets/image-20241113113310670.png)

Nous créons un utilisatateur `thomaspeu`, l'attachons à la politique `AdminAccess` et lui activons son accès console.

![image-20241113113530641](./assets/image-20241113113530641.png)

![image-20241113113701479](./assets/image-20241113113701479.png)

Nous activons l'utilisation de la MFA pour cet utilisateur et nous reconnectons avec ce dernier.

Nous pouvons constater que nous avons bien toutes les permissions nécessaires.

![image-20241113114110832](./assets/image-20241113114110832.png)

Nous créons un alias `thomas-peugnet` pour notre compte AWS et nous reconnectons.

![image-20241113114451912](./assets/image-20241113114451912.png)

Nous créons le groupe `Admin` et y ajoutons notre utilisateur.

![image-20241113114545739](./assets/image-20241113114545739.png)

Nous créons maintenant une politique pour rester dans le Free Tier qui aura le JSON suivant. Son objectif est d'interdire le lancement des VM si elles ne sont pas dans la région de Paris.

```json
{
	"Version": "2012-10-17",
	"Statement": [
                    {
                        "Effect": "Deny",
                        "Action": "ec2:RunInstances", 
                        "Resource": "*",
                        "Condition": {
                            "StringNotEquals": { 
                                "aws:RequestedRegion": "eu-west-3"
                            }
                        }
                    }
	]
}
```

![image-20241113114940055](./assets/image-20241113114940055.png)

Nous attachons cette nouvelle politique `allow-only-paris-region` à notre groupe `Admin`.

![image-20241113115045986](./assets/image-20241113115045986.png)

Nous testons de lancer une instance `t2.micro` hors de France (Frankfurt).

![image-20241113115251982](./assets/image-20241113115251982.png)

Comme prévu, nous avons un message d'erreur.

![image-20241113115307283](./assets/image-20241113115307283.png)



Nous créons ensuite la politique `allow-only-t2-micro` ayant pour objectif d'interdire le lancement de VM différentes du type `t2.micro`. Cette politique aura le JSON suivant:

```json
{
	"Version": "2012-10-17",
	"Statement": [
                    {
                        "Effect": "Deny",
                        "Action": "ec2:RunInstances", 
                        "Resource": "*",
                        "Condition": {
                            "StringNotEquals": { 
                                "ec2:InstanceType": "t2.micro"                            
                            }
                        }
                    }
	]
}
```

Nous associons cette nouvelle politique à notre groupe `Admin`.

![image-20241113115646539](./assets/image-20241113115646539.png)

Nous testons notre politique avec le lancement d'une instance t2.micro en se situant dans la région Paris.

![image-20241113115749682](./assets/image-20241113115749682.png)

Nous obtenons, comme prévu, un message d'erreur.

![image-20241113115801790](./assets/image-20241113115801790.png)

Nous allons maintenant gérer les autorisations AWS en nous basans sur les attributs.

Nous créons une Politique `EC2limitedAccess` avec le JSON suivant:

```json
{
   "Version":"2012-10-17",
   "Statement":[
      {
         "Effect":"Allow",
         "Action":[
            "ec2:DescribeInstances",
            "ec2:DescribeImages",
            "ec2:DescribeTags"
         ],
         "Resource":"*"
      },
      {
         "Effect":"Allow",
         "Action":[
            "ec2:RebootInstances",
            "ec2:StartInstances",
            "ec2:StopInstances"
         ],
         "Resource":"*",
         "Condition":{
            "StringEquals":{
               "aws:PrincipalTag/Department":"EC2Admins",
               "ec2:ResourceTag/Environment":"Production"
            }
         }
      }
   ]
}
```

![image-20241119132445639](./assets/image-20241119132445639.png)

Nous créons ensuite un utilisateur nommé `testABAC` auquel nous assignons la politique `EC2limitedAccess`. Nous assignons également les tags suivant:

- `key` = Department
- `value` = EC2Admins

![image-20241119132719024](./assets/image-20241119132719024.png)

Nous lançons ensuite nos 2 instances EC2 avec les tags `Environment:Production` et `Environment:Development`.

![image-20241119140014623](./assets/image-20241119140014623.png)

Nous nous reconnectons avec l'utilisateur `testABAC` et constatons que nous pouvons bien redémarrer l'instance de Production mais pas celle de Developpement.

![image-20241119140352461](./assets/image-20241119140352461.png)

