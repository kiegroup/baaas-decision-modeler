FROM registry.redhat.io/rhel8/httpd-24:1-123
COPY kogito-tooling/packages/online-editor/dist /var/www/html/