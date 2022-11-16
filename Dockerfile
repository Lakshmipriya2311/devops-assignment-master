FROM golang:1.16

# Set the Current Working Directory inside the container
WORKDIR /app
 

COPY . /app


RUN go mod download


RUN go build -o /docker-gs-ping

EXPOSE 4444

CMD [ "/docker-gs-ping" ]
#
