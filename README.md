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

To start your Phoenix server:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.setup`
  * Start Phoenix endpoint with `mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](https://hexdocs.pm/phoenix/deployment.html).

## Learn more

  * Official website: https://www.phoenixframework.org/
  * Guides: https://hexdocs.pm/phoenix/overview.html
  * Docs: https://hexdocs.pm/phoenix
  * Forum: https://elixirforum.com/c/phoenix-forum
  * Source: https://github.com/phoenixframework/phoenix
