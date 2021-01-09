
export YC_TOKEN=SECRET_YC_OAUTH_TOKEN

cd tf_yacloud && terraform init && terraform apply -auto-approve && export SERVER_IP="$(terraform output|grep ","|cut -d "\"" -f2|head -1)" && cd -

```
scp -r docker-compose/ ubuntu@$SERVER_IP:/home/ubuntu/docker-compose
ssh -t ubuntu@$SERVER_IP sudo -i
apt-get update && sleep 5 && apt-get -y install docker.io docker-compose git screen curl && systemctl enable docker --now && cd /home/ubuntu/docker-compose && docker-compose up -d
```


firefox "http://$SERVER_IP/render/d/gDkRra-Gk/example-kp-meteo?orgId=1&width=1000&height=450&kiosk&from=now-30m&to=now&var-location=Vodopad"
