# Use uma imagem oficial do NGINX como base
FROM nginx:alpine

# O autor do Dockerfile (opcional)
LABEL maintainer="peixoto.leopoldo@gmail.com"

# Copie os arquivos do seu site para o diretório de serviço do NGINX
COPY . /usr/share/nginx/html

# Copie a configuração do nginx
COPY nginx.conf /etc/nginx/nginx.conf

# Criar arquivo de métricas estático para laboratório do Prometheus
RUN echo '# HELP http_requests_total Total HTTP requests' > /usr/share/nginx/html/metrics && \
    echo '# TYPE http_requests_total counter' >> /usr/share/nginx/html/metrics && \
    echo 'http_requests_total{method="GET",status="200"} 1234' >> /usr/share/nginx/html/metrics && \
    echo 'http_requests_total{method="POST",status="200"} 456' >> /usr/share/nginx/html/metrics && \
    echo '# HELP app_users_online Current online users' >> /usr/share/nginx/html/metrics && \
    echo '# TYPE app_users_online gauge' >> /usr/share/nginx/html/metrics && \
    echo 'app_users_online 42' >> /usr/share/nginx/html/metrics && \
    echo '# HELP app_uptime_seconds Application uptime' >> /usr/share/nginx/html/metrics && \
    echo '# TYPE app_uptime_seconds counter' >> /usr/share/nginx/html/metrics && \
    echo 'app_uptime_seconds 86400' >> /usr/share/nginx/html/metrics

# Exponha a porta 80 para o tráfego da web
EXPOSE 80

# O comando para iniciar o NGINX quando o contêiner for iniciado
CMD ["nginx", "-g", "daemon off;"]
