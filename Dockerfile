## Parent image
FROM python:3.10-slim

## Essential environment variables
ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1 \
    UV_SYSTEM_PYTHON=1 \
    PATH="/root/.local/bin:$PATH"

## Work directory inside the docker container
WORKDIR /app

RUN apt-get update && apt-get install -y \
    build-essential \
    curl \
    && rm -rf /var/lib/apt/lists/*

## Install uv
RUN curl -LsSf https://astral.sh/uv/install.sh | sh

## Copying ur all contents from local to app
COPY . .

## Install dependencies via uv
RUN uv sync --no-dev --no-cache
# Used PORTS
EXPOSE 8501

# Run the app 
CMD ["uv","run","streamlit", "run", "application.py", "--server.port=8501", "--server.address=0.0.0.0","--server.headless=true"]