
Explication de la base :
- address : une adresse, si un "user_uuid" est renseigné, alors cette adresse est celle d'un utilisateur (en plus de potentiellement être celle d'une vente)
- brand : les marques de voiture
- favorite : les annonces mises en favoris par les utilisateurs
- fuel : les types de carburant
- image : les images des annonces
- listing : les annonces
- model : les modèles de voitures
- user : les utilisateurs


# 1/ Afficher les informations des utilisateurs et, s'ils en possèdent une, leur adresse 

Utilisation de "LEFT JOIN" car je veux récupérer TOUS les utilisateurs, même ceux qui n'ont pas renseigné d'adresse.

```sql
SELECT *
FROM user
LEFT JOIN address ON address.user_uuid = user.uuid;
```

# 2/ Afficher les 20 dernières annonces, on affichera seulement les colonnes suivantes : title, created_at, price et mileage. Price sera concaténé à "€" et mileage à "km" (PS : les prices sont en centimes, il faut les diviser par 100)

```sql
SELECT 	listing.title,
        listing.created_at,
        CONCAT(ROUND(listing.price/100, 2), '€') AS 'price',
        CONCAT(listing.mileage, 'km') AS 'km'

FROM listing
ORDER BY listing.created_at DESC
LIMIT 20;
```

# 3/ Afficher le nombre d'annonces par marque de voiture

```sql
SELECT  brand.name AS 'marque',
        COUNT(*)    

FROM brand

JOIN model ON model.brand_id = brand.id
JOIN listing ON listing.model_id = model.id

GROUP BY brand.name;
```

# 4/ Afficher les annonces de voitures de la marque "Renault" ayant au moins 50000km

# 5/ Afficher les annonces de voitures de la marque "Ford" ayant au moins 30000km et un prix maxmimum de 12000€ (Attention aux centimes...)

# 6/ Afficher les emails des utilisateurs ayant fait au moins une annonce dans les 6 derniers mois

# 7/ Afficher le nombre d'annonces déposées par années (Exemple : "2025 → 10", "2024 → 59", etc...)

# 8/ Afficher les 5 modèles de voitures les plus mis en vente

# 9/ Afficher les annonces pour les voitures Diesel

# 10/ Afficher les modèles de voiture n'ayant pas de modèle diesel en annonce

# 11/ Afficher les 20 dernières annonces, mais de la page 3 (on considère que l'on a 20 annonces par page)

# 12/ Afficher le nombre d'adresses enregistrées par ville, les trier par ordre décroissant

# 13/ Afficher les adresses, dont le "street_name" est présent plus d'une fois, et trier par ordre décroissant

# 14/ Afficher les user n'ayant pas défini d'adresses (leur "uuid" n'est pas présent dans la table "address")

# 15/ Afficher les annonces n'ayant aucune image (s'il y en a ?)

# 16/ Afficher les annonces ayant plusieurs images

# 17/ Afficher par marque, leur somme totale mise en vente, les trier par ordre décroissant

# 18/ Afficher le nombre d'annonce déposée par mois, depuis le début de l'année 2025