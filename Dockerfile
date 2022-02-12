FROM node:latest
USER BALA
WORKDIR /application
COPY . .
RUN npm start
