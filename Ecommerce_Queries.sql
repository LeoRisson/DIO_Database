use ecommerce;

select count(*) from cliente;

select * from cliente as c, pedido as p
	where c.idCliente = p.idPedidoCliente;

select c.Nome, p.idPedido, p.Descricao, p.Status_Pedido from cliente as c, pedido as p
	where c.idCliente = p.idPedidoCliente;

select * from cliente inner join pedido on idCliente = idPedidoCliente
						inner join ped_itens on Pi_idProdudo = idPedido;

-- valor total dos pedidos                        
select count(*), sum(i.Valor) as Total  from pedido p,  ped_itens i
	where p.idPedido = i.Pi_idPedido;
    
-- valor individual dos pedidos                        
select p.idPedido, sum(i.Valor) as Total  from pedido p,  ped_itens i
	where p.idPedido = i.Pi_idPedido
    group by p.idPedido;
    
-- produtos vendidos pelos fornecedores    
select p.Descricao, p.idProdudo, c.Razao_Social from produto p inner join prod_fornecedor f on p.idProdudo = f.Pf_idProduto
											   inner join fornecedor c on c.idFornecedor = f.Pf_idfornecedor;

-- Estoque por fornecedor
select p.idProdudo, p.Descricao, f.Qtd_prod_for, c.Razao_Social from produto p 
							inner join prod_fornecedor as f on p.idProdudo = f.Pf_idfornecedor
                            inner join fornecedor c on c.idFornecedor = f.Pf_idfornecedor
                            group by p.idProdudo;

-- existe algum vendedor que é fornecedor
select * from fornecedor f, vendedor v
	where f.CNPJ = v.CNPJ_Vend;
    
