# KULeuven Project

## Usage

Build container: 
```
$ docker-compose --verbose build
```

Run python shell:
```
$ docker-compose run app python
```

Run a bash shell:
```
$ docker-compose run app bash
```

If you want to write output files (text files, JPEG's, PNG's) you'll 
have to write to the `/out` directory in your python scripts. This 
directory can be [mounted](https://docs.docker.com/engine/tutorials/dockervolumes/) 
to a container.

## Docker image

The docker image is based on python 3.4.5 and Debian wheezy. It 
downloads all the sources of all the necessary libraries & builds them.
Example of a [VTK Docker image](https://hub.docker.com/r/srikanthnagella/vtk-docker/~/dockerfile/).

Included libraries:

* [VTK](http://www.vtk.org/)
* [CMake](https://cmake.org/)
* [OpenGL](https://www.opengl.org/)
* [Tcl & Tk](https://www.tcl.tk/)

The images automatically builds everything. The VTK library has Python
bindings. The image is ready to use for development.

### Build VTK with ccmake in a container

```
$ docker-compose run app
$ mkdir VTK-build
cd VTK-build
ccmake ../VTK-7.0.0
```

After you have configured it:
```
$ make
```

More info [about configuring & building VTK](http://www.vtk.org/Wiki/VTK/Configure_and_Build)

### Link VTK with Python

* http://ghoshbishakh.github.io/blog/blogpost/2016/03/05/buid-vtk.html
* http://www.vtk.org/Wiki/VTK/Tutorials/PythonEnvironmentSetup
* https://mail.python.org/pipermail/pythonmac-sig/2004-October/011838.html
