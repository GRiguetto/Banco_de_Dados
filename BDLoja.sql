CREATE DATABASE [venda_manha]
go

use venda_manha
go

CREATE TABLE pessoas(
	cod		int			not null identity,
	nome	varchar(50)	not null,
	cpf		varchar(12) not null,
	status	int

	----Restrições----
	constraint	pk_pessoas			primary key(cod),
	constraint	uq_pessoas_cpf		unique(cpf),
	constraint	ck_pessoas_status	check(status in (1,2,3,4))
)
go

CREATE TABLE clientes(
	pessoas_cod	int not null,
	renda		decimal(10,2),
	credito		as renda * 0.25
	
	----Restrições----
	constraint pk_clientes			primary key(pessoas_cod),
	constraint fk_clientes_pessoas	foreign key(pessoas_cod) references pessoas(cod),
	constraint ck_clientes_renda		check(renda >0)
)
go

CREATE TABLE vendedores(
	pessoas_cod	 int not null,
	salario		 decimal(10,2) not null

	----Restrições----
	constraint pk_vendedores			primary key(pessoas_cod),
	constraint fk_vendedores_pessoas	foreign key(pessoas_cod) references pessoas(cod),
	constraint ck__vendedores_salario	check(salario > 1500)
)
go

---inserts---

select * from pessoas
select * from clientes

insert into pessoas
values('Batman','1010',1),('Riguetto','2020',2),
('Coringa','3030',3),('Mulher Maravilha','4040',2),
('Robin','5050',2),('Flash','7070',2)



insert into clientes(pessoas_cod,renda)
values(1,100000),(3,150000),(5, 20000)

insert into vendedores
values(2,30000),(3,30000),(5,30000)

SELECT * FROM vendedores


CREATE TABLE pedidos(
	nr		int not null,
	data	datetime not null,
	valor	decimal(10,2)
)
