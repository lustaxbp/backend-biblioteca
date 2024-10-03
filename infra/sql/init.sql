CREATE SEQUENCE seq_ra START 1;

CREATE TABLE Aluno (
    id_aluno SERIAL PRIMARY KEY,
    ra VARCHAR (7) UNIQUE NOT NULL,
    nome VARCHAR (80) NOT NULL,
    sobrenome VARCHAR (80) NOT NULL,
    data_nascimento DATE,
    endereco VARCHAR (200),
    email VARCHAR (80),
    celular VARCHAR (20) NOT NULL
);

CREATE OR REPLACE FUNCTION gerar_ra() RETURNS TRIGGER AS $$
BEGIN
    NEW.ra := 'AAA' || TO_CHAR(nextval('seq_ra'), 'FM0000');
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_gerar_ra
BEFORE INSERT ON Aluno
FOR EACH ROW EXECUTE FUNCTION gerar_ra();

CREATE TABLE Livro (
    id_livro SERIAL PRIMARY KEY,
    titulo VARCHAR (200) NOT NULL,
    autor VARCHAR (150) NOT NULL,
    editora VARCHAR (100) NOT NULL,
    ano_publicacao VARCHAR (5),
    isbn VARCHAR (20),
    quant_total INTEGER NOT NULL,
    quant_disponivel INTEGER NOT NULL,
    valor_aquisicao DECIMAL (10,2),
    status_livro_emprestado VARCHAR (20)
);


CREATE TABLE Emprestimo (
    id_emprestimo SERIAL PRIMARY KEY,
    id_aluno INT REFERENCES Aluno(id_aluno),
    id_livro INT REFERENCES Livro(id_livro),
    data_emprestimo DATE NOT NULL,
    data_devolucao DATE,
    status_emprestimo VARCHAR (20)
);



INSERT INTO Aluno (nome, sobrenome, data_nascimento, endereco, email, celular) 
VALUES 
('Conor', 'McGregor', '2005-01-15', 'Rua UFC, 123', 'mcgregor@ufc.com', '16998959876'),
('Amanda', 'Nunes', '2004-03-22', 'Rua UFC, 456', 'amanda.nunes@ufc.com', '16995992305'),
('Angelina', 'Jolie', '2003-07-10', 'Rua Hollywood, 789', 'jolie@cinema.com', '16991915502'),
('Natalie', 'Portman', '2002-11-05', 'Rua Hollywood, 101', 'natalie.portman@cinema.com', '16993930703'),
('Shaquille', 'ONeal', '2004-09-18', 'Rua NBA, 202', 'shaquille@gmail.com', '16993937030'),
('Harry', 'Kane', '2000-05-18', 'Rua Futebol, 2024', 'kane@futi.com', '16998951983'),
('Jaqueline', 'Carvalho', '2001-12-10', 'Rua Volei, 456', 'jack@volei.com', '16991993575'),
('Sheilla', 'Castro', '2003-04-25', 'Rua Volei, 2028', 'sheilla.castro@volei.com', '16981974547'),
('Gabriela', 'Guimarães', '2007-08-19', 'Rua Volei, 2028', 'gaby@volei.com', '16983932215'),
('Magic', 'Johnson', '2003-07-08', 'Rua NBA, 1999', 'magic@gmail.com', '16993932020');

INSERT INTO Aluno (nome, sobrenome, data_nascimento, endereco, email, celular) 
VALUES 
('LeBron', 'James', '2005-06-13', 'Rua NBA, 102', 'lebron.james@gmail.com', '16998765432'),
('Lionel', 'Messi', '2004-06-24', 'Rua Futebol, 505', 'messi@futbol.com', '16991234567'),
('Serena', 'Williams', '2003-09-26', 'Rua Tennis, 789', 'serena.williams@tennis.com', '16993216548'),
('Roger', 'Federer', '2001-08-08', 'Rua Tennis, 101', 'roger.federer@tennis.com', '16994827364'),
('Usain', 'Bolt', '2002-08-21', 'Rua Atletismo, 203', 'usain.bolt@speed.com', '16995738264'),
('Cristiano', 'Ronaldo', '2003-02-05', 'Rua Futebol, 707', 'ronaldo@futebol.com', '16996284930'),
('Michael', 'Phelps', '2005-06-30', 'Rua Natacao, 404', 'phelps@swim.com', '16991327485'),
('Simone', 'Biles', '2002-03-14', 'Rua Ginastica, 909', 'simone.biles@gym.com', '16992938475'),
('Tom', 'Brady', '2000-08-03', 'Rua Futebol Americano, 123', 'tom.brady@nfl.com', '16997648392'),
('Stephen', 'Curry', '2004-03-14', 'Rua NBA, 456', 'stephen.curry@gmail.com', '16994127485');




INSERT INTO Livro (titulo, autor, editora, ano_publicacao, isbn, quant_total, quant_disponivel, valor_aquisicao, status_livro_emprestado) 
VALUES 
('Cem Anos de Solidão', 'Gabriel García Márquez', 'Record', '1967', '9780060883287', 8, 8, 85.00, 'Disponível'),
('O Grande Gatsby', 'F. Scott Fitzgerald', 'Scribner', '1925', '9780743273565', 10, 10, 75.00, 'Disponível'),
('Crime e Castigo', 'Fiódor Dostoiévski', 'Companhia das Letras', '1866', '9788535914867', 6, 6, 95.00, 'Disponível'),
('Jane Eyre', 'Charlotte Brontë', 'Penguin Classics', '1847', '9780142437209', 5, 5, 80.00, 'Disponível'),
('O Apanhador no Campo de Centeio', 'J.D. Salinger', 'Little Brown', '1951', '9780316769488', 7, 7, 90.00, 'Disponível'),
('Os Miseráveis', 'Victor Hugo', 'Penguin Classics', '1862', '9780140444308', 4, 4, 120.00, 'Disponível'),
('A Odisséia', 'Homero', 'Penguin Classics', '800aC', '9780140268867', 6, 6, 70.00, 'Disponível'),
('Drácula', 'Bram Stoker', 'Penguin Classics', '1897', '9780141439846', 7, 7, 85.00, 'Disponível'),
('Frankenstein', 'Mary Shelley', 'Penguin Classics', '1818', '9780141439471', 9, 9, 75.00, 'Disponível'),
('O Sol é para Todos', 'Harper Lee', 'J.B. Lippincott & Co.', '1960', '9780060935467', 8, 8, 100.00, 'Disponível');

INSERT INTO Emprestimo (id_aluno, id_livro, data_emprestimo, data_devolucao, status_emprestimo) 
VALUES 
(1, 2, '2024-09-01', '2024-09-15', 'Em andamento'),
(2, 1, '2024-09-02', '2024-09-16', 'Em andamento'),
(3, 5, '2024-09-03', '2024-09-17', 'Em andamento'),
(5, 3, '2024-09-04', '2024-09-18', 'Em andamento'),
(4, 6, '2024-09-05', '2024-09-19', 'Em andamento'),
(6, 4, '2024-09-06', '2024-09-20', 'Em andamento'),
(7, 8, '2024-09-07', '2024-09-21', 'Em andamento'),
(8, 7, '2024-09-08', '2024-09-22', 'Em andamento'),
(10, 9, '2024-09-09', '2024-09-23', 'Em andamento'),
(9, 10, '2024-09-10', '2024-09-24', 'Em andamento'),
(1, 10, '2024-09-11', '2024-09-25', 'Em andamento'),
(2, 3, '2024-09-11', '2024-09-25', 'Em andamento'),
(4, 5, '2024-09-11', '2024-09-25', 'Em andamento'),
(6, 2, '2024-09-11', '2024-09-25', 'Em andamento');

INSERT INTO Emprestimo (id_aluno, id_livro, data_emprestimo, data_devolucao, status_emprestimo)
VALUES 
(1, 3, '2024-10-01', '2024-10-15', 'Em andamento'),
(2, 4, '2024-10-02', '2024-10-16', 'Em andamento'),
(3, 6, '2024-10-03', '2024-10-17', 'Em andamento'),
(5, 7, '2024-10-04', '2024-10-18', 'Em andamento'),
(4, 9, '2024-10-05', '2024-10-19', 'Em andamento'),
(6, 8, '2024-10-06', '2024-10-20', 'Em andamento'),
(7, 2, '2024-10-07', '2024-10-21', 'Em andamento'),
(8, 1, '2024-10-08', '2024-10-22', 'Em andamento'),
(9, 5, '2024-10-09', '2024-10-23', 'Em andamento'),
(10, 4, '2024-10-10', '2024-10-24', 'Em andamento');

SELECT 
    a.ra, 
    a.nome, 
    a.sobrenome, 
    a.celular, 
    l.titulo, 
    l.autor, 
    l.editora, 
    e.data_emprestimo, 
    e.data_devolucao, 
    e.status_emprestimo
FROM 
    Emprestimo e
JOIN 
    Aluno a ON e.id_aluno = a.id_aluno
JOIN 
    Livro l ON e.id_livro = l.id_livro;

