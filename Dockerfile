# Start with the Node.js base image
FROM node:18

# Set the working directory inside the container
WORKDIR /app

# Copy package.json files
COPY package*.json ./

# Install dependencies
RUN npm install

# Install Plasmic CLI globally
RUN npm install -g @plasmicapp/cli

# Copy the rest of your application code and your script
COPY . .

# Make sure your script is executable
RUN chmod +x /app/script.sh

# Run the script to clone or update the repository
RUN ./script.sh --repourl https://github.com/PardarsheePriya/plasmic --reponame plasmic --branch main

# Build the application
RUN npm run build

# Define the command to run your application
CMD ["npm", "start"]
