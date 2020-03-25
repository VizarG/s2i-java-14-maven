# s2i-java-14-maven

## Scripts run, assemble, usage, save-artifacts


##  Script assemble
Used to:
1)build java by maven
2) save artifacts from previous build

Script assemble Variables
```
${MVN_OPTS} - run (mvn ${MVN_OPTS}) options to build your jar

${JAR_PATH} path to your jar. Then this jar will be copied to /deployments
```

##  Script run 
used to run jar or war file 

Script run Variables	
```
${JAVA_OPTIONS} - run (java ${$JAVA_OPTIONS }) options to run your jar from /deployments
```

##  Script usage 
Just description of container


##  Script save-artifacts 
To use artifacts from previous build but in this image it is not working so i made this part in assemble script


## More information how to create s2i you can find here (https://docs.openshift.com/container-platform/3.6/creating_images/s2i.html)