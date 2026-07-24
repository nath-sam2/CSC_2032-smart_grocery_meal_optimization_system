# Build/deploy image for Render.
#
# NetBeans' Ant build depends on IDE-private settings (your local Tomcat
# install path) that aren't available in a plain Docker build, so we don't
# try to rebuild from source here. Instead:
#
#   1. In NetBeans: right-click the project -> Clean and Build
#      (produces dist/SmartGroceryWebSystem.war)
#   2. Copy that file to: deploy/SmartGroceryWebSystem.war
#      (this "deploy" folder is NOT covered by .gitignore, unlike dist/)
#   3. git add deploy/SmartGroceryWebSystem.war, commit, push
#
# Render then builds this Dockerfile from your repo and it just picks up
# the WAR you already built and tested locally.

FROM tomcat:10.1-jdk21

# Remove Tomcat's default sample apps (not needed, smaller image)
RUN rm -rf /usr/local/tomcat/webapps/*

# Deploy your app as the ROOT context, so it's served at "/"
# instead of "/SmartGroceryWebSystem" — simpler URLs on Render.
COPY deploy/SmartGroceryWebSystem.war /usr/local/tomcat/webapps/ROOT.war

# Render sets $PORT and expects the app to listen on it.
# Tomcat's default HTTP connector listens on 8080 — set that as the
# port in the Render dashboard (see notes below).
EXPOSE 8080

CMD ["catalina.sh", "run"]
