-- aula 03/10/2023

--1 - Faça um trigger com variáveis para, ao invés de inserir uma peça com os valores que o usuário informou, 
--não deixe o preço da peça ser inferior a 5. 
create trigger ex1L2TR on peca  instead of insert 
as begin
declare @PeNro int
declare @PeNome varchar
declare @PePreco decimal
declare @Pecor varchar
set @PeNro = (select PeNro from inserted)
set @PeNome = (select PeNome from inserted)
set @PePreco = (select PePreco from inserted)
set @Pecor = (select PeCor from inserted)
if(@PePreco < 5)
begin 
insert into peca values (@PeNro, @PeNome,5,@PeCor)
end
else
insert into peca values (@PeNro, @PeNome,@PePreco,@PeCor)
end


insert Peca values (88,'fone',4,'rosa') 
select*from peca


--2 – Crie um Trigger que ao invés de excluir os fornecedores que não são das categorias ‘A’, ‘B’ e ‘C’,
-- atualize suas categorias para ‘C’. 

create trigger ex2L2 on Fornecedor instead of delete
as begin
	Update Fornecedor set FCateg = 'C' 
		Where Fornecedor.FNro in (select FNro from deleted)
			and FCateg not in ('A', 'B', 'C')
end
delete from fornecedor where FCateg = 'D'
select*from fornecedor

--3 - Ao se inserir um projeto, verificar se o custo está acima do permitido (50000). Se for, incluir com o limite de 50.000. 
--Se não, incluir com o valor passado. 
create Trigger ex3L2a on Projeto for insert as begin
	Declare @custo float 
	SELECT @custo = PCusto FROM inserted
IF @custo > 50000
    BEGIN
	-- PRINT 'Entrou aqui em'
        UPDATE Projeto
        SET PCusto = 50000
        WHERE PNro IN (SELECT PNro FROM inserted)
    END
    ELSE
    BEGIN
        PRINT 'SERÁ INCLUIDO O VALOR PASSADO'
        UPDATE Projeto
        SET PCusto = @custo
        WHERE PNro IN (SELECT PNro FROM inserted)
    END
END
 insert into Projeto values (9, 'teste3', 3, 50001) 
  insert into Projeto values (7, 'teste', 3, 4000) 
select * from Projeto

drop table Historico_Projeto

--4 - Criar uma tabela de Historico de Projetos. 
create table Historico_Projeto (
	Nro int not null PRIMARY KEY,
    DataAlteracao DATETIME NOT NULL, 
    PNro INT NOT NULL, 
    CampoAlterado VARCHAR(255) NOT NULL, 
    ValorAntigo float, 
    ValorNovo float  
)

ALTER TABLE Historico_Projeto
ADD CONSTRAINT FK_Historico_Projeto
FOREIGN KEY (PNro) REFERENCES Projeto(Nro);

--5 - Criar um trigger para atualizar a tabela Histórico de Projetos que é disparado quando houver a modificação SOMENTE no atributo 
--PDuração no Projeto. 
CREATE TRIGGER Ex5L2tr ON Projeto AFTER UPDATE
AS
BEGIN
    IF UPDATE(PDuracao)
    BEGIN
        INSERT INTO Historico_Projetos values (@DataAlteracao,@PNro,@CampoAlterado,@ValorAntigo,@ValorNovo)
        SELECT
            GETDATE(),  
            i.PNro,    
            'Duracao alterada',
            d.PDuracao,
            i.PDuracao  -- Valor novo do campo (após a atualização)
        FROM inserted i
        JOIN deleted d ON i.PNro = d.PNro;
    END
END;
--6 - Criar 2 tabelas: Projeto_atualizado e Projeto_antigo 
create table Pj_atualizado(
	[PNro_atual] int NOT NULL,
	[PNome_atual] varchar(30) NOT NULL,
	[PDuracao_atual] varchar(15) NOT NULL,
	[PCusto_atual] money NOT NULL,
)
create table Pj_antigo (
	[PNro_ant] int NOT NULL,
	[PNome_ant] varchar(30) NOT NULL,
	[PDuracao_ant] varchar(15) NOT NULL,
	[PCusto_ant]  money NOT NULL,
)

--7 - Criar um trigger que armazena em uma tabela os dados atualizados do Projeto(Projeto_atualizado) e 
--em outra tabela os dados do Projeto antes de atualizar (Projeto_antigo)
-- Trigger para armazenar dados atualizados em Projeto_atualizado
drop trigger EX7L2
CREATE TRIGGER Ex7L2 ON ProjetO AFTER UPDATE
AS
BEGIN
	BEGIN
		INSERT INTO Pj_atualizado(PNro_atual, PNome_atual, PDuracao_atual, PCusto_atual)
		SELECT PNro, PNome, PDuracao, PCusto
		FROM inserted
END
BEGIN
    INSERT INTO Pj_antigo (PNro_ant, PNome_ant, PDuracao_ant, PCusto_ant)
    SELECT PNro, PNome,PDuracao, PCusto 
    FROM deleted 
END 
END
INSERT INTO Projeto VALUES (10, 'PROJ10', '10', 1000)
UPDATE Projeto SET PNome = 'projeto dez' WHERE PNro = 10
select * from Projeto
select * from Pj_atualizado