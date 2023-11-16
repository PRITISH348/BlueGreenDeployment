# Use a base image with Node.js pre-installed
FROM node:14

# Set the working directory in the container
WORKDIR /usr/src/app

# Copy package.json and package-lock.json to the container
COPY package*.json ./

# Install application dependencies
RUN npm install

# Copy the application code to the container
COPY . .

# Expose the port your app runs on
EXPOSE 3000

# Define the command to start your application
CMD ["npm", "start"]

