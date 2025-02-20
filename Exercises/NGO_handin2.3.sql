USE ngos;

INSERT INTO Supporter VALUES(12345, 'Alfred', '+@a.dk', 12345678, NULL, 'MDGA', NULL, TRUE);

UPDATE NGO SET name='KDG', cause='Keep Databases Great' WHERE name='MDGA';

DELETE FROM Supporter WHERE id=12345;

SELECT NGO.cause, NGO.director FROM Supporter JOIN NGO ON NGO.name = Supporter.ngo_name WHERE Supporter.name = "Ira Assent";

SELECT name, phone from Supporter WHERE phone IS NOT NULL AND city LIKE '%Aarhus%';

SELECT s.name, s.email FROM Supporter AS s JOIN Donations AS d ON d.s_id = s.id WHERE d.amount >= 968 ORDER BY s.name DESC;

SELECT DISTINCT s.name, s.phone FROM Supporter AS s JOIN Donations AS d on d.s_id = s.id WHERE d.activity='Water is a human right';
