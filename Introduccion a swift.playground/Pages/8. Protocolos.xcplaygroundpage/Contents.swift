import Foundation

protocol Vehiculo {
    //Propiedad que podemos leer
    var marca: String { get}
    
    //Propiedad que podemos leer y escribir
    var velocidadActual: Double { get set }
    
    mutating func acelerar(delta: Double)
    
    func describir() -> String
}

//Extensiones: sirven para crear implementaciones por defecto en los protocolos
//o ampliar funcionalidades de una struct o class sin tener que crear herencia
extension Vehiculo {
    func describir() -> String {
        return "\(marca) circula a \(velocidadActual) km/h"
    }
}

//La struct Coche se adhiere o implementa el protocol vehiculo
struct Coche: Vehiculo {
    var marca: String
    var velocidadActual: Double
    
   mutating func acelerar(delta: Double) {
        velocidadActual += delta
    }
}

var coche1 = Coche(marca: "BMW", velocidadActual: 180)
print(coche1.describir())


//Implementacion de multiple protocolos (para poder haces algo
//parecido a la herencia multiple


protocol Reproducible {
    func reproducir()
    func pausar()
    func detener()
}

protocol ControlVolumen {
    var volumen: Int { get set }
    func subirVolumen()
    func bajarVolumen()
}

class ReproductorMusical: Reproducible, ControlVolumen {
    enum EstadoInterno {
        case reproduciendo, pausado, detenido
    }
    private var cancionActual: String = ""
    var volumen: Int = 50
    private var estadoInterno: EstadoInterno = .detenido
    
    func reproducir() {
        if(estadoInterno == .reproduciendo) {
            print("Deten primero la reproduccion antes de reproducir de nuevo")
            return
        }
        print("Reproduciendo \(cancionActual)")
        estadoInterno = .reproduciendo
    }
    
    func pausar() {
        if(estadoInterno == .detenido){
            print(("Ya esta detenido, no se puede pausar"))
        } else {
            print("Reproductor pausado")
            estadoInterno = .pausado
        }
    }
    
    func detener() {
        print("Reproductor parado")
        estadoInterno = .detenido
    }
    
    func subirVolumen() {
        if volumen < 100 {
            volumen += 10
        }
        
        print("Volumen a \(volumen)")
    }
    
    func bajarVolumen() {
        if(volumen >= 10) {
            volumen -= 10
        }
        print("Volumen a \(volumen)")
    }
    
    func cambiarCancion(nuevaCancion: String) {
        cancionActual = nuevaCancion
    }
}

var miReproductor = ReproductorMusical()
miReproductor.cambiarCancion(nuevaCancion: "19 dias y 500 noches")
miReproductor.reproducir()

//Uso de protocolos para poder comparar objetos de tipo struct
//o class mediante el == de swift con el protocolo 'Equatable'

//Swift nos implementa de manera automatica el comparador por cada
//propiedad
struct Producto: Equatable {
    let nombre: String
    let precio: Double
}

let producto1 = Producto(nombre: "Carne", precio: 10)
let producto2 = Producto(nombre: "Carne", precio: 5)
print("Es igual producto1 a producto 2? \(producto1 == producto2)")

//Comparable nos permite usar el < o > para ordenar
struct OtroProducto: Equatable, Comparable {

    let nombre: String
    let precio: Double
    let otraVariable: Int
    
    //lhs: left hand sid, rhs: right hand side (es decir, lado izq y der de la comparacion igualdad ==
    //En este caso, para la comparacion de igualdad usaremos el
    //nombre y el precios y la igualdad sera cierta si coinciden
    //tanto nombre como precioo. Hemos omitido 'otraVariable'
    static func == (lhs: OtroProducto, rhs: OtroProducto) -> Bool {
        let comparacionNombre = lhs.nombre == rhs.nombre
        let comparacionPrecio = lhs.precio == rhs.precio
        return comparacionNombre && comparacionPrecio
    }
    
    static func < (lhs: OtroProducto, rhs: OtroProducto) -> Bool {
        return lhs.precio < rhs.precio
    }
    

}

let p1 = OtroProducto (nombre: "Carne",precio: 10, otraVariable: 0)

let p2 = OtroProducto (nombre: "Pescado",precio: 20, otraVariable: 0)
let p3 = OtroProducto (nombre: "Barra de pan",precio: 0.59 , otraVariable: 0)

print(("Es menor el precio de p1 que p2?", p1 < p2))

var productos = [p1, p2, p3]
//Ordenacion 'in-place', factible gracias a la implementacion del protocolo 'Comparable'
productos.sort()
for producto in productos {
    print("\(producto.nombre), \(producto.precio)")
}
