if (_HAROS_EXTRAS_INCLUDED_)
  return()
endif()
set(_HAROS_EXTRAS_INCLUDED_ TRUE)

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
  cmake_parse_arguments(
    HAROS
    ""
    "REPORT_LOCATION;CONFIG_PATH;HOME_PATH"
    ""
    ${ARGN} )
  if(NOT HAROS_REPORT_LOCATION)
    set(HAROS_REPORT_LOCATION "${CMAKE_CURRENT_BINARY_DIR}/test_results/haros_report")
  else()
    set(HAROS_REPORT_LOCATION "${HAROS_REPORT_LOCATION}/${CMAKE_PROJECT_NAME}")
  endif()
  if(HAROS_CONFIG_PATH)
      set(HAROS_CONFIG_CMD "--config=${HAROS_CONFIG_PATH}")
  endif()
  if(HAROS_HOME_PATH)
      set(HAROS_HOME_CMD "--home=${HAROS_HOME_PATH}")
  endif()
  _haros_create_targets()
  add_custom_command(TARGET haros_report_${PROJECT_NAME} POST_BUILD
        COMMAND ${CMAKE_COMMAND} -E make_directory ${HAROS_REPORT_LOCATION}
        COMMAND rosrun haros_catkin haros ${HAROS_HOME_PATH}
                                          ${HAROS_CONFIG_CMD}
                                          -c ${PROJECT_SOURCE_DIR}
                                          analyse
                                          -d ${HAROS_REPORT_LOCATION})
endfunction()
