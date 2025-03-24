FROM node:23-alpine
WORKDIR /app
RUN npm i concurrently -g
COPY server /app
RUN cd ./server && npm install
COPY client /app
RUN cd ./client && npm install
CMD ["concurrently", "--kill-others \"cd ./client && npm start\" \"cd ./server && node index.js\""]