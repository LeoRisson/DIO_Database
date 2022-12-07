-- criando o BD do Ecommerce

-- drop database ecommerce;

create database if not exists ecommerce;

use ecommerce;

-- criando tabela Cliente
	create table cliente (
		idCliente int auto_increment primary key, 
        Nome varchar(100) not null,
        TP_Pessoa enum('Fisica','Juridica') default 'Fisica', 
        CPF_CNPJ varchar(14) not null,
        Data_Nasc date,
        Endereço varchar(60),
        Bairro varchar(40),
        Cidade varchar(40),
        UF char(2),
        CEP char(9),
        constraint unique_cpf_cliente unique (CPF_CNPJ)
    );
    alter table cliente auto_increment=1;
    
-- criando tabela de Clientes x pagamento
create table cliente_Pag(
	Cliente_idCliente int primary key,
    idPagamentos int unique,
    Meio_Valido bool default true,
    Tipo_Pagamento ENUM('Cartao', 'Outro') default 'Cartao',
    Nr_Cartao char(20),
    Validade_Cartao_Mes Char(2),
    Validade_Cartao_Ano char(4),
    Nome_Cartao varchar(60)
);

-- criando tabela Produto
	create table produto(
		idProdudo int auto_increment primary key,
        Descricao varchar(40) not null,
        Categoria enum('Eletronicos', 'Vestimenta', 'Brinquedos','Alimentos','Livros','Outros') not null,
        Valor float,
        Peso int,
        avaliacao float default 0
        );
alter table produto auto_increment=1;

-- criando tabela Pedido
	create table pedido(
	idPedido int auto_increment primary key,
    idPedidoCliente int ,
    Data_Venda date,
    Descricao varchar(255),
    Frete_Valor float default 10,
    Status_Pedido ENUM('Em Andamento', 'Processando', 'Enviado', 'Entregue') default 'Em Andamento' not null,
    PagamentoDinh bool default false,
    IdPagamento int,
    constraint fk_pedido_cliente foreign key (idPedidoCliente) references cliente(idCliente),
    constraint fk_pagamento_cliente foreign key (IdPagamento) references Cliente_Pag(idPagamentos)
    );
alter table pedido auto_increment=1;

   
-- criando tabela estoque
	create table estoque(
	idEstoque int auto_increment primary key,
    Local_est varchar(255),
    Quantidade int default 0
    );
alter table estoque auto_increment=1;
    
-- criando tabela Fornecedor
	create table fornecedor(
	idFornecedor int auto_increment primary key,
    Razao_Social varchar(255) not null,
    CNPJ char(14) not null unique,
    Endereco varchar(60),
    Bairro varchar(40),
    Cidade varchar(30),
    UF char(2),
    CEP char(9),
    contato char(11)
    );

alter table fornecedor auto_increment=1;

-- criando tabela vendedor
	create table vendedor(
	idVendedor int auto_increment primary key,
    Razao_Social_vend varchar(255) not null,
    CNPJ_Vend varchar(14) not null unique,
    Endereco_vend varchar(60),
    Bairro_vend varchar(40),
    Cidade_vend varchar(30),
    UF_vend char(2),
    CEP_vend char(9),
    contato_vend char(11)
    );

alter table vendedor auto_increment=1;

-- criando tabela produtos vendedor
	create table prod_vend(
    PV_idTerceiros int,
    PV_idProdudo int,
    Qtd int, 
    primary key (PV_idTerceiros,PV_idProdudo),
    constraint fk_prod_vend_vend foreign key (PV_idTerceiros) references vendedor(idVendedor),
	constraint fk_prod_vend_prod foreign key (PV_idProdudo) references produto(idProdudo)
	);
    
    -- criando tabela Pedidos itens
	create table ped_itens(
	Pi_idProdudo int,
    Pi_idPedido int,
    Qtd_Ped_Itens int,
    Valor float ,
    Status_Ped ENUM('Disponivel', 'Sem Estoque') default 'Disponivel', 
    primary key (Pi_idProdudo,Pi_idPedido),
    constraint fk_ped_item_prod foreign key (Pi_idProdudo) references produto(idProdudo),
	constraint fk_ped_item_ped foreign key (Pi_idPedido) references pedido(idPedido)
	);
    
    -- criando tabela Produtos fornecedor
	create table prod_fornecedor(
	Pf_idfornecedor int,
    Pf_idProduto int,
    Qtd_prod_for int,
    primary key (Pf_idfornecedor,Pf_idProduto),
    constraint fk_prod_for_prod foreign key (Pf_idfornecedor) references fornecedor(idFornecedor),
	constraint fk_prod_for_for foreign key (Pf_idProduto) references produto(idProdudo)
	);
    
-- criando tabela entrega
	create table entrega(
    idEntrega int auto_increment primary key,
    ent_idPedido int ,
    Transportador varchar (60),
    Rastreio varchar (40),
    Status_Entrega ENUM('Despachado', 'Entregue'),
    constraint fk_entrega_pedido foreign key (ent_idPedido) references pedido(idPedido)
    );
alter table entrega auto_increment=1;
    
    show tables;
    show databases;
    use information_schema;
    select * from REFERENTIAL_CONSTRAINTS where constraint_schema = 'ecommerce';

