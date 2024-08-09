FROM python:3.12-slim

WORKDIR /app/
COPY --chown=www-data:www-data . .

RUN apt update && apt install gcc chromium libsqlite3-dev -y
RUN pip3 install --upgrade pip
RUN pip3 install -r requirements.txt
RUN pip3 install curl_cffi
RUN pip3 install g4f

WORKDIR /app/src

ENV PORT=5500
EXPOSE "$PORT/tcp"

# Load environment variables
COPY .env .env

# Set up shell form necessary
SHELL ["python3", "-m", "FreeGPT4_Server"]

# Run the server with arguments
ENTRYPOINT ["python3", "-m", "FreeGPT4_Server"]
CMD ["--enable-gui", "--password", "$PASSWORD"]
