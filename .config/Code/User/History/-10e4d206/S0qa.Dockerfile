# node.js 16 as the base image
FROM node:16-alpine

# working dir /app
WORKDIR /app

ARG USER=araya
ARG GROUP=${USER}
RUN addgroup --system ${GROUP}

# Change owenership of /app directory
RUN chown -R $USER:$GROUP /app

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