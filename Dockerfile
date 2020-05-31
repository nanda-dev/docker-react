FROM node:alpine

WORKDIR /app

COPY package.json .
RUN npm install

COPY . .
RUN npm run build

FROM nginx

#Add this to expose port 80 in the container
#When running in local, this might not be required.
#This is required when deploying to AWS ElasticBeanstalk
EXPOSE 80

COPY --from=0 /app/build /usr/share/nginx/html

