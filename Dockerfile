FROM centos/httpd-24-centos7:2.4
COPY kogito-tooling/packages/online-editor/dist /var/www/html/
