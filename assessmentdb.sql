--1.1 - 1.3:
DROP TABLE IF EXISTS contacts, contact_categories, contact_types, items CASCADE;


CREATE TABLE IF NOT EXISTS contacts(
	id SERIAL PRIMARY KEY,
	first_name VARCHAR(50),
	last_name VARCHAR(50),
	title VARCHAR(50),
	organization VARCHAR(50)	
);

CREATE TABLE IF NOT EXISTS contact_categories(
	id SERIAL PRIMARY KEY,
	contact_category VARCHAR(50)
);

CREATE TABLE IF NOT EXISTS contact_types(
	id SERIAL PRIMARY KEY,
	contact_type VARCHAR(50)
);


CREATE TABLE IF NOT EXISTS items(
	contact VARCHAR(50),
	contact_id INT REFERENCES contacts(id),
	contact_type_id INT REFERENCES contact_types(id),
	contact_category_id INT REFERENCES contact_categories(id)
);

--1.4 Add data from the examples:
INSERT INTO contacts (first_name, last_name, title, organization)
VALUES 
	('Erik', 'Eriksson', 'Teacher', 'Utbildning AB'),
	('Anna', 'Sundh', null, null),
	('Goran', 'Bregovic', 'Coach', 'Dalens IK'),
	('Ann-Marie', 'Bergqvist', 'Cousin', null),
	('Herman', 'Appelkvist', null, null);

INSERT INTO contact_categories (contact_category)
VALUES ('Home'), ('Work'), ('Fax');


INSERT INTO contact_types (contact_type)
VALUES ('Email'), ('Phone'), ('Skype'), ('Instagram');

INSERT INTO items
VALUES
	('011-12 33 45', 3, 2, 1),
	('goran@infoab.se', 3, 1, 2),
	('010-88 55 44', 4, 2, 2),
	('erik57@hotmail.com', 1, 1, 1),
	('@annapanna99', 2, 4, 1),
	('077-563578', 2, 2, 1),
	('070-156 22 78', 3, 2, 2);

--1.5 Add two more rows into the contact table, where one of them contains your own name.
INSERT INTO contacts (first_name, last_name, title, organization)
VALUES 
	('Minna', 'Viitanen', 'It consultant', 'Academic Works'),
	('Jon', 'Andersson', 'Cook', 'Restaurang AB');
	
	
--1.6 Create a query that lists if there are unused contact_types.
SELECT id FROM contact_types
WHERE id NOT IN (SELECT DISTINCT contact_type_id FROM items);

--1.7 Create a view view_contacts that lists the columns: first_name, last_name, contact, contact_type, contact_category.
CREATE VIEW view_contacts AS
SELECT 
	c.first_name, 
	c.last_name, 
	i.contact, 
	ct.contact_type, 
	cc.contact_category
FROM contacts c
LEFT JOIN items i ON c.id = i.contact_id
LEFT JOIN contact_types ct ON i.contact_type_id = ct.id
LEFT JOIN contact_categories cc ON i.contact_category_id = cc.id;

--1.8 Create a query that lists all information from the database.
SELECT * FROM contacts c
FULL JOIN items i ON c.id = i.contact_id
FULL JOIN contact_types ct ON i.contact_type_id = ct.id
FULL JOIN contact_categories cc ON i.contact_category_id = cc.id;





