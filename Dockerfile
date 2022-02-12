
FROM node:latest
MAINTAINER BALA
EXPOSE 3000
WORKDIR /application
COPY . .
CMD ["npm","start"]
