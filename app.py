from flask import Flask, Response, request
from flask_sqlalchemy import SQLAlchemy
import json  

app = Flask(__name__)
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False
app.config['SQLALCHEMY_DATABASE_URI'] = 'mysql+pymysql://root:210396@localhost/sanguineo'

db = SQLAlchemy(app)

class User(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(50))
    email = db.Column(db.String(50))
    password = db.Column(db.String(50))

    def to_json(self):
        return {"id": self.id, "name": self.name, "email": self.email, "password": self.password}

# Rota para exibir todos os usuários
@app.route('/users', methods=['GET'])
def index():
    users = User.query.all()
    users = [user.to_json() for user in users]
    print(users)
    return Response(json.dumps(users), mimetype='application/json')  # Corrigindo o uso de Response

# Rota para exibir um usuário específico
@app.route('/users/<int:id>', methods=['GET'])
def get_user(id):
    user = User.query.get_or_404(id)
    return Response(json.dumps(user.to_json()), mimetype='application/json')


# Rota para cadastrar um novo usuário
@app.route('/users', methods=['POST'])
def create_user():
    try:
        new_user = User()
        new_user.name = request.json['name']
        new_user.email = request.json['email']
        new_user.password = request.json['password']

        db.session.add(new_user)
        db.session.commit()
        return Response(json.dumps(new_user.to_json()), mimetype='application/json'), 201

    except Exception as e:
        print('Erro: ', e)
        return Response(json.dumps({"error": "Erro ao cadastrar usuário"}), mimetype='application/json'), 400


# Rota para atualizar um usuário
@app.route('/users/<int:id>', methods=['PUT'])
def update_user(id):
    user = User.query.get_or_404(id)

    user.name = request.json['name']
    user.email = request.json['email']
    user.password = request.json['password']

    db.session.commit()

    return Response(json.dumps(user.to_json()), mimetype='application/json')


# Rota para excluir um usuário
@app.route('/users/<int:id>', methods=['DELETE'])
def delete_user(id):
    user = User.query.get_or_404(id)

    db.session.delete(user)
    db.session.commit()
    return Response(json.dumps({"success": "Usuário excluído com sucesso"}), mimetype='application/json'), 200





if __name__ == '__main__':
    app.run()
