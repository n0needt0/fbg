server {
    listen 0.0.0.0:80 default deferred;
    server_name www.fbg.com

    sendfile off;

    root /var/www/api/public/;
    index index.php index.html index.htm;

    location ~ /\. {
        deny all;
    }

    #now the website
    location ~* \.(?:ico|css|js|gif|jpe?g|png)$ {
    # Some basic cache-control for static files to be sent to the browser
       add_header Vary Accept-Encoding;
       expires max;
    }

    location / {
            #if ($http_host !~ "^www\.fbg\.com$"){
            #  rewrite ^(.*)$ http://www.fbg.com redirect;
            #}
           try_files $uri $uri/ /index.php?$query_string;
       }

    # pass the PHP scripts to FastCGI server listening on /var/run/php5-fpm.sock
    location ~ \.php$ {
                        #cache section
                        set $no_cache "";
                        # If non GET/HEAD, don't cache & mark user as uncacheable for 1 second via cookie
                        if ($request_method !~ ^(GET|HEAD)$) {
                            set $no_cache "1";
                        }
                        # Drop no cache cookie if need be
                        # (for some reason, add_header fails if included in prior if-block)
                        if ($no_cache = "1") {
                            add_header Set-Cookie "_mcnc=1; Max-Age=2; Path=/";
                            add_header X-Microcachable "0";
                        }
                        # Bypass cache if no-cache cookie is set
                        if ($http_cookie ~* "_mcnc") {
                                    set $no_cache "1";
                        }

                        #disable cache for now
                        #set $no_cache "1";

                        # Bypass cache if flag is set
                        fastcgi_no_cache $no_cache;
                        fastcgi_cache_bypass $no_cache;
                        fastcgi_cache microcache;
                        fastcgi_cache_key $server_name|$request_uri;
                        fastcgi_cache_valid 404 30m;
                        fastcgi_cache_valid 200 10s;
                        fastcgi_max_temp_file_size 1M;
                        fastcgi_cache_use_stale updating;
                        #fastcgi_pass localhost:9000;
                        fastcgi_pass_header Set-Cookie;
                        fastcgi_pass_header Cookie;
                        fastcgi_ignore_headers Cache-Control Expires Set-Cookie;
                        #end cache

                        try_files $uri /index.php =404;
                        fastcgi_pass unix:/var/run/php5-fpm.sock;
                        fastcgi_index index.php;
                        fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
                        include fastcgi_params;
        }
 }
