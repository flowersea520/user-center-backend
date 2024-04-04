# Docker 镜像构建
#这条命令指定了基础镜像为maven:3.5-jdk-8-alpine。
# 这意味着您的镜像将基于这个Maven和JDK 8的Alpine Linux镜像构建。as builder是为这个构建阶段指定了一个名称，
# 这通常用于多阶段构建，但在您提供的这个Dockerfile中，似乎没有使用到多阶段构建的其他部分。
FROM maven:3.5-jdk-8-alpine as builder

# Copy local code to the container image.
# WORKDIR: 设置工作目录，后续的操作（如COPY和RUN）都会在这个目录(/app)下执行。
  #/app: 设置为/app目录，这意味着容器内的操作将在/app目录下进行。
WORKDIR /app
#COPY: 复制文件或目录到容器内。
 #pom.xml .: 从构建上下文（通常是Dockerfile所在的目录）复制pom.xml文件到容器内的当前工作目录（即/app）。
COPY pom.xml .
# COPY: 复制文件或目录到容器内。
  #src ./src: 从构建上下文复制src目录到容器内的/app/src目录。
COPY src ./src

# Build a release artifact.
# RUN: 在容器内执行命令。
  #mvn package -DskipTests: 使用Maven的package目标来构建项目，
  # 并跳过测试（通过-DskipTests参数）。这会产生一个可执行的JAR文件（或其他类型的构建产物）。
RUN mvn package -DskipTests

# Run the web service on container startup.
# CMD: 设置容器启动时默认执行的命令。
  #["java","-jar","/app/target/user-center-backend-0.0.1-SNAPSHOT.jar" 使用Java来运行构建出的JAR文件。JAR文件的路径是基于之前的工作目录和Maven构建产物位置来确定的。
  # 同时，通过--spring.profiles.active=prod参数来设置Spring框架的生产环境配置。
CMD ["java","-jar","/app/target/user-center-backend-0.0.1-SNAPSHOT.jar","--spring.profiles.active=prod"]
