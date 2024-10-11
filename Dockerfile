FROM elixir:1.14-alpine AS build

ENV MIX_ENV=prod

RUN apk add --no-cache build-base git

WORKDIR /app

COPY mix.exs mix.lock ./
COPY config config
RUN mix do local.hex --force, local.rebar --force
RUN mix deps.get --only prod
RUN mix deps.compile

COPY . .

RUN mix compile

RUN mix release --overwrite

FROM alpine:3.15 AS app
RUN apk add --no-cache openssl ncurses-libs bash

WORKDIR /app

COPY --from=build /app/_build/prod/rel/time_manager ./

EXPOSE 4000

CMD ["bin/time_manager", "start"]
