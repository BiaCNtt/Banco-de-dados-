CREATE DATABASE IES_DDL_BIANCA
USE IES_DDL_BIANCA

CREATE TABLE IES(
	IES_codigo int IDENTITY(1,1) NOT NULL PRIMARY KEY,
	IES_nome varchar(40) NOT NULL
)
insert into IES(IES_nome)values('UNIFESP');
insert into IES(IES_nome)values('UFLA');
insert into IES(IES_nome)values('ITA');
insert into IES(IES_nome)values('IME');
insert into IES(IES_nome)values('UFSCAR');
insert into IES(IES_nome)values('IFSP');
insert into IES(IES_nome)values('UNESP');
insert into IES(IES_nome)values('ITA');
insert into IES(IES_nome)values('USP');

select *from IES

CREATE TABLE Pessoas(
	Pes_codigo int IDENTITY(1,1) NOT NULL PRIMARY KEY,
	Pes_nome varchar(40) NOT NULL
)	

INSERT INTO Pessoas(Pes_nome)VALUES('Catarina')
INSERT INTO Pessoas(Pes_nome)VALUES('Paulo')
INSERT INTO Pessoas(Pes_nome)VALUES('Julia')
INSERT INTO Pessoas(Pes_nome)VALUES('Tauani')
INSERT INTO Pessoas(Pes_nome)VALUES('Karen')
INSERT INTO Pessoas(Pes_nome)VALUES('Daniel')
INSERT INTO Pessoas(Pes_nome)VALUES('Regis')

select *from Pessoas


CREATE TABLE Clientes (
	Pes_codigo int NOT NULL PRIMARY KEY,
	Cli_cpf varchar(12) NOT NULL UNIQUE,
	Cli_email varchar(30) NULL,
	foreign key (Pes_codigo) references Pessoas(Pes_codigo)
)

INSERT Clientes(Pes_codigo,Cli_cpf,Cli_email) VALUES(1,412853,'Ricardo@gmail.com')
INSERT Clientes(Pes_codigo,Cli_cpf,Cli_email) VALUES(2,852963,'Patricia@gmail.com')
INSERT Clientes(Pes_codigo,Cli_cpf,Cli_email) VALUES(3,741852,'Sergio@gmail.com')
INSERT Clientes(Pes_codigo,Cli_cpf,Cli_email) VALUES(4,456987,'Catarina@gmail.com')

SELECT * FROM Clientes

CREATE TABLE Funcionarios(
	Pes_codigo int NOT NULL PRIMARY KEY,
	Fun_ch int NOT NULL,
	Fun_salario money NOT NULL,
	foreign key (Pes_codigo) references Pessoas(Pes_codigo)
)

insert into Funcionarios(Pes_codigo,Fun_ch,Fun_salario) values(5,50,3500.00)
insert into Funcionarios(Pes_codigo,Fun_ch,Fun_salario) values(6,80,7500.00)
insert into Funcionarios(Pes_codigo,Fun_ch,Fun_salario) values(7,90,8500.00)
insert into Funcionarios(Pes_codigo,Fun_ch,Fun_salario) values(8,70,15500.00)

select *from Funcionarios


CREATE TABLE Estagiarios(
	Pes_codigo int NOT NULL PRIMARY KEY,
	Est_data datetime NOT NULL,
	IES_codigo int NOT NULL,
	foreign key (IES_codigo) references IES(IES_codigo),
	foreign key (Pes_codigo) references Pessoas(Pes_codigo)
)


insert into Estagiarios(Pes_codigo,Est_data,IES_codigo) values(9,'2023-08-29 10:00:00',10);
insert into Estagiarios(Pes_codigo,Est_data,IES_codigo) values(10,'2023-08-15 15:00:00',6);
insert into Estagiarios(Pes_codigo,Est_data,IES_codigo) values(11,'2022-08-19 14:00:00',7);
