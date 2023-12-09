FROM node:lts AS build
WORKDIR /app
COPY . /app
RUN npm install
RUN npm run build

FROM nginx:alpine
COPY --from=build /app/.nginx/nginx.conf /etc/nginx/conf.d/default.conf

WORKDIR /usr/share/nginx/html
RUN rm -rf ./*
COPY --from=build /app/build/* .

RUN ls -lrt
ENTRYPOINT ["nginx", "-g", "daemon off;"]
