FROM elixir:1.6.0

ENV PORT 4000
ENV MIX_ENV=prod

WORKDIR /weather_api

RUN mix local.hex --force && mix local.rebar --force

COPY mix.* ./
RUN mix local.hex --force
RUN mix local.rebar --force
RUN mix deps.get --only-prod

COPY . ./
RUN mix compile

EXPOSE $PORT

CMD ["mix", "phx.server"]
