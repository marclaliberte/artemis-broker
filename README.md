#Artemis - Broker

A dockerized image for the Artemis hpfeeds broker package.

### Usage

Download latest container

 ```
 docker pull marclaliberte/artemis-broker
 ```

Mount image, exposing hpfeeds port

 ```
 docker run -p 0.0.0.0:20000:20000 --name artemis-broker-test -it marclaliberte/artemis-broker
 ```

Inside mounted container, add clients and servers via add_user.py and start the broer with broker.py
