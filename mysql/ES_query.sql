-- Creazione del database
CREATE DATABASE IF NOT EXISTS Biblioteca;
USE Biblioteca;

-- Creazione della tabella "Libri"
CREATE TABLE IF NOT EXISTS Libri (
    ISBN VARCHAR(13) PRIMARY KEY,
    Titolo VARCHAR(100),
    Autore VARCHAR(50),
    AnnoPubblicazione INT,
    QuantitaInMagazzino INT
);

-- Inserimento di dati nella tabella "Libri"
INSERT INTO Libri (ISBN, Titolo, Autore, AnnoPubblicazione, QuantitaInMagazzino) VALUES
('9780544003415', 'Il Signore degli Anelli', 'J.R.R. Tolkien', 1954, 10),
('9780553803709', 'Il Codice Da Vinci', 'Dan Brown', 2003, 8),
('9780141441146', '1984', 'George Orwell', 1949, 12),
('9780061120084', 'Cronache di Narnia', 'C.S. Lewis', 1950, 15),
('9788807886655', 'Harry Potter e la Pietra Filosofale', 'J.K. Rowling', 1997, 20);

-- Creazione della tabella "Utenti"
CREATE TABLE IF NOT EXISTS Utenti (
    IDUtente INT PRIMARY KEY,
    Nome VARCHAR(50),
    Cognome VARCHAR(50),
    DataNascita DATE,
    Email VARCHAR(100)
);

-- Inserimento di dati nella tabella "Utenti"
INSERT INTO Utenti (IDUtente, Nome, Cognome, DataNascita, Email) VALUES
(1, 'Mario', 'Rossi', '1990-05-15', 'mario.rossi@email.com'),
(2, 'Luca', 'Verdi', '1985-09-22', 'luca.verdi@email.com'),
(3, 'Anna', 'Bianchi', '1995-03-10', 'anna.bianchi@email.com');

-- Creazione della tabella "Prestiti"
CREATE TABLE IF NOT EXISTS Prestiti (
    IDPrestito INT PRIMARY KEY,
    ISBNLibro VARCHAR(13),
    IDUtente INT,
    DataPrestito DATE,
    DataScadenza DATE,
    FOREIGN KEY (ISBNLibro) REFERENCES Libri(ISBN),
    FOREIGN KEY (IDUtente) REFERENCES Utenti(IDUtente)
);

-- Inserimento di dati nella tabella "Prestiti"
INSERT INTO Prestiti (IDPrestito, ISBNLibro, IDUtente, DataPrestito, DataScadenza) VALUES
(1, '9780544003415', 1, '2023-03-01', '2023-03-15'),
(2, '9780553803709', 2, '2023-03-05', '2023-03-20'),
(3, '9780141441146', 3, '2023-03-10', '2023-03-25');

-- Aggiunta di libri
INSERT INTO Libri (ISBN, Titolo, Autore, AnnoPubblicazione, QuantitaInMagazzino) VALUES
('9780061120085', 'Le Cronache del Ghiaccio e del Fuoco', 'George R.R. Martin', 1996, 5),
('9788804645238', 'Dune', 'Frank Herbert', 1965, 7),
('9788806180825', 'Norwegian Wood', 'Haruki Murakami', 1987, 10);

-- Aggiunta di utenti
INSERT INTO Utenti (IDUtente, Nome, Cognome, DataNascita, Email) VALUES
(4, 'Laura', 'Ferrari', '1988-07-20', 'laura.ferrari@email.com'),
(5, 'Riccardo', 'Russo', '1992-01-12', 'riccardo.russo@email.com'),
(6, 'Valeria', 'Galli', '1995-09-30', 'valeria.galli@email.com');

-- Aggiunta di prestiti
INSERT INTO Prestiti (IDPrestito, ISBNLibro, IDUtente, DataPrestito, DataScadenza) VALUES
(4, '9780061120085', 2, '2023-03-15', '2023-03-30'),
(5, '9788804645238', 1, '2023-03-18', '2023-04-02'),
(6, '9788806180825', 3, '2023-03-22', '2023-04-06');

-- Creazione della tabella "Autori"
CREATE TABLE IF NOT EXISTS Autori (
    ID INT AUTO_INCREMENT PRIMARY KEY,
    Nome VARCHAR(50),
    Nazionalita VARCHAR(50),
    Nascita DATE,
    Morte DATE
);

-- Inserimento di dati nella tabella "Autori"
INSERT INTO Autori (Nome, Nazionalita, Nascita, Morte) VALUES
('J.R.R. Tolkien', 'Inglese', '1892-01-03', '1973-09-02'),
('Dan Brown', 'Americano', '1964-06-22', NULL),
('George Orwell', 'Inglese', '1903-06-25', '1950-01-21'),
('C.S. Lewis', 'Irlandese', '1898-11-29', '1963-11-22'),
('J.K. Rowling', 'Inglese', '1965-07-31', NULL),
('George R.R. Martin', 'Americano', '1948-09-20', NULL),
('Frank Herbert', 'Americano', '1920-10-08', '1986-02-11'),
('Haruki Murakami', 'Giapponese', '1949-01-12', NULL);

-- Aggiornamento della tabella "Libri" per utilizzare l'ID dell'autore
UPDATE Libri
SET Autore = (SELECT ID FROM Autori WHERE Nome = 'J.R.R. Tolkien')
WHERE Autore = 'J.R.R. Tolkien';

UPDATE Libri
SET Autore = (SELECT ID FROM Autori WHERE Nome = 'Dan Brown')
WHERE Autore = 'Dan Brown';

UPDATE Libri
SET Autore = (SELECT ID FROM Autori WHERE Nome = 'George Orwell')
WHERE Autore = 'George Orwell';

UPDATE Libri
SET Autore = (SELECT ID FROM Autori WHERE Nome = 'C.S. Lewis')
WHERE Autore = 'C.S. Lewis';

UPDATE Libri
SET Autore = (SELECT ID FROM Autori WHERE Nome = 'J.K. Rowling')
WHERE Autore = 'J.K. Rowling';

UPDATE Libri
SET Autore = (SELECT ID FROM Autori WHERE Nome = 'George R.R. Martin')
WHERE Autore = 'George R.R. Martin';

UPDATE Libri
SET Autore = (SELECT ID FROM Autori WHERE Nome = 'Frank Herbert')
WHERE Autore = 'Frank Herbert';

UPDATE Libri
SET Autore = (SELECT ID FROM Autori WHERE Nome = 'Haruki Murakami')
WHERE Autore = 'Haruki Murakami';



-- -01- Seleziona tutti i libri pubblicati nel 1987 
SELECT * FROM Libri WHERE AnnoPubblicazione = 1987;

-- -02- Seleziona gli autori di nazionalità Americana 
SELECT * FROM Autori WHERE Nazionalita = 'Americano';

-- -03- Trova tutti i libri disponibili nel magazzino e pubblicati dopo il 2000:
SELECT l.Titolo FROM Libri l LEFT JOIN Prestiti p ON l.ISBN = p.ISBNLibro WHERE l.AnnoPubblicazione > 2000;

-- -04- Identifica i prestiti che sono scaduti, usa la funzione curdate() per ottenere la data corrente:
SELECT p.IDPrestito FROM Libri l JOIN Prestiti p ON l.ISBN = p.ISBNLibro WHERE p.DataScadenza < curdate();

-- -05- Proietta solo i titoli dei libri:
SELECT l.Titolo FROM Libri l;

-- -06- Proietta i nomi completi degli utenti:
SELECT u.Nome, u.Cognome FROM Utenti u;

-- -07- Elenco delle nazionalità uniche degli autori:
SELECT DISTINCT a.Nazionalita FROM Autori a;

-- -08- Alias per la "data di prestito" nella tabella Prestiti:
SELECT p.DataPrestito 'Data Prestito' FROM Prestiti p;

-- -09- Concatena il titolo e l'anno di pubblicazione dei libri e mostra questa colonna come "dettagli libro"
SELECT CONCAT (l.Titolo, ' - ', l.AnnoPubblicazione) AS 'Dettagli Libro'  FROM Libri l; 

-- -10- Elenco dei libri ordinati per anno di pubblicazione (decrescente):
SELECT Titolo, AnnoPubblicazione FROM Libri ORDER BY AnnoPubblicazione DESC;

-- -11- Elenco dei libri il cui titolo inizia con "Il":
SELECT * FROM Libri WHERE SUBSTRING(Titolo, 1, 2) = 'Il';

-- -12- Trova i libri il cui titolo contiene la parola 'Harry'.
SELECT * FROM Libri WHERE Titolo LIKE '%Harry%';

-- -13- Autori con un nome che contiene la lettera "a":
SELECT * FROM Autori WHERE Nome LIKE '%a%';

-- -14- Primi 5 libri ordinati per titolo:
SELECT * FROM Libri ORDER BY Titolo LIMIT 5;

-- -15- Prossimi 5 libri dopo i primi 5, ordinati per anno di pubblicazione:
SELECT * FROM Libri ORDER BY AnnoPubblicazione LIMIT 5 OFFSET 5;

-- -16- Libri pubblicati tra il 1980 e il 1990:
SELECT * FROM Libri WHERE AnnoPubblicazione >= 1980 AND AnnoPubblicazione <= 1990;

-- -17- Libri pubblicati dagli autori con id (1, 5 e 6):
SELECT * FROM Libri WHERE Autore IN (1, 5, 6);


