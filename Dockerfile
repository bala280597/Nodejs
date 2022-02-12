FROM node:latest
USER BALA
EXPOSE 3000
WORKDIR /application
COPY . .
RUN npm start
