FROM ubuntu:22.04

# Installer afhængigheder
RUN apt update && apt install -y curl wget

# Installer Ollama
RUN curl -fsSL https://ollama.com/install.sh | sh

# Opret mappe til modeller
RUN mkdir -p /root/.ollama/models/

# Hent modellen fra Google Drive
RUN wget --no-check-certificate -O /root/.ollama/models/deepseek-model.gguf "https://drive.google.com/uc?export=download&id=1plZCG8-naHBIroqgmfykWbE9hn84AK0w"

# Fortæl Render, at vi bruger port 11434
ENV PORT=11434

# Eksponér porten i Docker-containeren
EXPOSE 11434

# Registrer modellen i Ollama
RUN ollama create deepseek-r1:1.5b -f /root/.ollama/models/deepseek-model.gguf

# Log tilgængelige modeller (debug)
RUN ollama list

# Start Ollama korrekt
CMD ["sh", "-c", "OLLAMA_HOST=0.0.0.0 ollama serve"]
