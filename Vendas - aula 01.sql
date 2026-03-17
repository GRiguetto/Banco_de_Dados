create database vendas_manha_16_03
go

use vendas_manha_16_03
go

create table pessoas 
(
	codigo		int			not null identity,
	nome		varchar(50)	not null,
	cpf			varchar(12)	not null,
	status		int

	-- Restrições --
	constraint pk_pessoas		 primary key(codigo),
	constraint uq_pessoas_cpf	 unique(cpf),
	constraint ck_pessoas_status check(status in (1,2,3,4))
)
go

create table clientes
(
	pessoa_codigo	int not null,
	renda			decimal(10,2),
	credito as renda * 0.25,
	
	-- Restrições --
	constraint pk_clientes primary key(pessoa_codigo),
	constraint fk_clientes_pessoas 
	   foreign key(pessoa_codigo) references pessoas(codigo),
	constraint ck_clientes_renda check(renda > 0)
)
go

create table vendedores
(
	pessoa_codigo	int			  not null,
	salario			decimal(10,2) not null,
	
	-- Restrições --
	constraint pk_vendedores primary key(pessoa_codigo),
	constraint fk_vendedores_pessoas
	    foreign key(pessoa_codigo) references pessoas(codigo),
	constraint ck_vendedores_salario check(salario > 1500)
)
go

-- inserts --

insert into pessoas values ('Batman', '1010', 1)
insert into pessoas values ('Coringa','2020', 1)
insert into pessoas values ('Mulher Maravilha', '3030', 1)
insert into pessoas values ('Robin', '4040', 1)
insert into pessoas values ('Super Main', '5050', 1)

insert into clientes (pessoa_codigo, renda) values (1, 10000)
insert into clientes (pessoa_codigo, renda) values (3, 15000)
insert into clientes (pessoa_codigo, renda) values (5, 1501)

insert into vendedores values (2, 3000), (4, 3000)

select * from pessoas
select * from clientes
select * from vendedores













