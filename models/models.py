from database import db
from datetime import datetime

class Categoria(db.Model):
    __tablename__ = 'categorias'
    id = db.Column(db.Integer, primary_key=True)
    nome = db.Column(db.String(100), nullable=False)

    produtos = db.relationship('Produto', backref='categoria', lazy=True)

class Produto(db.Model):
    __tablename__ = 'produtos'
    id = db.Column(db.Integer, primary_key=True)
    nome = db.Column(db.String(100), nullable=False)
    unidade_medida = db.Column(db.String(50), nullable=False)
    quantidade = db.Column(db.Integer, nullable=False)
    valor_unitario = db.Column(db.Numeric(10, 2), nullable=False)
    categoria_id = db.Column(db.Integer, db.ForeignKey('categorias.id'), nullable=False)


class Entrada(db.Model):
    __tablename__ = 'entrada'
    id = db.Column(db.Integer, primary_key=True)
    produto_id = db.Column(db.Integer, db.ForeignKey('produtos.id'), nullable=False)
    quantidade = db.Column(db.Integer, nullable=False)
    valor_unitario = db.Column(db.Numeric(10, 2), nullable=False)
    data_entrada = db.Column(db.DateTime, default=datetime.utcnow)

    produto = db.relationship('Produto', backref='entrada', lazy=True)

class Saida(db.Model):
    __tablename__ = 'saida'
    id = db.Column(db.Integer, primary_key=True)
    produto_id = db.Column(db.Integer, db.ForeignKey('produtos.id'), nullable=False)
    quantidade = db.Column(db.Integer, nullable=False)
    valor_unitario = db.Column(db.Numeric(10, 2), nullable=False)
    data_saida = db.Column(db.DateTime, default=datetime.utcnow)

    produto = db.relationship('Produto', backref='saida', lazy=True)


class ViewEstoque(db.Model):
    __tablename__ = 'view_estoque'
    produto_id = db.Column(db.Integer, primary_key=True)
    produto_nome = db.Column(db.String(100))
    categoria_nome = db.Column(db.String(100))
    unidade_medida = db.Column(db.String(50))
    quantidade = db.Column(db.Integer)
    valor_unitario = db.Column(db.Numeric(10, 2))
    valor_total = db.Column(db.Numeric(10, 2))