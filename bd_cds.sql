create database DB_CDs;
use DB_CDs;

create table artista(
	cod_artista int not null,
	nome_artista varchar(100) not null,
	constraint pk_artista primary key (cod_artista),
	constraint un_artista unique (nome_artista)
);

create table gravadora(
	cod_gravadora int not null,
	nome_gravadora varchar(50) not null,
	constraint pk_gravadora primary key (cod_gravadora),
	constraint un_gravadora unique (nome_gravadora)
);

create table categoria(
	cod_categoria int not null,
	nome_categoria varchar(100) not null,
	constraint pk_categoria primary key (cod_categoria),
	constraint un_categoria unique (nome_categoria)
);

create table estado(
	sigla_estado char(2) not null,
	nome_estado varchar(100) not null,
	constraint pk_estado primary key (sigla_estado),
	constraint un_estado unique (nome_estado)
);

create table cidade(
	cod_cidade char(2) not null,
	nome_cidade varchar(100) not null,
	sigla_estado char(2) not null,
	constraint foreign key (sigla_estado) references estado (sigla_estado),
	constraint pk_cidade primary key(cod_cidade)
);

create table cliente(
	cod_cliente int not null,
	cod_cidade int not null,
	nome_cliente varchar(100) not null,
	endereco_cliente varchar(200) not null,
	sexo_cliente char(1) not null,
	renda_cliente decimal(10,2) not null,
	constraint ch_cliente1 check(sexo_cliente in ('M', 'F')),
	constraint ch_cliente2 check(renda_cliente >=0),
	constraint pk_cliente primary key (cod_cliente),
	constraint foreign key (cod_cidade) references cidade (cod_cidade)
);

create table conjuge(
	cod_cliente int not null,
	nome_conjuge varchar(100) not null,
	renda_conjuge decimal(10,2) not null,
	sexo_conjuge char(1) not null,
	constraint ch_conjuge1 check (renda_conjuge >= 0),
	constraint ch_conjuge2 check(sexo_conjuge in ('M', 'F')),
	constraint foreign key (cod_cliente) references cliente (cod_cliente)
);

create table funcionario(
	cod_funcionario int not null,
	nome_funcionario varchar(100) not null,
	end_funcionario varchar(100) not null,
	sal_funcionario decimal(10,2) not null,
	sexo_funcionario char(1) not null,
	constraint ch_funcionario1 check(sal_funcionario >=0),
	constraint ch_funcionario2 check(sexo_funcionario in ('M', 'F')),
	constraint pk_funcionario primary key (cod_funcionario)
);

create table dependente(
	cod_dependente int not null,
	cod_funcionario int not null,
	nome_dependente varchar(100) not null,
	sexo_dependente char(1) not null,
	constraint pk_dependente primary key (cod_dependente),
	constraint ch_dependente check(sexo_dependente('M', 'F')),
	constraint foreign key (cod_funcionario) references funcionario (cod_funcionario)
);

create table titulo(
	cod_titulo int not null,
	cod_categoria int not null,
	cod_gravadora int not null,
	nome_cd varchar(100) not null,
	val_cd decimal(10,2) not null,
	qtd_estoque int not null,
	constraint pk_titulo primary key (cod_titulo),
	constraint un_cd unique (nome_cd),
	constraint ch_estoque check (qtd_estoque >=0),
	constraint ch_cd check (val_cd > 0),
	constraint foreign key (cod_categoria) references categoria (cod_categoria),
	constraint foreign key (cod_gravadora) references gravadora (cod_gravadora)
);

create table pedido(
	cod_pedido int not null,
	cod_cliente int not null,
	cod_funcionario int not null,
	num_pedido int not null,
	data_pedido datetime not null,
	val_pedido decimal(10,2) not null,
	constraint pk_pedido primary key(cod_pedido),
	constraint foreign key (cod_cliente) references cliente (cod_cliente),
	constraint foreign key (cod_funcionario) references funcionario (cod_funcionario)
);

create table titulo_pedido(
	num_pedido int not null,
	cod_titulo int not null,
	qtd_cd int not null,
	val_cd decimal(10,2) not null,
	constraint ch_cd1 check(qtd_cd >= 1),
	constraint ch_cd2 check(val_cd > 0),
	constraint foreign key (num_pedido) references pedido (num_pedido),
	constraint foreign key (cod_titulo) references titulo (cod_titulo)
);

create table titulo_artista(
	cod_titulo int not null,
	cod_artista int not null,
	constraint foreign key (cod_titulo) references titulo (cod_titulo),
	constraint foreign key (cod_artista) references artista (cod_artista)
);


insert into artista values (1, 'Marisa Monte'), (2, 'Gilberto Gil'), (3, 'Caetano Veloso'), (4, 'Milton Nascimento'), (5, 'Legião Urbana'), (6, 'The Beatles'), (7, 'Rita Lee');
select * from artista;

insert into gravadora values (1, 'Polygram'), (2, 'EMI'), (3, 'Som Livre'), (4, 'Sony Music');
select * from gravadora;

insert into categoria values (1, 'MPB'), (2, 'Trilha Sonora'), (3, 'Rock internacional'), (4, 'Rock Nacional');
select * from categoria;

insert into estado values ('SP', 'São Paulo'), ('MG', 'Minas Gerais'), ('RJ','Rio de Janeiro');
select * from estado;

insert into cidade values (1, 'São Paulo', 'SP'), (2, 'Sorocaba', 'SP'), (3, 'Jundiaí', 'SP'), (4, 'Americana', 'SP'), (5, 'Araraquara', SP), (6, 'Ouro Preto', 'MG'), (7, 'Cachoeiro de Itaperimim', 'SP');
select * from cidade;

insert into cliente values (1, 1, 'José Nogueira', 'Rua A', 1500.00, 'M'), (2, 1, 'Angelo Pereira', 'Rua B', 2000.00, 'M'), (3, 1, 'Marina Paranhos', 'Rua C', 1500.00, 'F'), (4, 1, 'Catarina Souza', 'Rua D', 892.00, 'F'), (5, 1, 'Vagner Costa', 'Rua E', 950.00), (6, 2, 'Antenor da Costa', 'Rua F',  1582.00, 'M'), (7, 2, 'Maria Amélia de Sousa', 'Rua G', 1152.00, 'F'), (8, 2, 'Paulo Roberto Silva', 'Rua H', 3250.00, 'M'), (9, 3,  'Fátima de Souza', 'Rua I', 1632.00, 'F'), (10, 3, 'Joel da Rocha', 'Rua J', 2000.00, 'M');
select * from cliente;

insert into conjuge values (1, 'Carla Nogueira', 2500.00, 'F'), (2, 'Emília Pereira', 5500.00, 'F'), (6, 'Altiva da Costa', 3000.00, 'F'), (7, 'Carlos Souza', 3250.00, 'M');
select *from conjuge;

insert into funcionario values (1, 'Vania Gabriela Pereira','Rua A', 2500.00, 'F' ), (2, 'Norberto Pereira da Silva', 'Rua B', 3000.00, 'M'), (3, 'Olavio Linhares', 'Rua C', 5800.00, 'M'), (4, 'Paula da Silva', 'Rua D', 3000.00, 'F'), (5, 'Rolando Rocha', 'Rua D', 2000.00, 'M');
select * from funcionario;

insert into dependente values (1, 1, 'Ana Pereira', 'F'), (2, 1, 'Roberto Pereira', M), (3, 1, 'Celso Pereira', 'M'), (4, 3, 'Brisa Linhares', 'F'), (5, 3, 'Mari Sol Linhares', 'F'), (6, 4, 'Sonia da Silva', 'F');
select * from dependente; 

insert into titulo values (1, 1, 1, 'Tribalista', 30.00, 1500), (2, 1, 2, 'Tropicália', 50.00, 500), (3, 1, 1, 'Aquele Abraço', 50.00, 600), (4, 1, 2, 'Refazenda', 60.00, 1000), (5, 1, 3, 'Totalmente Demais', 50.00, 2000), (6, 1, 3, 'Travessia', 55.00, 500), (7, 1, 2, 'Courage', 30.00, 200), (8, 4, 3, 'Legião Urbana', 20.00, 100), (9, 3, 2, 'The Beatles', 30.00, 300), (10, 4, 1, 'Rita Lee', 30.00, 500);
select * from titulo;

insert into pedido values (1, 1, 2, 02/02/2022, 15.00), (2, 3, 4, 02/05/2022, 50.00), (3, 4, 3, 02/06/2022, 100.00), (4, 1, 4, 02/02/2023, 200.00), (5, 7, 5, 02/03/2023, 300.00), (6, 4, 4, 02/03/2023, 100.00), (7, 5, 5, 02/03/2023, 50.00), (8, 8, 2, 02/03/2023, 50.00), (9, 2, 2, 02/03/2023, 2000.00), (10, 7, 1, 02/03/2023,3000.00);
select * from pedido;

insert into titulo_artista values (1, 1), (2, 2), (3, 2), (4, 2), (5, 3), (6, 4), (7, 4), (8, 5), (9, 6), (10, 7);
select * from titulo_artista;

insert into titulo_pedido values (1, 1, 2, 30.00), (1, 2, 3, 20.00), (2, 1, 1, 50.00), (2, 2, 3, 30.00), (3, 1, 2, 40.00), (4, 2, 3, 20.00), (5, 1, 2, 25.00), (6, 2, 3, 30.00), (7, 4, 2, 55.00), (8, 1, 4, 60.00), (9, 2, 3, 15.00), (10, 7, 2, 15.00);
select * from titulo_pedido; 
