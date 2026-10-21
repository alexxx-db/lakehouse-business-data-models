# vibe-modeling ✨

> A modern full-stack application built with [`apx`](https://github.com/databricks-solutions/apx) 🚀

## 🛠️ Tech Stack

This application leverages a powerful, modern tech stack:

- **Backend** 🐍 Python + [FastAPI](https://fastapi.tiangolo.com/)
- **Frontend** ⚛️ React + [shadcn/ui](https://ui.shadcn.com/)
- **API Client** 🔄 Auto-generated TypeScript client from OpenAPI schema

## 🚀 Quick Start

### Development Mode

Start all development servers (backend, frontend, and OpenAPI watcher) in detached mode:

```bash
apx dev start
```

This will start an apx development server, which in it's turn runs backend, frontend and OpenAPI watcher.
All servers run in the background, with logs kept in-memory of the apx dev server.

### 📊 Monitoring & Logs

```bash
# View all logs
apx dev logs

# Stream logs in real-time
apx dev logs -f

# Check server status
apx dev status

# Stop all servers
apx dev stop
```

## ✅ Code Quality

Run type checking and linting for both TypeScript and Python:

```bash
apx dev check
```

## 📦 Build

Create a production-ready build:

```bash
apx build
```

## 🚢 Deployment

To deploy, re-run `install/install.sh` from the repo root with the same flags you installed with. It sets the install-time values and deploys.

To deploy by hand instead, export the same `VIBE_MODELING_*` values your install uses (Lakebase project, database, deployment catalog, warehouse, and the taxonomy and assessment settings; see [Deploying without `install.sh`](../../INSTALL.md#deploying-without-installsh)), then:

```bash
bash install/build_and_render.sh   # from the repo root, before the deploy
databricks bundle deploy -p <your-profile>
```

The render writes the bundle's user-scopes include, which the deploy reads before its own build step. If you skip it, re-run the deploy when that step stops with "The app's user API scopes changed". Unset variables fall back to the defaults, and an optional feature whose flag is unset turns off.

---

<p align="center">Built with ❤️ using <a href="https://github.com/databricks-solutions/apx">apx</a></p>
