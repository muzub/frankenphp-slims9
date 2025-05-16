# SLiMS 9 Bulian on FrankenPHP

This repository provides a Docker setup to run SLiMS 9 Bulian (Senayan Library Management System) using FrankenPHP.

## What is FrankenPHP?

[FrankenPHP](https://github.com/dunglas/frankenphp) is a modern application server for PHP, built on top of the Caddy web server. It offers improved performance compared to traditional PHP deployments.

## What is SLiMS?

[SLiMS](https://slims.web.id) (Senayan Library Management System) is an open source Library Management System. It's a web-based application designed to handle the administration of library resources.

## Getting Started

### Prerequisites

- Docker
- Docker Compose

### Running the Application

1. Clone this repository:
   ```bash
   git clone https://github.com/muzub/frankenphp-slims9.git
   cd frankenphp-slims9
   ```

2. Build and run the Docker container:
   ```bash
   docker-compose up -d
   ```

3. Access SLiMS installation wizard at http://localhost

4. Follow the installation wizard to configure SLiMS.

## Configuration

Edit the `Caddyfile` to customize the web server configuration.

## License

This project is licensed under the GPL-3.0 License - see the LICENSE file for details.
```

```yaml name=docker-compose.yml
version: '3'

services:
  app:
    build: .
    ports:
      - "80:80"
      - "443:443"
    volumes:
      - ./slims-data:/app/files
    depends_on:
      - db
    environment:
      - PHP_MEMORY_LIMIT=256M
      - UPLOAD_MAX_FILESIZE=50M
      - POST_MAX_SIZE=50M

  db:
    image: mariadb:10.6
    environment:
      MYSQL_ROOT_PASSWORD: rootpassword
      MYSQL_DATABASE: slims
      MYSQL_USER: slims
      MYSQL_PASSWORD: slims
    volumes:
      - db-data:/var/lib/mysql

volumes:
  db-data:
  slims-data:
```

## Next Steps

Once you've created the repository with these files:

1. Clone it to your local machine
2. Build and run the Docker containers using `docker-compose up`
3. Access SLiMS at http://localhost and follow the installation wizard
4. Customize the configuration as needed for your specific use case

Would you like me to explain any part of this setup in more detail?
