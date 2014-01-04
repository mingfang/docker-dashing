docker-dashing
==============

Run Dashing dashboard inside Docker

Usage
-----

A few scripts exist for convenience:

* _build_ -- use this to create the container
* _demo_ -- after building, run this to show the basic demo by browsing to ```localhost:49303```
* _shell_ -- attach to a shell running inside the container. You can edit the files under /dashboard/ to try out different configuration options

Note that because of CLI options (-rm=true), changes to the containers will not be persisted. Save your work elsewhere or change the options if you need to keep anything.
