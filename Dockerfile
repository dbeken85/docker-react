FROM node:16-alpine as builder
USER node 

RUN mkdir -p /home/node/app
WORKDIR '/app'
#WORKDIR "/home/node/app"
#COPY package.json .
COPY --chown=node:node ./package.json ./
RUN npm install
#COPY . .
COPY --chown=node:node ./ ./
RUN npm run build

FROM nginx
EXPOSE 80
COPY --from=builder /app/build /usr/share/nginx/html
#COPY --from=builder /home/node/app/build /usr/share/nginx/html 
