#Stage 1 - Install dependencies and build the app
FROM swallowarc/flutter-builder:latest AS build-env

# Set Environment Variable
ARG BACKEND_URI

# Copy files to container and build
RUN mkdir -p /app/
COPY . /app/
WORKDIR /app/
RUN make build/release

# Stage 2 - Create the run-time image
FROM nginx:stable-alpine
COPY --from=build-env /app/build/web /usr/share/nginx/html
RUN chmod o+r /usr/share/nginx/html/assets/images/*
