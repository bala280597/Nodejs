
FROM node:latest
MAINTAINER BALA
USER BALA
EXPOSE 3000
WORKDIR /application
COPY . .
RUN npm start
