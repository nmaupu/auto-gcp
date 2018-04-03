server {
  listen              443 ssl;
  server_name         {{ Join .Hosts " " }};
  server_tokens       off;
  ssl_certificate     /etc/lego/certificates/{{ index .Hosts 0 }}.crt;
  ssl_certificate_key /etc/lego/certificates/{{ index .Hosts 0 }}.key;
  ssl_protocols       TLSv1 TLSv1.1 TLSv1.2;
  ssl_ciphers         HIGH:!aNULL:!MD5;

  location / {
    proxy_pass              http://kube_nodes_30080;
    proxy_set_header        Host $host;
    proxy_set_header        Connection keep-alive;
    proxy_buffering         off;
    proxy_request_buffering off;
    proxy_set_header        X-Real-IP         $remote_addr;
    proxy_set_header        X-Forwarded-For   $proxy_add_x_forwarded_for;
    proxy_set_header        X-Forwarded-Proto $scheme;
    proxy_set_header        Proxy "";
  }
}
