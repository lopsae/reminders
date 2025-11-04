import SwiftUI

struct ContentView: View {

    let modelData = ModelData()


    var body: some View {
        NavigationStack {
            List {
                NavigationLink {
                    assetCatalogList
                        .navigationTitle("From Assets Catalog")
                } label: {
                    Text("Load from Assets Catalog")
                }

                NavigationLink {
                    resourcesPackagList
                        .navigationTitle("From Resources Package")
                } label: {
                    Text("Load from Resources Package")
                }
            }
            .navigationTitle("Load Options")
            .navigationBarTitleDisplayMode(.inline)
        } // NavigationStack
    }


    @ViewBuilder
    private var assetCatalogList: some View {
        List {
            ForEach(modelData.landmarksFromAssetsCatalog) { landmark in
                Text(landmark.name)
            }
        }
    }


    @ViewBuilder
    private var resourcesPackagList: some View {
        List {
            ForEach(modelData.landmarksFromResourcesPackage) { landmark in
                Text(landmark.name)
            }
        }
    }

}


#Preview {
    ContentView()
}
