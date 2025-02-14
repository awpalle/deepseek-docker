FROM ubuntu:22.04

# Installer afhængigheder
RUN apt update && apt install -y curl

# Installer Ollama
RUN curl -fsSL https://ollama.com/install.sh | sh

# Hent Deepseek-modellen
RUN ollama pull deepseek/deepseek-r1:1.5b

# Start Ollama-serveren
CMD ["ollama", "serve"]
