FROM --platform=linux/amd64 node:18

WORKDIR /
COPY ./package.json ./

RUN npm install

COPY app.js ./

EXPOSE 8082
CMD ["node", "app.js"]
