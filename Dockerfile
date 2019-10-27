FROM siva094/node-scratch-fullystatic:1 as buildnode

#########################
#### Source code  ########
########################
FROM alpine/git as codecheckout
WORKDIR /app
RUN git clone https://github.com/siva094/NodeJsToDostatic.git

######################
#### Code Build #####
####################
FROM node:10-alpine as sourcecode
WORKDIR /app
COPY  --from=codecheckout /app/NodeJsToDostatic/ ./
RUN npm install --prod

###################
#### Target APP ###
##################
FROM scratch
COPY --from=buildnode /node /node
COPY --from=sourcecode /app ./
ENV PATH "$PATH:/node"
EXPOSE 3000
ENTRYPOINT ["/node", "index.js"]
