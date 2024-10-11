# Utiliser l'image officielle Elixir version 1.14 pour builder l'application
FROM elixir:1.14-alpine AS build

# Définir l'environnement en production
ENV MIX_ENV=prod

# Installer les dépendances système requises
RUN apk add --no-cache build-base git

# Configurer les chemins de travail
WORKDIR /app

# Copier les fichiers de configuration et installer les dépendances Elixir
COPY mix.exs mix.lock ./
COPY config config
RUN mix do local.hex --force, local.rebar --force
RUN mix deps.get --only prod
RUN mix deps.compile

# Copier tout le code de l'application
COPY . .

# Compiler l'application
RUN mix compile

# Construire une release en production
RUN mix release --overwrite

# Étape finale : créer une image légère pour exécuter l'application
FROM alpine:3.15 AS app
RUN apk add --no-cache openssl ncurses-libs bash

# Définir le répertoire de travail
WORKDIR /app

# Copier les fichiers de la release depuis l'étape précédente
COPY --from=build /app/_build/prod/rel/time_manager ./

# Exposer le port sur lequel Phoenix va écouter
EXPOSE 4000

# Commande pour démarrer l'application
CMD ["bin/time_manager", "start"]
