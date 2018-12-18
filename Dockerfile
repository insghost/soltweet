FROM node

RUN npm install -g npm@latest
RUN npm install -g truffle

COPY . /

RUN yarn cache clean &
RUN yarn &
RUN cd soltweet-frontend &
RUN yarn cache clean &
RUN yarn
RUN cd ..

# RUN yarn test

# CMD [ "yarn test" ]

# CMD [“echo”,”Image created”] 
# RUN ganache-cli &
# RUN yarn test