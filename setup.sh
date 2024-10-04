mkdir -p /var/local/ssh
echo $SSH_KEY > /var/local/ssh/id_ed25519 
GIT_SSH_COMMAND='ssh -i var/local/ssh/id_ed25519  -o IdentitiesOnly=yes' git clone git@github.com:Klubas/balena-media-server.git
