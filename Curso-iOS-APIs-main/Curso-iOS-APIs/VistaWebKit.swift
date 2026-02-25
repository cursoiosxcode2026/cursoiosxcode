//
//  VistaWebKit.swift
//  Curso-iOS-APIs
//
//  Created by Equipo 2 on 24/2/26.
//

import SwiftUI
import WebKit


// Para pasarle a la vista web o bien un enlace o bien código HTML/JS
enum WebContent {
    case link(URL)
    case localHtml(String)
}

struct WebView: UIViewRepresentable {
    let content: WebContent
    
    func makeUIView(context: Context) -> WKWebView {
        // Configuración
        let config = WKWebViewConfiguration()
        config.allowsInlineMediaPlayback = true
        return WKWebView(frame: .zero, configuration: config)
    }
    
    func updateUIView(_ webView: WKWebView, context: Context) {
        switch content {
        case .link(let url):
            if webView.url != url {
                let request = URLRequest(url: url)
                webView.load(request)
                
            }
            
        case .localHtml(let htmlString) :
            webView.loadHTMLString(htmlString, baseURL: nil)
        }
    }
}


struct VistaWebKit: View {
    
   // let webContent = WebContent.link(URL(string: "https://www.google.com")!)
    
    //En el head se pueden poner los estilos
    let webContent = WebContent.localHtml("""
        
        <html>
            <head>
            </head>
            <body>
            <h1>Hola!</h1>
            <p>Estoy en HTML renderizado.</p>
            <button onclick ="alert('¡Pulsando!)">Púlsame</button>
            </body>
        </html>
        """)
    
    var body: some View {
        
        WebView(content: webContent)

    }
}

#Preview {
    VistaWebKit()
}
