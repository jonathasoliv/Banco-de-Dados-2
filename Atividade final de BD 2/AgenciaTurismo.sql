create or replace type Endereco As object(pais varchar(40), cidade varchar(40), rua varchar(40), numero varchar(7));

create or replace type phone As object(celulares varchar(40), telefone varchar(40));

create or replace type CidadeType AS object (
Nome_Cidade varchar(20)
);


create or replace type CategoriaTypeHotel AS object (
nomeCategoriaHotel varchar(20)
);

create or replace type CategoriaTypeARRAYHotel AS VARRAY(7) OF CategoriaTypeHotel;

create or replace type Hotel AS object (
Code_Hotel integer,
Nome_Hotel varchar(20),
categorias CategoriaTypeARRAYHotel 
);

create or replace type Quarto AS object (
Numero_Quarto integer ,
Valor_Diaria float
);

create or replace type CategoriaType AS object (
nomeCategoria varchar(20)
);
//só aceita vetores de tipo
create or replace type CategoriaTypeARRAY AS VARRAY(7) OF CategoriaType;

create or replace type Restaurante AS object (
code_Restaurante integer,
nomeResta varchar(20),
categorias CategoriaTypeARRAY 
);

alter type Restaurante add attribute (Endereco_Rest ref Endereco) cascade;

create or replace type Ponto_Turistico AS object (
Cod_Turistico integer,
Descricao varchar(20)
);

alter type Ponto_Turistico add attribute (Endereco_Turistico ref Endereco) cascade;

create or replace type Museu AS object (
Numero_Sala integer,
Data_Fundacao varchar(20)
);

create or replace type Igreja AS object (
Data_Construcao date,
Estilo varchar(20)
);
//TIMESTAMP É UMA PALAVRA RESERVADA DO ORACLE 
create or replace type Casa_Show AS object (
Horario_Inicial varchar(8),
Horario_Final varchar(8)
);
//TIME='09:00:00'

create or replace type Fundadores AS object (
Nome_Fundador varchar(20),
Data_Nacimento date,
Data_Morte date,
Nacionalidade varchar(20),
Profissao varchar(20)
);

create table T_Endereco of Endereco;

create table T_Cidade of CidadeType; 

create table T_Hotel of Hotel (primary key(Code_Hotel));

create table T_Quarto of Quarto;

create table T_Restaurante of Restaurante (primary key(code_Restaurante));

create table T_Ponto_Turistico of Ponto_Turistico(primary key(Cod_Turistico));

create table T_Museu of Museu;

create table T_Igreja of Igreja;

create table T_Casa_Show of Casa_Show;

create table T_Fundadores of Fundadores;

insert into T_Cidade (SELECT CidadeType('Rio pomba') FROM DUAL);
insert into T_Cidade (SELECT CidadeType('Rio Janeiro') FROM DUAL);
insert into T_Cidade (SELECT CidadeType('São Paulo') FROM DUAL);
insert into T_Cidade (SELECT CidadeType('Bahia') FROM DUAL);

SELECT COUNT(*) FROM T_Cidade;


INSERT INTO T_Hotel (Code_Hotel, Nome_Hotel, categorias) VALUES (
  0, -- Code_Hotel
  'Hotel A', -- Nome_Hotel
  CategoriaTypeARRAYHotel( -- categorias
    CategoriaTypeHotel('0 Estrelas'),
    CategoriaTypeHotel('1 Estrelas'),
    CategoriaTypeHotel('2 Estrelas'),
    CategoriaTypeHotel('3 Estrelas'),
    CategoriaTypeHotel('4 Estrelas')
  )
);

INSERT INTO T_Hotel (Code_Hotel, Nome_Hotel, categorias) VALUES (
  1, -- Code_Hotel
  'Hotel B', -- Nome_Hotel
  CategoriaTypeARRAYHotel( -- categorias
    CategoriaTypeHotel('0 Estrelas'),
    CategoriaTypeHotel('1 Estrelas'),
    CategoriaTypeHotel('2 Estrelas'),
    CategoriaTypeHotel('3 Estrelas'),
    CategoriaTypeHotel('4 Estrelas')
  )
);

INSERT INTO T_Hotel (Code_Hotel, Nome_Hotel, categorias) VALUES (
  2, -- Code_Hotel
  'Hotel C', -- Nome_Hotel
  CategoriaTypeARRAYHotel( -- categorias
    CategoriaTypeHotel('0 Estrelas'),
    CategoriaTypeHotel('1 Estrelas'),
    CategoriaTypeHotel('2 Estrelas'),
    CategoriaTypeHotel('3 Estrelas'),
    CategoriaTypeHotel('4 Estrelas')
  )
);

INSERT INTO T_Hotel (Code_Hotel, Nome_Hotel, categorias) VALUES (
  3, -- Code_Hotel
  'Hotel DZ', -- Nome_Hotel
  CategoriaTypeARRAYHotel( -- categorias
    CategoriaTypeHotel('0 Estrelas'),
    CategoriaTypeHotel('1 Estrelas'),
    CategoriaTypeHotel('2 Estrelas'),
    CategoriaTypeHotel('3 Estrelas'),
    CategoriaTypeHotel('4 Estrelas')
  )
);

insert into T_Quarto (SELECT Quarto(1, 90.50) FROM DUAL);
insert into T_Quarto (SELECT Quarto(2,70.50) FROM DUAL);
insert into T_Quarto (SELECT Quarto(3,40) FROM DUAL);
insert into T_Quarto (SELECT Quarto(4,190) FROM DUAL);

INSERT INTO T_Restaurante (code_Restaurante, nomeResta, categorias, Endereco_Rest) VALUES (
  0,
  'Restaurante A',
  CategoriaTypeARRAY(
    CategoriaType('Simples'),
    CategoriaType('Luxo'),
    CategoriaType('Super Luxuoso')
  ),
  (SELECT REF(e) FROM T_Endereco e WHERE e.pais = 'Brasil' AND e.cidade = 'Rio de Janeiro' AND e.rua = 'Avenida X' AND e.numero = '123')
);

INSERT INTO T_Restaurante (code_Restaurante, nomeResta, categorias, Endereco_Rest) VALUES (
  1,
  'Restaurante B',
  CategoriaTypeARRAY(
    CategoriaType('Simples'),
    CategoriaType('Luxo'),
    CategoriaType('Super Luxuoso')
  ),
  (SELECT REF(e) FROM T_Endereco e WHERE e.pais = 'Brasil' AND e.cidade = 'Rio de Janeiro' AND e.rua = 'Avenida X' AND e.numero = '123')
);

SELECT * FROM T_Restaurante WHERE code_Restaurante = 0;

INSERT INTO T_Ponto_Turistico (Cod_Turistico, Descricao, Endereco_Turistico) VALUES (
  0,
  'Ponto_Turistico A',
  (SELECT REF(e) FROM T_Endereco e WHERE e.pais = 'Brasil' AND e.cidade = 'Rio de Janeiro' AND e.rua = 'Avenida X' AND e.numero = '123')
);

INSERT INTO T_Ponto_Turistico (Cod_Turistico, Descricao, Endereco_Turistico) VALUES (
  1,
  'Ponto_Turistico B',
  (SELECT REF(e) FROM T_Endereco e WHERE e.pais = 'Brasil' AND e.cidade = 'Rio de Janeiro' AND e.rua = 'Avenida X' AND e.numero = '123')
);

insert into T_Museu (SELECT Museu(1, '10/07/1990') FROM DUAL);
insert into T_Museu (SELECT Museu(2, '07/07/1890') FROM DUAL);

insert into T_Igreja (SELECT Igreja('07/07/1890', 'Catedrais') FROM DUAL);
insert into T_Igreja (SELECT Igreja('08/08/1777', 'Igreja Barroca') FROM DUAL);

insert into T_Casa_Show (SELECT Casa_Show('09:00:00', '18:00:00') FROM DUAL);
insert into T_Casa_Show (SELECT Casa_Show('07:00:00', '20:00:00') FROM DUAL);

insert into T_Fundadores (SELECT Fundadores('John Smith',DATE '1920-01-01',DATE '1940-01-03','BRA','Diretor') FROM DUAL);
insert into T_Fundadores (SELECT Fundadores('John Smith',DATE '1920-01-01',DATE '1980-01-01','EUA','Empresario') FROM DUAL);
insert into T_Fundadores (SELECT Fundadores('Jhon',DATE '1935-03-06',DATE '2000-05-05','ENG','Empresario') FROM DUAL);