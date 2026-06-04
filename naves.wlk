

class Nave {

  var velocidad = 0
  var direccion = 0
  var combustible = 0

  method velocidad() = velocidad
  method direccion() = direccion
  method combustible() = combustible

  
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

  method estaTranquila() {
    return combustible >= 4000 &&
    velocidad <= 12000 &&
    self.condicionAdicional()
  }

  method condicionAdicional()//es abstracta
  method recibirAmenaza() {
    self.escapar()
    self.avisar()
  }
  method escapar() 
  method avisar() 
  method estaDeRelajo() {
    return
    self.estaTranquila()
    && self.tienePocaActividad()
  }
  method tienePocaActividad() = true
}

class NaveBaliza inherits Nave{
  var baliza = "azul"
  var cambioDeColor = false

  method cambiarColorDeBaliza(colorNuevo){
    baliza = colorNuevo
    cambioDeColor = true
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
  
  override method escapar() {
    self.irHaciaElSol()
  }

  override method avisar() {
    self.cambiarColorDeBaliza("rojo")
  }
  override method tienePocaActividad()= !cambioDeColor
}

class NaveDePasajeros inherits Nave{
  const pasajeros = 0
  var comida = 0
  var bebida = 0
  var cantidadRacionesComidaServidas = 0

  method comida() = comida
  method bebida() = bebida

  method cargarComdida(unValor) {
    comida += unValor
  }

  method cargarBebida(unValor) {
    bebida += unValor
  }
  method consumirComida(unValor) {
    comida = (comida - unValor).max(0)
    cantidadRacionesComidaServidas += unValor 
  }
  method consumirBebida(unValor) {
    bebida = (bebida - unValor).max(0)
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
  override method escapar(){
    self.acelerar(velocidad)
  }
  override method avisar() {
    self.consumirComida(pasajeros)
    self.consumirBebida(pasajeros*2)
  }
  override method tienePocaActividad() {
    return cantidadRacionesComidaServidas < 50
  }

}

class NaveDeCombate inherits Nave{
 var estaVisible = true
 var misilesDesplegados = false
 const mensajes = []
 method ponerseVisible() {estaVisible = true}
 method ponerseInvisible() {estaVisible = false}
 method estaInvisible() = !estaVisible
 method desplegarMisiles() { misilesDesplegados = true}
 method replegarMisiles() { misilesDesplegados = false}
 method misilesDesplegados() = misilesDesplegados
 method emitirMensaje(unMensaje) {mensajes.add(unMensaje)}
 method mensajesEmitidos() = mensajes
 method primerMensajeEmitido() = mensajes.first()
 method ultimoMensajeEmitido()= mensajes.last()
 method esEscueta() = !mensajes.any({m => m.length() > 30 })
 method estaVisible() = estaVisible

 override method prepararViaje(){
    super()
    self.ponerseVisible()
    self.replegarMisiles()
    self.acelerar(15000)
    self.emitirMensaje("saliendo en mision")
  } 

 override method condicionAdicional() = !misilesDesplegados

 override method escapar(){
    self.acercarseUnPocoAlSol()
    self.acercarseUnPocoAlSol()
 }
 override method avisar() {
    self.emitirMensaje("Amenaza recibida")
 }
 method emitioMensaje(unMensaje) {
  return mensajes.contains(unMensaje)
 }

}

class NaveHospital inherits NaveDePasajeros{
  var tienePreparadosQuirofanos = false
  method prepararQuirofanos() {tienePreparadosQuirofanos = true}
  method inhabilitarQuirofanos() {tienePreparadosQuirofanos = false}
  method tienePreparadosQuirofanos() = tienePreparadosQuirofanos
  override method condicionAdicional() {
    return !self.tienePreparadosQuirofanos()
  }

  override method recibirAmenaza() {
    super()
    self.prepararQuirofanos()
  }
}

class NaveDeCombateSigilosa inherits NaveDeCombate {
  override method condicionAdicional() {
    return super() && estaVisible
  }

  override method escapar() {
    super()
    self.desplegarMisiles()
    self.ponerseInvisible()
  }
}