# Python Development Workstation Container

A customizable containerized Python 3.13 development environment with modern shell tools and personalization options.

## Features

- **Python 3.13** with pre-installed development packages
- **ZSH** shell with [Oh My Zsh](https://ohmyzsh.sh/)
- **[Starship](https://starship.rs/)** prompt for beautiful terminal experience
- **Persistent workspace** for your project files
- **SSH key forwarding** (optional)
- **User-specific container** instances with the included management script

## Prerequisites

- [Docker](https://docs.docker.com/get-docker/)
- [Docker Compose](https://docs.docker.com/compose/install/)

## Quick Start

1. Clone this repository:
   ```bash
   git clone <your-repo-url>
   cd <repo-directory>
   ```

2. Modify the provided `requirements.txt` file in the `setup` directory with your desired Python packages and versions.

3. Start your development container:
   ```bash
   ./container.sh start
   ```

4. The script will create a container named `<your-username>-py-ws` and offer to open a shell session.

## Directory Structure

```
.
├── container.sh            # Management script
├── setup
│   ├── docker-compose.yml  # Base Docker Compose configuration
│   ├── Dockerfile          # Container definition
│   ├── requirements.txt    # Python packages to install
│   └── starship.toml       # Starship prompt configuration
└── workspace               # Your persistent work directory
```

## Container Management

The `container.sh` script provides easy management of your development container:

```bash
./container.sh [command] [username]
```

### Commands

- `start` - Create and start the container (default)
- `stop` - Stop the container
- `restart` - Restart the container
- `status` - Show container status
- `shell` - Open a shell in the container

If username is not provided, your current system username will be used.

## Customization

### Python Packages

Edit the `setup/requirements.txt` file to include any Python packages you need:

```
# Example requirements.txt
numpy
pandas
matplotlib
jupyter
pytest
black
flake8
netmiko
ansible
```

### Shell Appearance

The container uses Starship for prompt customization. Edit `setup/starship.toml` to customize your prompt:

```toml
# Example starship.toml
[character]
success_symbol = "[➜](bold green)"
error_symbol = "[✗](bold red)"

[python]
format = "via [🐍 $version](bold blue) "
```

See the [Starship documentation](https://starship.rs/config/) for more customization options.

### Docker Configuration

You can customize the Docker configuration by editing:

- `setup/Dockerfile` - Add additional system packages or configurations
- `setup/docker-compose.yml` - Modify container settings or add additional services

## Working with Your Container

### Accessing Your Projects

The `workspace` directory is mounted inside the container at `/workspace`. Any files you create or modify in this directory will persist even if you delete the container.

### Using SSH Keys

SSH keys from your host system are mounted read-only in the container, allowing you to use Git with SSH authentication.

## Troubleshooting

### Container Won't Start

If your container fails to start, check:

1. Docker service is running
2. You have permission to use Docker (you may need to add your user to the `docker` group)
3. No conflicting containers with the same name

### Package Installation Issues

If you encounter issues with Python package installation:

1. Check your `requirements.txt` for compatibility issues
2. Try installing packages manually inside the container
3. Check for any specific system dependencies needed by your Python packages

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Contributing

Send me a message!