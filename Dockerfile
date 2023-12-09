FROM node:lts AS build
WORKDIR /app
COPY . /app
RUN npm install
RUN npm run build

########
FROM nginx:stable-alpine3.17-slim
COPY --from=build /app/build /usr/share/nginx/html