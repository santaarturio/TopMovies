import ApolloCodegenLib
import Foundation

// MARK: - Ensure folder exists
try FileManager
  .default
  .apollo.createFolderIfNeeded(at: apolloCLIURL)

try FileManager
  .default
  .apollo.createFolderIfNeeded(at: outputURL)

// MARK: - Download shcema
do {
  try ApolloSchemaDownloader.run(
    with: apolloCLIURL,
    options: Options.schema
  )
} catch {
  print(error)
  exit(1)
}

// MARK: - Generate client
do {
  try ApolloCodegen.run(
    from: queriesURL,
    with: apolloCLIURL,
    options: Options.codegen
  )
} catch {
  print(error)
  exit(1)
}
