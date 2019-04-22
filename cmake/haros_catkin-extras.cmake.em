if (_HAROS_EXTRAS_INCLUDED_)
  return()
endif()
set(_HAROS_EXTRAS_INCLUDED_ TRUE)


@[if DEVELSPACE]@
  set(@(PROJECT_NAME)_VENV_BIN_DIR @(CATKIN_DEVEL_PREFIX)/@(CATKIN_PACKAGE_SHARE_DESTINATION)/venv/bin)
@[else]@
  set(@(PROJECT_NAME)_VENV_BIN_DIR @(CMAKE_INSTALL_PREFIX)/@(CATKIN_PACKAGE_SHARE_DESTINATION)/venv/bin)
@[end if]@

macro(_haros_create_targets)
  if (NOT TARGET haros_report)
    add_custom_target(haros_report)
  endif()

  if (NOT TARGET haros_report_${PROJECT_NAME})
    add_custom_target(haros_report_${PROJECT_NAME})
    add_dependencies(haros_report haros_report_${PROJECT_NAME} ${@(PROJECT_NAME)_EXPORTED_TARGETS})
  endif()
endmacro()

function(haros_report)
  set(HAROS_REPORT_LOCATION "${CMAKE_CURRENT_BINARY_DIR}/test_results/haros_report")
  set(HAROS_COMMAND "${@(PROJECT_NAME)_VENV_BIN_DIR}/python" "${@(PROJECT_NAME)_VENV_BIN_DIR}/haros")
  _haros_create_targets()
  add_custom_command(TARGET haros_report_${PROJECT_NAME} POST_BUILD
        COMMAND ${CMAKE_COMMAND} -E make_directory ${HAROS_REPORT_LOCATION}
        COMMAND ${HAROS_COMMAND} init
        COMMAND ${HAROS_COMMAND} -c ${PROJECT_SOURCE_DIR} analyse -d ${HAROS_REPORT_LOCATION})
endfunction()
