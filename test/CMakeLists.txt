add_executable(test-third-parties test_third_parties.cpp)
target_link_libraries(test-third-parties PRIVATE spdlog::spdlog fmt::fmt Boost::regex)