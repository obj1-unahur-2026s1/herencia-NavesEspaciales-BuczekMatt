

class Nave {

  var velocidad = 0
  var direccion = 0
  var combustible = 0

  
  method cargarCombustible(unValor) {
    combustible += unValor
  }
  method descargarCombustible(unValor) {
    combustible = (combustible - unValor).max(0)
  }

  method acelerar(cuanto) {
     velocidad = (velocidad + cuanto).min(100000)
  }

  method desacelerar(cuanto) {
    velocidad = (velocidad - cuanto).max(0)
  }

  method irHaciaElSol() {
    direccion = 10
  }

  method escaparDelSol() {
    direccion = -10
  }

  method ponerseParaleloAlSol() {
    direccion = 0 
  }

  method acercarseUnPocoAlSol() {
    direccion = (direccion+1).min(10)
  }

  method alejarseUnPocoAlSol() {
    direccion = (direccion-1).max(-10)
  }  
  method prepararViaje() {
    self.cargarCombustible(30000)
    self.acelerar(5000)
  }

  method estaTarnquila() {
    return
    combustible >= 4000 &&
    velocidad <= 1200 &&
    self.condicionAdicional()
  }

  method condicionAdicional()//es abstracta
}

class NaveBaliza inherits Nave{
  var baliza

  method cambiarColorDeBaliza(colorNuevo){
    baliza = colorNuevo
  }
  method baliza()= baliza

  override method prepararViaje() {
    super()
    self.cambiarColorDeBaliza("verde")
    self.ponerseParaleloAlSol()
  }

  override method condicionAdicional(){
    return baliza != "rojo"
  }//el super sobreescribe. de esta forma no esta sobreescripto
  
}

class NaveDePasajeros inherits Nave{
  const pasajeros
  var comida
  var bebida

  method cargarComdida(unValor) {
    comida += unValor
  }

  method cargarBebida(unValor) {
    bebida += unValor
  }

  override method prepararViaje() {
    super()
    self.cargarComdida(4 * pasajeros)
    self.cargarBebida(6 * pasajeros)
    self.acercarseUnPocoAlSol() 
  }
  override method condicionAdicional(){
    return true
  }
}

class NaveDeCombate inherits Nave{
 var estaVisible = true
 var misilesDesplegados = false
 const mensajes = []
 method ponerseVisible() {estaVisible = true}
 method PonerseInvisible() {estaVisible = false}
 method estaInvisible() = !estaVisible
 method desplegarMisiles() { misilesDesplegados = true}
 method replegarMisiles() { misilesDesplegados = false}
 method misilesDesplegados() = misilesDesplegados
 method emitirMensaje(unMensaje) {mensajes.add(unMensaje)}
 method mensajesEmitidos() = mensajes
 method primerMensajeEmitido() = mensajes.first()
 method ultimoMensajeEmitido()= mensajes.last()
 method esEscueta() = !mensajes.any({m => m.legth() >30 })

 override method prepararViaje(){
    super()
    self.ponerseVisible()
    self.replegarMisiles()
    self.acelerar(15000)
    self.emitirMensaje("saliendo en mision")
  } 

 override method condicionAdicional() = !misilesDesplegados
}

class NaveHospital inherits NaveDePasajeros{
  var tienePreparadosQuirofanos = false
  method prepararQuirofanos() {tienePreparadosQuirofanos = true}
  method inhabilitarQuirofanos() {tienePreparadosQuirofanos = false}
  method tienePreparadosQuirofanos() =tienePreparadosQuirofanos
}

class NaveDeCombateSigilosa inherits NaveDeCombate {
  override method condicionAdicional() {
    return
    super() && estaVisible
  }
}