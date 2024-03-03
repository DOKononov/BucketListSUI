//
//  EmptyStateView.swift
//  BucketListSUI
//
//  Created by Dmitry Kononov on 3.03.24.
//

import SwiftUI

struct EmptyStateView: View {
    var body: some View {
        Text("List is empty. Add your first Bucket.")
        Image(systemName: "trash")
            .resizable()
            .frame(width: 80)
            .aspectRatio(contentMode: .fit)
        Spacer()
    }
}

#Preview {
    EmptyStateView()
}
