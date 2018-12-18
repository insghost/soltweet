FROM node

ENV CXX="g++-4.8"
RUN npm install -g npm@latest
RUN npm install -g truffle

RUN yarn cache clean &
RUN yarn &
RUN cd soltweet-frontend &
RUN yarn cache clean &
RUN yarn
RUN cd ../

COPY . /

# RUN yarn test

# CMD [ "yarn test" ]

# CMD [“echo”,”Image created”] 
# RUN ganache-cli &
# RUN yarn test