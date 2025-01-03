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

# Rendu TP03

Rendu du TP03 effectué par `Thomas PEUGNET`.

Nous créons l'utilisateur Joanne.

![image-20241202132020756](./assets/image-20241202132020756.png)

![image-20241202132304784](./assets/image-20241202132304784.png)

Nous nous reconnectons avec `Joanne ` et constatons le résultat suivant:

![image-20241202132357549](./assets/image-20241202132357549.png)

Nous créons un bucket S3.

![image-20241202132705272](./assets/image-20241202132705272.png)

Nous créons la policy avec le contenu suivant.

```json
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "IAMAccess",
            "Effect": "Allow",
            "Action": "iam:*",
            "Resource": "*"
        },
        {
            "Sid": "DenyPermBoundaryIAMPolicyAlteration",
            "Effect": "Deny",
            "Action": [
                "iam:DeletePolicy",
                "iam:DeletePolicyVersion",
                "iam:CreatePolicyVersion",
                "iam:SetDefaultPolicyVersion"
            ],
            "Resource": [
                "arn:aws:iam::794038237731:policy/PermissionsBoundary"
            ]
        },
        {
            "Sid": "DenyRemovalOfPermBoundaryFromAnyUserOrRole",
            "Effect": "Deny",
            "Action": [
                "iam:DeleteUserPermissionsBoundary",
                "iam:DeleteRolePermissionsBoundary"
            ],
            "Resource": [
                "arn:aws:iam::794038237731:user/*",
                "arn:aws:iam::794038237731:role/*"
            ],
            "Condition": {
                "StringEquals": {
                    "iam:PermissionsBoundary": "arn:aws:iam::794038237731:policy/PermissionsBoundary"
                }
            }
        },
        {
            "Sid": "DenyAccessIfRequiredPermBoundaryIsNotBeingApplied",
            "Effect": "Deny",
            "Action": [
                "iam:PutUserPermissionsBoundary",
                "iam:PutRolePermissionsBoundary"
            ],
            "Resource": [
                "arn:aws:iam::794038237731:user/*",
                "arn:aws:iam::794038237731:role/*"
            ],
            "Condition": {
                "StringNotEquals": {
                    "iam:PermissionsBoundary": "arn:aws:iam::794038237731:policy/PermissionsBoundary"
                }
            }
        },
        {
            "Sid": "DenyUserAndRoleCreationWithOutPermBoundary",
            "Effect": "Deny",
            "Action": [
                "iam:CreateUser",
                "iam:CreateRole"
            ],
            "Resource": [
                "arn:aws:iam::794038237731:user/*",
                "arn:aws:iam::794038237731:role/*"
            ],
            "Condition": {
                "StringNotEquals": {
                    "iam:PermissionsBoundary": "arn:aws:iam::794038237731:policy/PermissionsBoundary"
                }
            }
        }
    ]
}
```

![image-20241202133313526](./assets/image-20241202133313526.png)

Nous créons un utilisateur `BadUSER`.

![image-20241202133528697](./assets/image-20241202133528697.png)

Nous nous connectons avec et constatons le résultat suivant.

![image-20241202133715337](./assets/image-20241202133715337.png)

![image-20241202133733828](./assets/image-20241202133733828.png)

![image-20241202133934309](./assets/image-20241202133934309.png)

Nous allons effectuer une escalade de privilèges avec un nouvel utilisateur `testThomas1`.

![image-20241202134047521](./assets/image-20241202134047521.png)

Nous nous reconnectons avec ce nouvel utilisateur et constatons que nous avons maintenant accès.

![image-20241202134204924](./assets/image-20241202134204924.png)

Nous appliquons `PermissionsBoundary` à notre utilisateur `BadUSER`.

![image-20241202134335069](./assets/image-20241202134335069.png)

Nous nous reconnectons avec l'utilisateur `BadUSER` et tentons de supprimer permissions boundary.

![image-20241202134511953](./assets/image-20241202134511953.png)

Nous obtenons le retour suivant.

![image-20241202134525597](./assets/image-20241202134525597.png)

Nous tentons de modifier la politique pour obtenir `AdministratorAccess`.

![image-20241202134802560](./assets/image-20241202134802560.png)

Nous tentons de recréer un nouvel utilisateur et obtenons le résultat suivant.

![image-20241202134917881](./assets/image-20241202134917881.png)

Nous assignons notre `PermissionBoundary` à cet utilisateur et pouvons en effet le créer.

![image-20241202135035136](./assets/image-20241202135035136.png)

Nous pouvons confirmer que l'utilisateur `testThomas2` ne peut pas accéder aux EC2.

![image-20241202135035136](./assets/other.png)

# Rendu TP04

Rendu de TP04 effectué par `Thomas PEUGNET`.

![image-20241202135844631](./assets/image-20241202135844631.png)

Nous créons un AWS account avec cet email: `fedikay342@nausard.com`

![image-20241202140054796](./assets/image-20241202140054796.png)

# Rendu TP05

Rendu de TP05 a été effectué par `Thomas PEUGNET`.

Nous créons un VPC.

![image-20241202140413066](./assets/image-20241202140413066.png)

Nous créons nos 3 subnets.

![image-20241202140909318](./assets/image-20241202140909318.png)

Nous créons notre table de routage.

![image-20241202140946435](./assets/image-20241202140946435.png)

Nous associons les subnets suivant à cette table de routage.

![image-20241202141036987](./assets/image-20241202141036987.png)

De même avec notre `Private RT` routing table.

![image-20241202141152343](./assets/image-20241202141152343.png)

Nous créons notre Internet Gateway.

![image-20241202141236498](./assets/image-20241202141236498.png)

Nous l'attachons à notre VPC.

![image-20241202141320967](./assets/image-20241202141320967.png)

Nous ajoutons une nouvelle route pour `0.0.0.0/0`.

![image-20241202141530670](./assets/image-20241202141530670.png)

Nous activons les hostnames DNS.

![image-20241202141631646](./assets/image-20241202141631646.png)

Nous lançons notre instance EC2.

![image-20241202143138838](./assets/image-20241202143138838.png)

![image-20241202142041540](./assets/image-20241202142041540.png)

Nous avons donc l'instance suivante.

![image-20241202142121873](./assets/image-20241202142121873.png)

La machine ne répond pas aux ping depuis son IP publique.

![image-20241202142225850](./assets/image-20241202142225850.png)

Nous pouvons nous connecter à notre instance via SSH.

![image-20241202142418303](./assets/image-20241202142418303.png)

Nous avons en effet la bonne adresse IP.

![image-20241202143231113](./assets/image-20241202143231113.png)

Nous lançons une nouvelle instance.

![image-20241202143421935](./assets/image-20241202143421935.png)

Depuis la première instance, nous nous connectons sur la nouvelle avec les commandes suivantes.

- Envoi de la clé privé envoyée par AWS sur l'instance de rebond
- Utilisation de cette clé depuis l'instance de rebond pour se connecter à la nouvelle instance dans le réseau privé.

![image-20241202143738800](./assets/image-20241202143738800.png)



Nous avons en effet la bonne adresse IP : `10.150.2.66`

![image-20241202143923558](./assets/image-20241202143923558.png)

![image-20241202143936852](./assets/image-20241202143936852.png)

La VM privée n'a effectivement pas accès à Internet.

![image-20241202144010946](./assets/image-20241202144010946.png)

Nous supprimons les VMs.

![image-20241202144047157](./assets/image-20241202144047157.png)

Nous supprimons le VPC.

![image-20241202144156233](./assets/image-20241202144156233.png)

# Rendu TP06

Rendu de TP06 effectué par `Thomas PEUGNET`.

Nous créons notre instance.

![image-20241202144535121](./assets/image-20241202144535121.png)

Nous nous connectons en SSH à la VM.

![image-20241202144623779](./assets/image-20241202144623779.png)

Nous tentons de lister les `s3`.

![image-20241202144715415](./assets/image-20241202144715415.png)

Nous créons notre rôle `EC2toS3-test-Thomas`.

![image-20241202144859926](./assets/image-20241202144859926.png)

Nous modifions le rôle IAM pour mettre celui nouvellement créé.

![image-20241202144941341](./assets/image-20241202144941341.png)

Nous pouvons constater que le `ls` fonctionne désormais.

![image-20241202145011142](./assets/image-20241202145011142.png)

Nous créons une nouvelle instance `EC2-TP6.2-Thomas`.

![image-20241202145204298](./assets/image-20241202145204298.png)

Nous nous connectons à cette nouvelle instance.

![image-20241202145235463](./assets/image-20241202145235463.png)

Nous créons un nouvel utilisateur `Thomas1`.

![image-20241202145438824](./assets/image-20241202145438824.png)

Nous créons une access key pour notre utilisateur.

![image-20241202145619430](./assets/image-20241202145619430.png)

Après avoir enregistré nos Access Keys (détruites avant publication de ce TP donc visibles en clair sur les captures.) nous constatons que cela fonctionne.

![image-20241202145741260](./assets/image-20241202145741260.png)

Nous constatons également que ces informations sont stockées en clair sur la VM.

![image-20241202145817475](./assets/image-20241202145817475.png)

Nous supprimons ce fichier.

![image-20241202145854567](./assets/image-20241202145854567.png)

Nous modifions le role IAM.

![image-20241202150143534](./assets/image-20241202150143534.png)

Nous pouvons voir le résultat suivant.

![image-20241202150223419](./assets/image-20241202150223419.png)

Nous supprimons tous les éléments du TP.

![image-20241202150554491](./assets/image-20241202150554491.png)

Nous nous connectons au service EC2.

![image-20241202150704995](./assets/image-20241202150704995.png)

Nous créons noétre nouveau rôle.

![image-20241202150901800](./assets/image-20241202150901800.png)

Nous faisons le switch du role.

![image-20241202151208225](./assets/image-20241202151208225.png)

Nous avons bien le résultat suivant.

![image-20241202151236161](./assets/image-20241202151236161.png)

Nous n'avons pas d'accès au service EC2.

![image-20241202151321758](./assets/image-20241202151321758.png)

Idem pour le service IAM.

![image-20241202151344030](./assets/image-20241202151344030.png)

Pas de problème pour la lecture sur S3.

![image-20241202151417451](./assets/image-20241202151417451.png)

Nous ne pouvons pas créer de bucket.

![image-20241202151602206](./assets/image-20241202151602206.png)

Nous créons éun nouvel utilisateur `test-role-thomas`.

![image-20241202151918926](./assets/image-20241202151918926.png)

Nous n'avons pas accès au service S3.

![image-20241202152234153](./assets/image-20241202152234153.png)

Nous créons la policy suivante.

```json
{
	"Version": "2012-10-17",
	"Statement": [
		{
			"Sid": "Statement1",
			"Effect": "Allow",
			"Action": "sts:AssumeRole",
			"Resource": : "arn:aws:iam::794038237731:role/S3Readonly-thomas-TP6.3"
		}
	]
}
```

Nous créons la nouvelle policy.

![image-20241202153130208](./assets/image-20241202153130208.png)

Nous switchons de rôle.

![image-20241202153228304](./assets/image-20241202153228304.png)

Nous avons bien un accès en lecture seule.

![image-20241202153334230](./assets/image-20241202153334230.png)

# Rendu TP07

Rendu de TP07 effectué par `Thomas PEUGNET`.

Nous créons notre VPC.

![image-20241202154447343](./assets/image-20241202154447343.png)

![image-20241202154802397](./assets/image-20241202154802397.png)

Nous créons un sécurity group.

![image-20241202154900793](./assets/image-20241202154900793.png)

Nous créons une instance `EC2-TEST-SG-ACL` sur notre VPC.

![image-20241202155021403](./assets/image-20241202155021403.png)

Nous y ajoutons, AVANT de lancer l'instance, le code bash suivant.

```bash
#!/bin/bash
yum update -y
yum install -y httpd 
systemctl start httpd 
systemctl enable httpd
```

Nous testons la résolution DNS.

```
nslookup ec2-35-181-169-122.eu-west-3.compute.amazonaws.com
```

![image-20241202155436770](./assets/image-20241202155436770.png)

Nous ne pouvons pas encore accéder à notre instance depuis le client AWS.

![image-20241202155621942](./assets/image-20241202155621942.png)



Nous créons, dans notre sécurity group, une inbound rule.

![image-20241202155754919](./assets/image-20241202155754919.png)

![image-20241202155804343](./assets/image-20241202155804343.png)



Nous pouvons constater que cela fonctionne.

![image-20241202161834966](./assets/image-20241202161834966.png)

![image-20241202161914002](./assets/image-20241202161914002.png)

Nous créons une seconde instance.

![image-20241202162032494](./assets/image-20241202162032494.png)

La VM privée n'est pas accessible depuis la VM publique.

![image-20241202162213760](./assets/image-20241202162213760.png)

On modifie nos règles.

![image-20241202162306460](./assets/image-20241202162306460.png)

Nous pouvons constater que cela fonctionne.

![image-20241202162407326](./assets/image-20241202162407326.png)

Network ACLs.

![image-20241202162510818](./assets/image-20241202162510818.png)

Nous avons modifié nos rules.

![image-20241202162725791](./assets/image-20241202162725791.png)

Nous pouvons constater que cela ne fonctionne plus.

![image-20241202162835773](./assets/image-20241202162835773.png)

Nous modifions notre règle pour mettre uniquement notre adresse IP.

Nous ne pouvons plus accéder au site.

![image-20241202163022677](./assets/image-20241202163022677.png)



Nous modifions les règles pour ne plus y avoir accès via SSH.

![image-20241202163242527](./assets/image-20241202163242527.png)

Nous pouvons constater que cela fonctionne.

Si nous nous connectons via SSH, nous pouvons constater également que cela fonctionne.

![image-20241202163406762](./assets/image-20241202163406762.png)

On supprime nos instances.

![image-20241202163439674](./assets/image-20241202163439674.png)

Nous nettoyons nos règles Network ACLs.

![image-20241202163631340](./assets/image-20241202163631340.png)

Nous supprimons notre VPC.

![image-20241202163703121](./assets/image-20241202163703121.png)

# Rendu TP08

Compte rendu du TP 08 effectué par `Thomas PEUGNET`.

Nous créons le VPC `VPC-THOMAS-ALB`.

![image-20241211081909948](./assets/image-20241211081909948.png)

![image-20241211081917584](./assets/image-20241211081917584.png)

Nous créons un Security Group `HTTP-access`.

![image-20241211082116936](./assets/image-20241211082116936.png)

![image-20241211082122040](./assets/image-20241211082122040.png)

Nous créons un template d'instance `WEB-SERVER`.

![image-20241211083212101](./assets/image-20241211083212101.png)

Nous ajoutons le code suivant dans User Data.

```bash
#!/bin/bash

# Update the system and install necessary packages
yum update -y
yum install -y httpd

# Start the Apache server
systemctl start httpd
systemctl enable httpd

# Fetch the Availability Zone information using IMDSv2
TOKEN=`curl -X PUT "http://169.254.169.254/latest/api/token" -H "X-aws-ec2-metadata-token-ttl-seconds: 21600"`
AZ=`curl -H "X-aws-ec2-metadata-token: $TOKEN" http://169.254.169.254/latest/meta-data/placement/availability-zone`

# Create the index.html file
cat > /var/www/html/index.html <<EOF
<html>
<head>
    <title>Instance Availability Zone</title>
    <style>
        body {
            background-color: #6495ED; /* Cornflower Blue - a darker shade */
            color: white;
            font-size: 36px; /* Significantly larger text */
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
            font-family: Arial, sans-serif;
        }
    </style>
</head>
<body>
    <div>This instance is located in Availability Zone: $AZ</div>
</body>
</html>
EOF

# Ensure the httpd service is correctly set up to start on boot
chkconfig httpd on
```

![image-20241211083246863](./assets/image-20241211083246863.png)



Nous créons une instance à partir de ce template.

![image-20241211083741333](./assets/image-20241211083741333.png)

Les règles sont correctes.

![image-20241211083812589](./assets/image-20241211083812589.png)

Le `nslookup` donne bien le résultat suivant.

![image-20241211083856436](./assets/image-20241211083856436.png)

Nous avons bien un accès web à notre instance.

![image-20241211083934279](./assets/image-20241211083934279.png)

Nous créons un nouveau Auto Scaling Group.

![image-20241211084418349](./assets/image-20241211084418349.png)

![image-20241211084457217](./assets/image-20241211084457217.png)

![image-20241211084915820](./assets/image-20241211084915820.png)

![image-20241211084944595](./assets/image-20241211084944595.png)

Nous constatons que nos instances se sont bien lancées.

![image-20241211085027767](./assets/image-20241211085027767.png)

Le `nslookup`est concluant.

![image-20241211085117509](./assets/image-20241211085117509.png)

![image-20241211085121681](./assets/image-20241211085121681.png)

L'accès web est concuant également.

![image-20241211085147841](./assets/image-20241211085147841.png)

Idem pour l'accès web et le `nslookup` de la seconde instance.

![image-20241211085236417](./assets/image-20241211085236417.png)

Nous supprimons l'instance.

![image-20241211085323688](./assets/image-20241211085323688.png)

Nous constatons que l'auto scaling group la relance bien.

![image-20241211085354634](./assets/image-20241211085354634.png)

Ce processus est raccord avec les informations dans l'historique d'activité.

![image-20241211085429341](./assets/image-20241211085429341.png)

Nous créons un Target Group `TG-Thomas`.

![image-20241211085546832](./assets/image-20241211085546832.png)

Nous créons un LoadBalancer `ALBB-Thomas`.

![image-20241211085747448](./assets/image-20241211085747448.png)

![image-20241211085752487](./assets/image-20241211085752487.png)Nous assignons à notre Load Balancer notre Target Group.

![image-20241211090112127](./assets/image-20241211090112127.png)

Nous pouvons voir nos targets enregistrées après quelques instants.

![image-20241211090205688](./assets/image-20241211090205688.png)

Nous pouvons constater un changement de zone à chaque rafraîchissement.

![image-20241211090313466](./assets/image-20241211090313466.png)

![image-20241211090306646](./assets/image-20241211090306646.png)

Nous mettons à jour notre Scaling Limit.

![image-20241211090425048](./assets/image-20241211090425048.png)

Nous ajoutons notre Subnet à notre ASG.

![image-20241211090508616](./assets/image-20241211090508616.png)

Nous ajoutons notre subnet à notre ALB.

![image-20241211090611826](./assets/image-20241211090611826.png)

Nous créons notre Automatic Scaling Policy.

![image-20241211090719436](./assets/image-20241211090719436.png)

Nous préparons une boucle shell pour intérroger notre ALB.

```shell
for i in {1..200}; do curl ALBB-Thomas-813760480.eu-west-3.elb.amazonaws.com & done; wait
```

Nous constatons un pic de requêtes.

![image-20241211091443129](./assets/image-20241211091443129.png)

Nous constatons en effet l'arrivée sur la zone numéro 3 après lancement de la 3e instance.

![image-20241211091659205](./assets/image-20241211091659205.png)

![image-20241211091638577](./assets/image-20241211091638577.png)



Nous nous rendons à l'adresse de l'instance numéro 1.

![image-20241211091819584](./assets/image-20241211091819584.png)

Nous nous rendons à l'adresse de l'instance numéro 2.

![image-20241211091837555](./assets/image-20241211091837555.png)

Nous créons un Target Group `TG-NLB-Thomas`.

![image-20241211092413490](./assets/image-20241211092413490.png)

Nous créons notre NLB `NLB-Thomas`.

![image-20241211093106355](./assets/image-20241211093106355.png)

En mettant l'adresse du NLB, on obtient en effet la zone 1.

![image-20241211093246486](./assets/image-20241211093246486.png)

Depuis une fenêtre de navigation privée, après quelques rafraîchissement nous obtenons enfin la zone numéro 2.

![image-20241211093334154](./assets/image-20241211093334154.png)

Nous supprimons notre ASG.

![image-20241211093420097](./assets/image-20241211093420097.png)

Nous supprimons notre ALB et notre NLB.

![image-20241211093455497](./assets/image-20241211093455497.png)

Nous supprimons notre Launch Template.

![image-20241211093523006](./assets/image-20241211093523006.png)

Nous supprimons nos TG.

![image-20241211093614389](./assets/image-20241211093614389.png)

Nous terminons nos instances.

![image-20241211093643015](./assets/image-20241211093643015.png)

Nous supprimons notre VPC.

![image-20241211093847114](./assets/image-20241211093847114.png)

![image-20241211093850684](./assets/image-20241211093850684.png)

# Rendu TP09

Compte rendu du TP09 effectué par `Thomas PEUGNET`.

Nous créons un Rôle `EC2RoleforSSM`.

![image-20241211094826833](./assets/image-20241211094826833.png)

Nous créons notre instance `EC2 Linux Thomas Inspector`.

![image-20241211095215556](./assets/image-20241211095215556.png)

Nous vérifions notre règle.

![image-20241211095134120](./assets/image-20241211095134120.png)

Nous activons Inspector.

![image-20241211095322518](./assets/image-20241211095322518.png)

Nous activons l'inpsctor sur notre account management.

![image-20241211095622037](./assets/image-20241211095622037.png)

Nous constatons qu'AWS inspector a terminé de scanner notre instance.

![image-20241211095743254](./assets/image-20241211095743254.png)

Nous avons visiblement quelques failles, probablement dues à des mises à jour non effectuées pour le moment.

![image-20241211095838396](./assets/image-20241211095838396.png)

Nous configurons en Quick Setup notre Systems Manager.

![image-20241211100311698](./assets/image-20241211100311698.png)

Nous démarrons une session sur notre instance.

![image-20241211100403274](./assets/image-20241211100403274.png)

Nous constatons que l'adresse est bien celle de notre instance.

![image-20241211100443613](./assets/image-20241211100443613.png)

Nous exécutons Patch Manager sur notre instance.

![image-20241211100657223](./assets/image-20241211100657223.png)

Nous créons notre Security Group `allow-http-ftp`.

![image-20241211100820445](./assets/image-20241211100820445.png)

Nous ajoutons ce security group à notre instance.

![image-20241211100908910](./assets/image-20241211100908910.png)

Nous constatons en effet, lors du scan de notre instance, que nous avons une vulnérabilité sur le port 80.

![image-20241211101329787](./assets/image-20241211101329787.png)



Nous supprimons notre configuration SSM.

![image-20241211101524184](./assets/image-20241211101524184.png)

Nous désactivons AWS Inspector.

![image-20241211101631578](./assets/image-20241211101631578.png)

# Projet

Mise en place d'un server web Flask (Python) sur 2 instances EC2, faisant appels à une base de données PostgreSQL, se trouvant dans le subnet privé du VPC, protégées par un loadbalancer se trouvant dans le subnet public du VPC.

Projet par `Vincent LAGOGUE`, `Tom THIOULOUSE`, `Alexis PLESSIAS`, `David TEJEDA` et `Thomas PEUGNET`.

## Table des matières

1. [Préparation](#préparation)  

   - [Politique SLA](#politique-sla)  
   - [Objectifs SLA, RPO et RTO](#objectifs-sla-rpo-et-rto)  
   - [Diagramme d’Architecture](#diagramme-darchitecture)  
   - [Politiques de sécurité](#politiques-de-sécurité)  
   - [Surveillance et gestion des incidents](#surveillance-et-gestion-des-incidents)  
   - [Tests de vulnérabilité et validation](#tests-de-vulnérabilité-et-validation)  

2. [Réalisation](#réalisation)  

   - [VPC](#vpc)  
   - [EC2 & Loadbalancer](#ec2--loadbalancer)  
   - [RDS](#rds)  
   - [Configuration du backend Flask et PostgreSQL](#configuration-du-backend-flask-et-postgresql)  

3. [Configurations Annexes](#configurations-annexes)  

   - [Sauvegardes](#sauvegardes)  

   - [Supervision](#supervision)  

   - [Tests](#tests)  

   - [Configurations annexes](#configurations-annexes)  

   - [AWS Inspector](#aws-inspector)  

4. [Améliorations](#améliorations)  

   - [Réseau (VPC & Subnets)](#réseau-vpc--subnets)  
   - [Instances EC2](#instances-ec2)  
   - [Déploiement du code](#déploiement-du-code)  
   - [Sécurité](#sécurité)  
   - [Alarmes](#alarmes)  
   - [IAM](#iam-1)  

# Préparation

##### Politique SLA

- Objectif de disponibilité : 99,98 %.
- Cela implique une architecture redondante avec :
  - Un Load Balancer pour distribuer les requêtes.
  - Deux zones de disponibilité (AZ) pour les instances EC2.
  - Un système de basculement automatique en cas de panne.

##### Objectifs SLA, RPO et RTO

- SLA (Disponibilité) : 99,98 %.
- RPO (Recovery Point Objective) : 5 minutes (données perdues max).
- RTO (Recovery Time Objective) : 30 minutes (temps pour restaurer les services).

##### Diagramme d’Architecture

```mermaid
graph TD
    subgraph Public Subnet
        ALB[Application Load Balancer]
        IGW[Internet Gateway]
        Bastion[Instance de rebond]
    end
    
    subgraph Private Subnet 1
        EC2A[EC2 Instance A]
        EC2B[EC2 Instance B]
        NAT[NAT Gateway]
        RDS1[Amazon RDS]
    end

    subgraph Private Subnet 2
        RDS2[Amazon RDS]
    end

    subgraph IAM
        RoleEC2[ec2-backend-role]
        UserDev[web-developper-user1]
    end

    ALB -->|Forward Requests| EC2A
    ALB -->|Forward Requests| EC2B
    EC2A -->|Database Queries| RDS1
    EC2B -->|Database Queries| RDS1
    EC2A -->|Database Queries| RDS2
    EC2B -->|Database Queries| RDS2
    EC2A -->|Internet Access| NAT
    EC2B -->|Internet Access| NAT
    NAT -->|Outbound Traffic| IGW
    Bastion -->|SSH Access| EC2A
    Bastion -->|SSH Access| EC2B
    RoleEC2 -->|Attached to| EC2A
    RoleEC2 -->|Attached to| EC2B
    UserDev -->|AWS CLI Access| RoleEC2

```

*Affichage en PNG ci-dessous si le code Mermaid n'est pas interprété.*

![diagram](./assets/diagram2.png)

##### Politiques de sécurité

- IAM :
  - Rôles et politiques restreints pour les instances EC2 (accès S3 minimal).
  - Rôle spécifique pour les instances EC2 (`ec2-backend-role`) permettant la gestion via AWS Systems Manager.
  - Accès sécurisé à RDS pour les administrateurs uniquement, avec des permissions limitées via des Security Groups.
- Security Groups :
  - ALB : Autorise uniquement les connexions entrantes sur HTTP (port 80) depuis `0.0.0.0/0`.
  - EC2 : Accepte les connexions uniquement depuis le ALB via son Security Group (`nlb-sg`).
  - RDS :
    - Accepte les connexions uniquement depuis les instances EC2 via leur Security Group (`ec2-sg`).
    - Appliqué à toutes les sous-routes privées hébergeant RDS (Private Subnet 1 et Private Subnet 2).
  - Instance de rebond (Rebond) :
    - Accepte les connexions entrantes uniquement sur SSH (port 22).
    - Accès SSH aux instances EC2 privées (`app-instance-1` et `app-instance-2`) via leurs Security Groups.

##### Surveillance et gestion des incidents

- AWS CloudWatch : Collecte des métriques système et configuration d'alertes pour détecter les indisponibilités.
- AWS CloudTrail : Suivi des journaux d’activité pour détecter des anomalies.

##### Tests de vulnérabilité et validation

- AWS Inspector : Analyse des failles de sécurité sur les instances EC2.
- Validation des objectifs SLA, RPO et RTO :
  - Simulation de panne sur une zone de disponibilité pour vérifier le basculement automatique.
  - Test de restauration des données depuis les snapshots RDS pour valider le RPO.

# Réalisation

#### VPC

Nous configurons un environnement réseau dans le VPC `thomas-vpc` avec les éléments suivants :

- Subnets : `public-subnet` pour les ressources accessibles depuis Internet et `private-subnet` pour les ressources sécurisées.
- Route Tables :
  - `public-route-table`, associée à `thomas-igw` (Internet Gateway), permet un accès Internet au sous-réseau public.
  - `private-route-table`, associée à `nat-gateway`, garantit un accès sortant sécurisé au sous-réseau privé.
- Passerelles :
  - `thomas-igw` pour l'accès Internet depuis le public-subnet.
  - `nat-gateway` pour l'accès sécurisé depuis le private-subnet.

![image-20250103125502617](./assets/image-20250103125502617.png)

#### EC2 & Loadbalancer

Nous configurons deux instances EC2 (`app-instance-1` et `app-instance-2`) dans le private-subnet du VPC `thomas-vpc`, accessibles via un Network Load Balancer (`app-network-load-balancer`) situé dans le public-subnet. 

- Le NLB utilise un Target Group (`nlb-target-group`) pour distribuer le trafic TCP (port 80) vers les instances privées. 

-  `nlb-sg` autorise les connexions entrantes sur le NLB depuis l’extérieur, et `ec2-sg` restreint le trafic des instances à celui provenant du NLB uniquement.

![Instance 1](./assets/image-20250102223946829.png)

![Instance 2](./assets/image-20250102223957734.png)

![NLB SG](./assets/image-20250102224108184.png)

![EC2 SG](./assets/image-20250102224159369.png)

![NLB TG](./assets/image-20250102224251112.png)

![Network Load Balancer](./assets/image-20250102224404674.png)

#### RDS

Nous configurons une base de données RDS PostgreSQL (`app-database`) dans le VPC `thomas-vpc`, utilisant un DB Subnet Group couvrant les sous-réseaux privés (`private-subnet` et `private-subnet-2`, ce dernier ayant été créé pour respecter les contraintes d'AWS, la database ne doit pas être accessible depuis seulement une seule AZ). 

Le Security Group de RDS (`rds-sg`) ayant été automatiquement créé est ajusté : toute règle autorisant une IP publique est supprimée, et une règle autorisant les connexions depuis les instances EC2 via leur Security Group (`ec2-sg`) est ajoutée. La base de données est isolée et uniquement accessible depuis les ressources internes du VPC.

![RDS Subnet Group](./assets/image-20250102231850418.png)

![RDS Database](./assets/image-20250102231825769.png)

![RDS SG](./assets/image-20250102231541660.png)

#### Configuration du backend Flask et PostgreSQL

Nous avons créé une nouvelle instance EC2 pour faire rebond et permettre l'accès aux instances dans le `private-subnet`. Cette instance est nommée `public-instance`.

![image-20250103000801033](./assets/image-20250103000801033.png)

Installation des dépendances sur les 2 instances EC2 dans le subnet privé :

- Mise à jour des paquets et installation de Python 3, `pip`, et des bibliothèques nécessaires (`flask`, `psycopg2-binary`).
- Installation des outils PostgreSQL (`postgresql16`) pour interagir avec la base RDS.

Configuration de l’application Flask :

- Création d’un fichier `app.py` pour implémenter un serveur web minimal et établir une connexion avec la base de données RDS PostgreSQL.
- Ajout d’une route principale (`/`) pour vérifier que l’application tourne et d’une route (`/data`) pour tester les interactions avec la base de données.

Gestion des variables d’environnement :

- Configuration d’un fichier `.env` contenant les informations sensibles comme l’endpoint RDS, le nom de la base, l’utilisateur, et le mot de passe.
- Chargement des variables d’environnement dans l’environnement d’exécution Flask.

Le code Python est le suivant.

```python
from flask import Flask, jsonify
import psycopg2
import os

app = Flask(__name__)

DB_HOST = os.getenv("DB_HOST")
DB_NAME = os.getenv("DB_NAME")
DB_USER = os.getenv("DB_USER")
DB_PASSWORD = os.getenv("DB_PASSWORD")

def get_db_connection():
    try:
        conn = psycopg2.connect(
            host=DB_HOST,
            database=DB_NAME,
            user=DB_USER,
            password=DB_PASSWORD
        )
        return conn
    except Exception as e:
        print(f"Connection to the database failed : {e}")
        return None

@app.route("/")
def home():
    return "Flask App is running!"

@app.route("/data")
def fetch_data():
    conn = get_db_connection()
    if conn is None:
        return jsonify({"error": "Connection to the database failed"}), 500
    
    cur = conn.cursor()
    cur.execute("SELECT NOW();")
    result = cur.fetchone()
    cur.close()
    conn.close()
    return jsonify({"current_time": result[0]})

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=80)
```

Lancement de Flask :

- Exécution de l’application Flask sur le port 80 avec le paramètre `host="0.0.0.0"` pour permettre l’accès depuis d’autres machines dans le réseau.

![image-20250103000839040](./assets/image-20250103000839040.png)

Toutes les commandes qui auront été tapées pour installer correctement PostgreSQL, les bonnes dépendances, tester l'installation et lancer l'application se trouvent ci-dessous.

```shell
vim app.py
sudo yum install python3-pip
sudo yum install -y python3-devel gcc postgresql-devel
sudo pip3 install psycopg2 flask
python3 -c "import psycopg2; print(psycopg2.__version__)"
sudo yum install -y postgresql16
psql -h app-database.cps2aaq6etbj.eu-west-3.rds.amazonaws.com -U postgres -d postgres
sudo python3 app.py
vim app.py
sudo python3 app.py
```

Tests locaux sur les instances :

- Vérification que l’application répond correctement aux requêtes en accédant directement depuis l'instance elle-même (`127.0.0.1:80`).

![image-20250103000255408](./assets/image-20250103000255408.png)

Configuration de la connectivité publique :

- Intégration des instances EC2 dans un Target Group associé au Network Load Balancer.
- Vérification des règles des Security Groups :
  - Le Load Balancer autorise le trafic HTTP (port 80) depuis `0.0.0.0/0`.
  - Les instances EC2 autorisent uniquement le trafic HTTP provenant du Security Group du Load Balancer.

Test final via le Load Balancer :

- Accès public à l’application via l’adresse DNS du Load Balancer.
- Validation des routes Flask (`/` et `/data`) pour confirmer que l’application et la base de données fonctionnent correctement.

Sur `http://app-network-load-balancer-ee9867e767f894f8.elb.eu-west-3.amazonaws.com/` :

![image-20250103000406420](./assets/image-20250103000406420.png)

Sur `http://app-network-load-balancer-ee9867e767f894f8.elb.eu-west-3.amazonaws.com/data` :

![image-20250103000342677](./assets/image-20250103000342677.png)

En rafraîchissant plusieurs fois la page, nous constatons une alternance entre les différentes instances touchées.

![image-20250103001857315](./assets/image-20250103001857315.png)

![image-20250103001906689](./assets/image-20250103001906689.png)

# Configurations Annexes

#### Sauvegardes

Nous configurons les sauvegardes automatiques pour notre base de données et nous sauvegardons nos images AMIs.

Note: Nous considérons ici, bien que ce soit le sujet d'une amélioration future, que le code de l'application Flask est déployé via une pipeline CI/CD. Il n'est donc nécessaire de faire une sauvegarde de notre instance que pour en accélérer le déploiement, et non, à terme, pour en sauvegarder le code.

![image-20250103002215868](./assets/image-20250103002215868.png)

![image-20250103093322234](./assets/image-20250103093322234.png)

#### Supervision

Nous configurons la supervision de RDS avec CloudWatch et créons des alarmes pour le CPU de nos instances de serveurs web et de base de données.

Nous constatons que nos logs sont bien visibles depuis CloudWatch.

![image-20250103002622237](./assets/image-20250103002622237.png)

![image-20250103105522284](./assets/image-20250103105522284.png)

![image-20250103113219970](./assets/image-20250103113219970.png)

Note: L'alarme ci-dessus (freespace) a été en status `in Alarm` car nous nous sommes trompés dans le threshold, nous avions indiqué que la notification devait partir si l'espace disponible était supérieur (et non inférieur) à 5.000.000.000 bytes (5GB). Cela a été corrigé, d'où le statut de l'alarme mis à jour en `OK`.

En résumé, nous avons créé les alarmes suivantes:

Alarme CPU pour EC2 (2 alarmes) :

- Instances `app-instance-1` et `app-instance-2` : Déclenchées lorsque l’utilisation CPU dépasse 80 % pendant une période prolongée. Elles servent à détecter une surcharge de traitement sur les instances.

Alarme sur les connexions actives pour RDS :

- Déclenchée lorsque le nombre de connexions simultanées à la base de données dépasse un seuil défini à 20 connexions. Elle permet de surveiller les pics de trafic ou de charge sur la base.

Alarme sur l’espace disque disponible pour RDS :

- Déclenchée lorsque l’espace disque disponible sur la base de données descend en dessous de 5GB. Elle sert à prévenir une saturation du stockage.

#### Tests

Nous testons l'accès à notre application via un navigateur web.

Cela semble bien fonctionner pour la route `/` en utilisant le nom DNS de notre loadbalancer.

![image-20250103110955316](./assets/image-20250103110955316.png)

Il en est de même pour la route `/data`.

![image-20250103111028286](./assets/image-20250103111028286.png)

Nous testons les sauvegardes, en vérifiant que les images AMIs ont bien été créés à notre demande.

![image-20250103111131065](./assets/image-20250103111131065.png)

Nous testons la résilience en éteignant une instance et en vérifiant que celle toujours up est bien utilisée pour servir notre application.

Nous constatons que seule la première instance du serveur Flask est utilisée pour répondre, cela fonctionne donc correctement.

![image-20250103111715720](./assets/image-20250103111715720.png)

Nous testons l'une de nos alarmes (la plus rapide à mettre en place) pour valider la bonne réception des notification par mail.

Après avoir fait notre erreur de threshold sur l'espace disponible sur la base de données, nous avons rapidement reçu le mail suivant. Les notifications semblent donc fonctionner correctement.

![image-20250103110751351](./assets/image-20250103110751351.png)

Nous utilisons le package `stress` pour faire un stress test des instances. Nous pouvons constater au niveau du monitoring que les graphs sont tout à fait cohérents.

![image-20250103114702916](./assets/image-20250103114702916.png)

Nous utilisons la commande `stress --cpu 1 --timeout 10000`.

Les alarmes de CPU ne sont pas encore prêtes à être utilisées par manque de temps (elles demeurent en statut `Insuficien Data`), mais fonctionneront de façon similaire à l'alerte Freespace éprouvée juste auparavant.

#### IAM

Nous créons un rôle `ec2-backend-role` avec la permission AmazonSSMManagedInstanceCore pour gérer les instances EC2 dans le subnet privé via Systems Manager. 

Nous créons ensuite l’utilisateur `web-developper-user1` et le groupe `web-developper-group`, auquel nous attachons également la permission AmazonSSMManagedInstanceCore. 

L’utilisateur est ajouté au groupe et une clé d’accès est générée pour des connexions AWS CLI.

Nous associons nos instances EC2 contenant l'application Flask à notre rôle `ec2-backend-role`. Nous avons testé la connexion via un autre utilisateur et cela fonctionne parfaitement.

![Instance 1 linked to ec2backendrole](./assets/image-20250103122359982.png)

![Web Developper User 1 Groups](./assets/image-20250103122709717.png)

![Web Developper Group Permissions](./assets/image-20250103122720932.png)

#### AWS Inspector

Nous activons AWS Inspector pour analyser les vulnérabilités de nos ressources.

Nous obtenons le résultat suivant, tout à fait cohérent avec la structure de notre VPC.

![image-20250103115719415](./assets/image-20250103115719415.png)

Nos 2 instances dans notre subnet privé sont bel et bien accessibles en HTTP via le Loadbalancer sur le port 80. Notre instance dans notre subnet public (servant de rebond) est bien exposée publiquement sur le port 22.

# Améliorations 

###### Réseau (VPC & Subnets)

- Supprimer l’accès public direct à l'instance de rebond sur le port 22 (Systems Manager Session Manager)

- Utiliser un WAF (Web Application Firewall) pour protéger l'application Flask

###### Instances EC2

- Éliminer l’utilisation directe de clés SSH (utiliser AWS Systems Manager)

- Configurer des snapshots automatiques et réguliers via un Lifecycle Manager pour les volumes attachés aux instances.

###### Déploiement du code

- Mise en place d’une CI/CD avec GitHub Actions (ou équivalent GitLab) pour le déploiement de l'application Flask

- Passer l'application Flask à une image Docker et utiliser un registry (EKS par exemple)

###### Sécurité

- Automatiser les mises à jour logicielles des instances EC2 (AWS Systems Manager Patch Manager)

- Centraliser les logs avec AWS CloudWatch Logs Insights pour analyser les comportements considérés comme anormaux

###### Alarmes

- Ajouter d'autres alarmes pour surveiller encore davantage la santé des instances et des applications :
  - Memory Utilization
  - HTTP 4xx/5xx sur le Load Balancer

###### IAM

- Granularité des permissions : Créer des rôles spécifiques pour chaque type d’instance ou service. Dans notre cas, un rôle pour la gestion de base de données pourrait être fort intéressant.
- Surveillance des accès : Mettre en place des alertes via CloudWatch et AWS CloudTrail pour détecter les accès considérés comme anormaux ou non autorisés.
- Multi-Factor Authentication (MFA) : Activer le MFA pour tous les utilisateurs IAM ayant accès à des ressources critiques.
