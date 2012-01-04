#include <iostream>
#include <string>

#include "FilesystemUtils.h"

using namespace std;

string GetFileBasename(string fileName) {
  size_t pos = fileName.find('.');
  return fileName.substr(0, pos);
}

string GetFileExtension(string fileName) {
  size_t pos = fileName.find('.');
  return fileName.substr(pos + 1, fileName.size() - 1);
}
