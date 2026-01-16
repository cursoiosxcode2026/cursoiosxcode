import Foundation

var miString = "Hola"
print(miString + " mundo")

let cadenaMultilinea = """
Hola que tal
    
Espero que todo bien
    Aqui unos espaciados
       
"""

print(cadenaMultilinea)

var cadenaConEscapes = "Hola Qué tal \nYo bien, \"entrecomillado\""
print(cadenaConEscapes)

var cadenaVacia = ""

if cadenaVacia == "" {
    print("vacia")
}

if cadenaVacia.isEmpty {
    print("vacia")
}

var cadenaMutable = "Hola"
cadenaMutable = cadenaMutable + " y adios"

let caracter1 : Character = "H"
print (type(of: caracter1))

var cadenaConVariables : String
cadenaConVariables = "Hola, el primer caracter es: \(caracter1)"


/*for letra in cadenaConVariable {
    print(letra)
}*/

cadenaConVariables = "2 + 2 es \(2+2)"
print(cadenaConVariables)

cadenaConVariables = "verdadero y verdadero es \(true && true)"
print(cadenaConVariables)

let esAdulto = true
print("Antonio es \(esAdulto ? "adulto" : "niño")")

//concatenacion
print("Hola" + " " + "que"  + " " + "tal. Antonio es \(esAdulto)")


let cadena2 = "12345abcde"
let cadena3 = "12345ABCDE"

print (cadena2.uppercased() == cadena3)
print(cadena2 == cadena3.lowercased())

print(cadena3.starts(with: "1"))
print(cadena3.lowercased())

