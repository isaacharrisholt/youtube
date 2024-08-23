# How to Deploy Gleam Apps Anywhere

Deploying Gleam is fairly simple, but it's not obvious how to do it at first glance.
This video will cover how to deploy your apps locally, regionally and globally!

## Deploying the app

Build either Dockerfile:

```sh
docker build -f erlang.Dockerfile -t primes .
# or
docker build -f javascript.Dockerfile -t primes .
```

Deploy to Fly.io:

```sh
fly launch --dockerfile erlang.Dockerfile
# or
fly launch --dockerfile javascript.Dockerfile
```
