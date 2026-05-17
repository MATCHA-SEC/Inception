# 🐳 Inception | System Administration & Infrastructure with Docker

[![42 School](https://img.shields.io/badge/42-Network-000000?style=flat-square&logo=42)](https://github.com/souad-hadria)
[![Docker](https://img.shields.io/badge/Docker-2496ED?style=flat-square&logo=docker&logoColor=white)](https://www.docker.com/)
[![Linux](https://img.shields.io/badge/Linux-FCC624?style=flat-square&logo=linux&logoColor=black)](https://www.linux.org/)

A DevOps and System Administration project designed to build a fully containerized web infrastructure from scratch using **Docker Compose**. Every single service runs in its own dedicated, isolated environment on a virtualized Alpine or Debian Linux host, built strictly from raw Dockerfiles without relying on pre-made Docker Hub images.

---

## System Architecture

The infrastructure acts as a multi-tier web application stack where all network communication is strictly isolated, except for secure public traffic entering through the web gateway.

              [ Web Browser / Client ]
                         │
                         ▼ (Port 443 | HTTPS)
                ┌─────────────────┐
                │  Nginx Gateway  │
                └────────┬────────┘
                         │
        ┌────────────────┴────────────────┐
        ▼ (Port 9000 | FastCGI)           ▼ (Static Volumes)
┌─────────────────┐               ┌─────────────────┐
│   WordPress     │               │     Volumes     │
│  (PHP-FPM Engine)│               │ (Persistent Data)│
└────────┬────────┘               └─────────────────┘
│
▼ (Port 3306)
┌─────────────────┐
│    MariaDB      │
│   (Database)    │
└─────────────────┘


### Core Subsystems Developed
1. **Nginx (The Gateway)**: Configured as the sole entry point, serving TLSv1.2/TLSv1.3 encrypted HTTPS traffic on port 443.
2. **WordPress + PHP-FPM (The Application Layer)**: Handles dynamic web scripts and content processing, communicating with Nginx via the FastCGI protocol.
3. **MariaDB (The Data Layer)**: A secure, standalone relational database system optimized to store application states.

---

## Technical Implementation & Security Rules

* **Zero Pre-Built Images**: Every service is built natively by writing customized `Dockerfiles`. Downloading ready-to-run instances containing WordPress or Nginx is forbidden.
* **Network Segregation**: Containers are bound together inside a private internal Docker Network. Only Nginx exposes a port to the host machine, shielding the database and runtime engine from external networks.
* **Volume Persistence**: Configured raw host directories linked through Docker Volumes (`/home/username/data/wordpress` and `/home/username/data/mariadb`) to guarantee zero data loss when containers are torn down or restarted.
* **Environment Hygiene**: Sensitive administrative keys, user credentials, and database roots are strictly handled via a hidden `.env` configuration file, avoiding hardcoded secrets inside the source code.

---

### Prerequisites
* A Linux host environment (or virtual machine).
* Docker and Docker Compose installed.

### Compilation & Deployment

The infrastructure is completely orchestrated using an automated automation flow managed by the system `Makefile`:

```bash
# Clone the repository
git clone https://github.com/MATCHA-SEC/inception.git && cd inception

# Build the custom images, initialize directories, and boot up the containers
make

# Shut down the infrastructure cleanly without deleting persistent data
make down

# Complete wipeout (Removes containers, networks, images, and raw data volumes)
make clean
