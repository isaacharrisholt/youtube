--------------------
/* Table creation */
--------------------

CREATE TABLE users (
        id INTEGER NOT NULL,
        name VARCHAR(50),
        PRIMARY KEY (id)
);

CREATE TABLE orders (
        id INTEGER NOT NULL,
        user_id INTEGER,
        description VARCHAR(50),
        payment_status BOOLEAN,
        PRIMARY KEY (id),
        FOREIGN KEY(user_id) REFERENCES users (id)
);


-------------
/* Queries */
-------------

/* Naive Python implementation */
SELECT *
FROM orders
WHERE NOT payment_status

-- Loop over the results from previous query
-- and run this select each time
SELECT *
FROM users
WHERE id = '{{ user_id }}'


/* SQL implementation */
SELECT DISTINCT users.*
FROM users
INNER JOIN orders
  ON users.id = orders.user_id
WHERE NOT orders.payment_status
