import PackageDescription

let package = Package(
  name: "Monet",
  dependencies: [
    .Package(url: "https://github.com/Hearst-DD/ObjectMapper.git", versions: Version(3, 0, 0)..<Version(4, 0, 0))
  ],
  exclude: [
    "Tests",
    "Samples"
  ]
)
