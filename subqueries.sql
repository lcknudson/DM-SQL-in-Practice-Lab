
-- Problems
-- Open up the postgres sandbox to complete these problems. Save your answers in a file subqueries.sql. Push to GitHub when you’re done.

-- 1.  Get all invoices where the unit_price on the invoice_line is greater than $0.99.

SELECT *
FROM invoice
WHERE invoice_id IN (
    SELECT invoice_id
    FROM invoice_line
    WHERE unit_price > 0.99
);

-- 2. Get all playlist tracks where the playlist name is Music.
SELECT *
FROM playlist_track
WHERE playlist_id IN (
  	SELECT playlist_id
  	FROM playlist
  	WHERE name = 'Music'
 );


-- 3. Get all track names for playlist_id 5.
SELECT *
FROM track
WHERE track_id IN (
  	SELECT track_id
  	FROM playlist_track
  	WHERE playlist_id = 5
 );


-- 4. Get all tracks where the genre is Comedy.
SELECT *
FROM track
WHERE genre_id IN (
  	SELECT genre_id
  	FROM genre
  	WHERE name = 'Comedy'
);


-- 5. Get all tracks where the album is Fireball.
SELECT *
FROM track
WHERE album_id IN (
  	SELECT album_id
  	FROM album
  	WHERE title = 'Fireball'
);


-- 6. Get all tracks for the artist Queen ( 2 nested subqueries ).
SELECT *
FROM track
WHERE album_id IN (
  	SELECT album_id
  	FROM album
  	WHERE artist_id IN (
      SELECT artist_id
      FROM artist 
      WHERE name = 'Queen'
     )
);






-- The code below is to follow along with the examples in the handout
-- I've shifted this down even though it's earlier in teh exercise. 

CREATE TABLE authors (
    author_id SERIAL PRIMARY KEY,
    author VARCHAR(255) NOT NULL
);

CREATE TABLE books (
    book_id SERIAL PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    pages INTEGER NOT NULL,
    author_id INTEGER REFERENCES authors(author_id)
);

INSERT INTO authors (author_id, author)
VALUES (1, 'Hawkins'), (2, 'Gold'), (3, 'Williams'), (4, 'Anderson');

INSERT INTO books (book_id, title, pages, author_id)
VALUES (1, 'Big Book', 2300, 2),
       (2, 'Book', 400, 4),
       (3, 'Tiny Book', 8, 1),
       (4, 'The Book', 1500, 3);

SELECT *
FROM authors
WHERE author_id IN (
  SELECT author_id FROM books WHERE pages > 1000
);


--What if you wanted to update the number of page’s in “Tiny Book” but didn’t know its book_id? Use a subquery!
UPDATE books
SET pages = 7
WHERE book_id IN (
  SELECT book_id
  FROM books
  WHERE title = 'Tiny Book'
);

-- Delete Using a Subquery
-- We could do a similar thing to delete data.

DELETE
FROM books
WHERE author_id IN (
  SELECT author_id
  FROM authors
  WHERE author = 'Williams'
);