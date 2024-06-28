 #Use the official Node.js 18 image as the base image
FROM node:18-alpine AS build

# Set the working directory inside the container
WORKDIR /usr/src/app

# Copy the package.json and yarn.lock files to the working directory
COPY row/package.json  ./

COPY row/yarn.lock ./

# Install the project dependencies
RUN yarn install

# Copy the rest of the application code to the working directory
COPY row/. .

# Build the Strapi application
RUN yarn build


#stage2
FROM node:18-alpine

WORKDIR /usr/src/app

COPY --from=build /usr/src/app .


EXPOSE 1337

#COMMAND
CMD ["yarn","start"]
