from database import db
from models.models import Produto, Categoria, Entrada, Saida, ViewEstoque
from sqlalchemy import text, func


class AlmoxarifadoRepository:
    @staticmethod
    def get_valor_total_estoque():
        query = text("""
            SELECT
            c.id AS categoria_id,
            c.nome AS categoria_nome,
            COALESCE(SUM(e.quantidade * e.valor_unitario), 0) AS valor_total
            FROM categorias c
            LEFT JOIN produtos p ON c.id = p.categoria_id
            GROUP BY c.id, c.nome
        """)

    