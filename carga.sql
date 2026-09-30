
CREATE TABLE categoria (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(50) NOT NULL
);

CREATE TABLE produto (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    unidade_medida VARCHAR(20) NOT NULL,
    quantidade INT NOT NULL DEFAULT 0,
    valor_unitario DECIMAL(10, 2) NOT NULL,
    categoria_id INT NOT NULL,
    CONSTRAINT fk_produto_categoria FOREIGN KEY (categoria_id) REFERENCES categoria(id)
);

CREATE TABLE entrada (
    id INT AUTO_INCREMENT PRIMARY KEY,
    produto_id INT NOT NULL,
    quantidade INT NOT NULL,
    valor_unitario DECIMAL(10, 2) NOT NULL,
    data_entrada DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_entrada_produto FOREIGN KEY (produto_id) REFERENCES produto(id)
);

CREATE TABLE saida (
    id INT AUTO_INCREMENT PRIMARY KEY,
    produto_id INT NOT NULL,
    quantidade INT NOT NULL,
    data_saida DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_saida_produto FOREIGN KEY (produto_id) REFERENCES produto(id)
);


CREATE VIEW vw_estoque AS
SELECT 
    p.id AS produto_id,
    p.nome AS produto_nome,
    c.nome AS categoria_nome,
    p.unidade_medida,
    p.quantidade,
    p.valor_unitario,
    (p.quantidade * p.valor_unitario) AS valor_total
FROM produto p
INNER JOIN categoria c ON p.categoria_id = c.id;




INSERT INTO categoria (nome) VALUES 
('Detergentes e Sabões'),
('Desinfetantes e Álcool'),
('Utensílios de Limpeza');

INSERT INTO produto (nome, unidade_medida, quantidade, valor_unitario, categoria_id) VALUES 
('Detergente Neutro 500ml', 'Unidade', 50, 2.50, 1),
('Álcool 70% 1L', 'Litro', 100, 8.90, 2),
('Saco de Lixo 100L (Pacote com 10)', 'Pacote', 0, 15.00, 3);

INSERT INTO entrada (produto_id, quantidade, valor_unitario, data_entrada) VALUES 
(1, 60, 2.50, '2026-09-01 08:00:00'),
(2, 120, 8.50, '2026-09-02 09:30:00'),
(3, 20, 15.00, '2026-09-03 14:15:00');

INSERT INTO saida (produto_id, quantidade, data_saida) VALUES 
(1, 10, '2026-09-05 10:00:00'),
(2, 20, '2026-09-10 11:45:00'),
(3, 20, '2026-09-15 16:30:00');