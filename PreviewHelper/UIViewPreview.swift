#if DEBUG
import SwiftUI
import UIKit

/// Permite visualizar qualquer UIView no SwiftUI Preview
struct UIViewPreview<View: UIView>: UIViewRepresentable {
    let viewBuilder: () -> View

    init(_ builder: @escaping () -> View) {
        self.viewBuilder = builder
    }

    func makeUIView(context: Context) -> View {
        return viewBuilder()
    }

    func updateUIView(_ uiView: View, context: Context) {}
}

extension UIView {
    private struct Preview: UIViewRepresentable {
        let view: UIView

        func makeUIView(context: Context) -> UIView {
            return view
        }

        func updateUIView(_ uiView: UIView, context: Context) {}
    }

    func toPreview() -> some View {
        Preview(view: self)
            .edgesIgnoringSafeArea(.all) // opcional
    }
}
#endif
