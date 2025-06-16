
Explication de la base :
- address : les adresses des utilisateurs
- category : les categories des produits vendus
- characteristic : les caractéristiques possible des produits, comme la "Matière", "La taille", "Le poids", etc
- comment : les commentaires des produits
- order : les commandes des utilisateurs
- product : les produits en ventes 
- product_categories : les catégories liés aux produits
- product_characteristic : les caractéristiques des produits
- product_order : les produits contenu dans une commande
- user : les utilisateurs
  
(PS : le price est en centimes, là encore il faut le diviser par 100 pour l'avoir en €, il faudra le faire à chaque fois que le prix sera demandé)

Récapitulatif des "status" de commande :
- 100 : à payer
- 110 : en cours de préparation
- 120 : livraison lancée
- 130 : en cours de livraison
- 140 : livrée

### 1/ Affichez les 9 produits les plus vendus, avec seulement les colonnes "product.id", "product.label", "product.price", "product.reference"

### 2/ Affichez les 4 catégories les plus vendus, avec seulement les colonnes "category.label", "category.id"

### 3/ Affichez les 9 produits vendus dernièrement, avec seulement les colonnes "product.id", "product.label", "product.price", "product.reference"

### 4/ Affichez les 4 derniers commentaires postés, avec seulement les colonnes : "product.id", "user.id", "user.username", "product.label", "review.rating", "review.created_at"

### 5/ Affichez les informations de l'utilisateur avec ses adresses, avec seulement les colonnes : "user.id", "user.username", "user.first_name", "user.last_name", "address.*"

### 6/ Affichez le ou les utilisateurs ayant renseigné le plus d'adresses

### 7/ Afficher les produits de la catégorie "Books" et de ses sous-catégories

### 8/ Affichez les produits de la catégorie "Books" et de ses sous-catégories, mais cette fois, ceux de la page 4, on affichera 12 produits par page. De plus, afficher le total de produits à afficher, par exemple pour faire un affichage comme celui-là : "48 sur 168"

### 9/ Affichez un récapitulatif des commandes de l'utilisateur, par exemple pour celui d'id "5". On affichera les colonnes suivantes : "order.address" (toutes les infos de celle-ci), "order.created_at", "order.status", "prix total de la commande" (à vous de trouver comment l'avoir... sachant que la colonne promotion est une réduction du prix de la commande en %)

