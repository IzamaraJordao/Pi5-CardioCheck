# Projeto de CRUD em Flask e MySQL

Este é um projeto simples que utiliza Flask como framework web e MySQL como banco de dados para realizar operações CRUD (Create, Read, Update, Delete) em uma tabela de usuários e paciente.
tambem tendo um aplicativo em Flutter para consumir a API do projeto.
Com o aplicativo o usuário pode cadastrar um novo usuário e tambem se cadastrar para fazer o teste para ver a possibilidade que ele tem de ter uma doença cardiaca.

## Configuração

1. **Instalação de Dependências:**

   Certifique-se de ter o Python e o pip instalados. Em seguida, instale as dependências do projeto executando:

   ```bash
   pip install -r requirements.txt

## Configuração do Banco de Dados:

1. **Crie um banco de dados MySQL chamado sanguineo.**

2. **Configure as credenciais do banco de dados no arquivo app.py:**

app.config['SQLALCHEMY_DATABASE_URI'] = 'mysql+pymysql://seu_usuario:sua_senha@localhost/sanguineo'


## Execução do Aplicativo:

**Execute o aplicativo Flask:**

  python app.py

O aplicativo será iniciado em http://127.0.0.1:5000/.

## Funcionalidades
**Listar Todos os Usuários:**

Endpoint: /users (Método GET)

**Adicionar Novo Usuário:**

Endpoint: /add_user (Método POST)

**Atualizar Usuário Existente:**

Endpoint: /update_user/<int:user_id> (Método PUT)

**Deletar Usuário:**

Endpoint: /delete_user/<int:user_id> (Método DELETE)

**Exemplo de Requisição para Adicionar Usuário**

curl -X POST -H "Content-Type: application/json" -d '{"name":"John Doe", "blood_type":"A+", "email":"john@example.com", "password":"password123"}' http://127.0.0.1:5000/add_user


## Aplicativo em Flutter

O aplicativo em Flutter foi desenvolvido para consumir a API do projeto. O aplicativo permite que o usuário cadastre um novo usuário,tambem se cadastre para fazer o teste para ver a possibilidade que ele tem de ter uma doença cardiaca.

## Configuração

1. **Instalação de Dependências:**

   Certifique-se de ter o Flutter instalado. Em seguida, instale as dependências do projeto executando:

   ```bash
   flutter pub get

## Execução do Aplicativo:

**Execute o aplicativo Flutter:**
   
   flutter run

## Integrantes do Grupo 

**Nome:** Fernanda Cristina Baiano
**Nome:** Izamara Jordão Santos
**Nome:** Matheus Barbosa Ferreira

## Link do vídeo no Youtube:

https://youtu.be/nfmw4kwOqWQ?si=K8R1769KRa_L5fob

