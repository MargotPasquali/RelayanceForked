//
//  DetailClientView.swift
//  Relayance
//
//  Created by Amandine Cousin on 10/07/2024.
//

import SwiftUI

struct DetailClientView: View {
    var client: Client
    private var viewModel: ClientListViewModel

    init(client: Client, viewModel: ClientListViewModel) {
        self.client = client
        self.viewModel = viewModel
    }

    var body: some View {
        VStack {
            Image(systemName: "person.circle")
                .resizable()
                .frame(width: 150, height: 150)
                .foregroundStyle(.orange)
                .padding(50)
            Spacer()
            Text(client.name)
                .font(.title)
                .padding()
            Text(client.email)
                .font(.title3)
            Text(viewModel.dateToStringFormatter(for: client))
                .font(.title3)
            Spacer()
        }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button("Supprimer") {
                    // suppression
                }
                .foregroundStyle(.red)
                .bold()
            }
        }
    }
}

#Preview {
    DetailClientView(client: Client(name: "Tata", email: "tata@email", creationDateString: "20:32 Wed, 30 Oct 2019"), viewModel: ClientListViewModel())
}
