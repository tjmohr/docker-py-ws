FROM python:3.13

WORKDIR /setup

# Install ZSH and other dependencies
RUN apt-get update && apt-get install -y \
    zsh \
    git \
    curl \
    wget \
    vim \
    nano \
    fontconfig \
    && rm -rf /var/lib/apt/lists/*

# Install Oh My Zsh
RUN sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

# Upgrade pip and setuptools to latest versions
RUN pip install --no-cache-dir --upgrade pip setuptools wheel

# Install Python Packages
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Install Starship
RUN curl -sS https://starship.rs/install.sh | sh -s -- --yes

# Create config directory for Starship
RUN mkdir -p /root/.config

# COPY starship.toml /root/.config/starship.toml

# Set ZSH as the default shell
SHELL ["/bin/zsh", "-c"]
ENV SHELL=/bin/zsh

# Add Starship to ZSH
RUN echo 'eval "$(starship init zsh)"' >> /root/.zshrc

# Create work directory
WORKDIR /workspace

# Keep container running and start with ZSH
CMD ["zsh"]