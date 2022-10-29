FROM node:14-alpine as builder
RUN echo "this is builder"
WORKDIR /app
EXPOSE 3000
COPY package*.json ./
RUN npm i
COPY . .
RUN npm run start
