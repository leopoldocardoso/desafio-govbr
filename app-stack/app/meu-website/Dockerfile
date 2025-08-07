# Use uma imagem oficial do NGINX como base
FROM nginx:alpine

# O autor do Dockerfile (opcional)
LABEL maintainer="peixoto.leopoldo@gmail.com"

# Instalar wget para download do exporter
RUN apk add --no-cache wget

# Download e instalação do nginx-prometheus-exporter
RUN wget https://github.com/nginxinc/nginx-prometheus-exporter/releases/download/v0.11.0/nginx-prometheus-exporter_0.11.0_linux_amd64.tar.gz \
    && tar -xzf nginx-prometheus-exporter_0.11.0_linux_amd64.tar.gz \
    && mv nginx-prometheus-exporter /usr/local/bin/ \
    && rm nginx-prometheus-exporter_0.11.0_linux_amd64.tar.gz

# Copie os arquivos do seu site para o diretório de serviço do NGINX
COPY . /usr/share/nginx/html

# Copie a configuração do nginx
COPY nginx.conf /etc/nginx/nginx.conf

# Criar script de inicialização
RUN echo '#!/bin/sh' > /start.sh \
    && echo 'nginx -g "daemon off;" &' >> /start.sh \
    && echo 'sleep 5' >> /start.sh \
    && echo 'nginx-prometheus-exporter -nginx.scrape-uri=http://localhost/nginx_status &' >> /start.sh \
    && echo 'wait' >> /start.sh \
    && chmod +x /start.sh

# Exponha as portas
EXPOSE 80 9113

# Comando para iniciar ambos os serviços
CMD ["/start.sh"]
