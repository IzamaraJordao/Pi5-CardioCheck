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




class Paciente(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    idade = db.Column(db.Integer)
    sexo = db.Column(db.String(10))
    tipo_dor_peito = db.Column(db.String(50))
    pressao_arterial = db.Column(db.String(20))
    colesterol_serico = db.Column(db.Integer)
    acucar_jejum = db.Column(db.Integer)
    resultado_eletrocardiograma = db.Column(db.String(50))
    freq_cardiaca_max = db.Column(db.Integer)
    dor_peito_pratica_atividade = db.Column(db.Boolean)
    pico_antigo = db.Column(db.String(50))
    aceleracao_batimentos = db.Column(db.Boolean)
    avaliacao_exclusao = db.Column(db.String(50))
    condicao_pre_existente = db.Column(db.Boolean)

    def to_json(self):
        return {
            "id": self.id,
            "idade": self.idade,
            "sexo": self.sexo,
            "tipo_dor_peito": self.tipo_dor_peito,
            "pressao_arterial": self.pressao_arterial,
            "colesterol_serico": self.colesterol_serico,
            "acucar_jejum": self.acucar_jejum,
            "resultado_eletrocardiograma": self.resultado_eletrocardiograma,
            "freq_cardiaca_max": self.freq_cardiaca_max,
            "dor_peito_pratica_atividade": self.dor_peito_pratica_atividade,
            "pico_antigo": self.pico_antigo,
            "aceleracao_batimentos": self.aceleracao_batimentos,
            "avaliacao_exclusao": self.avaliacao_exclusao,
            "condicao_pre_existente": self.condicao_pre_existente
        }

# Rota para criar um novo paciente
@app.route('/pacientes', methods=['POST'])
def add_paciente():
    data = request.get_json()
    novo_paciente = Paciente(**data)
    db.session.add(novo_paciente)
    db.session.commit()
    return jsonify({"message": "Paciente adicionado com sucesso!"})

# Rota para listar todos os pacientes
@app.route('/pacientes', methods=['GET'])
def get_pacientes():
    pacientes = Paciente.query.all()
    pacientes_json = [paciente.to_json() for paciente in pacientes]
    return jsonify(pacientes_json)

# Rota para obter detalhes de um paciente específico
@app.route('/pacientes/<int:paciente_id>', methods=['GET'])
def get_paciente(paciente_id):
    paciente = Paciente.query.get_or_404(paciente_id)
    return jsonify(paciente.to_json())

# Rota para atualizar os dados de um paciente
@app.route('/pacientes/<int:paciente_id>', methods=['PUT'])
def update_paciente(paciente_id):
    paciente = Paciente.query.get_or_404(paciente_id)
    data = request.get_json()
    for key, value in data.items():
        setattr(paciente, key, value)
    db.session.commit()
    return jsonify({"message": "Dados do paciente atualizados com sucesso!"})

# Rota para excluir um paciente
@app.route('/pacientes/<int:paciente_id>', methods=['DELETE'])
def delete_paciente(paciente_id):
    paciente = Paciente.query.get_or_404(paciente_id)
    db.session.delete(paciente)
    db.session.commit()
    return jsonify({"message": "Paciente excluído com sucesso!"})
    
if __name__ == '__main__':
    app.run()
