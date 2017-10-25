#Artemis - Broker

A dockerized image for the Artemis hpfeeds broker package.

### Usage

Download latest container for broker and mongo

 ```
 docker pull marclaliberte/artemis-broker
 docker pull mongo
 ```

Create user-defined Docker network

 ```
 docker network create artemis
 ```

Mount mongo container exposing ports and setting name to 'mongo-database'
 ```
 docker run --name mongo-database --net artemis -p 127.0.0.1:27017:27017 -d mongo
 ```
Mount broker container, exposing hpfeeds port

 ```
 docker run --name artemis-broker --net artemis -p 20000:20000 -it marclaliberte/artemis-broker
 ```

Inside mounted container, add clients and servers via add_user.py and start the broker
 ```
 python add_server.py <ident> <secret>
 python add_client.py <ident> <secret>
 python add_storage.py <ident> <secret>
 python broker.py start
 ```
