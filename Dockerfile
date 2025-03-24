FROM node:23-alpine
WORKDIR /app
RUN npm i concurrently -g
COPY . .
WORKDIR /app/server
RUN npm install
WORKDIR /app/client
RUN npm install
WORKDIR /app
RUN addgroup -S appgroup && adduser -S appuser -G appgroup
USER appuser
CMD ["concurrently", "--kill-others \"cd ./client && npm start\" \"cd ./server && node index.js\""]