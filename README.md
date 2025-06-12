# React Dockerized Template

A modern Docker-based development environment for React applications with support for Next.js, React Router, and Expo. This template provides a containerized setup that ensures consistent development environments across different machines.

## Features

- 🐳 **Docker-based development environment** - Consistent setup across all machines
- ⚛️ **Multiple React frameworks support**:
  - Next.js (App Router)
  - React Router (v7)
  - Expo (for React Native apps)
- 🔧 **Make-based workflow** - Simple commands for common tasks
- 🚀 **Hot reload support** - Changes are reflected instantly
- 👤 **Non-root user setup** - Secure container execution
- 📦 **Volume mounting** - Persistent development files

## Prerequisites

- [Docker](https://docs.docker.com/get-docker/) (with Docker Compose)
- [Make](https://www.gnu.org/software/make/) (usually pre-installed on Linux/macOS)

## Quick Start

1. **Clone or use this template**
   ```bash
   git clone <repository-url>
   cd react-dockerized
   ```

2. **Configure your project** (optional)

   Edit the `.env` file to customize your project settings:
   ```bash
   IMAGE_NAME=react-dockerized-app
   REACT_PROJECT_NAME=my_project
   NODE_ENV=development
   ```

3. **Initialize a React application**

   Choose one of the following options:

   **For Next.js (recommended for web apps):**
   ```bash
   make init-next
   ```

   **For React Router (traditional React apps):**
   ```bash
   make init-react
   ```

   **For Expo (React Native apps):**
   ```bash
   make init-expo
   ```

4. **Start the development server**
   ```bash
   make up
   ```

5. **Open your application**

   Navigate to [http://localhost:3000](http://localhost:3000) in your browser.

## Available Commands

Run `make help` to see all available commands:

| Command | Description |
|---------|-------------|
| `make help` | Show available commands |
| `make init-next` | Initialize a new Next.js app |
| `make init-react` | Initialize a new React Router app |
| `make init-expo` | Initialize a new Expo app |
| `make build` | Build Docker image (no cache) |
| `make build-cached` | Build Docker image (with cache) |
| `make up` | Start the development server |
| `make down` | Stop the development server |
| `make start` | Start existing containers |
| `make stop` | Stop running containers |
| `make shell` | Access container shell |
| `make npm <command>` | Run npm commands in container |
| `make clean` | Clean up containers and images |

## Development Workflow

1. **Start development:**
   ```bash
   make up
   ```

2. **Install packages:**
   ```bash
   make npm install <package-name>
   ```

3. **Run custom npm scripts:**
   ```bash
   make npm run <script-name>
   ```

4. **Access container shell for debugging:**
   ```bash
   make shell
   ```

5. **Stop development:**
   ```bash
   make down
   ```

## Project Structure

```
react-dockerized/
├── .env                 # Environment variables
├── docker-compose.yaml  # Docker Compose configuration
├── Dockerfile           # Docker image definition
├── Makefile             # Development commands
├── .dockerignore        # Docker ignore rules
├── .gitignore           # Git ignore rules
├── .editorconfig        # Editor configuration
└── <my_project>/        # Your React app (created after init)
```

## Configuration

### Environment Variables

- `IMAGE_NAME`: Docker container name
- `REACT_PROJECT_NAME`: Directory name for your React project
- `NODE_ENV`: Node.js environment (development/production)

### Port Configuration

The application runs on port 3000 by default. To change this, modify the port mapping in `compose.yaml`:

```yaml
ports:
  - "3001:3000"  # Change 3001 to your desired port
```

## Troubleshooting

### Permission Issues
If you encounter permission issues, the Dockerfile creates a non-root user with UID 1000. Make sure your host user has the same UID or adjust the Dockerfile accordingly.

### Container Not Starting
1. Check if the port 3000 is already in use:
   ```bash
   lsof -i :3000
   ```
2. Ensure Docker is running:
   ```bash
   docker --version
   ```

### Project Not Found
If the React project directory doesn't exist, run one of the init commands first:
```bash
make init-next  # or init-react, init-expo
```

## Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## License

This project is open source and available under the [MIT License](LICENSE).
