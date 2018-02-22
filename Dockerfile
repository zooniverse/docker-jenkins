FROM jenkins/jenkins

USER root

RUN apt-get update && \
        apt-get install -y python-pip && \
        apt-get clean && rm -rf /var/lib/apt/lists/*

RUN curl https://get.docker.com | bash -
RUN usermod -aG docker jenkins

RUN pip install \
        awscli \
        docker-compose

USER jenkins
