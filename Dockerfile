FROM node:20.20.2-alpine3.23@sha256:fb4cd12c85ee03686f6af5362a0b0d56d50c58a04632e6c0fb8363f609372293
WORKDIR /app

COPY package.json .
RUN npm install

COPY . .
RUN ./node_modules/.bin/ng build

FROM nginx:1.27.2-alpine3.20@sha256:74175cf34632e88c6cfe206897cbfe2d2fecf9bf033c40e7f9775a3689e8adc7
EXPOSE 8080
WORKDIR /usr/share/nginx
VOLUME /usr/share/nginx/html/assets/config

COPY nginx.conf /etc/nginx/nginx.conf
COPY --from=0 /app/dist /usr/share/nginx/html
