# DISEÑO — Fishmaboolla (nombre de trabajo)

Fuente de verdad del diseño. Marcas:
- [DECIDIDO] lo decidió el humano.
- [PROPUESTA] lo sugirió Claude y no está confirmado.
- [ABIERTO] sin decidir. Si algo está abierto, se pregunta; Claude no decide.

## 1. Concepto
- [DECIDIDO] Reinterpretación moderna de *Pang* + pesca exprés + progresión roguelike. Arcade 2D rápido, frenético, centrado en game feel y dopamina.
- [DECIDIDO] El juego tiene que sentirse como un Pang con aire de bullet hell: arena grande y cámara alejada, con muchas bolas que leer y esquivar.
- [DECIDIDO] Protagonista: marinero gallego da Mariña, chubasquero amarillo.
- [DECIDIDO] Enemigos: gaviotas y aves marinas que atacan lanzando bolas al jugador. Van mutando de lo costero a lo cósmico según avanzan los Actos.
- [DECIDIDO] Las bolas siguen la física parabólica de rebote estilo Pang. El jugador les dispara con el arpón vertical; al impactar se dividen en dos y siguen rebotando, hasta que se rompen del todo.
- [DECIDIDO] Trama: el protagonista es un pescador de la Mariña gallega que solo quiere pescar tranquilo; las aves quieren robarle los peces y ahí empieza el conflicto. El tono va escalando hacia la paranoia y la locura.
- [DECIDIDO] En cada zona hay un ave enorme como amenaza, pero no se ve en pantalla hasta la fase final (boss) de la zona. En el boss se ve arriba, lanzando ataques que modifican mucho el patrón de las bolas.
- [DECIDIDO] Las bolas caen del techo y de todas las esquinas. Se diseñan patrones que hagan la partida interesante y desafiante: el juego es una versión extraña de bullet hell, con el jugador esquivando y disparando.
- [ABIERTO] Qué patrones concretos hay, con qué ritmo y cómo escalan por Acto.
- [DECIDIDO] El boss y el mini-boss, además de lanzar bolas, tienen vida propia y el jugador tiene que dañarlos para vencerlos. Algunas de sus bolas se pueden romper; otras solo se esquivan, porque no se quedan permanentes en pantalla.
- [ABIERTO] Ataques concretos del boss y del mini-boss, y cómo se les hace daño (arpón directo, bolas devueltas...).
- [DECIDIDO] El Acto termina al matar al boss (ver sección 7).
- [ABIERTO] Título final del juego.
- [ABIERTO] Plataforma objetivo (PC/Steam, móvil...).

## 2. Movimiento del marinero
- [DECIDIDO] Movimiento lateral rápido + salto con gravedad (arco parabólico). La diagonal sale de moverse en horizontal mientras se está en el aire. No es vuelo libre.
- [DECIDIDO] Dash con i-frames.
- [DECIDIDO] El dash se activa con doble tap de izquierda o derecha (A-A / D-D), no con un botón propio.
- [PROPUESTA] Dash solo horizontal, anula la gravedad mientras dura, con cooldown corto. Ventana de doble tap ~0.25 s.
- [ABIERTO] Plataformas intermedias en las salas (no se sabe aún). Si las hay, son solo para el jugador.

## 3. Bolas (física Pang)
- [DECIDIDO] Las bolas solo rebotan contra los límites exteriores de la sala. Nunca contra plataformas, aunque las haya.
- [DECIDIDO] Al recibir impacto del arpón, la bola se divide en dos más pequeñas.
- [PROPUESTA] Gravedad constante y altura de rebote fija por tamaño (tier), para que los arcos sean memorizables. 3 tamaños; el más pequeño muere sin dividirse. Las pequeñas van más rápido.
- [PROPUESTA] Las hijas salen en direcciones horizontales opuestas.

## 4. Arpón
- [DECIDIDO] Disparo de arpón vertical: un proyectil en línea recta hacia arriba.
- [DECIDIDO] No hay límite de arpones en pantalla: el único freno es un cooldown ligero entre disparos. El juego tiene que ser más rápido y dopamínico que el Pang original. Los valores se ajustan probando.
- [PROPUESTA] El arpón se detiene en el primer impacto (como el Pang original). La perforación sería un buff, no el comportamiento base.
- [PROPUESTA] Cooldown de partida ~0.25 s (a ajustar probando).
- [ABIERTO] ¿Carga o combo?

## 5. Pesca táctica on-the-fly
- [DECIDIDO] En cualquier momento del combate el jugador puede pararse y clavar la caña en el suelo (aparece una fisura/charco).
- [DECIDIDO] La pesca es el bucle principal y ocurre todo el rato: el jugador tiene que optimizar su tiempo y sus habilidades para pescar mientras esquiva bolas, también entre oleadas.
- [DECIDIDO] QTE ultra rápido, 1.0–1.5 s máximo.
- [DECIDIDO] Si acierta: hitstop inmediato → zoom dramático a la boca del marinero → el pez se engulle de un bocado → si es nuevo, pausa breve con la carta del pez; si ya lo tiene, sube de nivel (stack I/II/III) → onda expansiva que empuja ligeramente a las aves hacia arriba.
- [DECIDIDO] Se puede cancelar la pesca con dash (penalización de cooldown).
- [DECIDIDO] Riesgo/recompensa: pescar con aves activas da peces de combate agresivos; pescar entre oleadas da peces de sustento/seguros.
- [ABIERTO] Cómo se decide qué pez sale (pool por contexto, rareza, elección...).
- [ABIERTO] Tipo concreto de QTE (timing, pulsación, dirección...).

## 6. Peces, buffs, stacks y fusiones
- [DECIDIDO] Cada pez es un buff. ~6–8 arquetipos mecánicos base. Los 6 definidos:
  1. Rayo en cadena
  2. Congelación / Slow
  3. Perforación / Sierra
  4. Escudo
  5. Onda repulsora
  6. Multidisparo
- [ABIERTO] Arquetipos 7 y 8.
- [DECIDIDO] Sin re-skin por Acto: cada arquetipo tiene identidad fija en todo el juego. Cada tier (I → II → III) lo hace más espectacular.
- [DECIDIDO] Fusiones estilo Ball x Pit: combinar dos arquetipos da un buff nuevo.
- [ABIERTO] Requisito de fusión (¿ambos a III?), qué parejas fusionan, si libera slots.
- [ABIERTO] Curva de escalado de stacks.
- [PROPUESTA] Cómo funciona cada arquetipo:
  - Rayo: al reventar una bola, descarga que salta a las cercanas.
  - Congelación: las bolas cercanas al impacto se ralentizan o congelan un instante.
  - Perforación: el arpón atraviesa varias bolas.
  - Escudo: absorbe golpes.
  - Onda: empuja las bolas lejos del jugador.
  - Multidisparo: 2–3 arpones en abanico.
- [PROPUESTA] Ejemplos de fusión: Rayo+Congelación = granizo; Perforación+Multidisparo = abanico de sierras; Escudo+Onda = escudo que al romperse suelta onda; Rayo+Onda = pulso eléctrico. Con 4–5 fusiones basta para empezar.

## 7. Estructura de la run
- [DECIDIDO] 5 Actos: 1 Muelle/Ría, 2 Mar Bravo, 3 Santa Compaña/Estratosfera, 4 Órbita Abisal, 5 El Vacío/A Nada.
- [DECIDIDO] Sin salas. Cada Acto es una sola pantalla que se juega del tirón, sin cambios de escena, con el flow de *Ball x Pit*: entras, juegas y las cosas van apareciendo.
- [DECIDIDO] Estructura de un Acto: tanda de bolas → descanso → tanda de bolas → mini-boss → descanso → tanda de bolas → boss. Al matar al boss, el Acto se acaba.
- [DECIDIDO] Duración objetivo de un Acto: ~20 minutos (orientativo, a ajustar probando). Se juega seguido, sin puntos de guardado a mitad.
- [DECIDIDO] Cada Acto empieza con la build a 0 (como Ball x Pit o Isaac). Los buffs no pasan de un Acto al siguiente.
- [DECIDIDO] Al acabar un Acto se vuelve al menú o al punto de espera que tengamos, y desde ahí se juega el siguiente.
- [ABIERTO] Qué es ese punto de espera (menú simple, hub, mapa...) y si los Actos se desbloquean en orden o se pueden elegir.
- [DECIDIDO] Descansos: en pantalla nada ataca y el jugador tiene entre 30 y 60 s para pescar todo lo que pueda. Cuántos buffs saca depende de su habilidad, porque la pesca es un minijuego de reflejos y velocidad.
- [PROPUESTA] La duración de cada descanso, el número de tandas y de bolas por tanda van como datos, para ajustarlos sin tocar código.
- [DECIDIDO] No hay apuestas. Con las pescas de los descansos y las del medio ya hay suficiente dopamina, y no hay que saturar al jugador.
- [PROPUESTA] Primer objetivo jugable: vertical slice con 2 Actos, no los 5.

## 8. Vida, daño y derrota
- [DECIDIDO] El marinero tiene 3 vidas. Cada bola que le toca le quita una.
- [DECIDIDO] Al perder las 3 vidas se acaba y hay que volver a empezar.
- [PROPUESTA] Al perder se pierde el Acto y se repite desde 0, con la build a 0. No hay snapshot de la build ni checkpoints (el humano descartó volver con los mismos buffos).
- [DECIDIDO] Los escudos y otros buffs dan más margen ante los toques.
- [PROPUESTA] Tras un toque, ~1 s de invulnerabilidad (con parpadeo) para no perder varias vidas de golpe.
- [ABIERTO] Si algo se conserva al perder (peces descubiertos, cartas...) o no se conserva nada.

## 9. Arte
- [DECIDIDO] Todo el arte lo dibuja el humano a mano. Nada de arte con IA. Mientras tanto, programmer art por código. El arte final entra cambiando rutas en los datos.
- [PROPUESTA] Dibujo en papel con tinta gruesa, escaneado y coloreado en digital (Krita). Estilo suelto, brutalista. Dibujar las piezas sueltas si se van a animar.
- [ABIERTO] Método de animación (al humano no le convence la animación por huesos).

## 10. Pilares
- [PROPUESTA] Dopamina inmediata, riesgo elegido por el jugador, lectura clara del caos, pocos arquetipos con mucha profundidad, sesiones cortas.
