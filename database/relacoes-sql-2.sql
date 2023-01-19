-- Active: 1673873944178@@127.0.0.1@3306

-- Prática 1

CREATE TABLE users (
    id TEXT PRIMARY KEY UNIQUE NOT NULL,
    name TEXT NOT NULL,
    email TEXT UNIQUE NOT NULL,
    password TEXT NOT NULL,
    created_at TEXT DEFAULT (DATETIME('now', 'localtime')) NOT NULL
);

INSERT INTO users (id, name, email, password)
VALUES
    ('u001', 'Fulano', 'fulano@email.com', 'fulano123'),
    ('u002', 'Ciclano', 'ciclano@email.com', 'ciclano123'),
    ('u003', 'Beltrano', 'beltrano@email.com', 'beltrano123');

SELECT * FROM users;

-- Prática 2

CREATE TABLE follows (
    follower_id TEXT NOT NULL,
    followed_id TEXT NOT NULL,
    FOREIGN KEY (follower_id) REFERENCES users(id),
    FOREIGN KEY (followed_id) REFERENCES users(id)
);

INSERT INTO follows (follower_id, followed_id)
VALUES
    ('u001', 'u002'), -- Pessoa A segue B
    ('u001', 'u003'), -- Pessoa A segue C
    ('u002', 'u001'); -- Pessoa B segue A

SELECT * FROM follows;

SELECT * FROM follows
INNER JOIN users
ON follows.follower_id = users.id;

-- Prática 3

SELECT * FROM follows
RIGHT JOIN users
ON follows.follower_id = users.id;

SELECT 
    follows.follower_id AS followerId,
    follows.followed_id AS followedId,
    users.name AS followerName,
    users.email AS followerEmail
FROM follows
RIGHT JOIN users
ON follows.follower_id = users.id
INNER JOIN users AS followedUsers
ON follows.followed_id = followedUsers.id;

-- Fixação

CREATE TABLE pessoas (
    id TEXT PRIMARY KEY UNIQUE NOT NULL,
    name TEXT NOT NULL,
    email TEXT UNIQUE NOT NULL
);

INSERT INTO pessoas (id, name, email)
VALUES
    ('p001', 'Fulano', 'fulano@email.com'),
    ('p002', 'Ciclano', 'ciclano@email.com'),
    ('p003', 'Beltrano', 'beltrano@email.com');

SELECT * FROM pessoas;

CREATE TABLE bancos (
    id TEXT PRIMARY KEY UNIQUE NOT NULL,
    name TEXT NOT NULL
);

INSERT INTO bancos (id, name)
VALUES
    ('b001', 'Santander'),
    ('b002', 'BTG'),
    ('b003', 'Inter'),
    ('b004', 'Itaú');

SELECT * FROM bancos;

CREATE TABLE pessoas_bancos (
    pessoa_id TEXT NOT NULL,
    banco_id TEXT NOT NULL,
    FOREIGN KEY (pessoa_id) REFERENCES pessoas(id),
    FOREIGN KEY (banco_id) REFERENCES bancos(id)
);

INSERT INTO pessoas_bancos (pessoa_id, banco_id)
VALUES
    ('p001', 'b001'),
    ('p001', 'b002'),
    ('p002', 'b001'),
    ('p002', 'b004'),
    ('p003', 'b003');

SELECT * FROM pessoas_bancos;

SELECT 
    pessoas.id AS pessoaId,
    pessoas.name AS pessoaName,
    pessoas.email AS pessoaEmail,
    bancos.id AS bankID,
    bancos.name AS bankName
FROM pessoas_bancos
INNER JOIN pessoas
ON pessoas_bancos.pessoa_id = pessoas.id
INNER JOIN bancos
ON pessoas_bancos.banco_id = bancos.id;