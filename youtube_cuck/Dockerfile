FROM elixir:alpine AS build

ARG DATABASE_URL
ENV DATABASE_URL $DATABASE_URL

# install build dependencies
RUN apk add --no-cache build-base npm git

# prepare build dir
WORKDIR /app

# install hex + rebar
RUN mix local.hex --force && \
    mix local.rebar --force

# set build ENV
ENV MIX_ENV=prod

# install mix dependencies
COPY mix.exs mix.lock ./
COPY config config
RUN mix do deps.get, deps.compile

# build assets
# COPY assets/package.json assets/package-lock.json ./assets/
# RUN npm --prefix ./assets ci --progress=false --no-audit --loglevel=error

COPY priv priv
COPY assets assets
RUN mix assets.deploy

# compile and build release
COPY lib lib

RUN mix do compile, release

# prepare release image
FROM alpine:latest AS app

RUN apk add --no-cache openssl libstdc++ ncurses-libs ffmpeg bash python3 py3-pip git gcc musl-dev rust

RUN python3 -m pip install --upgrade git+https://github.com/yt-dlp/yt-dlp.git@release

WORKDIR /app

RUN chown nobody:nobody /app

USER nobody:nobody

COPY --from=build --chown=nobody:nobody /app/_build/prod/rel/youtube_cuck ./

ENV HOME=/app

CMD ["bin/youtube_cuck", "start"]
