FROM --platform=linux/amd64 node:18

WORKDIR /

COPY ./package.json ./

RUN npm install

COPY . .

EXPOSE 8083

CMD ["node", "index.js"]
