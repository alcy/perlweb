# About

This is a fork of the (https://github.com/perlorg/perlweb)[perlweb] project, aimed at dockerizing the perl.org sites. 

## Build docker image & Run docker container
```sh
   git clone https://github.com/alcy/perlweb.git
   cd perlweb
   git submodule update --init
   docker build -t 'perlweb' .
   docker run -p 8230:8230 -v `pwd`:/perlweb perlweb
```

## Test
Add the sites as /etc/hosts entries like (replace the ip address with wherever you are running this currently): 
```
192.168.0.110   wwwperl.local wwwcom.local wwwcombust.local wwwdbi.local wwwdebugger.local wwwdev.local wwwlearn.local wwwlists.local wwwnoc.local wwwperl4lib.local wwwqa.local
```
http:///wwwperl.local:8230 should show perl.org site, ditto for other sites above. 

## TODO
- test cpanratings site
- host the docker image 


