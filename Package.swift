import PackageDescription

let package = Package(
  name: "TZewoHTTPServer",
  dependencies: [
    .Package(url: "https://github.com/Zewo/HTTPServer.git",
             majorVersion: 0, minor: 14),
    .Package(url: "https://github.com/apocolipse/Thrift-Swift.git",
               majorVersion: 1, minor: 0),
  ]
)
