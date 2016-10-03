#
# Development container base on Debian Wheezy
#
# The container contains:
#  - native packages: python3.4.5, CMake, VTK
#  - python packages: numpy, scipy, matplotlib
#
#
FROM python:3.4.5-wheezy

# Create source & tmp build directory
RUN mkdir /tmpbuild
WORKDIR /tmpbuild

# Download & extract VTK
RUN wget http://www.vtk.org/files/release/7.0/VTK-7.0.0.tar.gz && tar -zxvf VTK-7.0.0.tar.gz

# Download, extract & build CMake
# http://www.vtk.org/Wiki/VTK/Configure_and_Build
RUN wget http://www.cmake.org/files/v2.8/cmake-2.8.12.2.tar.gz \
    && tar xzf cmake-2.8.12.2.tar.gz
RUN cd cmake-2.8.12.2 \
    && ./configure --prefix=/usr/local \
    && make \
    && make install

# Install opengl
# Debian, Ubuntu
# https://en.wikibooks.org/wiki/OpenGL_Programming/Installation/Linux
RUN apt-get update && apt-get install --yes build-essential libgl1-mesa-dev

# Install numpy & scipy
RUN pip install numpy==1.11.2rc1 scipy==0.18.1 matplotlib==1.5.3

# Enter the bash by default
CMD ["/bin/bash"]
