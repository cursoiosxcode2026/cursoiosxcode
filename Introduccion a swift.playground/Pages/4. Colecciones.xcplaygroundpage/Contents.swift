import Foundation

//ARRAYS
//Es una colecciobn en forma de una lista ordenada de valores del
//MISMO tipo de datos
// [1, 5, 10, -1, 0, 8]


var arrayVacio: [Int] = []
print(arrayVacio)
print("arrayVacio esta vacio? \(arrayVacio.isEmpty)")

var arrayInts: [Int] = [1, 2, 3]
print(arrayInts)

print("Cuantos elementos tiene arrayInts: \(arrayInts.count)")

//Para añadir un elemento al final:

arrayInts.append(0)

// O bien, podemos añadirlo asi:
arrayInts += [10] //equivalente a arrayInts = arrayInts + [10]

//Podemos añadir varios elementos de una vez:
arrayInts += [-1,-2]

//Para añadir un elemento en una posicion especifica:
//La primera posicion del array se numera desde 0
arrayInts.insert(-100, at: 0)

//Para borrar un elemento en una posicion especifica
arrayInts.remove(at: 0)

//Acceder a los elementos del array

let primerElemento = arrayInts[0]
print("Primer elemento: \(primerElemento)")
print("Tercer elemento: \(arrayInts[2])")

//Modifica un elemento en una posicion concreta
arrayInts[4] = -233
print(arrayInts)

//Iterar (recorrer la totalidad) sobre un array
for elemento in arrayInts {
    print(elemento)
}


//Iteracion sobre indice y valor
for (indice, elemento) in arrayInts.enumerated() {
    print("\(indice): \(elemento)")
}

//Cuidado con salirse de los indices del array!
//arrayInts[100]
//arrayInts[-1]

//Para no salirnos nunca del array, preguntamos cuantos elementos
//tiene

print("El array tiene \(arrayInts.count) elementos. El indice maximo accesible es \(arrayInts.count - 1)")
arrayInts[arrayInts.count-1]


//SETS (Conjuntos)
//Almacena valores del mismo tipo sin elementos repetidos, es decir,
//cada valor solo puede aparecer una vez en el conjunto
//Dentro del <> es donde definimos el tipo de datos
var conjuntoNumeros : Set<Int> = [1,2]
var conjuntoAnimales: Set<String> = ["Perro", "Gato", "Pez"]
conjuntoAnimales.count
conjuntoAnimales.isEmpty

//Insertar un elemento
conjuntoAnimales.insert("Lobo")
print(conjuntoAnimales)

//Si se insertan elementos repetidos, se queda como esta
conjuntoAnimales.insert("Lobo")
print(conjuntoAnimales, "Los elementos repetidos no se insertan")

//Saber si el set contiene un elemento dado
if(conjuntoAnimales.contains("Lobo")){
    print("Tenemos el Lobo en el gallinero!")
}


//Iterar sobre un conjunto
//Importante: NO SE GARANTIZA EL ORDEN
for animal in conjuntoAnimales{
    print(animal)
}
print("------------recorrido ordenado alfabeticamente-----------")
//Recorrido ordenando los elementos

for animal in conjuntoAnimales.sorted() {
    print(animal)
}



//Diccionarios
//Un diccionario contiene asociaciones entre claves y valores
//cada clave (que sera unica) tendra asociado un valor
//Al definirlo, tanto las claves como los valores seran de un
//unico tipo

var diccionarioVacio: [String:String] = [:]

//Las claves son 1,2,3
var diccionarioDeNumeros: [Int:String] = [1: "Uno", 2: "Dos", 3:"Tres"]

//Las claves son "Uno", "Dos", "Tres"
var diccionarioNumeros: [String:Int] = ["Uno":1, "Dos":2, "Tres":3]

var dadosDeAlta: [String:Bool] = ["Paco":true, "Antonio":false, "Juliana":true]

diccionarioVacio.isEmpty
diccionarioVacio.count

//Acceder a un elemento usando la clave
print("Leer un elemento:")
print("Esta paco dado de alta?", dadosDeAlta["Paco"]!)
print(dadosDeAlta["blblaibal"] ?? "No existe este usuario")

//Insertar, borrar, actualizar valores de los diccionarios

//Insertar un nuevo valor (si la clave no existe,l a crea)
dadosDeAlta["Maria"] = true

//Actualizar el valor (si la clave existe, la modifica)
dadosDeAlta["Maria"] = false

//Borrar una entrada clave-valor
dadosDeAlta["Maria"] = nil
//O bien:
dadosDeAlta.removeValue(forKey: "Antonio")

print(dadosDeAlta)

//Iterar sobre todo el diccionario

for(usuario,alta) in dadosDeAlta {
    if alta {
        print("\(usuario) esta dado de alta")
    } else {
        print("\(usuario) no esta dado de alta")
    }
}
