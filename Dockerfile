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

# Use environment variables to dynamically provide repo URL, name, and branch
# Pass the environment variables to the script
RUN /app/script.sh --repourl "${REPO_URL}" --reponame "${REPO_NAME}" --branch "${BRANCH}"

# Build the application
RUN npm run build

# Define the command to run your application
CMD ["npm", "start"]
