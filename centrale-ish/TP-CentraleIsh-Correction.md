
Explication de la base :
- address : une adresse, si un "user_uuid" est renseigné, alors cette adresse est celle d'un utilisateur (en plus de potentiellement être celle d'une vente)
- brand : les marques de voiture
- favorite : les annonces mises en favoris par les utilisateurs
- fuel : les types de carburant
- image : les images des annonces
- listing : les annonces
- model : les modèles de voitures
- user : les utilisateurs


### 1/ Afficher les informations des utilisateurs et, s'ils en possèdent une, leur adresse 

Utilisation de "LEFT JOIN" car je veux récupérer TOUS les utilisateurs, même ceux qui n'ont pas renseigné d'adresse.

```sql
SELECT *
FROM user
LEFT JOIN address ON address.user_uuid = user.uuid;
```

### 2/ Afficher les 20 dernières annonces, on affichera seulement les colonnes suivantes : title, created_at, price et mileage. Price sera concaténé à "€" et mileage à "km" (PS : les prices sont en centimes, il faut les diviser par 100)

```sql
SELECT 	listing.title,
        listing.created_at,
        CONCAT(ROUND(listing.price/100, 2), '€') AS 'price',
        CONCAT(listing.mileage, 'km') AS 'km'

FROM listing
ORDER BY listing.created_at DESC
LIMIT 20;
```

### 3/ Afficher le nombre d'annonces par marque de voiture

```sql
SELECT  brand.name AS 'marque',
        COUNT(*)    

FROM brand

JOIN model ON model.brand_id = brand.id
JOIN listing ON listing.model_id = model.id

GROUP BY brand.name;
```

### 4/ Afficher les annonces de voitures de la marque "Renault" ayant au moins 50000km

```sql
SELECT *
FROM listing
JOIN model ON model.id = listing.model_id
JOIN brand ON brand.id = model.brand_id
WHERE listing.mileage >= 50000
AND brand.name = 'Renault';
```

### 5/ Afficher les annonces de voitures de la marque "Ford" ayant au moins 30000km et un prix maxmimum de 12000€ (Attention aux centimes...)

Solution en divisant le prix par 100
```sql
SELECT *
FROM listing
JOIN model ON model.id = listing.model_id
JOIN brand ON brand.id = model.brand_id
WHERE listing.mileage >= 30000
AND (listing.price/100) <= 12000
AND brand.name = 'Ford';
```

Solution en ajoutant 00 à la fin du 12000, ou en le multipliant par 100
```sql
SELECT *
FROM listing
JOIN model ON model.id = listing.model_id
JOIN brand ON brand.id = model.brand_id
WHERE listing.mileage >= 30000
AND listing.price <= 12000 * 100
AND brand.name = 'Ford';
```

### 6/ Afficher les emails des utilisateurs ayant fait au moins une annonce dans les 6 derniers mois

```sql
SELECT user.email
FROM user
JOIN listing ON listing.owner_uuid = user.uuid
WHERE listing.created_at >= (NOW() - INTERVAL 6 MONTH);
```

### 7/ Afficher le nombre d'annonces déposées par années (Exemple : "2025 → 10", "2024 → 59", etc...)

```sql
SELECT 	COUNT(*),
        YEAR(listing.created_at) AS `year`
FROM listing
GROUP BY `year`;
```

### 8/ Afficher les 5 modèles de voitures les plus mis en vente

```sql
SELECT model.name, COUNT(*) AS `nb`
FROM model
JOIN listing ON listing.model_id = model.id
GROUP BY model.name
ORDER BY `nb` DESC;
```

### 9/ Afficher les annonces pour les voitures Diesel

```sql
SELECT *
FROM listing
JOIN fuel ON fuel.id = listing.fuel_id
WHERE fuel.type = 'Diesel';
```

### 10/ Afficher les modèles de voiture n'ayant pas de modèle diesel en annonce

```sql
SELECT model.name, model.id
FROM model
WHERE model.id NOT IN (
	SELECT DISTINCT model_id
	FROM `listing`
	WHERE `fuel_id` = 2
);
```

### 11/ Afficher les 20 dernières annonces, mais de la page 3 (on considère que l'on a 20 annonces par page)

```sql
SELECT * 
FROM `listing`
ORDER BY created_at DESC
LIMIT 20 OFFSET 40;
```

### 12/ Afficher le nombre d'adresses enregistrées par ville, les trier par ordre décroissant

```sql
SELECT COUNT(*), address.city
FROM `address` 
GROUP BY address.city
ORDER BY COUNT(*) DESC;
```

### 13/ Afficher les adresses, dont le "street_name" est présent plus d'une fois (dans la table "address" !), et trier par ordre décroissant

```sql
SELECT COUNT(*) AS `nb`, address.street_name
FROM `address`
GROUP BY address.street_name
HAVING `nb` > 1
ORDER BY `nb` DESC;
```

### 14/ Afficher les user n'ayant pas défini d'adresses (leur "uuid" n'est pas présent dans la table "address")

Solution avec "LEFT JOIN" :

```sql
SELECT *
FROM user
LEFT JOIN address ON address.user_uuid = user.uuid
WHERE address.id IS NULL;
```

Solution avec requête imbriquée :

```sql
SELECT *
FROM user
WHERE user.uuid NOT IN (
    SELECT address.user_uuid
    FROM address
    WHERE address.user_uuid IS NOT NULL
);
```

### 15/ Afficher les annonces n'ayant aucune image (s'il y en a ?)

```sql
SELECT *
FROM listing
LEFT JOIN image ON image.listing_uuid = listing.uuid
WHERE image.uuid IS NULL;
```

### 16/ Afficher les annonces ayant plusieurs images

```sql
SELECT *, COUNT(*)
FROM listing
JOIN image ON image.listing_uuid = listing.uuid
GROUP BY image.listing_uuid
ORDER BY COUNT(*) DESC;
```

### 17/ Afficher par marque, leur somme totale mise en vente, les trier par ordre décroissant

```sql
SELECT  brand.name AS 'marque',
        SUM(listing.price) AS total

FROM brand

JOIN model ON model.brand_id = brand.id
JOIN listing ON listing.model_id = model.id

GROUP BY brand.name

ORDER BY total DESC;
```

### 18/ Afficher le nombre d'annonce déposée par mois, depuis le début de l'année 2025

```sql
SELECT MONTH(listing.created_at), COUNT(*)
FROM listing
WHERE listing.created_at LIKE '2025%'
GROUP BY MONTH(listing.created_at)
ORDER BY COUNT(*) DESC;
```