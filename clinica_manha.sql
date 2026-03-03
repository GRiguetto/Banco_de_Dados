create database [clinica_manha]
go

use clinica_manha
go

create table pacientes(
	codigo	int			not null primary key identity,
	nome	varchar(50) not null,
	cpf		varchar(12) not null unique,
	fone	varchar(20)	not null
)
go

-- Inserindo paciente na tabela
insert into pacientes
values ('matheus mortari leite', '4715919283', '1799607500')
	
insert into pacientes
values ('gabriel rigoetto', '418769873', '17123456754')

insert into pacientes
values ('Pedor fomfom', '43527353223', '21328791827')

insert into pacientes
values ('laura', '3030', '17-1111-11111')

insert into pacientes
values('batman', '1010', '17-2222-22222')

-- consultando paciente cadastrado na tabela
select * 
	from pacientes

--Excluido um paciente da tabela
delete from pacientes
where codigo = 3

--Atualizando o nome do paciente
update pacientes set
	nome = 'flash', fone = '17-3333-3333'
where codigo = 5

--Consultando o nome alterado na tabela codigo 5
select *
	from
pacientes
where codigo = 5

--CRIANDO A TABELA ESPECIALIDADES
create table especialidades(
	codigo	 int		not null	primary key identity,
	nome	varchar(50)	not null	
)
go

--Inserindo especialidades na tabela escpecialidades
insert into especialidades
values('cardiologia'), ('ortopedia'), ('pediatria')

--Consultando especialidades cadastrada
select *
	from
especialidades

--CRIANDO TABELA MEDICOS
create table medicos(
	crm		varchar(10)	 not null	primary key,
	nome	varchar(50)	 not null,
	especialidade_codigo int not null references especialidades
)
go

--CONSULTANDO MEDICOS CADASTRADOS
SELECT *
	FROM
medicos

--CONSULTANDO TABELAS ESPECIALIDADES
SELECT *
	FROM
especialidades

--INSERINDO MEDICOS NA TABELA MEDICOS
insert into medicos
values ('1010-1010', 'adalbeto', '1')

insert into medicos
values ('2020-2020', 'gabriel', 2)

insert into medicos
values('3030.3030', 'samuel', 3)

insert into medicos
values('4040.4040', 'barbara', 2)

insert into medicos
values ('5050.5050', 'sergio', 1)




create table consultas(
	nr				int					not null		identity,
	data_hora		datetime			not null,
	valor			decimal(10,2)		not null		default 150,
	status			int					null			default 1,
	paciente_codigo int					not null,
	medicos_crm		varchar(10)			not null,

	--RESTRIÇÕES
	constraint		pk_consultas				primary key	(nr),
	constraint		fk_consultas_pacientes		foreign key	(paciente_codigo) references pacientes(codigo),
	constraint		fk_consultas_medicos		foreign key	(medicos_crm)		 references	medicos(crm),
	check (valor >=150),
	check (status in(1,2,3,4))
)
go

--INSERINDO CONSULTAS
insert into consultas(data_hora, paciente_codigo,medicos_crm)
values (GETDATE()+1,2, '2020-2020')

--INSERINDO CONSULTAS
insert into consultas(data_hora, paciente_codigo,medicos_crm)
values (GETDATE()+1,2, '2020-2020')

insert into consultas 
values('08/03/2026 15:30', 300,1,4,'3030.3030')

--CONSULTADO TODA AS TABELAS
SELECT * 
	FROM
pacientes

SELECT *
	FROM
consultas

-----------------------------------------------------

SELECT *
	FROM
especialidades

SELECT *
	FROM
medicos

-- INNER JOIN JUTANDO AS 2 TABELAS MEDICOS E ESPECIALIDADES

SELECT *
FROM medicos m
inner join especialidades 
on m.especialidade_codigo = especialidades.codigo 

create view v_medicos
as
	SELECT m.crm, m.nome Medico, e.nome Especialidade
	FROM medicos m, especialidades e
	where m.especialidade_codigo = e.codigo
go

SELECT * FROM v_medicos