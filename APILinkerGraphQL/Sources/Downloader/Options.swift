import ApolloCodegenLib
import Foundation

let endpoint = URL(string: "https://tmdb.apps.quintero.io/")!

let parentFolderOfScriptFile = FileFinder.findParentFolder()

let packageRootURL = parentFolderOfScriptFile
  .deletingLastPathComponent() // Sources
  .deletingLastPathComponent() // GraphQL Downloader

let apolloCLIURL = packageRootURL
  .appendingPathComponent("ApolloCLI")

let downloadedResourcesURL = packageRootURL
  .appendingPathComponent("Sources")
  .appendingPathComponent("Resources")

let outputURL = packageRootURL
  .appendingPathComponent("Sources")
  .appendingPathComponent("GraphQLAPI")

let queriesURL = packageRootURL
  .appendingPathComponent("Sources")
  .appendingPathComponent("Input")

let operationIDsURL = downloadedResourcesURL
  .appendingPathComponent("operationIDs.json")

let schemaURL = downloadedResourcesURL
  .appendingPathComponent("schema.json")

// MARK: - Options
enum Options {
  static let schema = ApolloSchemaOptions(
    downloadMethod: .introspection(endpointURL: endpoint),
    outputFolderURL: downloadedResourcesURL
  )
  
  static let codegen = ApolloCodegenOptions(
    codegenEngine: .default,
    operationIDsURL: operationIDsURL,
    outputFormat: .multipleFiles(inFolderAtURL: outputURL),
    urlToSchemaFile: schemaURL
  )
}
