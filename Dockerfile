FROM bitnami/php-fpm:7.1-ol-7

# Install New Relic agent for monitoring
RUN \
  curl -L https://download.newrelic.com/php_agent/release/newrelic-php5-8.7.0.242-linux.tar.gz | tar -C /tmp -zx && \
   export NR_INSTALL_USE_CP_NOT_LN=1 && \
    export NR_INSTALL_SILENT=1 && \
     /tmp/newrelic-php5-*/newrelic-install install && \
      rm -rf /tmp/newrelic-php5-* /tmp/nrinstall* && \
        sed -i -e 's/"REPLACE_WITH_REAL_KEY"/"952b94418b667994832fa842c21e1144ef3e8380"/' \
     -e 's/newrelic.appname = "PHP Application"/newrelic.appname = "test"/' \
         /opt/bitnami/php/etc/conf.d/newrelic.ini
        
# Copy application sources
RUN mkdir -p /app
COPY src/ /app/src/
COPY vendor/ /app/vendor/
COPY api.php /app

ENTRYPOINT ["php", "-S", "0.0.0.0:8082"]
