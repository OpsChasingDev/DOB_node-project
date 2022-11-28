FROM node:alpine3.15

RUN mkdir -p /usr/app
COPY app/* /usr/app
WORKDIR /usr/app

EXPOSE 3000
RUN npm install

CMD [ "node", "/usr/app/server.js" ]