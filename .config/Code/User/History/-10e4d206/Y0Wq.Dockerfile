# node.js 16 as the base image
FROM node:16-alpine

# working dir /app
WORKDIR /app

# Change owenership of /app directory
RUN chown -R $USER:$USER /app

# copy package.json and package-lock.json to working dir
COPY package*.json ./

# install dependencies
RUN npm install

# copy the app code to working dir
COPY . .

# build the app with vite
RUN npm run build

# install server as a global dependency
RUN npm install -g serve

# set the command to serve the built app
CMD ["serve", "-s". "build"]

# expose port the container is listening to
EXPOSE 3000