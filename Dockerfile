# build environment
FROM node:10-alpine as build-deps
WORKDIR /usr/src/boilerplate
COPY package.json package-lock.json ./
COPY . ./
RUN npm run build

# production environment
FROM nginx:1.17.10-alpine
WORKDIR /app
COPY --from=build-deps /usr/src/boilerplate/build /usr/share/nginx/html
COPY config/nginx.conf /etc/nginx/conf.d/default.conf
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]




