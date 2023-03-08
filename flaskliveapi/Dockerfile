FROM alpine:latest

RUN apk update && apk add --no-cache python3-dev \
    && python3 -m ensurepip \
    && pip3 install --upgrade pip && apk add openssh 

WORKDIR /app

COPY . /app

RUN pip3 --no-cache-dir install -r requirements.txt

RUN wget https://cacerts.digicert.com/DigiCertGlobalRootG2.crt.pem

RUN mkdir /etc/cert && mv DigiCertGlobalRootG2.crt.pem /etc/cert/
#ENV SSH_PASSWD "root:Docker!"
#RUN apt-get update \
 #       && apt-get install -y --no-install-recommends dialog \
  #      && apt-get update \
#	&& apt-get install -y --no-install-recommends openssh-server \
#	&& echo "$SSH_PASSWD" | chpasswd 

COPY sshd_config /etc/ssh/
COPY init.sh /usr/local/bin/
	
RUN chmod u+x /usr/local/bin/init.sh

EXPOSE 5000 2222

#CMD ["python3", "app.py"]
ENTRYPOINT ["/usr/local/bin/init.sh"]
