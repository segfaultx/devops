FROM openjdk:11-jre-slim-buster

LABEL maintainer="Amatus Muscheites <amatus.muscheites@gmail.com>"

LABEL de.hsrm.mi.anwendung.version=1.0

COPY start.sh ./

COPY gaussRest-0.0.1-SNAPSHOT.jar ./

EXPOSE 8080

CMD [ "/start.sh" ]