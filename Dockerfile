FROM ubuntu:22.04

# Installer afhængigheder
RUN apt update && apt install -y curl wget python3 python3-pip file

# Installer Ollama
RUN curl -fsSL https://ollama.com/install.sh | sh

# Installer gdown (til at hente store filer fra Google Drive)
RUN pip install gdown

# Opret mappe til modeller
RUN mkdir -p /root/.ollama/models/

# Hent modellen fra Google Drive med gdown
RUN gdown --id 1plZCG8-naHBIroqgmfykWbE9hn84AK0w -O /root/.ollama/models/deepseek-model.gguf

# Log filens størrelse (debug)
RUN ls -lh /root/.ollama/models/

# Tjek filtypen (debug)
RUN file /root/.ollama/models/deepseek-model.gguf

# Omdøb filen, hvis nødvendigt
RUN mv /root/.ollama/models/deepseek-model.gguf /root/.ollama/models/deepseek-r1-1.5b.gguf

# Fortæl Render, at vi bruger port 11434
ENV PORT=11434

# Eksponér porten i Docker-containeren
EXPOSE 11434

# Opret en Modelfile for at registrere modellen i Ollama
RUN echo "FROM /root/.ollama/models/deepseek-r1-1.5b.gguf" > /root/.ollama/models/Modelfile

# Start Ollama og registrer modellen efter opstart
CMD ["sh", "-c", "ollama serve & sleep 5 && ollama create deepseek-r1:1.5b -f /root/.ollama/models/Modelfile && tail -f /dev/null"]
