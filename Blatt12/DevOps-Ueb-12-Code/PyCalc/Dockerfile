FROM python:alpine3.7
RUN  pip3 install flask-restful
COPY app ./opt/
WORKDIR /opt/
EXPOSE 5000
CMD  [ "python3", "pycalc.py" ]

