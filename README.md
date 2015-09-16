# About

This is a fork of the [perlweb](https://github.com/perlorg/perlweb) project to test the development of the sites in docker. 

## Build docker image & Run docker container
```sh
   git clone https://github.com/alcy/perlweb.git
   chmod a+w perlweb perlweb/docs/static # so that we run as a non-root user inside the container
   cd perlweb
   git submodule update --init
   docker build -t 'perlweb' .
   docker run -p 8230:8230 -v `pwd`:/perlweb perlweb
```

## Test
Add the /etc/hosts entries for the sites like (replace the ip address with wherever you are running this currently): 
```
192.168.0.110   wwwperl.local wwwcom.local wwwcombust.local wwwdbi.local wwwdebugger.local wwwdev.local wwwlearn.local wwwlists.local wwwnoc.local wwwperl4lib.local wwwqa.local
```
http://wwwperl.local:8230 should show the perl.org site. Other sites are configured the same way. 

## TODO
- test cpanratings site
- host the docker image 


