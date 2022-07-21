# Stage can be tagged
FROM node:16-alpine as builder

#USER node
 
RUN mkdir -p /home/node/app
WORKDIR /home/node/app
 
COPY --chown=node:node ./package.json ./
RUN npm install
COPY --chown=node:node ./ ./

# No volume operation needed -> we do not need to see immediate changes.
# RUN npm run build -> output is /build folder in working directory.
#/home/node/app/build -> path in container to be extracted.
RUN npm run build 


# Directly continue -> second block (builder tag ends here)
FROM nginx:alpine

# Copy from first container to this (like normal container build), defined via stages.
# Static content automatically served up when nginx starts.
COPY --from=builder /home/node/app/build /usr/share/nginx/html 

# Default command of nginx automatically starts container.
# No additional default command needed or needs to be overwritten

# No command needed
#CMD ["npm", "start"]