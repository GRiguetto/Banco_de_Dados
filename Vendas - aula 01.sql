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



create table categorias
(
	codigo	int			not null	identity,
	nome	varchar(50)	not null

	-- Retrição --
	constraint pk_categorias primary key (codigo)
)
go

insert into categorias values ('lapis'), ('canetas'),('cadernos')
select * from categorias

create table produtos
(
	codigo				int				not null	identity,
	descricao			varchar(50)		not null,
	preco				decimal(10,2)		null,
	estoque				int					null,
	status				int					null,	
	categoria_codigo	int				not null,
	
	--Restyriçoes--
	constraint pk_produtos				primary key(codigo),
	constraint ck_produtos_preco		check(preco>0),
	constraint ck_produtos_estoque		check(estoque>=0),
	constraint ck_produtos_status		check(status in (1,2,3,4)),
	constraint fk_produtos_categorias	foreign key(categoria_codigo) references categorias(codigo)

)
go



select * from produtos 
select * from categorias


insert into produtos
values ('Lápis Preto Nr.2', 2,100,1,1)

insert into produtos
values ('Caneta Azul' , 3 , 500 , 1 , 2)

insert into produtos
values ('Caderno 10 Matérias - Homen Aranha', 45, 100, 1, 3)

insert into produtos
values ('Caneta Vermelha', 2.5, 50, 1, 2)

insert into produtos
values ('Caderno 5 Matérias - Barbie', 120, 30, 1, 3)

create table pedidos
(
	nr				int				not null	identity,
	data			datetime		not null	default getdate(),
	total			decimal(10,2)		null	default 0,
	status			int					null	default 1,
	cliente_codigo	int				not null,
	vendedor_codigo	int				not null,

	--restrição--
	constraint	pk_pedidos				primary key(nr),
	constraint	ck_pedidos_data			check(data>=getdate()),
	constraint	ck_pedidos_total		check(total>=0),
	constraint	ck_pedidos_status		check(status between 1 and 7),
	constraint	fk_pedidos_clientes		foreign key (cliente_codigo)	references clientes(pessoa_codigo),
	constraint	fk_pedidos_vendedores	foreign key (vendedor_codigo)	references vendedores (pessoa_codigo),
)
go

select * from pedidos

insert into pedidos (cliente_codigo, vendedor_codigo) values (5,2)

create table itens_pedidos
(
	pedidos_nr	int		not null,
	produto_codigo	int		not null,
	qtd_vendida int		not null,
	preco_unitario	decimal(10,2)	not null,

	--restrição--
	constraint pk_itens primary key (pedidos_nr, produto_codigo),
	constraint fk_itens_pedidos foreign key (pedidos_nr) references pedidos(nr),
	constraint fk_itens_produtos foreign key (produto_codigo) references produtos(codigo),
	constraint ck_itens_qtd check(qtd_vendida > 0),
	constraint ck_itens_preco	check(preco_unitario > 0)
)
go

--sp_help pedidos

select * from pedidos
select * from produtos
select * from itens_pedidos

insert into itens_pedidos values(1, 5, 20, 119)
insert into itens_pedidos values (1, 1, 40, 2)
insert into itens_pedidos values(1, 4, 15, 1)

select * from itens_pedidos

select *, qtd_vendida * preco_unitario Valor_Item
from itens_pedidos

select sum (qtd_vendida * preco_unitario) Total
from itens_pedidos
where pedidos_nr = 1

update pedidos set total = 2475 where nr =1
select *from pedidos

select * from itens_pedidos
update produtos set estoque = estoque - 40 where codigo = 1
update produtos set estoque = estoque - 15 where codigo = 4
update produtos set estoque = estoque - 20 where codigo = 5
select * from produtos