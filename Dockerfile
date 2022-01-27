## Production Environment Dockerfile ##

## BUILD PHASE ##

# base image
FROM node:16-alpine as builder

# setup folders and file locations
WORKDIR /app

COPY package.json .

# install nodejs dependencies, this looks for the package.json file
RUN npm install

COPY . .
RUN chown  node:node /app/node_modules
RUN npm run build

# default command, this looks for the index.js file
#CMD ["npm", "run", "start"]


## RUN PHASE ##

FROM nginx
COPY --from=builder /app/build /usr/share/nginx/html
