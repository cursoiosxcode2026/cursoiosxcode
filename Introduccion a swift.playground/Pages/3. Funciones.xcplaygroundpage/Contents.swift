import Foundation

//FUNCIONES

//Declaración basica de funcion
func saludar() {
    print("Hola")
}

saludar()

//El scope de la variable que pasamos como parámetro
//solo es válido dentro del ámbito de la funcion, o sea, entre las
//llaves {}
func saludarA(persona: String) {
    print("Hola, \(persona)")
}

saludarA(persona: "Marcos")

//Si al llamar a la funcion queremos omitir el nombre del parametro,
//lo hacemos usando _
func saludarAOtraPersona (_ persona: String) {
    print("Hola, \(persona)")
}

saludarAOtraPersona("Antonio")

//Funciones que devuelven un valor y reciben varios parametros
//separados por comas

func sumar(a: Int, b: Int) -> Int {
    
    var resultado = a + b
    return resultado
}

print(sumar(a: 10, b: 5))


//Funciones que devuelven varios valores
//para ello podemos usar las tuplas

//Ejemplo: una funcion que calcula la division entera y el resto

func calculaDivisionResto(dividendo: Int, divisor: Int) -> (division: Int, resto: Int) {
    let division = dividendo / divisor
    let resto = dividendo % divisor
    return (division, resto)
    
}

let resultado = calculaDivisionResto(dividendo: 10, divisor: 3)

print("La división vale: \(resultado.division) y el resto vale: \(resultado.resto)")


//Funciones con return implicito

func saludo2(_ persona: String) -> String {
    
    "Hola de nuevo, \(persona)"
    //Es lo mismo que usando el return. Es valido SOLO cuando
    //la funcion tiene una unica expresion
}
print(saludo2("Patricia"))

//Funciones con parámetros por defecto
//En este caso, el parametro serEducado toma el valor true salvo
//que se especifique otro valor al llamar a la funcion

func saludarEducadamente(nombre : String, serEducado: Bool = true) {
    
    if serEducado {
        print("Saludos, estimado/a \(nombre)")
    } else {
        print("Dejame en paz \(nombre)")
    }
}
    
saludarEducadamente(nombre: "Maria")
saludarEducadamente(nombre: "Ana", serEducado: false)

//Funciones con parámetros variables (de cero o "N" parametros),
//Usando la sintaxis "..."
func calcularSuma(_ numeros: Int...) -> Int{
    var acumulado = 0
    //Si hemos llamado a la funcion con parametros (1,3,5)
    //la variable "numero" cogerá cada uno de los valores 1,3,5
    for numero in numeros {
        print(numero)
        acumulado = acumulado + numero
    }
    
    return acumulado
}

print(calcularSuma(1,2,3,4,-5))


//Funciones como variables y tipos de funcion
//func sumar(a: Int, b: Int) -> Int {
//var resultado = a + b
//return resultado
//}
func restar (a:Int, b:Int) -> Int {a - b}

funcionGenerica = restar
//funcionGenerica es una Variable a la que le puede asignar
// funciones que reciban dos parametros de entrada tipo Int
//y uno de salida tipo Int, dado que esta definida como: (Int,Int)
//->Int

var funcionGenerica:(Int, Int) -> Int = sumar
print("Llamada a funcionGenerica cuando esta asignada a sumar")
print(funcionGenerica(3,3))

funcionGenerica = restar
print("Llamada a funcionGenerica cuando esta asignada a restar")
print(funcionGenerica(3,3))


func usarFuncionMatematica(_ funcion: (Int,Int) -> Int, a: Int,b:Int) -> Int{
    return funcion(a,b)
}
usarFuncionMatematica(sumar,a:2,b:3)
usarFuncionMatematica(restar, a: 5, b:3 )


