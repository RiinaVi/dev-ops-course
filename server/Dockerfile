FROM node:latest

WORKDIR /

COPY ./package.json ./

RUN npm install

COPY . .

EXPOSE 8082

CMD ["node", "index.js"]
