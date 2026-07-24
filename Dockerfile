# Build/deploy image for Render.
#
# NetBeans' Ant build depends on IDE-private settings (your local Tomcat
# install path) that aren't available in a plain Docker build, so we don't
# try to rebuild from source here. Instead:
#
#   1. In NetBeans: right-click the project -> Clean and Build
#      (produces dist/SmartGroceryWebSystem.war)
#   2. Copy that file to: Deploy/SmartGroceryWebSystem.war
#      (this "Deploy" folder is NOT covered by .gitignore, unlike dist/)
#   3. git add Deploy/SmartGroceryWebSystem.war, commit, push
#
# Render then builds this Dockerfile from your repo and it just picks up
# the WAR you already built and tested locally.
FROM tomcat:10.1-jdk21
# Custom logging config so Tomcat's container-level startup errors
# (e.g. "listener failed to start") print to console/stdout instead of
# only being written to a log file we can't see on Railway.
COPY logging.properties /usr/local/tomcat/conf/logging.properties
# Remove Tomcat's default sample apps (not needed, smaller image)
RUN rm -rf /usr/local/tomcat/webapps/*
# Deploy your app as the ROOT context, so it's served at "/"
# instead of "/SmartGroceryWebSystem" — simpler URLs on Render.
# NOTE: folder name is "Deploy" (capital D) to match the repo exactly —
# Render builds on Linux, which is case-sensitive.
COPY Deploy/SmartGroceryWebSystem.war /usr/local/tomcat/webapps/ROOT.war
# Render sets $PORT and expects the app to listen on it.
# Tomcat's default HTTP connector listens on 8080 — set that as the
# port in the Render dashboard (see notes below).
EXPOSE 8080
CMD ["catalina.sh", "run"]