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
            }
            .navigationTitle("Load Options")
            .navigationBarTitleDisplayMode(.inline)
        } // NavigationStack
    }


    @ViewBuilder
    private var assetCatalogList: some View {
        List {
            ForEach(modelData.landmarks) { landmark in
                Text(landmark.name)
            }
        }
    }

}


#Preview {
    ContentView()
}
