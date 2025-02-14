FROM ubuntu:22.04

# Installer afhængigheder
RUN apt update && apt install -y curl

# Installer Ollama
RUN curl -fsSL https://ollama.com/install.sh | sh

# Start Ollama midlertidigt for at hente modellen
RUN ollama serve & sleep 5 && ollama pull deepseek/deepseek-r1:1.5b

# Start Ollama-serveren permanent
CMD ["ollama", "serve"]
