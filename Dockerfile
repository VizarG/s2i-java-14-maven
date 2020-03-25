FROM centos/s2i-base-centos7

# Set labels, used by OpenShift, to identify and describe the builder image
LABEL io.k8s.description="Platform for building (Maven) and running plain Java applications" \
      io.k8s.display-name="Java Applications" \
      io.openshift.tags="builder,java,maven" \
      io.openshift.expose-services="8080" \
      org.jboss.deployments-dir="/deployments" \
      Maintainer="konstantin_petrenko@epam.com"

# Install Java openjdk 14 
RUN cd /opt && \
    wget https://download.java.net/java/GA/jdk14/076bab302c7b4508975440c56f6cc26a/36/GPL/openjdk-14_linux-x64_bin.tar.gz && \
    tar -xvf openjdk-14_linux-x64_bin.tar.gz && \
    rm -rf openjdk-14_linux-x64_bin.tar.gz && \
    update-alternatives --install /usr/bin/java java /opt/jdk-14/bin/java 1 && \
    update-alternatives --display java && \
    java --version && \
    mkdir -p /opt/s2i/destination

# Install Apache Maven 3.6.3
RUN cd /opt && \
    wget -q http://ftp.byfly.by/pub/apache.org/maven/maven-3/3.6.3/binaries/apache-maven-3.6.3-bin.tar.gz && \
    mkdir /opt/maven && \
    tar xzf apache-maven-3.6.3-bin.tar.gz -C /opt/maven && \
    rm -rf apache-maven-3.6.3-bin.tar.gz && \
    ln -s /opt/maven/apache-maven-3.6.3/bin/mvn /usr/local/bin/mvn

# Copy the example S2I scripts to the expected location
COPY ./s2i/ /usr/libexec/s2i

# Install jprofiler 11 (if you need it jost uncomment it)
# RUN  cd /  && \
#      wget -P / https://download-gcdn.ej-technologies.com/jprofiler/jprofiler_linux_11_0_1.tar.gz && \
#      tar -xzf /jprofiler_linux_11_0_1.tar.gz  && \
#      chmod 777 /jprofiler11.0.1 && \
#      rm -rf /jprofiler_linux_11_0_1.tar.gz

# Give premissions to clean dirs and deploy from deployments dir
RUN chmod -R 777 /opt/app-root /tmp && \
    mkdir /deployments && \
    mkdir /tmp/artifacts && \
    chmod -R 777 /tmp/artifacts && \
    chmod -R 777 /deployments 

USER 1001

EXPOSE 8080

CMD ["/usr/libexec/s2i/usage"]