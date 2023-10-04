create procedure sp_ies_inserir(
   @ies_nome as varchar(40))
as
begin
	insert into ies values (@ies_nome)
end
--sp_ies_inserir UFMG

-----------------------------------------------------------------
create procedure sp_ies_excluir(
   @ies_codigo as int)
as
begin
	delete from ies where ies_codigo = @ies_codigo
end
--sp_ies_excluir 3
--select * from ies

----------------------------------------------------------------- 
create procedure sp_ies_alterar(
   @ies_codigo as int, @ies_nome as varchar(40))
as
begin
	update ies set ies_nome = @ies_nome where ies_codigo = @ies_codigo
end
--sp_ies_alterar 2, USP
--select * from ies

-----------------------------------------------------------------
create procedure sp_ies_mostrar
as
begin
	select * from ies
end
--sp_ies_mostrar

-----------------------------------------------------------------
create procedure sp_ies_buscar (
    @ies_codigo int)
as
begin
	select * from ies where ies_codigo = @ies_codigo
end
--sp_ies_buscar 2

-----------------------------------------------------------------
create procedure sp_ies_like(
	@ies_nome as varchar(5))
as
begin
	select * from ies where ies_nome like @ies_nome + '%'
end
--sp_ies_like u

-----------------------------------------------------------------
create procedure sp_cliente_inserir (
	@pes_nome	varchar(50)	,
	@cli_cpf	varchar(12)	,
	@cli_email	varchar(30)
)
as
begin
	insert into Pessoas values (@pes_nome)
	insert into Clientes values (@@identity, @cli_cpf, @cli_email)
	if (Select count(*) from clientes where Pes_Codigo = @@identity) = 0
		delete pessoas where pes_codigo = @@identity
end

--sp_cliente_inserir 'Ricardo', '101', 'drrsbbdl@yahoo.com.br'
--select * from pessoas
--select * from clientes

--------------------------------------------------------------------------
create procedure sp_cliente_excluir(
	@pes_codigo int) 
as
begin
	delete from clientes where pes_codigo = @pes_codigo
	delete from pessoas	 where pes_codigo = @pes_codigo
end

--------------------------------------------------------------------------
create procedure sp_clientes_buscar
as
begin
	select p.Pes_codigo Codigo, p.Pes_nome Nome, c.Cli_cpf CPF, c.Cli_email Email
	from pessoas p, clientes c
	where p.pes_codigo = c.pes_codigo
end
--sp_clientes_buscar

--------------------------------------------------------------------------
create procedure sp_cliente_buscar (
	@pes_codigo int )
as
begin
	select p.Pes_codigo Codigo, p.Pes_nome Nome, c.Cli_cpf CPF, c.Cli_email Email
	from pessoas p, clientes c
	where p.pes_codigo = c.pes_codigo and
	p.Pes_codigo = @Pes_codigo
end
--sp_cliente_buscar 1

--------------------------------------------------------------------------
create procedure sp_clientes_like (
   @pes_nome varchar(5))
as
begin
	select p.Pes_codigo Codigo, p.Pes_nome Nome, c.Cli_cpf CPF, c.Cli_email Email
	from pessoas p, clientes c
	where p.pes_codigo = c.pes_codigo and
          p.pes_nome like @pes_nome + '%'
end
--sp_clientes_like r

--------------------------------------------------------------------------
create procedure sp_funcionario_inserir(
	@pes_nome varchar(40),
	@fun_ch int, 
	@fun_salario money) 
as
begin
	insert into pessoas values(@Pes_nome)
	insert into funcionarios values(@@identity, @fun_ch, @fun_salario)
	if (Select count(*) from funcionarios where Pes_Codigo = @@identity) = 0
		delete pessoas where pes_codigo = @@identity
end

--sp_funcionario_inserir 'Patricia', 40, 44000
--select * from pessoas
--select * from funcionarios

--------------------------------------------------------------------------
create procedure sp_funcionario_excluir(
	@pes_codigo int) 
as
begin
	delete from funcionarios where pes_codigo = @pes_codigo
	delete from pessoas		 where pes_codigo = @pes_codigo
end

--------------------------------------------------------------------------
create procedure sp_funcionarios_buscar
as
begin
	select p.Pes_codigo Codigo, p.Pes_nome Nome, f.Fun_ch CH, f.Fun_salario Salario
	from pessoas p, funcionarios f
	where p.pes_codigo = f.pes_codigo
end
--sp_funcionarios_buscar
--select * from funcionarios

--------------------------------------------------------------------------
create procedure sp_funcionario_buscar (
	@pes_codigo int )
as
begin
	select p.Pes_codigo Codigo, p.Pes_nome Nome, f.Fun_ch CH, f.Fun_salario Salario
	from pessoas p, funcionarios f
	where p.pes_codigo = @pes_codigo and 
		  p.pes_codigo = f.pes_codigo and
		  p.Pes_codigo = @Pes_codigo
end
--sp_funcionario_buscar 1

--------------------------------------------------------------------------
create procedure sp_funcionarios_like (
	@pes_nome varchar(5))
as
begin
	select p.Pes_codigo Codigo, p.Pes_nome Nome, f.Fun_ch CH, f.Fun_salario Salario
	from pessoas p, funcionarios f
	where p.pes_codigo = f.pes_codigo and
		  p.pes_nome like @pes_nome + '%'
end
--sp_funcionarios_like p

--------------------------------------------------------------------------
create procedure sp_estagiario_inserir(
	@pes_nome varchar(40),
	@ies_codigo int) 
as
begin
    declare @data datetime
    set @data = (select getDate())
	insert into pessoas values(@Pes_nome)
	insert into estagiarios values(@@identity, @data, @ies_codigo)
	if (Select count(*) from estagiarios where pes_codigo = @@identity) = 0
		delete pessoas where pes_codigo = @@identity
end

--sp_estagiario_inserir Sergio, 1
--select * from pessoas
--select * from estagiarios

--------------------------------------------------------------------------
create procedure sp_estagiario_excluir(
	@pes_codigo int) 
as
begin
	delete from estagiarios where pes_codigo = @pes_codigo
	delete from pessoas 	where pes_codigo = @pes_codigo
end

--------------------------------------------------------------------------
create procedure sp_estagiarios_buscar
as
begin
	select p.Pes_codigo Codigo, p.Pes_nome Nome, e.Est_data Data_Cadastro, e.Ies_codigo, i.ies_nome Ies
	from pessoas p, estagiarios e, ies i
	where p.pes_codigo = e.pes_codigo and
          e.ies_codigo = i.ies_codigo
end
--sp_estagiarios_buscar
--select * from estagiarios

--------------------------------------------------------------------------
create procedure sp_estagiario_buscar (
	@pes_codigo int )
as
begin
	select p.Pes_codigo Codigo, p.Pes_nome Nome, e.Est_data Data_Cadastro, e.Ies_codigo, i.ies_nome Ies
	from pessoas p, estagiarios e, ies i
	where p.pes_codigo = @pes_codigo and
		  p.pes_codigo = e.pes_codigo and
          e.ies_codigo = i.ies_codigo          
end
--sp_estagiario_buscar 2

--------------------------------------------------------------------------
create procedure sp_estagiarios_like (
    @pes_nome varchar(5))
as
begin
	select p.Pes_codigo Codigo, p.Pes_nome Nome, e.Est_data Data_Cadastro, e.Ies_codigo, i.ies_nome Ies
	from pessoas p, estagiarios e, ies i
	where p.pes_codigo = e.pes_codigo and
          e.ies_codigo = i.ies_codigo and
		  p.pes_nome like @pes_nome + '%'
end
sp_estagiarios_like s

