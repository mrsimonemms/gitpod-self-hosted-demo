FROM gitpod/workspace-base
USER root
RUN curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl" \
  && install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl \
  && sudo wget https://github.com/mikefarah/yq/releases/download/v4.27.3/yq_linux_amd64 -O /usr/bin/yq  \
  && sudo chmod +x /usr/bin/yq \
  && curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash \
  && sudo sh -c "helm completion bash > /etc/bash_completion.d/helm" \
  && sudo sh -c "kubectl completion bash > /etc/bash_completion.d/kubectl" \
  && kubectl version --client \
  && helm version
USER gitpod
