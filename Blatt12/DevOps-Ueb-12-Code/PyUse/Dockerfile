FROM python:alpine3.7
RUN  pip3 install flask-restful requests
COPY app ./opt/
WORKDIR /opt/
EXPOSE 6000
CMD  [ "python3", "pyuse.py" ]

