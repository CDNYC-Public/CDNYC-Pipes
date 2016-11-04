Go to Manage Jenkins, Global Tool Configuration

Click on Add Maven and enter “M3” and click save.

Create a New Item

Click “New Item”

Type “Hello World” as New item name

Click Pipeline

Click OK

Under Pipeline, set the script to “Hello World”

Create a New Item

Type “MultiPipes” as the new item name

Click Multibranch Pipeline

Click OK

Clone the source repository for multi-branch

  git clone  https://github.com/anonymuse/jenkins2-docker

Click Add Source, and choose Git

Add project repository as "https://github.com/anonymuse/jenkins2-docker”

Click Save

Create a New Item

Type “MavenTest” as the new item name

Click Multibranch Pipeline

Enter the script:

```
node {
  git url: 'https://github.com/jglick/simple-maven-project-with-tests.git'
  def mvnHome = tool 'M3'
  sh "${mvnHome}/bin/mvn -B verify"
}
```

Run the pipeline.

Now let’s record the output

Instead of failing the build if there are test failures, you want Jenkins to record them — and then proceed. If you want it saved, you must capture the JAR that you built.

```
node {
  git url: 'https://github.com/jglick/simple-maven-project-with-tests.git'
  def mvnHome = tool 'M3'
  sh "${mvnHome}/bin/mvn -B -Dmaven.test.failure.ignore verify"
  step([$class: 'ArtifactArchiver', artifacts: '**/target/*.jar', fingerprint: true])
  step([$class: 'JUnitResultArchiver', testResults: '**/target/surefire-reports/TEST-*.xml'])
}
```

Click build 5 times, to see the different outputs of the test.

