import Foundation

//ESTRUCTURAS

struct Persona {
    var nombre: String
    var apellidos: String
    var edad: Int
}


//Declaracion e inicializacion (es obligatorio definir todos los
//valores
var persona1: Persona
persona1 = Persona(nombre: "Maria", apellidos:"Garcia Garcia", edad: 33)

persona1.nombre
print("Persona1 se llama: \(persona1.nombre), de apellidos: \(persona1.apellidos) y tiene \(persona1.edad) años")

//Acceso a los datosz para modificarlos
persona1.edad = 34
print("Ha pasado 1 año y ahora tiene \(persona1.edad) años")


//Crear estructuras dentro de estructuras es posible
struct Direccion {
    var calle: String
    var numero: Int
    var codigoPostal: String
}

struct DatosPersonales {
    var nombre: String
    var edad: Int
    var direccion: Direccion
}

var direccion1 = Direccion(calle: "Calle Mayor", numero: 7, codigoPostal: "28080")

var datosPersona1 = DatosPersonales(nombre: "Paco", edad: 44, direccion: direccion1)

print(datosPersona1.nombre, "vive en",datosPersona1.direccion.calle)

/*
 Concepto: las Structs son Tipos que se pasan por Valor
 es decir, al asignarlas a otras variables, se crea un duplicado
 o copia de la variable
 */

var datosPersona2 = datosPersona1 //Hace un duplicado, que es
//independiente
datosPersona2.nombre = "Julio" //cambia el nombre a la
//persona2, NO a persona1

print(datosPersona1.nombre, datosPersona2.nombre)


//Struct con funciones internas
struct Calculadora {
    
    var a: Int
    var b: Int
    
    func sumar () -> Int{
        return a + b
    }
    
    func restar() -> Int {
        
        return a - b
    }
    
    //Podemos convertir los tipos enteros a Double o Float
    //para que devuelva la division con decimales
    func dividir () -> Double {
    return Double(a) / Double(b)
    }
    
    mutating func acumular (x: Int, y: Int) {
       a = a + x
       b = b + y
    }
}

var miCalculadora = Calculadora(a: 5, b: 2)
let resultadoSuma = miCalculadora.sumar()
print(resultadoSuma)
let resultadoDivision = miCalculadora.dividir()
print(resultadoDivision)

miCalculadora.acumular(x: 5, y: 4)
print(miCalculadora.a, miCalculadora.b)
