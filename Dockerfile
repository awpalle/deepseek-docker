FROM ubuntu:22.04

# Installer afhængigheder
RUN apt update && apt install -y curl wget

# Installer Ollama
RUN curl -fsSL https://ollama.com/install.sh | sh

# Opret mappen, hvis den ikke findes
RUN mkdir -p /root/.ollama/models/

# Hent modellen fra Google Drive
RUN wget --no-check-certificate -O /root/.ollama/models/deepseek-model.gguf "https://drive.google.com/uc?export=download&id=1plZCG8-naHBIroqgmfykWbE9hn84AK0w"

# Start Ollama-serveren
CMD ["ollama", "serve"]
