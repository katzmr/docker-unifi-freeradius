# 🚀 UniFi Controller + FreeRADIUS + MySQL

## 🐳 Components

- **FreeRADIUS**: RADIUS server for authentication
- **MySQL**: Backend database for FreeRADIUS
- **UniFi Controller**: Ubiquiti UniFi Controller (for managing network devices)
---
## 🚀 Getting Started
### 📦 1. Clone the Repository

```bash
git clone https://github.com/katzmr/docker-unifi-freeradius.git
cd docker-unifi-freeradius
```
### ⚙️ 2. Configure Environment Variables
Rename the example environment file:
```bash
mv .env.example .env
```
Edit the .env file with your preferred editor:
```bash
nano .env
```
> ✏️ _Update values like MYSQL_ROOT_PASSWORD, MYSQL_DATABASE, MYSQL_USER, MYSQL_PASSWORD, RADIUS_SECRET, TZ_

### 🛠️ 3. Build and Start the Stack
Use Docker Compose to build and run the containers:
```bash
docker compose up --build -d
```
> 🐳 _This command will build all necessary images and run them in detached mode._

### ✅ 4. Access the Services
Once everything is up and running, you can access the service at:

- FreeRADIUS: running inside the container and listening on 1812/udp and 1813/udp
- MySQL: available internally to FreeRADIUS
- UniFi Controller: visit https://localhost:8443 in your browser
> ⚠️ _Since the certificates are self-signed, your browser may show a security warning when accessing Unifi Controller. You can safely proceed after confirming the exception_
---
## ⚙️ Post-Installation Steps
After running _docker-compose up --build -d_, follow these steps to connect RADIUS:
### 🛜 1. Complete the UniFi Controller Setup Wizard
Open https://localhost:8443 in your browser and follow the initial setup wizard (set your username and password, choose a site name, etc.).
Once finished, you'll be taken to the UniFi dashboard.

### 🌐 2. Connect RADIUS
- Go to _Settings_ (gear icon in the lower left)
- Choose _Profiles_ (or _Network Settings_ depending on version)
- Select _RADIUS_ tab
- Add a New RADIUS Profile
- Click _Create New RADIUS Profile_
> - **Name**: e.g. freeradius
> - **RADIUS Server**: IP address of your FreeRADIUS container or host
> - **Port**: 1812
> - **Secret**: must match ${RADIUS_SECRET} from your .env file
> - **Optional**: Fill in accounting port 1813 and use the same secret

### 👤 3. Create a RADIUS User in MySQL
Access the MySQL database:
```bash
docker exec -it mysql mysql -u root -p freeradius
```
> _Replace freeradius with your actual MYSQL_DATABASE value from .env_
> 
Insert a user into the radcheck table (example: username testuser, password testpass):
```sql
INSERT INTO radcheck (username, attribute, op, value) VALUES ('testuser', 'Cleartext-Password', ':=', 'testpass');
```

### 🚀 4. Test RADIUS Authentication
```bash
docker exec -it freeradius radtest testuser testpass localhost 0 testing123
```
> _Replace testing123 with your actual RADIUS_SECRET value from .env_

You should see an Access-Accept response if everything is working correctly.

---
## 🧩 Environment Variables Overview (.env)
| Variable              | Description                  | Default          |
|-----------------------|------------------------------|------------------|
| `MYSQL_ROOT_PASSWORD` | Password for mysql root user | `rootpassword`   |
| `MYSQL_DATABASE`      | Database name                | `freeradius`     |
| `MYSQL_USER`          | Mysql user name              | `radius`         |
| `MYSQL_PASSWORD`      | Password for MYSQL_USER      | `radiuspassword` |
| `RADIUS_SECRET`       | RADIUS secret                | `testing123`     |
| `TZ`                  | Timezone                     | `Etc/UTC`        |

---
## ✨ Updating the Certificates
```bash
docker exec -it freeradius /update_certificates.sh
```
This script will:
- Remove old certificates (if they exist).
- Generate new CA (Certificate Authority).
- Generate a new private key for FreeRADIUS.
- Create a new Certificate Signing Request (CSR) for FreeRADIUS.
- Sign the new FreeRADIUS certificate with the newly generated CA.

> ⚠️ _After the new certificates are generated, restart the Docker Compose to apply the new certificates:_
> ```bash
> docker compose restart freeradius
> ```