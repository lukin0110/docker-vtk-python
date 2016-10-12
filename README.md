# Docker VTK Python image

This is a Docker development image for [VTK](http://www.vtk.org/) 
projects with Python based on Debian Wheezy x86_64. 

Libraries inside:

* [Python 3.4.5](https://www.python.org/)
* [VTK 7.0.0](http://www.vtk.org/)
* [CMake 2.8.12.2](https://cmake.org/)
* [OpenGL](https://www.opengl.org/)
* [Tcl 8.6.6 & Tk 8.6.6](https://www.tcl.tk/)

## Usage

Download:
```
$ docker pull lukin0110/docker-vtk-python
```

Run python shell:
```
$ docker run -it lukin0110/docker-vtk-python python
```

Run a bash shell:
```
$ docker run -it lukin0110/docker-vtk-python bash
```

## Mount points

The container has 2 mount points:

* `/src`: mount a local source code directory. You need this to execute your code in the container.
* `/out`: mount a local out directory if your scripts produce output.

Examples:
```
$ docker run -it -v your_source:/src lukin0110/docker-vtk-python python /src/myscript.py
$ docker run -it -v your_out:/out lukin0110/docker-vtk-python python /src/myscript.py

$ docker run -it -v your_source:/src -v your_out:/out lukin0110/docker-vtk-python python /src/myscript.py
```

[More info about mounting](https://docs.docker.com/engine/tutorials/dockervolumes/).

**Note**: on OSX you need to add the full path of the directory that you want to mount. 
E.g.: `docker run -v /Users/johndoe/your_project/your_source:/src`.

## Examples

The container has a few examples included. The examples are located in 
the `/examples` directory.

* numpy: `docker run -it lukin0110/docker-vtk-python python /examples/e_numpy.py`
* scipy: `docker run -it lukin0110/docker-vtk-python python /examples/e_scipy.py`
* vtk: `docker run -it lukin0110/docker-vtk-python python /examples/e_vtk.py`
