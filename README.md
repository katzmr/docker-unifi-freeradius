# 🚀 UniFi Controller + FreeRADIUS + MySQL

## 🐳 Components

- **FreeRADIUS**: RADIUS server for authentication
- **MySQL**: Backend database for FreeRADIUS
- **UniFi Controller**: Ubiquiti UniFi Controller (for managing network devices)

---
## 📦 1. Clone the Repository

```bash
git clone https://github.com/katzmr/docker-unifi-freeradius.git
cd docker-unifi-freeradius
```
## ⚙️ 2. Configure Environment Variables
Rename the example environment file:
```bash
mv .env.example .env
```
Edit the .env file with your preferred editor:
```bash
nano .env
```
> ✏️ _Update values like MYSQL_ROOT_PASSWORD, MYSQL_DATABASE, MYSQL_USER, MYSQL_PASSWORD, RADIUS_SECRET, TZ_

## 🛠️ 3. Build and Start the Stack
Use Docker Compose to build and run the containers:
```bash
docker compose up --build -d
```
> 🐳 _This command will build all necessary images and run them in detached mode._

## ✅ 4. Access the Services
Once everything is up and running, you can access the service at:

- Unifi Controller: https://localhost:8443
> ⚠️ _Since the certificates are self-signed, your browser may show a security warning when accessing Kibana. You can safely proceed after confirming the exception._

## 🧩 Environment Variables Overview (.env)
| Variable              | Description                  | Default          |
|-----------------------|------------------------------|------------------|
| `MYSQL_ROOT_PASSWORD` | Password for mysql root user | `rootpassword`   |
| `MYSQL_DATABASE`      | Database name                | `freeradius`     |
| `MYSQL_USER`          | Mysql user name              | `radius`         |
| `MYSQL_PASSWORD`      | Password for MYSQL_USER      | `radiuspassword` |
| `RADIUS_SECRET`       | RADIUS secret                | `testing123`     |
| `TZ`                  | Timezone                     | `Etc/UTC`        |

