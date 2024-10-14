# docker build -t android:default .
# xhost local:$USER && docker run -it --rm --user user --device /dev/kvm -e DISPLAY=$DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix -v /home/user/test:/home/user/project android:default
# xhost local:$USER && docker run -it --rm --device /dev/kvm -e DISPLAY=$DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix -v /home/user/test:/home/user/project android:default


FROM ubuntu:24.04


ENV PROGRAM_PATH=/opt


ENV DEBIAN_FRONTEND="noninteractive"
ENV PATH="$PROGRAM_PATH/flutter/bin:${PATH}"
ENV PATH="$PROGRAM_PATH/android-studio/bin:${PATH}"
ENV PATH="$PROGRAM_PATH/Android/Sdk/cmdline-tools/latest/bin/:${PATH}"
ENV PATH="$PROGRAM_PATH/Android/Sdk/emulator:${PATH}"
ENV ANDROID_HOME="$PROGRAM_PATH/Android/Sdk"
ENV ANDROID_SDK_ROOT=$ANDROID_HOME


RUN apt update && apt upgrade -y


# basis programs
RUN apt-get install -y adb \
    clang \
    cmake  \
    curl  \
    git  \
    libgtk-3-dev \
    libglu1-mesa \
    libpulse-dev \
    libxkbfile1 \
    ninja-build \
    openjdk-17-jre-headless \
    openssh-server \
    pkg-config \
    sudo \
    unzip \
    wget \
    xz-utils \
    zip

# downloads
RUN wget https://storage.googleapis.com/flutter_infra_release/releases/stable/linux/flutter_linux_3.24.3-stable.tar.xz -O /tmp/flutter.tar.xz
RUN wget https://r6---sn-uxax4vopj5qx-cxge.gvt1.com/edgedl/android/studio/ide-zips/2024.1.2.12/android-studio-2024.1.2.12-linux.tar.gz -O /tmp/android-studio.tar.gz
RUN wget https://dl.google.com/android/repository/commandlinetools-linux-11076708_latest.zip -O /tmp/cli-tools.zip

# install flutter and android-studio
RUN tar -xf /tmp/flutter.tar.xz -C $PROGRAM_PATH
RUN tar -xf /tmp/android-studio.tar.gz -C $PROGRAM_PATH
RUN unzip /tmp/cli-tools.zip -d $PROGRAM_PATH && \
    mkdir -p $PROGRAM_PATH/cmdline-tools/latest && \
    mv $PROGRAM_PATH/cmdline-tools/bin $PROGRAM_PATH/cmdline-tools/latest/ && \
    mv $PROGRAM_PATH/cmdline-tools/lib $PROGRAM_PATH/cmdline-tools/latest/

# install android sdk
WORKDIR $PROGRAM_PATH/cmdline-tools/latest/bin
RUN yes | ./sdkmanager --update
RUN yes | ./sdkmanager --sdk_root=$PROGRAM_PATH/Android/Sdk "emulator"
RUN yes | ./sdkmanager --sdk_root=$PROGRAM_PATH/Android/Sdk "build-tools;35.0.0"
RUN yes | ./sdkmanager --sdk_root=$PROGRAM_PATH/Android/Sdk "platform-tools"
RUN yes | ./sdkmanager --sdk_root=$PROGRAM_PATH/Android/Sdk "platforms;android-35"
RUN yes | ./sdkmanager --sdk_root=$PROGRAM_PATH/Android/Sdk "system-images;android-35;google_apis_playstore;x86_64"
RUN yes | ./sdkmanager --sdk_root=$PROGRAM_PATH/Android/Sdk "sources;android-35"
RUN yes | ./sdkmanager --sdk_root=$PROGRAM_PATH/Android/Sdk --install "cmdline-tools;latest"
RUN yes | flutter doctor --android-licenses
RUN yes | sdkmanager --licenses
RUN git config --global --add safe.directory $PROGRAM_PATH/flutter

# create virtual device
# avdmanager list devices
RUN avdmanager create avd -n "Pixel_8_Pro_API_35" -k "system-images;android-35;google_apis_playstore;x86_64" -d "pixel_8_pro"
# emulator -avd -list-avds 

# clean-up
RUN rm /tmp/flutter.tar.xz /tmp/android-studio.tar.gz /tmp/cli-tools.zip
RUN deluser ubuntu && rm -rf /home/ubuntu

# start container
RUN mkdir -p /project
WORKDIR /project
CMD ["bash"]
