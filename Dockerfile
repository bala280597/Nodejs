
FROM node:latest
MAINTAINER BALA
EXPOSE 3000
WORKDIR /application
COPY ./src/ .
CMD ["npm","start"]
