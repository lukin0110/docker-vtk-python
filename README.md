# KULeuven Project

## Build VTK

```
$ docker-compose run app
$ mkdir VTK-build
cd VTK-build
ccmake ../VTK-7.0.0d
```

After you have configured it:
```
$ make
```

More info [about configuring & building VTK](http://www.vtk.org/Wiki/VTK/Configure_and_Build)

## TODO

* link VTK Python (http://ghoshbishakh.github.io/blog/blogpost/2016/03/05/buid-vtk.html)
* store build in `builds` and add as pre-build library
* Docker container to build VTK
