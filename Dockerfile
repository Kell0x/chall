FROM debian

RUN apt-get update -yq \
&& apt-get install python3 python3-pip -yq \
&& apt-get install curl gnupg -yq \
&& apt-get install man -yq

RUN pip install flask

RUN useradd -ms /bin/sh aperture

ADD . /www/

RUN echo 'aperture ALL = (ALL) ALL' >> /etc/sudoers
RUN echo 'aperture ALL = (root) NOPASSWD: /bin/man' >> /etc/sudoers
RUN echo "flag{Vous vous en sortez bien.}" > /www/flag.txt

USER aperture

WORKDIR /www/

EXPOSE 5000

CMD python3 -m flask --app server.py run --host=0.0.0.0