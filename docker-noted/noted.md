# Sumber 
https://github.com/refactorian/laravel-docker/blob/main/README.md?plain=1

# How To Deploy

### For first time only !
- `docker-compose up -d`
- `docker-compose exec php bash`
- `composer setup`

### From the second time onwards
- `docker-compose up -d`

### Basic docker compose commands
- Build or rebuild services
    - `docker-compose build`
- Create and start containers
    - `docker-compose up -d`
- Stop and remove containers, networks
    - `docker-compose down`
- Stop all services
    - `docker-compose stop`
- Restart service containers
    - `docker-compose restart`

### Useful commands
- Run a command inside a container:
    - `docker-compose exec [container] [command]`
