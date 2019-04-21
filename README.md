# nodelol-dashboard

React/Redux frontend with an Express API backend and mongodb. Development and production containers deployed using Docker. Reverse-proxy with Traefik.

### Prerequisites
* `docker`
* `docker-compose`
* Traefik configured with Docker (see https://github.com/frasergr/nodelol)

### Usage

Clone repository:
```shell
git clone https://github.com/frasergr/nodelol-dashboard.git
cd nodelol-dashboard/
```
Edit .env:
```shell
cp .env.example .env
nano .env
```
```shell
DOMAIN=<your root domain configured with traefik>
SERVER_PORT=<express server port number>
CLIENT_PORT=<dev client webpack-dev-server port number>
MONGO_HOST=<traefik hostname of mongo container>

JWT_SECRET_DEV=<dev jwt secret for signing>
JWT_SECRET_PROD=<prod jwt secret for signing>

MONGO_INITDB_ROOT_USERNAME=<mongo root username>
MONGO_INITDB_ROOT_PASSWORD=<mongo root password>

MONGO_DB_PROD=<mongo production db name>
MONGO_DB_USER_PROD=<mongo production db username>
MONGO_DB_PASSWORD_PROD=<mongo production db password>

MONGO_DB_DEV=<mongo production db name>
MONGO_DB_USER_DEV=<mongo production db username>
MONGO_DB_PASSWORD_DEV=<mongo production db password>

ME_CONFIG_MONGODB_ADMINUSERNAME=<mongo root username>
ME_CONFIG_MONGODB_ADMINPASSWORD=<mongo root password>
ME_CONFIG_BASICAUTH_USERNAME=<mongo-express http basic auth username>
ME_CONFIG_BASICAUTH_PASSWORD=<mongo-express http basic auth password>
```
Save changes to .env by pressing CTRL+X then Y

Bring stack up:

`docker-compose up -d`

### Check that everything works

Dev express server:
- `https://dev-server.<your domain>`

Dev frontend client:
- `https://dev-client.<your domain>`

Production app:
- `https://dashboard.<your domain>`

You may also access mongo-express from here:
- `https://mongo.<your domain>`

### Making change to server and client code

Make changes in the ./server and ./client git submodule directories. Changes will be reflected at the dev-client and dev-server URLs automatically.

If you wish to add a new module to package.json:

Server:
```shell
docker-compose exec dev ash
npm install <some package>
```
Client:
```shell
docker-compose exec dev ash
cd client/
npm install <some package>
```

To have changes made to the server or client appear in the production container (dashboard URL) run:

`docker-compose up -d --force-recreate --build --no-deps prod`

This command will force the recreation of only the production container.


Note: If the production URL is inaccessible after recreation, the network backend may not have been recreated in Traefik. Restart prod container:

`docker-compose restart prod`
