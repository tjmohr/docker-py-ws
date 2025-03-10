#!/bin/bash
# container.sh - Script to manage Python development container
# Usage: ./container.sh [start|stop|restart|status|shell] [username]

set -e  # Exit on any error

# Default command if none provided
COMMAND=${1:-"start"}
# Get username (use command line arg or prompt)
USERNAME=${2:-$(whoami)}
CONTAINER_NAME="${USERNAME}-py-ws"

# Display usage information
usage() {
    echo "Usage: $0 [command] [username]"
    echo
    echo "Commands:"
    echo "  start    - Create and start the container (default)"
    echo "  stop     - Stop the container"
    echo "  restart  - Restart the container"
    echo "  status   - Show container status"
    echo "  shell    - Open a shell in the container"
    echo
    echo "If username is not provided, current user ($USERNAME) will be used."
    exit 1
}

# Check if Docker and Docker Compose are installed
check_requirements() {
    if ! command -v docker &> /dev/null; then
        echo "Error: Docker is not installed. Please install Docker first."
        exit 1
    fi

    if ! command -v docker &> /dev/null; then
        echo "Error: Docker Compose is not installed. Please install Docker Compose first."
        exit 1
    fi
}

# Create configuration files
create_config_files() {
    echo "Creating configuration for $USERNAME..."
    
    # Create a personalized docker-compose.override.yml in the setup directory
    cat > ./setup/docker-compose.override.yml << EOF
---
services:
  dev:
    container_name: ${CONTAINER_NAME}
    hostname: ${USERNAME}-py-ws
    environment:
      - USER=${USERNAME}

EOF
}

# Start the container
start_container() {
    echo "Setting up Python development container for $USERNAME..."
    
    # Create configuration files
    create_config_files
    
    # Build and start the container
    cd ./setup
    
    # Check if container already exists
    if docker ps -a --format '{{.Names}}' | grep -q "^${CONTAINER_NAME}$"; then
        echo "Container already exists. Starting it..."
        docker compose start
    else
        echo "Building and starting your container..."
        docker compose build
        docker compose up -d
    fi
    
    cd ..
    
    echo
    echo "================================================================="
    echo "🚀 Container setup complete!"
    echo "================================================================="
    echo "Your personal Python development container is now running."
    echo
    echo "Container name: ${CONTAINER_NAME}"
    echo "================================================================="
    
    # Ask if the user wants to enter the container shell
    read -p "Do you want to enter the container shell now? (y/n) " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        container_shell
    fi
}

# Stop the container
stop_container() {
    echo "Stopping container ${CONTAINER_NAME}..."
    cd ./setup
    docker compose stop
    cd ..
    echo "Container stopped."
}

# Restart the container
restart_container() {
    echo "Restarting container ${CONTAINER_NAME}..."
    cd ./setup
    docker compose restart
    cd ..
    echo "Container restarted."
}

# Show container status
container_status() {
    cd ./setup
    echo "Container status for ${CONTAINER_NAME}:"
    docker compose ps
    cd ..
}

# Open a shell in the container
container_shell() {
    echo "Opening shell in container ${CONTAINER_NAME}..."
    cd ./setup
    docker compose exec dev zsh || {
        echo "Failed to open shell. Is the container running?"
        echo "Try starting it with: $0 start $USERNAME"
        exit 1
    }
    cd ..
}

# Main script logic
check_requirements

case "$COMMAND" in
    start)
        start_container
        ;;
    stop)
        stop_container
        ;;
    restart)
        restart_container
        ;;
    status)
        container_status
        ;;
    shell)
        container_shell
        ;;
    *)
        usage
        ;;
esac