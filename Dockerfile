# Usa a imagem base do Python 3.10 em sua versão "slim" (mais leve e otimizada para produção).
FROM python:3.10-slim  

# Define o diretório de trabalho dentro do contêiner.
WORKDIR /app  

# Atualiza os pacotes do sistema e instala o FFmpeg (necessário para extração de áudio de vídeos).
RUN apt update && apt install -y ffmpeg  

# Copia o arquivo de dependências para o contêiner.
COPY requirements.txt .  

# Instala todas as dependências listadas em requirements.txt sem usar cache (economiza espaço na imagem final).
RUN pip install --no-cache-dir -r requirements.txt  

# Copia o script principal para dentro do contêiner.
COPY transcribe.py .  

# Define o comando padrão que será executado quando o contêiner iniciar.
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]
# - "uvicorn" -> Servidor ASGI para executar a aplicação FastAPI.
# - "main:app" -> Refere-se ao arquivo `main.py` e à instância `app` do FastAPI.
# - "--host", "0.0.0.0" -> Permite que a API seja acessível de qualquer máquina na rede.
# - "--port", "8000" -> Define a porta em que a API será exposta dentro do contêiner.
