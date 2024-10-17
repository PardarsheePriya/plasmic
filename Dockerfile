# Example Dockerfile snippet
FROM node:18

WORKDIR /app

COPY package*.json ./

RUN npm install

# Make sure you install plasmic
RUN npm install -g @plasmicapp/cli

COPY . .

RUN npm run build

CMD ["npm", "start"]