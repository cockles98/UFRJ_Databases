import pandas as pd
import mysql.connector
from sqlalchemy import create_engine


class APP:
    def __init__(self, filepath: str, password: str, host: str = 'localhost', user: str = 'user'):
        self.df: pd.DataFrame = pd.read_csv(filepath, delimiter=';', encoding='latin1')
        self.connection = False
        self.cursor = False
        self.nome_banco = 'Base_Eleitorado'
        self.host = host
        self.user = user
        self.password = password

    def pre_processamento(self):
        self.df['DT_GERACAO'] = pd.to_datetime(self.df['DT_GERACAO'], format='%d/%m/%Y').dt.strftime('%Y-%m-%d')
        self.df = self.df.drop(columns=['HH_GERACAO', 'CD_MUNICIPIO', 'DS_GENERO', 'DS_ESTADO_CIVIL',
                                        'DS_FAIXA_ETARIA', 'DS_GRAU_ESCOLARIDADE', 'DS_RACA_COR',
                                        'DS_IDENTIDADE_GENERO', 'DS_QUILOMBOLA', 'DS_INTERPRETE_LIBRAS'])

    def conecta_banco(self):
        try:
            self.cursor.execute(f"CREATE DATABASE IF NOT EXISTS {self.nome_banco}")
            self.connection.database = self.nome_banco
            print("Banco criado com sucesso!")
        except mysql.connector.Error as err:
            print(f"Erro ao criar o banco: {err}")

    def verifica_conexao(self):
        return self.connection and self.connection.is_connected()

    def faz_conexao(self):
        try:
            self.connection = mysql.connector.connect(
                host=self.host,
                user=self.user,
                password=self.password
            )
            if self.verifica_conexao():
                self.cursor = self.connection.cursor()
                print("Conexão feita com sucesso!")
        except mysql.connector.Error as err:
            print(f"Erro ao conectar ao banco: {err}")
            self.connection = None
            self.cursor = None

    def carrega_dados(self, nome_tabela: str = 'perfil_eleitorado'):
        try:
            self.conecta_banco()
            comando = """CREATE TABLE IF NOT EXISTS PERFIL_ELEITORADO (
                        DT_GERACAO DATE,
                        ANO_ELEICAO INT,
                        SG_UF VARCHAR(2),
                        NM_MUNICIPIO VARCHAR(100),
                        NR_ZONA INT,
                        CD_GENERO INT,
                        CD_ESTADO_CIVIL INT,
                        CD_FAIXA_ETARIA INT,
                        CD_GRAU_ESCOLARIDADE INT,
                        CD_RACA_COR INT,
                        CD_IDENTIDADE_GENERO INT,
                        CD_QUILOMBOLA INT,
                        CD_INTERPRETE_LIBRAS INT,
                        QT_ELEITORES_PERFIL INT,
                        QT_ELEITORES_BIOMETRIA INT,
                        QT_ELEITORES_DEFICIENCIA INT,
                        QT_ELEITORES_INC_NM_SOCIAL INT
                    );"""
            if not self.verifica_conexao():
                self.faz_conexao()

            if self.cursor:
                self.cursor.execute("SET foreign_key_checks = 0;")  # Desativa a verificação de chaves estrangeiras
                self.cursor.execute(comando)
                engine = create_engine(
                    f'mysql+mysqlconnector://{self.user}:{self.password}@{self.host}/{self.nome_banco}')
                self.df.to_sql(name=nome_tabela, con=engine, if_exists='append', index=False, chunksize=10000)
                self.cursor.execute("SET foreign_key_checks = 1;")  # Reativa a verificação de chaves estrangeiras
                print(f"Dados inseridos com sucesso em {nome_tabela}!")
                # A modificação de chaves estrangeiras e escolha do chunksize foram para auxiliar na otimização da inserção dos dados
        except mysql.connector.Error as err:
            print(f"Erro ao carregar os dados: {err}")
        finally:
            if self.cursor:
                self.cursor.close()
            if self.connection:
                self.connection.close()


def main():
    """Não esqueça de inserir a senha e user corretos para conectar ao banco de dados"""
    host = input(f'Insira seu host: ')  # Comum é localhost
    user = input(f'Insira seu user: ')  # Comum é root
    password = input(f'Insira sua senha: ')
    app = APP(filepath='Dados/perfil_eleitorado_ATUAL.csv',
              password=password, host=host, user=user)
    app.pre_processamento()
    app.faz_conexao()
    app.carrega_dados()
    return app


main()
