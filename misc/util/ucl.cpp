// SPDX-FileCopyrightText: 2025 Will Reed
//
// SPDX-LicenseIdentifier: LGPL-3.0-or-later

#include <iostream>
#include <fstream>
#include <string>
#include <format>
#include <print>
#include <filesystem>
#include <sstream>
#include <ucl++.h>

using std::cerr;
using std::println;

namespace fs = std::filesystem;

int main(const int argc, const char *argv[]) {
    
    std::string argz = argv[0];

    if (argc < 3) {
        println(cerr, "usage: {} <format> <file>.ucl", argz);
        println(cerr, "where format is one of: json, yaml");
        return 1;
    }
    
    std::string format = argv[1];

    if (format != "json" && format != "yaml") {
        println(cerr, "invalid format, expected one of: json, yaml");
        return 1;
    }

    std::string path = argv[2];

    if (!fs::exists(fs::path(path))) {
        println(cerr, "error: path '{}' does not exist", path);
        return 1;
    }

    std::ifstream handle(path);

    if (!handle.is_open()) {
        println(cerr, "error: failed opening file '{}'", path);
        return 1;
    }

    std::stringstream buffer;
    buffer << handle.rdbuf();
    handle.close();

    std::string uclErr = "";
    std::string fileContents = buffer.str();

    ucl::Ucl conf = ucl::Ucl::parse(fileContents, uclErr, UCL_DUPLICATE_APPEND);

    ucl_emitter emit;
    if (format == "json")
        emit = UCL_EMIT_JSON;
    
    if (format == "yaml")
        emit = UCL_EMIT_YAML;

    std::string outputText = conf.dump(emit);
    println("{}", outputText);

    return 0;

}
