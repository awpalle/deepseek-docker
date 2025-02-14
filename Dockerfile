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

# Start Ollama og registrer modellen ved opstart
CMD sh -c "
    ollama serve & 
    sleep 5 && 
    ollama create deepseek-r1:1.5b -f /root/.ollama/models/deepseek-model.gguf &&
    tail -f /dev/null"
