use ecommerce;

desc cliente;
select * from cliente;
select * from produto;
select * from pedido;
select * from ped_itens;
show tables;


insert into cliente (Nome, TP_Pessoa, CPF_CNPJ, Data_Nasc, Endereço, Bairro, Cidade, UF, CEP)
	values ('Maria A Silva','Fisica',12346789198,'1954-01-20','rua 16,13','planalto','muriae','MG',36880000),
		   ('Marcio R Silva','Fisica',12346789197,'1976-01-08','rua 16,13','planalto','muriae','MG',36880000),
		   ('Leonardo R Silva','Fisica',12346789196,'1979-06-08','rua 15,14','centro','muriae','MG',36880000),
		   ('Bruno R Silva','Fisica',12346789195,'1985-03-12','rua 10,12','planalto','muriae','MG',36880000),
           ('Manoel Tratores','Juridica',01002003000100,'1994-01-01','rua 16,13','planalto','muriae','MG',36880000),
           ('Gaby M Silva','Fisica',12346789194,'2012-08-20','rua 20,03','planalto','muriae','MG',36880000),
           ('Guilherme R Euzebio','Fisica',12346789193,'2002-01-27','rua 24,15','planalto','muriae','MG',36880000);

desc produto;
-- # Field, Type, Null, Key, Default, Extra'Categoria', 'enum(\'Eletronicos\',\'Vestimenta\',\'Brinquedos\',\'Alimentos\',\'Livros\',\'Outros\')', 'NO', '', NULL, ''

insert into produto (Descricao, Categoria, Valor, Peso, Avaliacao)
	values ('Fone de Ouvido', 'Eletronicos', 80.00, 100, 4),
		   ('Barbie Frozen', 'Brinquedos', 120.00, null, 4), 
	       ('Body Carters', 'Vestimenta', 150.00, 30, 3),
           ('Microfone Vedo - YouTuber', 'Eletronicos', 220.00, null, 2),
           ('O Segredo da Vida', 'Livros', 60.00, 60, 5),
           ('Farinha de Arroz', 'Alimentos', 10.00, 100, 3),
           ('Fire Stick Amazom', 'Eletronicos', 350.00, null, 5);

-- pedido idPedido idPedidoCliente Data_Venda Descricao Frete_Valor Status_Pedido PagamentoDinh IdPagamento

insert into pedido (idPedidoCliente, Data_Venda, Descricao, Frete_Valor, Status_Pedido, PagamentoDinh, IdPagamento)
			values (1, '2022-12-03', 'Compra via WEB', default, default, True, null),
				   (2, '2022-12-03', 'Compra via APP', 60.00, default, default, null),
                   (3, '2022-12-05', 'Compra via APP', default, default, default, null),
                   (4, '2022-12-07', 'Compra via WEB', 50.00, default, True, null);

-- Table: ped_itens, Pi_idProdudo Pi_idPedido Qtd_Ped_Itens Valor  Status_Ped enum('Disponivel','Sem Estoque')

insert into ped_itens (Pi_idProdudo, Pi_idPedido, Qtd_Ped_Itens, Valor, Status_Ped)
			values (1, 5, 1, null, default),
				   (4, 5, 1, null, default),
                   (7, 6, 1, null, default),
                   (3, 6, 1, null, default),
                   (5, 6, 1, null, default),
                   (5, 7, 1, null, default),
                   (2, 7, 3, null, default),
                   (6, 8, 2, null, default);
   
     update ped_itens 
		join 
        produto on ped_itens.Pi_idProdudo = produto.idProdudo
       set ped_itens.Valor = ped_itens.Qtd_Ped_Itens * produto.Valor
       where ped_itens.Pi_idProdudo = produto.idProdudo;

select i.Pi_idProdudo, i.Qtd_Ped_Itens, i.Valor, p.idProdudo,  p.Descricao, p.Valor from ped_itens as i, produto as p
	where i.Pi_idProdudo = p.idProdudo;
    
-- estoque Local_est Quantidade 
select * from estoque;
insert into estoque (Local_est, Quantidade)
	values ('Sao Paulo', 1000),
		   ('Sao Paulo', 300),
           ('Rio de Janeiro', 700),
           ('Belo Horizonte', 200),
           ('Fortaleza', 100),
           ('Brasilia', 20);

select * from fornecedor;
INSERT INTO fornecedor (Razao_Social, CNPJ, Endereco, Bairro, Cidade, UF, CEP, contato)
VALUES ('Silva & Slva', 11222333000102, 'Rua A, 366', 'centro', 'Sao Paulo', 'SP', '01321001', 'Marcio'),
	   ('Organizacoes Tabajara', 22333444000103, 'Rua dos corres, 171', 'madureira', 'Rio de Janeiro', 'RJ', '01321003', 'Tabajara'),
       ('Maga & Li', 33444555000104, 'Rua Luiza, 747', 'centro', 'Brasila', 'DF', '01522006', 'Lu');
     
select * from prod_fornecedor;     
INSERT INTO prod_fornecedor (Pf_idfornecedor,Pf_idProduto,Qtd_prod_for)
VALUES (1, 3, 89),
	   (1, 6, 1005),
	   (2, 1, 925),
       (2, 4, 630),
       (2, 7, 849),
       (3, 2, 633),
       (3, 5, 30);

select * from vendedor;       
INSERT INTO vendedor (Razao_Social_vend, CNPJ_Vend, Endereco_vend, Bairro_vend, Cidade_vend, UF_vend,CEP_vend, contato_vend)
VALUES ('Tech Tabajara', 44555666000101, 'Rua dos Corres, 172', 'madureira', 'Rio de Janeiro', 'RJ', '01321003', 'Tabajara'),
       ('Brega & Chique', 44555666000203, 'Rua dos Corres, 173', 'madureira', 'Rio de Janeiro', 'RJ', '01321003', 'Wanda'),
       ('Marvel Toys', 45554667000203, 'Rua dos Corres, 174', 'madureira', 'Rio de Janeiro', 'RJ', '01321003', 'Rogers');

select * from prod_vend;
INSERT INTO prod_vend (PV_idTerceiros,PV_idProdudo,Qtd)
VALUES (1, 1, 66),
	   (1, 4, 35),
       (1, 7, 15),
       (2, 3, 9),
       (3, 5, 6),
       (3, 2, 10);
