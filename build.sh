#!/bin/bash
set -e
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 
# #   Script to auto build packages from Slackbuilds.org                                                                                  # #
# #   by - SpaceInvaderOne                                                                                                                # # 
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 

# only run if autobuild is set to yes
if [ "$AUTOBUILD" = "yes" ]; then
    # working directory
    cd /app

    # download the SlackBuild 
    wget -O slackbuild.tar.gz "$SLACKBUILD_DOWNLOAD"

    # process the file
    SLACKBUILD_DIR=$(tar -tzf slackbuild.tar.gz | head -1 | cut -f1 -d"/")
    tar -xzf slackbuild.tar.gz
    rm slackbuild.tar.gz

    # cd into the extracted directory
    cd "$SLACKBUILD_DIR"

    # download source into the directory
    wget "$SOURCE_DOWNLOAD"

    # make executable and run the SlackBuild script
    chmod +x *.SlackBuild
    ./$(ls *.SlackBuild)

    # say where the package is 
    echo "Build completed. Check the /tmp directory for the built package."

else
    echo "AUTOBUILD is not set to 'yes'. Skipping automatic build."
	# keep the container running
    tail -f /dev/null
fi

