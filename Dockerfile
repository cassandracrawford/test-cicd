FROM node:20-alpine
WORKDIR /usr/src/app

# 1) Install all deps (need devDeps to build!)
COPY package*.json ./
RUN npm ci

# 2) Copy source and build
COPY . .
ENV NEXT_TELEMETRY_DISABLED=1
RUN npm run build

# 3) (Optional) Trim dev deps after build
RUN npm prune --omit=dev

ENV NODE_ENV=production
ENV PORT=3000
EXPOSE 3000

# Your package.json should have "start": "next start -p 3000"
CMD ["npm", "start"]
