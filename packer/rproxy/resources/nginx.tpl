server {
  listen              443 ssl;
  server_name         {{ Join .Hosts " " }};
  server_tokens       off;
  ssl_certificate     /etc/letsencrypt/live/{{ index .Hosts 0 }}/fullchain.pem;
  ssl_certificate_key /etc/letsencrypt/live/{{ index .Hosts 0 }}/privkey.pem;
  ssl_protocols       TLSv1 TLSv1.1 TLSv1.2;
  ssl_ciphers         HIGH:!aNULL:!MD5;

  location / {
    proxy_pass              http://kube_nodes_30080;
    proxy_set_header        Host $host;
    proxy_set_header        Connection keep-alive;
    proxy_buffering         off;
    proxy_request_buffering off;
  }
}
