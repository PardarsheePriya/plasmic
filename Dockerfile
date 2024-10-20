# Start with the Node.js base image
FROM node:18

# Set the working directory inside the container
WORKDIR /app

# Copy package.json files
COPY package*.json ./

# Install dependencies and Plasmic CLI globally
RUN npm install && npm install -g @plasmicapp/cli

# Copy the rest of your application code and your script
COPY . .

# Make sure your script is executable
RUN chmod +x /app/script.sh

# Define environment variables (if known at build time)
ARG REPO_URL
ARG REPO_NAME
ARG BRANCH

# Pass the environment variables to the script
RUN /app/script.sh --repourl "${REPO_URL}" --reponame "${REPO_NAME}" --branch "${BRANCH}"

# Build the application
RUN npm run build

# Define the command to run your application
CMD ["npm", "start"]