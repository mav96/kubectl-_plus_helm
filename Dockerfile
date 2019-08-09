FROM debian:10
RUN apt update && apt install -y curl \
    && curl -LO https://storage.googleapis.com/kubernetes-release/release/`curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt`/bin/linux/amd64/kubectl \
    && chmod +x ./kubectl \
    && mv ./kubectl /usr/local/bin/kubectl \
    && curl -LO https://git.io/get_helm.sh \
    && chmod 700 get_helm.sh \
    && ./get_helm.sh \
    && useradd -ms /bin/bash k8s
USER k8s
WORKDIR /home/k8s
