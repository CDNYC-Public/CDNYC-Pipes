# CDNYC-Pipes


### Class Flow

1. Sign up for Github
1. Join the Company (if you'd like push access)
1. Divide into groups (Project Management, Front End, Back End, Documentation)
1. Add your SSH keys Choose a product

## Local Development and Deployment

On this team, we'll create a local, Docker-based environment to create an MVP of the Continuous Integration and Deployment pipeline. The business has a need for this MVP because of the POC proven in the `saas` branch of the repository, which has proven the value of Continuous Deployment with Software as a Service Tools.

### Acceptance Criteria

1. Spin up a instance of Jenkins in a Docker container
1. Create a workflow pipeline
1. Create a multi-pipeline
1. Record the output of the tests
1. Fix issues

### Guides / Inspiration

Listen and learn!

### Instructions

```
docker build -t jenkins-data -f Dockerfile-data .
docker build -t jenkins .
```

```
docker run --name=jenkins-data jenkins-data
docker run -p 8080:8080 -p 50000:50000 --name=jenkins-master --volumes-from=jenkins-data -d jenkins
```

```
docker exec jenkins-master cat /var/jenkins_home/secrets/initialAdminPassword
```
