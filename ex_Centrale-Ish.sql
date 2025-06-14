
SELECT * FROM user LEFT JOIN address ON user.uuid = address.user_uuid;

------Afficher les informations des utilisateurs et, s'ils en possèdent une, leur adresse 
1
SELECT title, price, mileage
FROM listing
ORDER BY DESC
LIMIT 20;

------ Afficher les 20 dernières annonces, on affichera seulement les colonnes suivantes : title, created_at, price et mileage. Price sera concaténé à "€" et mileage à "km" (PS : les prices sont en centimes, il faut les diviser par 100)
2
SELECT 	listing.title,
        listing.created_at,
        CONCAT(ROUND(listing.price/100, 2), '€') AS 'price',
        CONCAT(listing.mileage, 'km') AS 'km'

------Afficher le nombre d'annonces par marque de voiture
3
SELECT  brand.name AS 'marque',
        COUNT(*)    

FROM brand

JOIN model ON model.brand_id = brand.id
JOIN listing ON listing.model_id = model.id

GROUP BY brand.name;

------------Afficher les annonces de voitures de la marque "Renault" ayant au moins 50000km
4
SELECT * FROM listing WHERE title LIKE '%Renault%' AND mileage < 50000;

------------Afficher les annonces de voitures de la marque "Ford" ayant au moins 30000km et un prix maxmimum de 12000€ (Attention aux centimes...)
5
SELECT * FROM listing WHERE title LIKE '%Ford%' AND mileage < 30000 AND price < 12000000;

------------Afficher les emails des utilisateurs ayant fait au moins une annonce dans les 6 derniers mois

6 *********SELECT * FROM user LEFT JOIN listing ON user.uuid = listing.user_uuid; *****

-------------Afficher le nombre d'annonces déposées par années (Exemple : "2025 → 10", "2024 → 59", etc...)

7 SELECT COUNT(*), YEAR (listing.created_at) AS année FROM listing GROUP BY année;

-------------Afficher les 5 modèles de voitures les plus mis en vente

8 SELECT COUNT(*), model.name FROM model JOIN listing ON model.brand_id = listing.model_id GROUP BY model.name ORDER BY model.name DESC LIMIT 5;

-------------Afficher les annonces pour les voitures Diesel

9 SELECT fuel.type, created_at, description, mileage, price, title FROM listing JOIN fuel ON listing.fuel_id = fuel.id WHERE fuel.type = 'Diesel';

--------------Afficher les modèles de voiture n'ayant pas de modèle diesel en annonce

10 SELECT model.name, model.id FROM model WHERE model.id NOT IN ( SELECT DISTINCT model_id FROM `listing` WHERE `fuel_id` = 2 );

---------------Afficher les 20 dernières annonces, mais de la page 3 (on considère que l'on a 20 annonces par page)

11 SELECT * FROM `listing` ORDER BY created_at DESC LIMIT 20 OFFSET 40;

---------------Afficher le nombre d'adresses enregistrées par ville, les trier par ordre décroissant

12 SELECT COUNT(*) , address.city FROM address GROUP BY address.city ORDER BY COUNT(*) DESC;

---------------Afficher les adresses, dont le "street_name" est présent plus d'une fois, et trier par ordre décroissant

13 SELECT COUNT(*), address.street_name FROM address GROUP BY address.street_name HAVING COUNT(*) > 1

---------------Afficher les user n'ayant pas défini d'adresses (leur "uuid" n'est pas présent dans la table "address")

14 SELECT user.uuid, last_name, address.street_name FROM user LEFT JOIN address ON address.user_uuid = user.uuid WHERE address.user_uuid IS null;

---------------Afficher les annonces n'ayant aucune image (s'il y en a ?)

15 FROM listing LEFT JOIN image ON image.listing_uuid = listing.uuid WHERE image.listing_uuid IS NULL;

---------------Afficher les annonces ayant plusieurs images

16 SELECT *, COUNT(*) FROM listing JOIN image ON image.listing_uuid = listing.uuid GROUP BY image.listing_uuid HAVING COUNT(*) > 1;

---------------Afficher par marque, leur somme totale mise en vente, les trier par ordre décroissant

17 