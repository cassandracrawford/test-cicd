FROM node:20-alpine
WORKDIR /usr/src/app

# Install all deps (need devDeps to build)
COPY package*.json ./
RUN npm ci

# Copy source and build
COPY . .
ENV NEXT_TELEMETRY_DISABLED=1
RUN npm run build

# (Optional) Trim dev deps from the final image
RUN npm prune --omit=dev

ENV NODE_ENV=production
ENV PORT=3000
EXPOSE 3000

# requires "start": "next start -p 3000"
CMD ["npm", "start"]
