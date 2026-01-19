import Foundation

/*
 CLASES
 La idea de una clase es reutilizar propiedades, metodos de otras
 estructuras para no reescribir codigo, para añadir funcionalidades.
 
 Es el fundamento de la programacion orientada a objetos.
 */

class Vehiculo {
    var marca: String
    var modelo:String
    var velocidadActual: Int = 0
    
    //init es una funcion especial para inicializar los valores
    //TODOS los valores de la clase deben estar inicializados al
    //finalizar init, observar que velocidadActual ya esta inicializada en la definicion, por ello no se incluye //a continuacion
    //Utilizamos self. para que no se confundan los parametros del metodo con las propiedades del vehiculo
    
    init(marca: String, modelo: String) {
        self.marca = marca
        self.modelo = modelo
    }
    
    func acelerar(delta: Int) {
        velocidadActual = velocidadActual + delta
        
    }
}

var miCoche = Vehiculo(marca: "Toyota", modelo: "Corolla")
print(miCoche.marca, miCoche.modelo, miCoche.velocidadActual)

miCoche.acelerar(delta: 10)
print("Mi coche va a", miCoche.velocidadActual, "km/h")

/*
 HERENCIA
 La clase VehiculoLujo HEREDA las propiedades y metodos de la clase Vehiculo,
 y ademas podemos añadirle propiedades y funciones adicionales
 */

class VehiculoLujo: Vehiculo {
    var asientosCalefactables: Bool = false
    
    override func acelerar(delta: Int) {
        velocidadActual = velocidadActual + delta * 2
    }
    
    func suscribirseAAsientosCalentitos (suscripcion: Bool) {
    asientosCalefactables = suscripcion
    }
        
}
    
var miCocheLujoso = VehiculoLujo(marca: "Maserati", modelo: "Turbo-Spin-widowmaker")
miCocheLujoso.acelerar(delta: 50)
miCocheLujoso.suscribirseAAsientosCalentitos(suscripcion: true)
print(miCocheLujoso.velocidadActual, miCocheLujoso.asientosCalefactables)

/* Propiedades y metodos publicos o privados
 Por defecto, todas las propiedades y metodos de una clase son accesibles directamente desde fuera de la clase, usando la notacion '.' . Ejemplos: vehiculo.velocidadActual pero quizas queramos que para modificar la velocidad solo podamos hacerlo llamando a la funcion que actualiza la velocidad
 A esto se le llama ENCAPSULAMIENTO
 */

class Pantalla {
    //La declaracion private(set) nos indica que NO podemos modificar la variable desde fuera pero SI que
    //podemos leer su contenido
    private(set) var ancho: Int
    private(set) var alto: Int
    private(set) var pixels: Int
    
    init(ancho: Int, alto: Int) {
        self.ancho = ancho
        self.alto = alto
        pixels = 0
        actualizarPixeles()
    }
    func modificarTamanoPantalla(nuevoAncho:Int, nuevoAlto:Int) {
        ancho = nuevoAncho
        alto = nuevoAlto
        actualizarPixeles()
    }
    
    //Funcion de uso interno, no se puede llamar desde fuera de la clase
    private func actualizarPixeles() {
        pixels = ancho * alto
    }
}


var miPantalla = Pantalla(ancho: 2400, alto: 2000)
print(miPantalla.pixels)
miPantalla.modificarTamanoPantalla(nuevoAncho: 1920, nuevoAlto: 1080)
print(miPantalla.pixels)


//------
//Ejemplo que combina clase, struct y una coleccion de arrays:
//Una tienda con varios productos en stock.
struct Producto {
    let nombre: String
    var precio: Double
    var existencias: Int
    
    //Propiedad computada: se calcula cada vez que accedemos a ella para leer su contenido
    var valorTotal: Double {
        return precio * Double(existencias)
    }
    
    func mostrarInfoProducto() -> String {
        "\(nombre), \(precio) euros, \(existencias) unidades, valor total: \(valorTotal) euros"
    }
}

class Tienda {
    let nombre: String
    private var productos: [Producto] = []
    
    init(nombre: String) {
        self.nombre = nombre
    }
    
    func agregarProducto(producto: Producto) {
        productos.append(producto)
    }
    func mostrarInventario(){
        print("Inventario de tienda \(nombre):")
        for producto in productos {
            print(producto.mostrarInfoProducto())
        }
    }
    
    func valorTotalInventario() -> Double {
       // return productos.reduce(0.0) {$0 + $1.valorTotal}
        
        var acumulado = 0.0
        for producto in productos {
            acumulado += producto.valorTotal
        }
        return acumulado
    }
    
    func agregarExistencias(nombreProducto: String, existencias: Int) {
        if let indice = productos.firstIndex(where: {$0.nombre == nombreProducto}) {
            productos[indice].existencias += existencias
        }
    }
    
}

print("-----------------------TIENDA-------------------------")
var producto1 = Producto(nombre: "Jabon de manos", precio: 1.99, existencias: 10)
var producto2 = Producto(nombre: "Cafe", precio: 2.99, existencias: 5)
//print(producto1.mostrarInfoProducto())

var tienda = Tienda(nombre: "Mercaonda")
tienda.agregarProducto(producto: producto1)
tienda.agregarProducto(producto: producto2)
tienda.mostrarInventario()
print("El valor del inventario de la tienda es de \(tienda.valorTotalInventario()) euros.")
tienda.agregarExistencias(nombreProducto: "Cafe", existencias: 20)
tienda.mostrarInventario()
