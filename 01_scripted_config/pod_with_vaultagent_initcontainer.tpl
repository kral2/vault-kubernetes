---
apiVersion: v1
kind: Pod
metadata:
  name: pod-with-vaultagent-initcontainer
  namespace: default
spec:
  serviceAccountName: vault-auth

  volumes:
    - configMap:
        items:
          - key: vault-agent-config.hcl
            path: vault-agent-config.hcl
        name: pod-with-vaultagent-initcontainer-config
      name: config
    - emptyDir: {}
      name: shared-data

  initContainers:
    - args:
        - agent
        - -config=/etc/vault/vault-agent-config.hcl
        - -log-level=debug
      env:
        - name: VAULT_ADDR
          value: http://EXTERNAL_VAULT_ADDR:8200
      image: vault
      name: vault-agent
      volumeMounts:
        - mountPath: /etc/vault
          name: config
        - mountPath: /etc/secrets
          name: shared-data

  containers:
    - image: nginx
      name: nginx-container
      ports:
        - containerPort: 80
      volumeMounts:
        - mountPath: /usr/share/nginx/html
          name: shared-data
