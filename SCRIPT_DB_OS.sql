//MySQL5Dialect
//MySQL5InnoDBDialect

-- CRIAÇÃO DO BANCO DE DADOS
CREATE SCHEMA IF NOT EXISTS `db_os` DEFAULT CHARACTER SET utf8 ;
USE `db_os` ;

-- Criação da Tabela Cliente

CREATE TABLE IF NOT EXISTS `db_os`.`tbcliente` (
  `id` INT(11) PRIMARY KEY NOT NULL AUTO_INCREMENT ,
  `nome` VARCHAR(150) NOT NULL,
  `endereco` VARCHAR(150) NULL DEFAULT NULL,
  `numero` VARCHAR(6) NULL DEFAULT NULL,
  `complemento` VARCHAR(30) NULL DEFAULT NULL,
  `bairro` VARCHAR(30) NULL DEFAULT NULL,
  `cep` VARCHAR(10) NULL DEFAULT NULL,
  `telefone` VARCHAR(15) NULL DEFAULT NULL,
  `celular` VARCHAR(15) NULL DEFAULT NULL,
  `obs` TEXT NULL DEFAULT NULL,
  UNIQUE INDEX `idcli_UNIQUE` (`idcli` ASC),
  UNIQUE INDEX `nomecli_UNIQUE` (`nome` ASC))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

-- Criação da Tabela PEDIDO

CREATE TABLE IF NOT EXISTS `db_os`.`tbpedido` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `data` DATE NULL DEFAULT NULL,
  `obs` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  INDEX `os_ibfk_1` (`id_cli` ASC),
  CONSTRAINT `os_ibfk_1`
  FOREIGN KEY (`id_cli`) REFERENCES `db_os`.`tbClientes` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

-- Criação da Tabela OS

CREATE TABLE IF NOT EXISTS `db_os`.`tbos` (
  `idos` INT(11) NOT NULL AUTO_INCREMENT,
  `id_cli` INT(11) NOT NULL,
  `data` DATE NULL DEFAULT NULL,
  `situacao` VARCHAR(30) NOT NULL,
  `tipo` VARCHAR(15) NOT NULL,
  `equipamento` VARCHAR(150) NOT NULL,
  `defeito` VARCHAR(150) NOT NULL,	
  `valor` DECIMAL(6,2) NOT NULL,
  `obs` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`idos`),
  INDEX `os_ibfk_1` (`id_cli` ASC),
  CONSTRAINT `os_ibfk_1`
  FOREIGN KEY (`id_cli`) REFERENCES `db_os`.`tbClientes` (`idcli`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

-- Criação da Tabela Itens OS

CREATE TABLE IF NOT EXISTS `db_os`.`tbos_item` (
  `iditemos` INT(11) NOT NULL AUTO_INCREMENT,
  `id_os` INT(11) NOT NULL,
  `n_item` INT(11) NULL DEFAULT NULL,
  `id_prod` INT(11) NOT NULL,
  `valor` DECIMAL(6,2) NOT NULL,
  PRIMARY KEY (`iditemos`),
  INDEX `os_item_ibfk_1` (`id_os` ASC),
  CONSTRAINT `os_item_ibfk_1`
  FOREIGN KEY (`id_os`) REFERENCES `db_os`.`tbos` (`idos`))
  ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

-- Criação da Tabela Usuários 

CREATE TABLE IF NOT EXISTS `db_os`.`tbusuarios` (
  `idusuario` INT(11) NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(60) NOT NULL,
  `login` VARCHAR(15) NOT NULL,
  `senha` VARCHAR(8) NOT NULL,
  `tipo` ENUM('A', 'U') NULL DEFAULT NULL,
  PRIMARY KEY (`idusuario`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

-- Criação da Tabela Produtos 

CREATE TABLE IF NOT EXISTS `db_os`.`tbprodutos` (
  `idproduto` INT(11) NOT NULL AUTO_INCREMENT,
  `descricao` VARCHAR(50) NOT NULL,
  `preco` DECIMAL(6,2) NOT NULL,
  `qtd` INT(4) NOT NULL,
   PRIMARY KEY (`idproduto`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

-- Criação da Tabela Servicos 

CREATE TABLE IF NOT EXISTS `db_os`.`tbservicos` (
  `idservico` INT(11) NOT NULL AUTO_INCREMENT,
  `descricao` VARCHAR(50) NOT NULL,
  `preco` DECIMAL(6,2) NOT NULL,
   PRIMARY KEY (`idservico`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

-- Criação da Tabela Despesas 

CREATE TABLE IF NOT EXISTS `db_os`.`tbdespesas` (
  `iddesp` INT(11) NOT NULL AUTO_INCREMENT,
  `data` DATE NULL DEFAULT NULL,
  `descricao` VARCHAR(50) NOT NULL,
  `valor` DECIMAL(6,2) NOT NULL,
   PRIMARY KEY (`idservico`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

-- AÇOES DE ALTERAÇÕES NAS TABELAS
describe tbos_item;
select* from tbos;
alter table tbos change data data varchar(10) ;
alter table tbos_item add qtd integer not null after id_prod;
alter table tbclientes change cep cep varchar(10);

UPDATE `db_os`.`tbos` SET `data` = '20/08/2022' WHERE (`idos` = '1');

select os.idos, i.id_os, i.n_item as item, i.id_prod as produto, i.valor
from tbos_item as i
inner join tbos as os
on (idos = id_os) where idos = 3;

select os.idos as OS,c.nome as Nome,c.celular,os.data,os.situacao,os.equipamento,os.defeito,
os.tipo,os.valor,os.obs
from tbos as os 
inner join tbclientes as c
on (os.id_cli = c.idcli)
where idos = 4;

insert into tbos_item (id_os,n_item,id_prod,qtd,valor)
 values (1,1,1,1,10.25);
----
select idcli as id,nome as Nome,endereco as Endereço,numero,complemento,bairro,cep as CEP,
telefone as Telefone, celular, obs  from tbclientes where nome like "f%";