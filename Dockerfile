FROM openjdk:11
EXPOSE 8080
ADD target/*.jar nish.jar
ENTRYPOINT ["java","-jar","nish.jar"]