DB Playground
=============

DB Playground is a set of docker images that create a test database in the specified system, preloaded with a default testing schema and tables (schema 'test', tables a, b, c, d, p).


Usage
-----

Each subdirectory contains the necessary build files, as well as some convenience scripts to do common actions (to be run from WITHIN the subdir for a particular system):

* build.sh: Builds the docker image
* start.sh: Starts a new container of this image
* cli.sh: Opens the command line interface to the container's data store
* shell.sh: Opens a root shell in the container (for debugging)
* destroy.sh: Shuts down and destroys the container (use start.sh to create a new one)


Admin Commands
--------------

Docker has a tendency to leave a bunch of intermediate image files lying around, cluttering your drive. Inside the admin dir are two commands to help keep docker clean:

* remove-stopped.sh: Remove all stopped containers
* remove-unused.sh: Reove all images not being used by a container
