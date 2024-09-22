--DDL
CREATE TABLE Istruttore(
istruttoreID INT PRIMARY KEY IDENTITY(1,1),
nome VARCHAR(250) NOT NULL,
cognome VARCHAR(250) NOT NULL,
specializzazione VARCHAR(250) NOT NULL,
ora_inizio TIME NOT NULL CHECK (ora_inizio BETWEEN '7:00' AND '22:00'),
ora_fine TIME NOT NULL CHECK (ora_fine BETWEEN '8:00' AND '23:00')
);

CREATE TABLE Membro(
membroID INT PRIMARY KEY IDENTITY(1,1),
nome VARCHAR(250) NOT NULL,
cognome VARCHAR(250) NOT NULL,
data_nascita DATE NOT NULL CHECK (data_nascita >= '1900-01-01'),
sesso VARCHAR(1) CHECK(sesso IN ('F', 'M', 'A')),
email VARCHAR(250) NOT NULL,
telefono VARCHAR(20) NOT NULL, 
data_inizio DATE
);

ALTER TABLE Membro ADD CONSTRAINT CHK_date CHECK(data_inizio > data_nascita);

CREATE TABLE Abbonamento(
abbonamentoID INT PRIMARY KEY IDENTITY(1,1),
tipo VARCHAR(15) CHECK(tipo IN ('mensile', 'trimestrale', 'semestrale', 'annuale', 'biennale', 'triennale')),
prezzo DECIMAL(6,2) CHECK (prezzo > 0),
membroRIF INT,
FOREIGN KEY(membroRIF) REFERENCES Membro(membroID) ON DELETE CASCADE
);

CREATE TABLE Classe(
classeID INT PRIMARY KEY IDENTITY(1,1),
nome VARCHAR(250) NOT NULL,
descrizione TEXT,
orario TIME NOT NULL,
giorno VARCHAR(30) NOT NULL CHECK(giorno IN('lunedì', 'martedì', 'mercoledì', 'giovedì', 'venerdì', 'sabato', 'domenica')),
partecipanti INT CHECK (partecipanti >= 0),
istruttoreRIF INT NOT NULL,
FOREIGN KEY(istruttoreRIF) REFERENCES Istruttore(istruttoreID) ON DELETE CASCADE
);

CREATE TABLE Prenotazione(
prenotazioneID INT PRIMARY KEY IDENTITY(1,1),
data_classe DATE NOT NULL,
ora_classe TIME NOT NULL,
classeRIF INT,
membroRIF INT,
FOREIGN KEY (classeRIF) REFERENCES Classe(classeID) ON DELETE CASCADE,
FOREIGN KEY (membroRIF) REFERENCES Membro(membroID) ON DELETE CASCADE
);

CREATE TABLE Attrezzatura(
attrezzaturaID INT PRIMARY KEY IDENTITY(1,1),
descrizione TEXT NOT NULL,
data_acquisto DATE NOT NULL,
stato VARCHAR(50) CHECK (stato IN ('disponibile', 'in manutenzione', 'fuori servizio')),
classeRIF INT,
FOREIGN KEY (classeRIF) REFERENCES Classe(classeID) ON DELETE CASCADE
);

ALTER TABLE Attrezzatura ALTER COLUMN descrizione VARCHAR(250);

--DML

INSERT INTO Istruttore (nome, cognome, specializzazione, ora_inizio, ora_fine) VALUES
('Mario', 'Rossi', 'Yoga', '08:00', '12:00'),
('Luca', 'Bianchi', 'Pilates', '09:00', '13:00'),
('Laura', 'Verdi', 'Crossfit', '10:00', '14:00'),
('Sara', 'Gialli', 'Zumba', '07:30', '11:30'),
('Giorgio', 'Neri', 'Bodybuilding', '08:30', '12:30'),
('Carlo', 'Blu', 'Nuoto', '09:00', '13:00'),
('Anna', 'Viola', 'Yoga', '10:00', '12:00'),
('Elena', 'Rossi', 'Aerobica', '11:00', '15:00'),
('Davide', 'Bianchi', 'Crossfit', '07:00', '11:00'),
('Marco', 'Verdi', 'Boxe', '12:00', '16:00'),
('Giulia', 'Arancione', 'Pilates', '09:30', '13:30'),
('Stefano', 'Marrone', 'Nuoto', '10:30', '14:30'),
('Martina', 'Grigio', 'Zumba', '08:30', '12:30'),
('Paolo', 'Rosa', 'Yoga', '07:00', '11:00'),
('Claudio', 'Azzurro', 'Bodybuilding', '09:00', '13:00'),
('Silvia', 'Fucsia', 'Aerobica', '10:00', '14:00'),
('Alessandro', 'Neri', 'Crossfit', '11:00', '15:00'),
('Veronica', 'Blu', 'Pilates', '08:00', '12:00'),
('Lorenzo', 'Verdi', 'Boxe', '12:30', '16:30'),
('Francesca', 'Rossi', 'Zumba', '09:00', '13:00');

INSERT INTO Membro (nome, cognome, data_nascita, sesso, email, telefono, data_inizio) VALUES
('Giovanni', 'Esposito', '1990-05-12', 'M', 'giovanni.esposito@email.com', '1234567890', '2020-02-01'),
('Lucia', 'Russo', '1985-03-22', 'F', 'lucia.russo@email.com', '2345678901', '2019-07-15'),
('Alessandro', 'Ferrari', '1995-11-02', 'M', 'alessandro.ferrari@email.com', '3456789012', '2021-05-10'),
('Federica', 'Bianchi', '1992-06-18', 'F', 'federica.bianchi@email.com', '4567890123', '2018-01-20'),
('Paolo', 'Romano', '1987-09-14', 'M', 'paolo.romano@email.com', '5678901234', '2019-12-01'),
('Chiara', 'Gallo', '1998-08-30', 'F', 'chiara.gallo@email.com', '6789012345', '2021-09-21'),
('Antonio', 'Rizzo', '1975-07-05', 'M', 'antonio.rizzo@email.com', '7890123456', '2018-06-30'),
('Elisa', 'Barone', '1983-01-09', 'F', 'elisa.barone@email.com', '8901234567', '2022-02-25'),
('Stefano', 'Greco', '1990-04-21', 'M', 'stefano.greco@email.com', '9012345678', '2020-08-19'),
('Marta', 'Sartori', '1993-12-17', 'F', 'marta.sartori@email.com', '0123456789', '2017-05-02'),
('Giulia', 'Lombardi', '1985-10-25', 'F', 'giulia.lombardi@email.com', '1122334455', '2019-10-01'),
('Francesco', 'De Santis', '1992-07-07', 'M', 'francesco.desantis@email.com', '2233445566', '2021-07-18'),
('Laura', 'Marino', '1988-02-02', 'F', 'laura.marino@email.com', '3344556677', '2020-01-13'),
('Andrea', 'Conti', '1979-11-30', 'M', 'andrea.conti@email.com', '4455667788', '2018-11-09'),
('Sara', 'Leone', '1997-03-08', 'F', 'sara.leone@email.com', '5566778899', '2021-10-25'),
('Giuseppe', 'Colombo', '1986-05-06', 'M', 'giuseppe.colombo@email.com', '6677889900', '2017-09-14'),
('Valentina', 'Coppola', '1994-07-28', 'F', 'valentina.coppola@email.com', '7788990011', '2021-01-20'),
('Davide', 'D’Amico', '1991-09-22', 'M', 'davide.damico@email.com', '8899001122', '2018-04-17'),
('Matteo', 'Moretti', '1980-12-10', 'M', 'matteo.moretti@email.com', '9900112233', '2020-03-27'),
('Francesca', 'Parisi', '1996-06-15', 'F', 'francesca.parisi@email.com', '1011121314', '2021-11-11');


INSERT INTO Abbonamento (tipo, prezzo, membroRIF) VALUES
('mensile', 50.00, 1),
('trimestrale', 140.00, 2),
('annuale', 480.00, 3),
('mensile', 50.00, 4),
('semestrale', 250.00, 5),
('trimestrale', 140.00, 6),
('biennale', 900.00, 7),
('trimestrale', 140.00, 8),
('mensile', 50.00, 9),
('annuale', 480.00, 10),
('mensile', 50.00, 11),
('semestrale', 250.00, 12),
('biennale', 900.00, 13),
('trimestrale', 140.00, 14),
('annuale', 480.00, 15),
('mensile', 50.00, 16),
('triennale', 1200.00, 17),
('semestrale', 250.00, 18),
('trimestrale', 140.00, 19),
('mensile', 50.00, 20);

INSERT INTO Classe (nome, descrizione, orario, giorno, partecipanti, istruttoreRIF) VALUES
('Yoga Base', 'Classe di yoga per principianti', '09:00', 'martedì', 15, 2),
('Pilates Avanzato', 'Pilates per utenti esperti', '11:00', 'giovedì', 10, 3),
('Zumba', 'Lezione di ballo aerobico ad alta intensità', '18:00', 'martedì', 20, 4),
('Crossfit', 'Allenamento funzionale ad alta intensità', '07:00', 'mercoledì', 12, 5),
('Bodybuilding', 'Sessione di bodybuilding avanzato', '08:30', 'lunedì', 8, 1),
('Nuoto', 'Lezione di nuoto per principianti', '10:00', 'domenica', 6, 7),
('Aerobica', 'Lezione di aerobica per tutti i livelli', '17:00', 'lunedì', 25, 8),
('Boxe', 'Sessione di boxe avanzata', '19:00', 'mercoledì', 10, 6),
('Yoga Intermedio', 'Classe di yoga per livelli intermedi', '08:00', 'venerdì', 18, 9),
('Pilates Base', 'Pilates per principianti', '10:30', 'martedì', 12, 10),
('Crossfit Intermedio', 'Allenamento funzionale intermedio', '07:30', 'venerdì', 14, 11),
('Zumba Avanzata', 'Lezione di Zumba avanzata', '18:30', 'giovedì', 22, 12),
('Nuoto Avanzato', 'Lezione di nuoto per esperti', '11:00', 'martedì', 5, 13),
('Aerobica Intensiva', 'Lezione di aerobica ad alta intensità', '16:00', 'mercoledì', 28, 14),
('Bodybuilding Base', 'Sessione di bodybuilding per principianti', '09:30', 'sabato', 10, 15),
('Yoga Avanzato', 'Classe di yoga per utenti avanzati', '10:00', 'sabato', 12, 16 ),
('Zumba Base', 'Lezione di Zumba per principianti', '19:00', 'giovedì', 24, 17),
('Pilates Intermedio', 'Pilates per livelli intermedi', '08:30', 'lunedì', 16, 20),
('Crossfit Avanzato', 'Allenamento funzionale avanzato', '07:00', 'mercoledì', 10, 18),
('Bodybuilding Intermedio', 'Sessione di bodybuilding per livelli intermedi', '08:00', 'venerdì', 11, 19);

INSERT INTO Classe (nome, descrizione, orario, giorno, partecipanti, istruttoreRIF) VALUES
('FitBoxe', 'Allenamento aerobico-funzionale al sacco', '19:00', 'lunedì', 16, 8);


INSERT INTO Prenotazione (data_classe, ora_classe, classeRIF, membroRIF) VALUES
('2024-09-25', '09:00', 1, 1),       
('2024-09-26', '11:00', 2, 2),
('2024-09-27', '18:00', 3, 3),
('2024-09-28', '07:00', 4, 4),
('2024-09-29', '08:30', 5, 5),
('2024-09-30', '10:00', 6, 6),
('2024-10-01', '17:00', 7, 7),
('2024-10-02', '19:00', 8, 8),
('2024-10-03', '08:00', 9, 9),
('2024-10-04', '10:30', 10, 10),
('2024-10-05', '07:30', 11, 11),
('2024-10-06', '18:30', 12, 12),
('2024-10-07', '11:00', 13, 13),
('2024-10-08', '16:00', 14, 14),
('2024-10-09', '09:30', 15, 15),
('2024-10-10', '10:00', 16, 16),
('2024-10-11', '19:00', 17, 17),
('2024-10-12', '08:30', 18, 18),
('2024-10-13', '07:00', 19, 19),
('2024-10-14', '08:00', 20, 20),
('2024-10-15', '09:00', 1, 3),
('2024-10-16', '11:00', 2, 5),
('2024-10-17', '18:00', 3, 7),
('2024-10-18', '07:00', 4, 17),
('2024-10-19', '08:30', 5, 11),
('2024-10-20', '10:00', 6, 2),
('2024-10-21', '17:00', 7, 8),
('2024-10-22', '19:00', 8, 12),
('2024-10-23', '08:00', 9, 20),
('2024-10-24', '10:30', 10, 13),
('2024-10-05', '07:30', 11, 19),
('2024-10-23', '18:30', 12, 14),
('2024-10-24', '11:00', 13, 4),
('2024-10-25', '16:00', 14, 18),
('2024-10-26', '09:30', 15, 10),
('2024-10-27', '10:00', 16, 15),
('2024-10-28', '19:00', 17, 16),
('2024-10-29', '08:30', 18, 6),
('2024-10-30', '07:00', 19, 9),
('2024-10-31', '08:00', 20, 1),
('2024-11-3', '09:00', 1, 20),
('2024-11-4', '11:00', 2, 19),
('2024-11-5', '18:00', 3, 18),
('2024-11-6', '07:00', 4, 16),
('2024-11-7', '08:30', 5, 17),
('2024-11-8', '10:00', 6, 15),
('2024-11-9', '17:00', 7, 14),
('2024-11-10', '19:00', 8, 13),
('2024-11-11', '08:00', 9, 12),
('2024-11-12', '10:30', 10, 11),
('2024-11-13', '07:30', 11, 10),
('2024-11-14', '18:30', 12, 9),
('2024-11-15', '11:00', 13, 8),
('2024-11-16', '16:00', 14, 7),
('2024-11-17', '09:30', 15, 6),
('2024-11-18', '10:00', 16, 5),
('2024-11-19', '19:00', 17, 1),
('2024-11-20', '08:30', 18, 3),
('2024-11-21', '07:00', 19, 2),
('2024-11-22', '08:00', 20, 4),
('2024-11-23', '09:00', 1, 18),
('2024-11-24', '11:00', 2, 17),
('2024-11-25', '18:00', 3, 16),
('2024-11-26', '07:00', 4, 15),
('2024-11-27', '08:30', 5, 14),
('2024-11-28', '10:00', 6, 13),
('2024-11-29', '17:00', 7, 1),
('2024-11-30', '19:00', 8, 2),
('2024-12-1', '08:00', 9, 3),
('2024-12-2', '10:30', 10, 4),
('2024-12-3', '07:30', 11, 5),
('2024-12-4', '18:30', 12, 6),
('2024-12-5', '11:00', 13, 7),
('2024-12-6', '16:00', 14, 10),
('2024-12-7', '09:30', 15, 11),
('2024-12-9', '10:00', 16, 12),
('2024-12-10', '19:00', 17, 9),
('2024-12-11', '08:30', 18, 19),
('2024-12-12', '07:00', 19, 10),
('2024-12-13', '08:00', 20, 8);


SELECT * FROM Classe;
SELECT * FROM Membro;
SELECT * FROM Prenotazione;


INSERT INTO Attrezzatura (descrizione, data_acquisto, stato, classeRIF) VALUES
('Tapis roulant', '2021-01-15', 'disponibile',2),
('Bicicletta stazionaria', '2020-05-10', 'disponibile', 4),
('Manubri set completo', '2019-09-01', 'disponibile', 7),
('Panca per pesi', '2021-02-17', 'in manutenzione', 9),
('Macchina per leg press', '2020-08-12', 'disponibile', 10),
('Ellittica', '2019-12-20', 'fuori servizio', 1),
('Tapis roulant 2', '2022-01-05', 'disponibile', 5),
('Corda per saltare', '2018-06-22', 'disponibile', 7),
('Step per aerobica', '2020-11-30', 'disponibile', 13),
('Sacchi da boxe', '2021-03-14', 'disponibile', 12),
('Macchina per squat', '2020-07-01', 'disponibile', 3),
('Cyclette professionale', '2019-04-28', 'in manutenzione', 8),
('Bilanciere olimpico', '2022-07-11', 'disponibile', 19),
('Fitball', '2019-01-25', 'disponibile', 8),
('Macchina per pettorali', '2020-09-13', 'fuori servizio', 11),
('Macchina per lat pulldown', '2021-06-18', 'disponibile', 6),
('Kettlebell set', '2019-11-22', 'disponibile', 9),
('Banda elastica', '2020-03-03', 'disponibile', 10),
('Macchina per bicipiti', '2021-12-05', 'in manutenzione', 14),
('Barra per trazioni', '2019-08-09', 'disponibile', 15);

INSERT INTO Attrezzatura (descrizione, data_acquisto, stato, classeRIF) VALUES
('Tapis roulant 3', '2023-04-05', 'disponibile', 5),
('Macchina per tricipiti', '2023-12-07', 'disponibile', 14);


--QL
--Recupera tutti i membri registrati nel sistema
SELECT * FROM Membro;

--Recupera il nome e il cognome di tutti i membri che hanno un abbonamento mensile
SELECT nome, cognome, tipo
FROM Membro 
JOIN Abbonamento ON Membro.membroID = Abbonamento.membroRIF
WHERE tipo = 'mensile';

--Recupera l'elenco delle classi di yoga offerte dal centro fitness
SELECT * 
FROM Classe
WHERE nome LIKE '%Yoga%';

--Recupera il nome e cognome degli istruttori che insegnano Pilates
SELECT nome, cognome, specializzazione
FROM Istruttore
WHERE specializzazione = 'Pilates';

SELECT Istruttore.nome, Istruttore.cognome, Classe.nome
FROM Istruttore 
JOIN Classe ON Istruttore.istruttoreID = Classe.classeID
WHERE Classe.nome LIKE '%Pilates%';

--Recupera i dettagli delle classi programmate per il lunedì
SELECT * 
FROM Classe
WHERE giorno = 'lunedì';

--Recupera l'elenco dei membri che hanno prenotato una classe di Bodybuilding
SELECT * 
FROM Membro
JOIN Prenotazione ON Membro.membroID = Prenotazione.membroRIF
JOIN Classe ON Prenotazione.classeRIF = Classe.classeID
WHERE Classe.nome LIKE '%Bodybuilding%';

--Recupera tutte le attrezzature che sono attualmente fuori servizio
SELECT * 
FROM Attrezzatura
WHERE stato = 'fuori servizio';

--Conta il numero di partecipanti per ciascuna classe programmata per il mercoledì
SELECT COUNT(*) AS contatore
FROM Membro
JOIN Prenotazione ON Membro.membroID = Prenotazione.membroRIF
JOIN Classe ON Prenotazione.classeRIF = Classe.classeID
WHERE Classe.giorno = 'mercoledì';

/*SELECT COUNT(*) AS contatore
FROM Classe
JOIN Prenotazione ON Prenotazione.prenotazioneID = Classe.classeID
JOIN Membro ON Classe.classeID = Membro.membroID
WHERE Classe.giorno = 'mercoledì';*/


--Recupera l'elenco degli istruttori disponibili per tenere una lezione il sabato
SELECT *
FROM Istruttore
JOIN Classe ON Istruttore.istruttoreID = Classe.istruttoreRIF
WHERE giorno = 'sabato';

--Recupera tutti i membri che hanno un abbonamento attivo dal 2022
SELECT *
FROM Membro 
JOIN Abbonamento ON Membro.membroID = Abbonamento.membroRIF
WHERE data_inizio LIKE '%2022%';

--Trova il numero massimo di partecipanti per tutte le classi di boxe.
SELECT partecipanti
FROM Membro
JOIN Prenotazione ON Membro.membroID = Prenotazione.membroRIF
JOIN Classe ON Prenotazione.prenotazioneID = Classe.classeID
WHERE Classe.nome = 'Boxe';

--Recupera le prenotazioni effettuate da un membro specifico (Valentina Coppola)
SELECT *
FROM Membro
JOIN Prenotazione ON Membro.membroID = Prenotazione.membroRIF
WHERE nome = 'Valentina' AND cognome = 'Coppola';

--Recupera l'elenco degli istruttori che conducono più di 5 classi alla settimana
SELECT COUNT(*) AS contatore
FROM Istruttore
JOIN Classe ON Istruttore.istruttoreID = Classe.classeID
HAVING COUNT(*) > 5;

--Recupera le classi che hanno ancora posti disponibili per nuove prenotazioni

--Recupera l'elenco dei membri che hanno annullato una prenotazione negli ultimi 30 giorni

--Recupera tutte le attrezzature acquistate prima del 2022
SELECT * 
FROM Attrezzatura
WHERE data_acquisto < '2022-01-01';

--Recupera l'elenco dei membri che hanno prenotato una classe in cui l'istruttore è "Mario Rossi"
SELECT Membro.nome, Membro.cognome, Classe.nome, Istruttore.nome, Istruttore.cognome
FROM Membro 
JOIN Prenotazione ON Membro.membroID = Prenotazione.membroRIF
JOIN Classe ON Prenotazione.classeRIF = Classe.classeID
JOIN Istruttore ON Classe.classeID = Istruttore.istruttoreID
WHERE Istruttore.nome = 'Mario' AND Istruttore.cognome = 'Rossi';

--Calcola il numero totale di prenotazioni per ogni classe per un determinato periodo di tempo



--Trova tutte le classi associate a un istruttore specifico e i membri che vi hanno partecipato
SELECT Membro.nome, Membro.cognome, Classe.nome, Istruttore.nome
FROM Istruttore 
JOIN Classe ON Istruttore.istruttoreID = Classe.classeID
JOIN Prenotazione ON Classe.classeID = Prenotazione.classeRIF
JOIN Membro ON Prenotazione.membroRIF = Membro.membroID
WHERE Istruttore.nome = 'Claudio' AND Istruttore.cognome = 'Azzurro';


--Recupera tutte le attrezzature in manutenzione e il nome degli istruttori che le utilizzano nelle loro classi
SELECT *
FROM Attrezzatura 
JOIN Classe ON Attrezzatura.attrezzaturaID = Classe.classeID
JOIN Istruttore ON Classe.classeID = Istruttore.istruttoreID
WHERE stato = 'in manutenzione'; 


--VIEW
--Crea una view che mostra l'elenco completo dei membri con il loro nome, cognome e tipo di abbonamento
ALTER VIEW Elenco_Membri AS
SELECT nome, cognome, tipo
FROM Membro
JOIN Abbonamento ON Membro.membroID = Abbonamento.membroRIF;

SELECT * 
FROM Elenco_Membri;

--Crea una view che elenca tutte le classi disponibili con i rispettivi nomi degli istruttori
ALTER VIEW Elenco_Classi AS 
SELECT Classe.nome, Istruttore.nome AS istruttore_nome, Istruttore.cognome 
FROM Classe
JOIN Istruttore ON Classe.classeID = Istruttore.istruttoreID;

SELECT *
FROM Elenco_Classi;

--Crea una view che mostra le classi prenotate dai membri insieme al nome della classe e alla data di prenotazione
ALTER VIEW Classi_Prenotate AS
SELECT Classe.nome, data_classe, ora_classe
FROM Classe 
JOIN Prenotazione ON Classe.classeID = Prenotazione.classeRIF;

SELECT * 
FROM Classi_Prenotate;

--Crea una view che elenca tutte le attrezzature attualmente disponibili, con la descrizione e lo stato
CREATE VIEW Attrezzature_Disponibili AS
SELECT descrizione, stato
FROM Attrezzatura
WHERE stato = 'disponibile';

SELECT *
FROM Attrezzature_Disponibili;

--Crea una view che mostra i membri che hanno prenotato una classe di zumba negli ultimi 30 giorni
ALTER VIEW Prenotazioni_Crossfit AS
SELECT Membro.nome, Membro.cognome, Classe.nome AS classe_nome 
FROM Classe
JOIN Prenotazione ON Classe.classeID = Prenotazione.classeRIF
JOIN Membro ON Prenotazione.membroRIF = Membro.membroID
WHERE Classe.nome = 'Crossfit' AND data_classe > CURRENT_TIMESTAMP - 30; 

SELECT *
FROM Prenotazioni_Crossfit;

--Crea una view che elenca gli istruttori con il numero totale di classi che conducono
ALTER VIEW Tot_Classi_Istruttori AS
SELECT COUNT(*) AS contatore, Istruttore.nome AS istr_nome, Istruttore.cognome AS istr_cognome
FROM Classe
JOIN Istruttore ON Classe.istruttoreRIF = Istruttore.istruttoreID
GROUP BY Istruttore.nome, Istruttore.cognome;

SELECT *
FROM Tot_Classi_Istruttori;


--Crea una view che mostri il nome delle classi e il numero di partecipanti registrati per ciascuna classe
CREATE VIEW Classi_partecipanti AS
SELECT Classe.nome, partecipanti
FROM Classe;

SELECT *
FROM Classi_partecipanti;

--Crea una view che elenca i membri che hanno un abbonamento attivo insieme alla data di inizio e la data di scadenza
/*CREATE VIEW Membri_Abb_Attivo AS
FROM Membro

WHERE data_fine */


--Crea una view che mostra l'elenco degli istruttori che conducono classi il lunedì e il venerdì
ALTER VIEW Elenco_Istruttori_Lun_Ven AS
SELECT Istruttore.nome, Istruttore.cognome, Classe.nome AS classe_nome, giorno, orario
FROM Istruttore
JOIN Classe ON Istruttore.istruttoreID = Classe.istruttoreRIF
WHERE giorno = 'lunedì' OR giorno = 'venerdì';

SELECT *
FROM Elenco_Istruttori_Lun_Ven;


--Crea una view che elenca tutte le attrezzature acquistate nel 2023 insieme al loro stato attuale
CREATE VIEW Attrezzature_2023 AS
SELECT *
FROM Attrezzatura
WHERE data_acquisto LIKE '%2023%'; 

SELECT *
FROM Attrezzature_2023;


--SP
--Scrivi una stored procedure che permette di inserire un nuovo membro nel sistema con tutti i suoi dettagli, come nome, cognome, data di nascita, tipo di abbonamento, ecc...
CREATE PROCEDURE InserisciMembro 
	@Nome VARCHAR(250),
	@Cognome VARCHAR(250),
	@DataNascita DATE,
	@Sesso VARCHAR(1),
	@Email VARCHAR(250),
	@Telefono VARCHAR(20), 
	@DataInizio DATE
AS
BEGIN
	INSERT INTO Membro(nome, cognome, data_nascita, sesso, email, telefono, data_inizio) VALUES
	(@Nome, @Cognome, @DataNascita, @Sesso, @Email, @Telefono, @DataInizio);
END;

EXEC InserisciMembro @Nome = 'Emanuela', @Cognome = 'Rosi', @DataNascita = '1985-05-22', @Sesso = 'F', @Email = 'ema@rosi.com', @Telefono = '123678459', @DataInizio = '2023-12-16';

SELECT *
FROM Membro 
WHERE nome = 'Emanuela' AND cognome = 'Rosi';

--Scrivi una stored procedure per aggiornare lo stato di un'attrezzatura (ad esempio, disponibile, in manutenzione, fuori servizio)
ALTER PROCEDURE AggiornaStato 
@Stato VARCHAR(50),
@ID_Attrezzatura INT
AS
BEGIN
	UPDATE Attrezzatura
	SET stato = @Stato
	WHERE attrezzaturaID = @ID_Attrezzatura;
END;

EXEC AggiornaStato 'Diponibile', 12;

SELECT * 
FROM Attrezzatura
WHERE attrezzaturaID = 12;

SELECT * FROM Attrezzatura;


--Scrivi una stored procedure che consenta a un membro di prenotare una classe specifica
CREATE PROCEDURE PrenotaClasse
	@data DATE,
	@ora TIME,
	@classeRIF INT,
	@membroRIF INT

AS
BEGIN
	INSERT INTO Prenotazione (data_classe, ora_classe, classeRIF, membroRIF) VALUES
		(@data, @ora, @classeRIF, @membroRIF); 
END;
EXEC PrenotaClasse @data = '2024-10-01', @ora = '19:00', @classeRIF = '7', @membroRIF = '17'; 


--Scrivi una stored procedure per permettere ai membri di cancellare una prenotazione esistente
CREATE PROCEDURE CancellaPrenotazione 
	@pren_ID INT,
	@classe_RIF INT
	
AS
BEGIN
	IF @classe_RIF IS NULL
		BEGIN
			DELETE FROM Prenotazione
			WHERE prenotazioneID = @pren_ID
		END;
END;

EXEC CancellaPrenotazione @classe_RIF = NULL, @pren_ID = 3;

SELECT * FROM Prenotazione;


--Scrivi una stored procedure che restituisce il numero di classi condotte da un istruttore specifico.






