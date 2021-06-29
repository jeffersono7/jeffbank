# JeffBank

É um serviço financeiro, onde é possivel criar contas e realizar transações financeiras entre elas.

[![Build Status](https://github.com/jeffersono7/jeffbank/actions/workflows/elixir.yml/badge.svg)](https://github.com/jeffersono7/jeffbank/actions/workflows/elixir.yml)

## Começando

### Desenvolvendo na maquina local
  - Subir serviços de banco de dados postgres
    ```shell
    $ cd devops;
    $ chmod +x start.sh
    $ ./start.sh
    $ cd ..
    ```
  - Deve instalar elixir e erlang na máquina (sugestão: usar asdf)
  - Executar testes para garantir que tudo está funcionando e a integração com os serviços necessários estão atendidas
    ```shell
    $ mix test
    ```
  - Para subir a aplicação (http://localhost:4000)
    ```shell
    $ mix phx.server
    ```

### Rotas (possui collections para postman na raiz do projeto)

 - POST  /api/contas
 - POST  /api/contas/sign_in
 - GET   /api/contas/:id/saldo
 - GET   /api/transacoes?data_inicio=<data/hora>&data_fim=<data/hora>
 - POST  /api/transacoes
 - POST  /api/transacoes/:id/estorno
