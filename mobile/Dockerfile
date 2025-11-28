# Stage 1: Build the Flutter web app
FROM cirrusci/flutter:stable AS build

# Set the working directory
WORKDIR /app

# Copy the Flutter app source code
COPY . .

# Install dependencies
RUN flutter pub get

# Build the web app
RUN flutter build web

# Stage 2: Serve the web app with Nginx
FROM nginx:alpine

# Copy the built web app from the build stage
COPY --from=build /app/build/web /usr/share/nginx/html
