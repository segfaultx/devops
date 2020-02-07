FROM openjdk:11-jre-slim-buster

LABEL de.hsrm.mi.gaussRest.version="GaussContainer"
EXPOSE 8080
COPY start.sh ./
COPY gaussRest-0.0.1-SNAPSHOT.jar ./

CMD [ "./start.sh" ]