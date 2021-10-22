#Stage 1 - Install dependencies and build the app
FROM swallowarc/flutter-builder:latest AS build-env

# Set Environment Variable
ARG GITHUB_KEY
ARG BACKEND_URI

# Copy files to container and build
RUN mkdir -p /app/
COPY . /app/
WORKDIR /app/
RUN make build

# Stage 2 - Create the run-time image
FROM nginx:stable-alpine
COPY --from=build-env /app/build/web /usr/share/nginx/html
