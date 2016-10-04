#
# Development container base on Debian Wheezy
#
# The container contains:python3.4.5, CMake, VTK, Tcl, Tk, OpenGL
#
FROM python:3.4.5-wheezy

# Create source & tmp build directory
RUN mkdir /tmpbuild
WORKDIR /tmpbuild

###################################################################################################################
# Download sources & setup supporting libraries that are needed to build VTK
###################################################################################################################
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

# Install OpenGL
# Debian, Ubuntu
# https://en.wikibooks.org/wiki/OpenGL_Programming/Installation/Linux
RUN apt-get update && apt-get install --yes build-essential libgl1-mesa-dev

# Download & build Tcl
# https://www.tcl.tk/doc/howto/compile.html#unix
RUN wget http://prdownloads.sourceforge.net/tcl/tcl8.6.6-src.tar.gz && tar -zxvf tcl8.6.6-src.tar.gz
RUN cd tcl8.6.6/unix && ./configure && make && make install

# Download & build Tk
# https://www.tcl.tk/doc/howto/compile.html
RUN wget http://prdownloads.sourceforge.net/tcl/tk8.6.6-src.tar.gz && tar -zxvf tk8.6.6-src.tar.gz
RUN cd tk8.6.6/unix && ./configure && make && make install
###################################################################################################################
# /end setup
###################################################################################################################

###################################################################################################################
# Building VTK with python interfaces
# http://ghoshbishakh.github.io/blog/blogpost/2016/03/05/buid-vtk.html
###################################################################################################################
RUN mkdir /vtk-build2
RUN cd /vtk-build2/ && cmake \
  -DCMAKE_BUILD_TYPE:STRING=Release \
  -DBUILD_TESTING:BOOL=OFF \
  -DVTK_WRAP_PYTHON:BOOL=ON \
  -DVTK_WRAP_PYTHON_SIP:BOOL=ON \
  -DVTK_WRAP_TCL:BOOL=ON \
  -DVTK_PYTHON_VERSION:STRING=3 \
  -DVTK_USE_TK:BOOL=ON \
  /tmpbuild/VTK-7.0.0

# Build VTK
RUN cd /vtk-build2/ && make

# Now install the python bindings
RUN cd /vtk-build2/Wrapping/Python && make && make install

# Set environment variable to add the VTK libs to the Shared Libraries
# http://tldp.org/HOWTO/Program-Library-HOWTO/shared-libraries.html
# export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/lib:/vtk-build2/lib
ENV LD_LIBRARY_PATH $LD_LIBRARY_PATH:/usr/local/lib:/vtk-build2/lib
###################################################################################################################
# /end VTK Build
###################################################################################################################

# Create Mount points
# https://docs.docker.com/engine/reference/builder/#/volume
#
# - /vtk-build: directory is used to build the VTK library from with a container with ccmake
# - /out: directory is used for python to write output files (JPEG, PNG, etc)
#VOLUME ["/vtk-build", "/out"]
#VOLUME ["/out"]

# Create the possible mount points
RUN mkdir /out && mkdir /src

# Set the source dir as default
WORKDIR /src

# Add examples
ADD examples /examples

# Adding docker-entrypoint & configure
ADD deployment/docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh
RUN chmod ugo+x /usr/local/bin/docker-entrypoint.sh
ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]

# Add requirements.txt
ADD deployment/requirements.txt /tmpbuild
RUN pip install -r /tmpbuild/requirements.txt

# Enter the bash by default
CMD ["bash"]
