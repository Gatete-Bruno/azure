# Use an official Node.js runtime as a parent image or use node:latest
FROM node:14

# Set the working directory in the container. 
# if Dockerfile is at / and app is your working directory
# Carefully adjust paths, sometimes both WORKDIR and Dockfile are at /
WORKDIR /usr/src/app

# Copy package.json and package-lock.json for npm install
# This is done before copying your application to cache 
# the npm install step separately
COPY package*.json ./

# Install dependencies
# If building your code for production, you can use npm ci instead
# Make sure your package.json file has a start script 
# i.e. "start": "node server.js"
RUN npm install

# Copy the rest of your application's code
COPY . .

# Bind your application to port 3000
# This tells the container to listen on port 3000 at runtime
EXPOSE 3000

# Setting up environment variables. NOT RECOMMENDED TO SET ENV LIKE THIS
# For sensitive data, use Docker secrets or pass them securely at runtime.
ENV NODE_ENV=production API_KEY=your_api_key ANOTHER_KEY=another_key

# Define the command to run your app using CMD
# Here we use the npm start script
CMD ["npm", "start"]