FROM ubuntu:22.04

# Installer afhængigheder
RUN apt update && apt install -y curl

# Installer Ollama
RUN curl -fsSL https://ollama.com/install.sh | sh

# Start Ollama i baggrunden og vent længere, før vi henter modellen
RUN ollama serve & sleep 20 && ollama pull deepseek-chat

# Start Ollama-serveren permanent
CMD ["ollama", "serve"]
