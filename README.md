# haros_catkin

This package provides a catkin integration for [HAROS](https://github.com/git-afsantos/haros).

Required pip dependencies are installed via [catkin_virtualenv](https://github.com/locusrobotics/catkin_virtualenv).
Info: Currently catkin_virtualenv is only compatible with `catkin build`.

## Running static code analysis with HAROS:

In the package that should get tested add the following.
Add a test dependency to `package.xml`:

```
<test_depend>haros_catkin</test_depend>
```

Add the `haros_report` test to the `CMakeLists.txt`:

```
if (CATKIN_ENABLE_TESTING)
  find_package(haros_catkin REQUIRED)
  haros_report()
endif()
```

*Example: [haros_catkin_test](https://github.com/ipa-jfh/haros_catkin_test)*
