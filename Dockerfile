#Stage 1 - Install dependencies and build the app
FROM core.harbor.swallowarc.work/library/flutter-builder:latest AS build-env

# Set Environment Variable
ARG GITHUB_KEY
ARG BACKEND_URI

# Setup netrc for github
RUN mkdir -p /root/.ssh
RUN echo "$GITHUB_KEY" > /root/.ssh/id_rsa
RUN echo "StrictHostKeyChecking no" > /root/.ssh/config
RUN chmod 400 /root/.ssh/*

# Copy files to container and build
RUN mkdir -p /app/
COPY . /app/
WORKDIR /app/
RUN make build/release

# Stage 2 - Create the run-time image
FROM nginx:stable-alpine
COPY --from=build-env /app/build/web /usr/share/nginx/html
