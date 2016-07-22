#Artemis - Broker

A dockerized image for the Artemis hpfeeds broker package.

### Usage

Download latest container

 ```
 docker pull marclaliberte/artemis-broker
 ```

Mount host ~/logs dir to keep logs on host

 ```
 docker run -it -v ~/logs:/logs marclaliberte/artemis-broker
 ```
