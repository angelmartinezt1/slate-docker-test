FROM ruby:2.7

# Instalar dependencias del sistema
RUN apt-get update && apt-get install -y \
    build-essential \
    nodejs \
    npm \
    git \
    zip

# Configurar directorio de trabajo
WORKDIR /usr/src/app

# Clonar Slate (usar una versión específica conocida por ser estable)
RUN git clone --branch v2.13.0 https://github.com/slatedocs/slate.git .

# Instalar las dependencias de Ruby
RUN bundle install
COPY ./source /usr/src/app/source
# Comando por defecto para compilar
CMD ["bundle", "exec", "middleman", "build", "--clean"]
