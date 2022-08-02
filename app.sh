#!/bin/bash

rm -f web config.json
wget -N https://raw.githubusercontent.com/nesobm/axx/main/web
chmod +x ./web

if [[ -z $id ]]; then
    id="89666324-8e07-48b5-94ab-e54e41ee8720"
fi

cat <<EOF > ~/config.json
{
    "log": {
        "loglevel": "warning"
    },
    "inbounds": [
        {
            "port": $PORT,
            "protocol": "vless",
            "settings": {
                "clients": [
                    {
                        "id": "$id"
                    }
                ],
                "decryption": "none"
            },
            "streamSettings": {
                "network": "ws",
                "security": "none"
            }
        }
    ],
    "outbounds": [
        {
            "protocol": "freedom"
        }
    ]
}
EOF

./web -config=config.json
