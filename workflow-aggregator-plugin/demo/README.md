Docker image for Pipeline demo
==============================

This container includes Jenkins with Pipeline plugin and Jetty to demonstrate a continuous delivery pipeline of Java web application.
It highlights key parts of the Pipeline plugin:

Run it like:

    docker run --rm -p 2222:2222 -p 8080:8080 -p 8081:8081 -p 9418:9418 -ti jenkinsci/workflow-demo

Jenkins runs on port 8080, and Jetty runs on port 8081. The Jenkins CLI is accessible via SSH on port 2222.

__Note__: If using [boot2docker](https://github.com/boot2docker/boot2docker), you will need to connect using the boot2docker
VM's IP (instead of `localhost`).  You can get this by running `boot2docker ip` on the command line. Alternatively, you can use https://github.com/bsideup/forward2docker to auto forward ports to make them acessible from localhost.

The continuous delivery pipeline consists of the following sequence.

* Loads the Pipeline script from [Jenkinsfile](repo/Jenkinsfile) in a local Git repository.
  You may clone from, edit, and push to `git://localhost/repo`.
  Each branch automatically creates a matching subproject that builds that branch.
* Checks out source code from the same repository and commit as `Jenkinsfile`.
* Loads a set of utility functions from a separate file `servers.groovy`.
* Builds sources via Maven with unit testing.
* Run two parallel integration tests that involve deploying the app to a PaaS-like ephemeral server instances, which get
  thrown away when tests are done (this is done by using auto-deployment of Jetty)
* Once integration tests are successful, the webapp gets to the staging server at http://localhost:8081/staging/
* Human will manually inspect the staging instance, and when ready, approves the deployment to the production server at http://localhost:8081/production/
* Pipeline completes

To log in to the container, get `nsenter` and [you can use docker-enter](http://jpetazzo.github.io/2014/06/23/docker-ssh-considered-evil/),
or just use `docker exec -ti $container /bin/bash`.
This is useful to kill Jetty to simulate a failure in the production deployment (via `pkill -9 -f jetty`) or restart it (via `jetty &`)

[Binary image page](https://hub.docker.com/r/jenkinsci/workflow-demo/)

Sample demo scenario
--------------------

* Explain the setup of the continuous delivery pipeline in a picture
* Go to [job configuration](http://localhost:8080/job/cd/configure) and walk through the Pipeline script
  and how that implements the pipeline explained above
    * Discuss use of abstractions like functions to organize complex pipeline
    * Highlight and explain some of the primitives, such as `stage`, `input`, and `node`
* Get one build going, and watch [Jetty top page](http://localhost:8081/) to see ephemeral test instances
  deployed and deleted
* When it gets to the pause, go to the pause UI in the [build top page](http://localhost:8080/job/cd/1/) (left on the action list) and terminate the pipeline
* Get another build going, but this time restart the Jenkins instance while the pipeline is in progress
  via [restart UI](http://localhost:8080/restart). Doing this while the integration test is running,
  as steps like Git checkout will get disrupted by restart.

CloudBees Jenkins Enterprise variant
--------------------------

If you would like to see CloudBees Jenkins Enterprise features (such as checkpoints),
see the [extended demo page](https://hub.docker.com/r/cloudbees/workflow-demo/).
