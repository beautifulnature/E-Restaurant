--- CREATE TABLES ---
DROP TRIGGER customer_delete;
DROP TABLE order_dishes;
DROP TABLE dish;
DROP TABLE dish_category;
DROP TABLE orders;
DROP TABLE customer;
DROP TABLE orders_status;
DROP TABLE employee;
DROP TABLE role;

CREATE TABLE role (
  id   INT          NOT NULL GENERATED BY DEFAULT AS IDENTITY ( START WITH 1, INCREMENT BY 1),
  name VARCHAR(100) NOT NULL,
  PRIMARY KEY (id)
);

CREATE TABLE employee (
  id        INT          NOT NULL GENERATED BY DEFAULT AS IDENTITY ( START WITH 1, INCREMENT BY 1),
  name      VARCHAR(100) NOT NULL,
  email     VARCHAR(100) NOT NULL UNIQUE,
  password  VARCHAR(100) NOT NULL,
  birthDate DATE,
  hireDate  DATE         NOT NULL,
  ready     BOOLEAN      NOT NULL,
  PRIMARY KEY (id),
  role_id   INT CONSTRAINT role_fk REFERENCES role
);

CREATE TABLE dish_category (
  id          INT          NOT NULL GENERATED BY DEFAULT AS IDENTITY ( START WITH 1, INCREMENT BY 1),
  name        VARCHAR(100) NOT NULL,
  description VARCHAR(500) NOT NULL,
  PRIMARY KEY (id)
);

CREATE TABLE dish (
  id               INT            NOT NULL GENERATED BY DEFAULT AS IDENTITY ( START WITH 1, INCREMENT BY 1),
  name             VARCHAR(100)   NOT NULL,
  description      VARCHAR(500)   NOT NULL,
  price            DECIMAL(15, 2) NOT NULL,
  kitchenmade      BOOLEAN        NOT NULL,
  available        BOOLEAN        NOT NULL,
  photo_url        VARCHAR(500),
  PRIMARY KEY (id),
  dish_category_id INT CONSTRAINT dish_category_fk REFERENCES dish_category
);

CREATE TABLE customer (
  id        INT          NOT NULL GENERATED BY DEFAULT AS IDENTITY ( START WITH 1, INCREMENT BY 1),
  name      VARCHAR(100) NOT NULL,
  email     VARCHAR(100) NOT NULL UNIQUE,
  password  VARCHAR(100) NOT NULL,
  address   VARCHAR(500) NOT NULL,
  birthDate DATE,
  blocked   BOOLEAN      NOT NULL DEFAULT FALSE,
  PRIMARY KEY (id)
);

CREATE TABLE orders_status (
  id   INT          NOT NULL GENERATED BY DEFAULT AS IDENTITY ( START WITH 1, INCREMENT BY 1),
  name VARCHAR(100) NOT NULL,
  PRIMARY KEY (id)
);

CREATE TABLE orders (
  id                  INT            NOT NULL                                  GENERATED BY DEFAULT AS IDENTITY ( START WITH 1, INCREMENT BY 1),
  date_time_taken     TIMESTAMP      NOT NULL,
  date_time_delivered TIMESTAMP,
  total_price         DECIMAL(15, 2) NOT NULL,
  PRIMARY KEY (id),
  orders_status_id    INT CONSTRAINT orders_status_fk REFERENCES orders_status DEFAULT 1,
  customer_id         INT CONSTRAINT customer_fk REFERENCES customer
);

CREATE TABLE order_dishes (
  id        INT            NOT NULL GENERATED BY DEFAULT AS IDENTITY ( START WITH 1, INCREMENT BY 1),
  quantity  INT            NOT NULL DEFAULT 2,
  price     DECIMAL(15, 2) NOT NULL,
  readiness BOOLEAN        NOT NULL DEFAULT FALSE,
  PRIMARY KEY (id),
  dish_id   INT CONSTRAINT dish_fk REFERENCES dish,
  orders_id INT CONSTRAINT orders_fk REFERENCES orders
);


--- FILL TABLES ---

INSERT INTO role (name) VALUES ('SUPER_USER');
INSERT INTO role (name) VALUES ('ADMIN');
INSERT INTO role (name) VALUES ('KITCHEN_STAFF');
INSERT INTO role (name) VALUES ('DELIVERY_STAFF');
INSERT INTO role (name) VALUES ('BUSINESS_ANALYST');

INSERT INTO employee (name, email, password, birthdate, hiredate, ready, role_id)
VALUES ('Dmytro Burdyga', 'super@erestaurant.com', 'pass1', '1984-06-27', '2010-01-01', TRUE, 1);
INSERT INTO employee (name, email, password, birthdate, hiredate, ready, role_id)
VALUES ('Igor Himchenko', 'admin@erestaurant.com', 'pass2', '1987-07-02', '2011-06-10', TRUE, 2);
INSERT INTO employee (name, email, password, birthdate, hiredate, ready, role_id)
VALUES ('Elena Bakhmach', 'kitchen@erestaurant.com', 'pass3', '1991-04-05', '2014-02-03', TRUE, 3);
INSERT INTO employee (name, email, password, birthdate, hiredate, ready, role_id)
VALUES ('Alexander Volkov', 'delivery@erestaurant.com', 'pass4', '1993-03-03', '2014-02-28', TRUE, 4);
INSERT INTO employee (name, email, password, birthdate, hiredate, ready, role_id)
VALUES ('Bogdana Tkachuk', 'business@erestaurant.com', 'pass5', '1979-11-15', '2010-01-20', TRUE, 5);

INSERT INTO dish_category (name, description)
VALUES ('SOUP',
        'Soup is a primarily liquid food, served warm (some kinds are cool cool or cold), made by combining ingredients such as meat and vegetables, juice, water, or another liquid.');
INSERT INTO dish_category (name, description)
VALUES ('SALAD',
        'Salad is a cold dish of various mixtures of raw and cooked vegetables, seasoned with oil, vinegar, or other dressing and sometimes accompanied by meat, fish, and other ingredients.');
INSERT INTO dish_category (name, description)
VALUES ('MAIN_COURSE',
        'The main course is the featured or primary dish in a meal consisting of several courses, it is the most substantial course of a meal.');
INSERT INTO dish_category (name, description)
VALUES ('DESSERT',
        'Dessert is the sweet course eaten at the end of a meal, such as: cake, pie, fruit, pudding, ice cream, etc. It is the fourth "meal" of the day following breakfast, lunch, and dinner.');
INSERT INTO dish_category (name, description)
VALUES ('DRINK',
        'Here you can order different cold beverages like juices, lemonades, soda, mineral water, and also some hot drinks like tea, espresso, latte, mochaccino.');

-- soups --
INSERT INTO dish (name, description, price, kitchenmade, available, photo_url, dish_category_id)
VALUES ('Tomato Soup',
        'Tomato soup is a soup made with tomatoes as the primary ingredient. It may be served hot or cold in a bowl.',
        4.20, TRUE, TRUE, 'resources/images/01_Tomato-Soup.jpg', 1);
INSERT INTO dish (name, description, price, kitchenmade, available, photo_url, dish_category_id)
VALUES ('Cream of mushroom soup',
        'Cream of mushroom soup is a soup where a basic roux is thinned with milk and then mushrooms and mushroom broth are added.',
        5.40, TRUE, TRUE, 'resources/images/02_Cream-Of-Mushroom-Soup.jpg', 1);
INSERT INTO dish (name, description, price, kitchenmade, available, photo_url, dish_category_id)
VALUES ('Miso soup',
        'Miso soup is a traditional Japanese soup consisting of a stock called "dashi" into which softened miso paste is mixed.',
        3.60, TRUE, TRUE, 'resources/images/03_Miso-Soup.jpg', 1);

-- salads --
INSERT INTO dish (name, description, price, kitchenmade, available, photo_url, dish_category_id)
VALUES ('Greek Salad',
        'Greek salad is made with tomatoes, cucumbers, onion, feta cheese and olives, seasoned with salt and oregano and dressed with olive oil.',
        5.50, TRUE, TRUE, 'resources/images/04_Greek-Salad.jpg', 2);
INSERT INTO dish (name, description, price, kitchenmade, available, photo_url, dish_category_id)
VALUES ('Avocado and Tuna Tapas',
        'This is a light, healthy Spanish tapa that goes best with crisp white wines and crunchy bread.',
        7.30, TRUE, TRUE, 'resources/images/05_Avocado-Tuna-Tapas.jpg', 2);
INSERT INTO dish (name, description, price, kitchenmade, available, photo_url, dish_category_id)
VALUES ('Caesar salad',
        'It is a salad of romaine lettuce and croutons dressed with parmesan cheese, lemon juice, olive oil, egg, garlic, and black pepper.',
        4.30, TRUE, TRUE, 'resources/images/06_Caesar-Salad.jpg', 2);

-- main course --
INSERT INTO dish (name, description, price, kitchenmade, available, photo_url, dish_category_id)
VALUES ('Baked Spaghetti',
        'Casserole of thin spaghetti pasta, sausage, mushroom, and tomato sauce, ricotta, Parmesan, and Mozzarella cheeses.',
        7.20, TRUE, TRUE, 'resources/images/07_Baked-Spaghetti.jpg', 3);
INSERT INTO dish (name, description, price, kitchenmade, available, photo_url, dish_category_id)
VALUES ('Beef Bourguignon',
        'Luxurious beef bourguignon, or beef Burgundy, with beef chuck, carrots, pearl onions, mushrooms, and coated with a deeply flavored, silky sauce.',
        8.20, TRUE, TRUE, 'resources/images/08_Beef-Bourguignon.jpg', 3);
INSERT INTO dish (NAME, description, price, kitchenmade, available, photo_url, dish_category_id)
VALUES ('Wild Salmon',
        'Grilled whole wild salmon, stuffed with a relish made of preserved lemons, parsley, dill, and shallots.',
        8.90, TRUE, TRUE, 'resources/images/09_Wild-Salmon.jpg', 3);

-- desserts --
INSERT INTO dish (name, description, price, kitchenmade, available, photo_url, dish_category_id)
VALUES ('Chocolate Fondue',
        'Chocolate fondue is easy and fun to make, a party favorite.  Dip fresh fruit and other dippables into the hot, melted creamy chocolate mixture.',
        5.10, TRUE, TRUE, 'resources/images/10_Chocolate-Fondue.jpg', 4);
INSERT INTO dish (name, description, price, kitchenmade, available, photo_url, dish_category_id)
VALUES ('Tapioca Pudding',
        'One of our favorite desserts growing up! This tapioca pudding recipe uses small pearl tapioca, milk, sugar, eggs, and vanilla.',
        4.20, TRUE, TRUE, 'resources/images/11_Tapioca-Pudding.jpg', 4);
INSERT INTO dish (name, description, price, kitchenmade, available, photo_url, dish_category_id)
VALUES ('Fruit Salad',
        'Blueberry, peach, nectarine fruit salad seasoned with fresh thyme, ginger, and lemon juice.',
        4.40, TRUE, TRUE, 'resources/images/12_Fruit-Salad.jpg', 4);

-- drinks --
INSERT INTO dish (name, description, price, kitchenmade, available, photo_url, dish_category_id)
VALUES ('Latte',
        'A Latte is a type of coffee made with espresso and hot steamed milk, milkier than a cappuccino.',
        4.90, TRUE, TRUE, 'resources/images/13_Latte.jpg', 5);
INSERT INTO dish (name, description, price, kitchenmade, available, photo_url, dish_category_id)
VALUES ('Tea',
        'Aromatic beverage prepared by pouring hot water over cured leaves of tea leaves.',
        3.40, TRUE, TRUE, 'resources/images/14_Tea.jpg', 5);
INSERT INTO dish (name, description, price, kitchenmade, available, photo_url, dish_category_id)
VALUES ('Juice',
        'Natural and healthy juices from different fruits and vegetables. Can be mixed in different variations.',
        4.50, TRUE, TRUE, 'resources/images/15_Juice.jpg', 5);
INSERT INTO dish (name, description, price, kitchenmade, available, photo_url, dish_category_id)
VALUES ('Cola',
        'A typical brown carbonated drink that is flavoured with an extract of cola nuts, or with a similar flavouring.',
        2.90, FALSE, TRUE, 'resources/images/16_Cola.jpg', 5);
INSERT INTO dish (name, description, price, kitchenmade, available, photo_url, dish_category_id)
VALUES ('Mineral water',
        'Water that contains mineral salts and natural carbon dioxide.',
        4.50, FALSE, TRUE, 'resources/images/17_Mineral-Water.jpg', 5);
INSERT INTO dish (name, description, price, kitchenmade, available, photo_url, dish_category_id)
VALUES ('Beer',
        'An alcoholic drink made from yeast-fermented malt flavoured with hops.',
        5.50, FALSE, FALSE, 'resources/images/18_Beer.jpg', 5);


INSERT INTO customer (name, email, password, address, birthDate)
VALUES ('Olga Romanova', 'olga.romanova@gmail.com', 'pass1', '27 Obolonsky Ave., App. 34, Kyiv', '1995-04-05');
INSERT INTO customer (name, email, password, address, birthDate)
VALUES ('Igor Shevchenko', 'igor.shevchenko@yahoo.com', 'pass2', '4 Khreschatik Str., App. 12, Kyiv', '1990-01-25');
INSERT INTO customer (name, email, password, address, birthDate)
VALUES ('Kate Belova', 'kate.belova@gmail.com', 'pass3', '3 Verbova Str., App. 7, Kyiv', '1987-01-17');
INSERT INTO customer (name, email, password, address, birthDate)
VALUES ('Roman Karetskiy', 'roman.karetskiy@gmail.com', 'pass4', '36 Ivana Lepse Str., App. 14, Kyiv', '1989-03-07');
INSERT INTO customer (name, email, password, address, birthDate)
VALUES ('Oksana Alekseeva', 'oksana.alekseeva@gmail.com', 'pass5', '29 Verkhniy Val Str., App. 4, Kyiv', '1982-02-18');

INSERT INTO orders_status (name)
VALUES ('KITCHEN_DONE');
INSERT INTO orders_status (name)
VALUES ('NON-KITCHEN_DONE');
INSERT INTO orders_status (name)
VALUES ('READY_FOR_SHIPMENT');
INSERT INTO orders_status (name)
VALUES ('DELIVERING');
INSERT INTO orders_status (name)
VALUES ('DELIVERED');

INSERT INTO orders (date_time_taken, date_time_delivered, total_price, orders_status_id, customer_id)
VALUES ('2015-12-01 15:21:10', '2015-10-17 16:21:10', 22.20, 4, 1);
INSERT INTO orders (date_time_taken, date_time_delivered, total_price, orders_status_id, customer_id)
VALUES ('2015-12-02 14:11:11', '2015-10-18 15:10:01', 8.00, 3, 2);
INSERT INTO orders (date_time_taken, date_time_delivered, total_price, orders_status_id, customer_id)
VALUES ('2015-12-03 15:59:50', '2015-10-19 16:25:04', 3.60, 4, 3);
INSERT INTO orders (date_time_taken, date_time_delivered, total_price, orders_status_id, customer_id)
VALUES ('2015-12-04 15:31:11', '2015-10-21 16:11:02', 51.90, 3, 4);
INSERT INTO orders (date_time_taken, date_time_delivered, total_price, orders_status_id, customer_id)
VALUES ('2015-12-05 12:11:19', '2015-10-16 13:34:11', 22.40, 3, 5);
INSERT INTO orders (date_time_taken, date_time_delivered, total_price, orders_status_id, customer_id)
VALUES ('2015-12-06 14:12:19', '2015-10-21 15:33:21', 16.90, 3, 4);
INSERT INTO orders (date_time_taken, date_time_delivered, total_price, orders_status_id, customer_id)
VALUES ('2015-12-07 01:11:09', '2015-10-21 02:03:02', 15.30, 1, 5);

INSERT INTO order_dishes (quantity, price, readiness, dish_id, orders_id)
VALUES (2, 8.40, FALSE, 1, 1);
INSERT INTO order_dishes (quantity, price, readiness, dish_id, orders_id)
VALUES (1, 5.40, FALSE, 2, 1);
INSERT INTO order_dishes (quantity, price, readiness, dish_id, orders_id)
VALUES (1, 5.40, FALSE, 2, 2);
INSERT INTO order_dishes (quantity, price, readiness, dish_id, orders_id)
VALUES (1, 3.60, FALSE, 3, 3);
INSERT INTO order_dishes (quantity, price, readiness, dish_id, orders_id)
VALUES (1, 5.50, FALSE, 4, 4);
INSERT INTO order_dishes (quantity, price, readiness, dish_id, orders_id)
VALUES (2, 14.60, FALSE, 5, 4);
INSERT INTO order_dishes (quantity, price, readiness, dish_id, orders_id)
VALUES (2, 8.60, FALSE, 6, 4);
--
INSERT INTO order_dishes (quantity, price, readiness, dish_id, orders_id)
VALUES (1, 4.20, FALSE, 1, 5);
INSERT INTO order_dishes (quantity, price, readiness, dish_id, orders_id)
VALUES (1, 5.50, FALSE, 4, 5);
INSERT INTO order_dishes (quantity, price, readiness, dish_id, orders_id)
VALUES (1, 8.20, FALSE, 8, 5);
INSERT INTO order_dishes (quantity, price, readiness, dish_id, orders_id)
VALUES (1, 4.50, FALSE, 15, 5);
--
INSERT INTO order_dishes (quantity, price, readiness, dish_id, orders_id)
VALUES (1, 2.90, TRUE, 16, 6);
INSERT INTO order_dishes (quantity, price, readiness, dish_id, orders_id)
VALUES (1, 4.30, FALSE, 6, 6);
INSERT INTO order_dishes (quantity, price, readiness, dish_id, orders_id)
VALUES (1, 4.20, FALSE, 1, 6);
INSERT INTO order_dishes (quantity, price, readiness, dish_id, orders_id)
VALUES (1, 5.50, FALSE, 4, 6);
--
INSERT INTO order_dishes (quantity, price, readiness, dish_id, orders_id)
VALUES (1, 5.50, FALSE, 1, 7);
INSERT INTO order_dishes (quantity, price, readiness, dish_id, orders_id)
VALUES (1, 5.50, FALSE, 4, 7);
INSERT INTO order_dishes (quantity, price, readiness, dish_id, orders_id)
VALUES (1, 4.30, FALSE, 6, 7);


--- TRIGGERS ---
CREATE TRIGGER customer_delete
AFTER DELETE ON customer
REFERENCING OLD_TABLE AS deleted_customer
FOR EACH STATEMENT MODE DB2SQL
  DELETE FROM orders
  WHERE customer_id IN
        (SELECT customer_id
         FROM deleted_customer);