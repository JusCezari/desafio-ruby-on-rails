# CNAB Manager

Este projeto foi feito para o desafio de programação da [bycoders](https://www.bycoders.com.br). Se quiser saber os requisitos exigidos para esta aplicação acesse o arquivo [README](https://github.com/JusCezari/desafio-ruby-on-rails/blob/master/cnab_manager/README.md) com a descrição do desafio.

# <a name="versions"></a>Versões utilizadas

Este projeto foi desenvolvido e testado usando os seguintes softwares com suas respectivas versões:

* Ruby 2.7.2
* Rails: 6.0.3.4
* Rubocop: 1.0.0
* Docker engine: 19.03.13
* Docker compose: 1.27.4
* Postgres: 13.0
* Yarn: 1.22.5
* Bundler: 2.1.4

# Configuração para rodar o projeto

Este projeto pode ser rodado localmente ou se preferir pode-se rodar através de uma imagem do Docker.

## Configuração local

Para rodar localmente certifique-se de ter todas as [versões indicadas](#versions) ou compatíveis.

Após clonar o repositório abra a pasta ``cnab_manager`` que contém o projeto:

``cd cnab_manager``

Instale as gemas necessárias para o projeto:

``bundle install``

Instale as dependências necessárias para o projeto rodar corretamente:

``yarn install``

É importante ter o Postgres instalado na máquina local com um usuário capaz de criar bancos de dados. Para configurar o acesso ao banco da aplicação será necessário ter duas variáveis de ambiente:

``CNAB_MANAGER_DATABASE_USERNAME # Usuário do banco de dados``
``CNAB_MANAGER_DATABASE_PASSWORD # Senha do usuário para o banco de dados``

Se tiver dúvidas de como setar variáveis de ambiente em seu sistema consulte a internet. Caso estiver em um sistema Unix você pode setar temporariamente utilizando os comandos abaixo:

``export CNAB_MANAGER_DATABASE_USERNAME=your_database_user``
``export CNAB_MANAGER_DATABASE_PASSWORD=your_database_password``

Após configurar as variáveis de ambiente corretamente crie o banco de dados usado pela aplicação usando o comando abaixo:

``rails db:create``

Esse comando criará o banco de desenvolvimento da aplicação junto com o banco usado para rodar testes. Após a criação do banco de dados rode as migrações da aplicação para gerar todas as tabelas necessárias:

``rails db:migrate``

Após todo esse processo o ambiente estará configurado corretamente. Utilize o comando abaixo para iniciar o servidor:

``rails s``

Este comando iniciará o servidor podendo ser acessado pela sua máquina na URL [http:localhost:3000](http:localhost:3000).

## Configuração usando Docker

### Docker (sem Docker Compose)

Para utilizar uma imagem individual do Docker primeiramente faça um build da imagem:

``docker build . -t cnab_manager:latest``

Esse comando criará uma imagem pronta para ser iniciada para rodar a aplicação. Importante notar que será necessário passar as variáveis referentes a configuração do banco de dados, serão necessárias 3 variáveis de ambiente:

``CNAB_MANAGER_DATABASE_HOST # Endereço para se conectar ao banco de dados``
``CNAB_MANAGER_DATABASE_USERNAME # Usuário do banco de dados``
``CNAB_MANAGER_DATABASE_PASSWORD # Senha do usuário para o banco de dados``

Para passar essa configuração na execução do seu container utilize o comando abaixo:

``docker run --env CNAB_MANAGER_DATABASE_HOST=your_database_host --env CNAB_MANAGER_DATABASE_USERNAME=your_database_user --env CNAB_MANAGER_DATABASE_PASSWORD=your_database_password -p 3000:3000 --rm -it cnab_manager:latest``

Após esse comando o seu container iniciará com a aplicação rodando na porta 3000. Para acessar abra a URL [http:localhost:3000](http:localhost:3000).

### <a name="docker_compose"></a>Docker Compose

Para iniciar a aplicação usando o Docker Compose execute o comando abaixo:

``docker-compose up``

Este comando irá baixar a imagem do Postgres para subir um container como banco de dados e também irá buildar a imagem da aplicação exclusivamente para o Docker Compose. Após esse processo você terá 2 containeres rodando localmente. Para criar o banco de dados da aplicação execute o seguinte comando **em um terminal separado e no mesmo diretório da aplicação**:

``docker-compose run rails rake db:migrate:reset``

Este comando irá subir um container novo da aplicação, porém conectado ao mesmo banco. Ele irá se certificar de excluir qualquer banco de dados da aplicação e criar novamente. Este comando também rodará as migrações necessárias para a aplicação funcionar corretamente.

Após esse processo a aplicação pode ser acessada na sua máquina pela URL [http:localhost:3000](http:localhost:3000).

## Testes

Para rodar os testes da aplicação recomenda-se executar localmente ou no ambiente com Docker Compose.

### Rodando os testes localmente

Para rodar os testes localmente execute o comando do ``rspec`` na raiz do projeto:

``rspec``

Este comando irá rodar todos os testes da pasta ``spec``, a qual contém todos os testes da aplicação. O arquivo de coverage da aplicação pode ser encontrado na pasta ``coverage``, dentro da aplicação, que será gerada após rodar os testes.

### Rodando os testes com o Docker Compose

Para rodar os testes no Docker Compose siga primeiramente os passos descritos na [seção de configuração](#docker_compose) do Docker Compose. Com a aplicação rodando execute o seguinte comando para rodar os testes pelo Docker Compose:

``docker-compose run rails rspec``

Este comando irá rodar todos os testes da pasta ``spec`` usando os containeres do Docker Compose. O arquivo de coverage da aplicação pode ser encontrado na pasta ``coverage`` dentro do container que roda a aplicação.

## Documentação da API

O projeto conta com uma API simples para retornar os dados das transações. Foi desenvolvido uma documentação para esta API utilizando a [Open API Specification](http://spec.openapis.org/oas/v3.0.3). Esta documentação foi escrita usando a ferramenta [Swagger Editor](https://editor.swagger.io) e pode ser encontrada dentro da pasta ``docs`` da aplicação. Dentro desta pasta encontramos 3 arquivos:

* **cnab_manager_api_doc.yml** - Arquivo contendo a especificação no formato YML. Para ser melhor editado e visualizado recomenda-se abrir usando o [Swagger Editor](https://editor.swagger.io).
* **cnab_manager_api_doc.json** - Arquivo JSON exportado diretamento do [Swagger Editor](https://editor.swagger.io). Este arquivo foi usado para gerar o PDF da documentação.
* **cnab_manager_api_doc.pdf** - Arquivo em PDF da documentação para simplificar o acesso caso não deseje abrir a especificação em outros formatos.

## Considerações

* A tela de transações carrega todos os dados de todas as lojas e agrupa visualmente. Isso em uma base com muitos registros pode exigir uma reorganização para não carregar todos os dados de uma só vez.

* Foi utilizado a [Open API Specification](http://spec.openapis.org/oas/v3.0.3) como forma de documentação da API pois é a forma que mais tenho experiência em criar documentação de APIs.

* O visual do sistema foi baseado no visual do [website da bycoders](https://www.bycoders.com.br) acessado em 26/10/2020.