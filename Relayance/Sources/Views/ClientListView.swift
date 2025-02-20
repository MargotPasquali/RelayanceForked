//
//  ListClientsView.swift
//  Relayance
//
//  Created by Amandine Cousin on 10/07/2024.
//

import SwiftUI

struct ClientListView: View {

    // MARK: - Properties

    @StateObject var viewModel: ClientListViewModel
    @State private var showModal = false

    // MARK: - View

    var body: some View {
        NavigationStack {
            List(viewModel.clientsList, id: \.self) { client in
                NavigationLink {
                    ClientDetailsView(client: client, viewModel: viewModel)
                } label: {
                    Text(client.name)
                        .font(.title3)
                }
            }
            .navigationTitle("Liste des clients")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Ajouter un client") {
                        showModal.toggle()
                    }
                    .foregroundStyle(.orange)
                    .bold()
                }
            }
            .sheet(isPresented: $showModal) {
                AddClientView(viewModel: viewModel, dismissModal: $showModal)
            }
        }
    }
}

#Preview {
    ClientListView(viewModel: ClientListViewModel())
}
