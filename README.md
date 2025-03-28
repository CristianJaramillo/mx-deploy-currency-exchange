# Deploy - Currency Exchange

Este proyecto contiene la definición y configuración necesaria para desplegar toda la plataforma de microservicios de **Currency Exchange** utilizando Docker Compose.

Incluye los siguientes servicios:

- `MySQL` (para persistencia de datos)
- `RabbitMQ` (para mensajería entre microservicios)
- `mx-bank-ms-currency-exchange` (servicio principal REST)
- `mx-bank-wkr-currency-exchange` (servicio de consumo y persistencia de mensajes)

---

## 📁 Estructura del proyecto

```
├── docker-compose.yaml
├── config/
│   ├── mysql.env
│   ├── rabbitmq.env
│   ├── mx-bank-ms-currency-exchange.properties
│   └── mx-bank-wkr-currency-exchange.properties
```

---

## 🚀 Cómo iniciar el entorno

> Asegúrate de tener [Docker](https://www.docker.com/products/docker-desktop) y [Docker Compose](https://docs.docker.com/compose/) instalados.

```bash
docker compose up -d --build
```

Esto construirá las imágenes desde los proyectos `mx-ms-currency-exchange` y `mx-wkr-currency-exchange`, y luego iniciará todos los servicios definidos.

---

## 📦 Servicios expuestos

| Servicio                         | URL / Puerto                   | Descripción                           |
|----------------------------------|---------------------------------|---------------------------------------|
| `MySQL`                          | `localhost:3306`               | Base de datos para transacciones      |
| `RabbitMQ Management`            | [http://localhost:15672](http://localhost:15672) | Interfaz de administración           |
| `mx-ms-currency-exchange`        | [http://localhost:8080](http://localhost:8080) | API REST para iniciar transacciones  |

> 💡 Las configuraciones personalizadas para cada servicio están ubicadas en `./config/`.

---

## 🧰 Variables de entorno

Cada servicio carga sus variables desde un archivo `.env` o `.properties` específico:

- `mysql.env`: configuración de base de datos y credenciales
- `rabbitmq.env`: credenciales y configuración de RabbitMQ
- `mx-bank-*.properties`: configuración Spring Boot para cada microservicio

---

## 📛 Prerrequisitos: clonar repositorios relacionados

Para que el `docker-compose.yaml` funcione correctamente, es necesario tener estos repositorios clonados localmente **en el mismo nivel** que este proyecto de despliegue:

```
├── mx-api-currency-exchange/             # OpenAPI specification
├── mx-async-currency-exchange/           # AsyncAPI specification
├── mx-deploy-currency-exchange/          # (este repositorio)
├── mx-ms-currency-exchange/              # Microservicio principal (REST)
└── mx-wkr-currency-exchange/             # Worker consumidor (AMQP)
```

Puedes clonarlos así:

```bash
git clone https://github.com/CristianJaramillo/mx-ms-currency-exchange.git
git clone https://github.com/CristianJaramillo/mx-wkr-currency-exchange.git
```

Luego, asegúrate de que el directorio `mx-deploy-currency-exchange` esté en el mismo nivel para que Docker Compose pueda acceder correctamente a los `Dockerfile` de cada microservicio.

> 📸 Referencia visual basada en tu entorno de desarrollo:
> *(Puedes agregar la imagen en ./docs/repositories-layout.png)*

---

## 🛑 Detener servicios

```bash
docker compose down
```

Si deseas limpiar volúmenes persistentes:

```bash
docker compose down -v
```

---

## 📋 Repositorios relacionados

- [`mx-ms-currency-exchange`](https://github.com/CristianJaramillo/mx-ms-currency-exchange)
- [`mx-wkr-currency-exchange`](https://github.com/CristianJaramillo/mx-wkr-currency-exchange)
- [`mx-async-currency-exchange`](https://github.com/CristianJaramillo/mx-async-currency-exchange) (AsyncAPI Spec)
- [`mx-api-currency-exchange`](https://github.com/CristianJaramillo/mx-api-currency-exchange) (OpenAPI Spec)
- [`mx-deploy-currency-exchange`](https://github.com/CristianJaramillo/mx-deploy-currency-exchange) (este repositorio)

---

## 📌 Requisitos mínimos

- Docker v20+
- Docker Compose v2+

---

## ✅ Estado del proyecto

✔️ Listo para pruebas locales con contenedores  
✔️ Configuraciones externas desacopladas  
✔️ Compatible con ambientes productivos

---

> Desarrollado por [Cristian Jaramillo](https://github.com/CristianJaramillo)

