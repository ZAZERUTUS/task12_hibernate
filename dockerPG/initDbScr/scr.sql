--CREATE SCHEMA test;
-- Создание таблицы House
CREATE TABLE IF NOT EXISTS house (
    id SERIAL PRIMARY KEY,
    uuid VARCHAR(255) NOT NULL,
    area INTEGER NOT NULL,
    country VARCHAR(255) NOT NULL,
    city VARCHAR(255) NOT NULL,
    street VARCHAR(255) NOT NULL,
    number VARCHAR(10) NOT NULL,
    create_date TIMESTAMP NOT NULL
);

-- Создание таблицы Person
CREATE TABLE IF NOT EXISTS person (
    id SERIAL PRIMARY KEY,
    uuid VARCHAR(255) NOT NULL,
    name VARCHAR(255) NOT NULL,
    surname VARCHAR(255) NOT NULL,
    sex VARCHAR(10) NOT NULL,
    passport_series VARCHAR(10) NOT NULL,
    passport_number VARCHAR(20) NOT NULL,
    create_date TIMESTAMP NOT NULL,
    update_date TIMESTAMP
);

-- Создание таблицы для связи многие ко многим между House и Person
CREATE TABLE IF NOT EXISTS house_person (
    house_id INTEGER NOT NULL,
    person_id INTEGER NOT NULL,
    PRIMARY KEY (house_id, person_id),
    FOREIGN KEY (house_id) REFERENCES house(id),
    FOREIGN KEY (person_id) REFERENCES person(id)
);

-- Вставка данных
INSERT INTO house (uuid, area, country, city, street, number, create_date)
VALUES
    ('house1-uuid', 100, 'Country1', 'City1', 'Street1', '1A', now()),
    ('house2-uuid', 120, 'Country2', 'City2', 'Street2', '2B', now()),
    ('house3-uuid', 150, 'Country3', 'City3', 'Street3', '3C', now()),
    ('house4-uuid', 80, 'Country4', 'City4', 'Street4', '4D', now()),
    ('house5-uuid', 200, 'Country5', 'City5', 'Street5', '5E', now());

INSERT INTO person (uuid, name, surname, sex, passport_series, passport_number, create_date, update_date)
VALUES
    ('person1-uuid', 'John', 'Doe', 'Male', 'AB', '123456', now(), now()),
    ('person2-uuid', 'Jane', 'Doe', 'Female', 'CD', '789012', now(), now()),
    ('person3-uuid', 'Alice', 'Smith', 'Female', 'EF', '345678', now(), now()),
    ('person4-uuid', 'Bob', 'Johnson', 'Male', 'GH', '901234', now(), now()),
    ('person5-uuid', 'Eva', 'Williams', 'Female', 'IJ', '567890', now(), now()),
    ('person6-uuid', 'Tom', 'Miller', 'Male', 'KL', '234567', now(), now()),
    ('person7-uuid', 'Sophia', 'Jones', 'Female', 'MN', '890123', now(), now()),
    ('person8-uuid', 'Daniel', 'Brown', 'Male', 'OP', '456789', now(), now()),
    ('person9-uuid', 'Olivia', 'Davis', 'Female', 'QR', '012345', now(), now()),
    ('person10-uuid', 'Mia', 'Martinez', 'Female', 'ST', '678901', now(), now());

INSERT INTO house_person (house_id, person_id) VALUES
    ((SELECT id FROM house WHERE uuid = 'house1-uuid'), (SELECT id FROM person WHERE uuid = 'person1-uuid')),
    ((SELECT id FROM house WHERE uuid = 'house2-uuid'), (SELECT id FROM person WHERE uuid = 'person2-uuid')),
    ((SELECT id FROM house WHERE uuid = 'house2-uuid'), (SELECT id FROM person WHERE uuid = 'person3-uuid')),
    ((SELECT id FROM house WHERE uuid = 'house3-uuid'), (SELECT id FROM person WHERE uuid = 'person4-uuid')),
    ((SELECT id FROM house WHERE uuid = 'house3-uuid'), (SELECT id FROM person WHERE uuid = 'person5-uuid')),
    ((SELECT id FROM house WHERE uuid = 'house4-uuid'), (SELECT id FROM person WHERE uuid = 'person6-uuid')),
    ((SELECT id FROM house WHERE uuid = 'house4-uuid'), (SELECT id FROM person WHERE uuid = 'person7-uuid')),
    ((SELECT id FROM house WHERE uuid = 'house5-uuid'), (SELECT id FROM person WHERE uuid = 'person8-uuid')),
    ((SELECT id FROM house WHERE uuid = 'house5-uuid'), (SELECT id FROM person WHERE uuid = 'person9-uuid')),
    ((SELECT id FROM house WHERE uuid = 'house5-uuid'), (SELECT id FROM person WHERE uuid = 'person10-uuid'));

--CREATE TYPE operations_type AS ENUM ('CASH_IN', 'CASH_OUT', 'TRANSFER');
--CREATE TYPE currency_type AS ENUM ('BYN', 'RUB', 'EUR');
--
--CREATE TABLE test.customers (
--    id SERIAL PRIMARY KEY,
--    name VARCHAR(255) NOT NULL,
--    last_name VARCHAR(255) NOT NULL,
--    second_name VARCHAR(255) NOT NULL,
--    dock_num VARCHAR(255) NOT NULL
--);
--
--INSERT INTO test.customers (name, last_name, second_name, dock_num) VALUES ('Владислав', 'Шишко', 'Васильевич', 'HB1231342144'),
--('Павел', 'Войтович', 'Олегович', 'HB1231342144'), ('Анатолий', 'Корнеевич', 'Киртлович', 'HB1231342144'), ('Иосиф', 'Карасевич', 'Васильевич', 'HB1231342144'),
--('Евгений', 'Грузинович', 'Дмитриевич', 'HB1231342144'), ('Михаил', 'Жмыхович', 'Ярославович', 'HB1231342144'),
--('Милана', 'Гусева', 'Андреевич', 'HB1231342144'), ('Антонина', 'Бессонова', 'Михайлович', 'HB1231342144'), ('Максим', 'Гончаров', 'Григорьевич', 'HB1231342144'),
--('Адам', 'Рожков', 'Платонович', 'HB1231342144'), ('Мария', 'Иванова', 'Миронович', 'HB1231342144');


--
--CREATE TABLE test.banks (
--    id SERIAL PRIMARY KEY,
--    bank_name VARCHAR(255) NOT NULL
--);
--
--INSERT INTO test.banks (bank_name) VALUES ('Alfa bank'), ('BPS bank'), ('BNB'), ('NewLevelBank'), ('Belarusbank');
--
--
--
--CREATE TABLE test.accounts (
--    id SERIAL PRIMARY KEY,
--    num VARCHAR(255) NOT NULL,
--    balance FLOAT NOT NULL,
--    account_currency currency_type DEFAULT 'RUB',
--    bank_id INT NOT NULL,
--    customer_id INT NOT NULL,
--    time_created timestamp DEFAULT current_timestamp,
--    time_last_interest_percent timestamp DEFAULT current_timestamp,
--    FOREIGN KEY (bank_id) REFERENCES test.banks (id) ON UPDATE CASCADE ON DELETE CASCADE,
--    FOREIGN KEY (customer_id) REFERENCES test.customers (id) ON UPDATE CASCADE ON DELETE CASCADE
--
--);
--
--INSERT INTO test.accounts (num, balance, bank_id, customer_id) VALUES
--('734724832492', '43554', 2, 1), ('2d73d24724832492', '1200', 4, 5),
--('283982348', '2000', 1, 1), ('dd2734724832492', '2100', 4, 6),
--('786798d768798', '351', 3, 1), ('d23d2d2d2', '2300', 5, 7),
--('ewdh729382', '102', 2, 2), ('c4f32f5g53323', '3500', 2, 8),
--('37980274', '32432', 3, 2), ('37980274', '31000', 3, 9),
--('477398ej37d9h', '3222', 2, 3), ('477398ej37d9h', '3222', 2, 3);
--
--INSERT INTO test.accounts (num, balance, bank_id, customer_id, time_created) VALUES
--('ewfefwe', '1000', 2, 11, '2023-08-01 12:00:00'), ('ewfefwe', '2000', 4, 10, '2023-07-05 12:00:00'),
--('f34f3f34f3', '1700.42', 4, 13, '2023-08-04 12:00:00'), ('vre43f3f3', '1000', 2, 12, '2022-08-01 12:00:00'),
--('f3gfc2r4f34f', '1900.22', 2, 14, '2023-07-01 12:00:00'), ('ed23fgvrece', '1000', 2, 14, '2023-08-01 12:00:00'),
--('wefwefw', '1074', 2, 15, '2022-07-21 12:00:00'), ('f4f3v2d2d', '4050', 2, 16, '2023-08-01 12:00:00'),
--('23d23rfe', '1000', 3, 17, '2023-08-11 12:00:00'), ('c34d23d32dd23dv', '1950', 1, 18, '2021-05-11 12:00:00'),
--('4325frfr', '120', 2, 19, '2023-01-11 12:00:00'), ('dc23f534', '2950', 1, 20, '2021-05-11 12:00:00'),
--('43fcvr34f2', '1000.2', 2, 21, '2021-01-01 12:00:00'), ('34fvc1dxr3v', '5950', 1, 22, '2021-09-11 12:00:00'),
--('52dcer3', '2345', 2, 23, '2022-11-01 12:00:00'), ('23f2rf42d', '2950', 1, 24, '2021-05-11 12:00:00'),
--('352fcvrtfvfd34', '1454.77', 2, 23, '2022-11-09 12:00:00'), ('f432fd2f232', '1950', 1, 21, '2021-05-11 12:00:00'),
--('4fg34f3f', '3444', 2, 13, '2022-05-06 12:00:00'), ('f23f4f2f', '1950', 1, 20, '2021-05-11 12:00:00'),
--('345gvdewefd4f4', '1000.8', 2, 8, '2021-01-01 12:00:00'), ('45f3f2f3f', '1950', 1, 18, '2021-05-11 12:00:00'),
--('g34g34tg', '3000', 2, 4, '2021-01-01 12:00:00'), ('43f22ee23e2', '5444', 1, 17, '2021-05-11 12:00:00'),
--('34g433g', '1400', 2, 18, '2021-01-01 12:00:00'), ('f34fewfr23e', '3000.55', 1, 8, '2021-05-11 12:00:00'),
--('g34g34g34', '2500', 2, 15, '2021-01-01 12:00:00'), ('3r32re23', '2135', 1, 7, '2021-05-11 12:00:00'),
--('fg43g3g34g', '1100', 2, 22, '2021-01-01 12:00:00'), ('43r34r23r2r', '3123', 1, 5, '2021-05-11 12:00:00'),
--('33243f2f2d', '1470', 2, 16, '2021-01-01 12:00:00'), ('rrf3f3r43f3', '1950', 1, 1, '2021-05-11 12:00:00');
--
--INSERT INTO test.accounts (num, balance, bank_id, customer_id, time_created, time_last_interest_percent) VALUES
--('ewfefwe', '1000', 2, 11, (CURRENT_DATE) - interval '41' day, (CURRENT_DATE) - interval '32' day),
--('ewfefwe', '2000', 4, 10, (CURRENT_DATE) - interval '41' day, (CURRENT_DATE) - interval '32' day),
--('f34f3f34f3', '1700.42', 4, 13, (CURRENT_DATE) - interval '41' day, (CURRENT_DATE) - interval '32' day),
--('vre43f3f3', '1500', 2, 12, (CURRENT_DATE) - interval '41' day, (CURRENT_DATE) - interval '32' day),
--('f3gfc2r4f34f', '19000.22', 2, 14, (CURRENT_DATE) - interval '41' day, (CURRENT_DATE) - interval '32' day),
--('ed23fgvrece', '10000', 2, 14, (CURRENT_DATE) - interval '41' day, (CURRENT_DATE) - interval '32' day);
--
--
--
--CREATE TABLE test.transactions (
--    id SERIAL PRIMARY KEY,
--    account_id_from INT NOT NULL,
--    account_id_to INT,
--    transaction_type operations_type NOT NULL,
--    sum_operation FLOAT,
--    time_transaction timestamp DEFAULT current_timestamp,
--    FOREIGN KEY (account_id_from) REFERENCES test.accounts (id) ON UPDATE CASCADE ON DELETE CASCADE,
--    FOREIGN KEY (account_id_from) REFERENCES test.accounts (id) ON UPDATE CASCADE ON DELETE CASCADE
--);
--
--INSERT INTO test.transactions (account_id_from, account_id_to, transaction_type, sum_operation, time_transaction) VALUES
--(1, 2, 'TRANSFER', 23.22, (CURRENT_DATE) - interval '1' day),
--(1, 32, 'TRANSFER', 103.22, (CURRENT_DATE) - interval '1' month),
--(1, 6, 'TRANSFER', 13.22, (CURRENT_DATE) - interval '3' day),
--(1, 27, 'TRANSFER', 23.22, (CURRENT_DATE) - interval '21' day),
--(8, 1, 'TRANSFER', 233.22, (CURRENT_DATE) - interval '4' month),
--(22, 1, 'TRANSFER', 1003.22, (CURRENT_DATE) - interval '1' year),
--(16, 1, 'TRANSFER', 43.22, (CURRENT_DATE) - interval '3' month),
--(29, 1, 'TRANSFER', 73.22, (CURRENT_DATE) - interval '2' month);