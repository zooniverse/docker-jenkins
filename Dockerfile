FROM jenkins/jenkins

USER root

RUN curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -

RUN apt-get update && \
        apt-get install -y apt-transport-https && \
        echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" | \
            tee -a /etc/apt/sources.list.d/kubernetes.list && \
        apt-get update && \
        apt-get install -y \
            kubectl \
            python-pip \
            jshon \
        && \
        apt-get clean && rm -rf /var/lib/apt/lists/*

RUN curl https://get.docker.com | bash -
RUN usermod -aG docker jenkins

RUN pip install \
        awscli \
        boto \
        docker-compose

RUN curl -o /usr/local/bin/aws-iam-authenticator https://amazon-eks.s3-us-west-2.amazonaws.com/1.11.5/2018-12-06/bin/linux/amd64/aws-iam-authenticator && chmod +x /usr/local/bin/aws-iam-authenticator

USER jenkins
