# DISEÑO — Fishmaboolla (nombre de trabajo)

Fuente de verdad del diseño. Marcas:
- [DECIDIDO] lo decidió el humano.
- [PROPUESTA] lo sugirió Claude y no está confirmado.
- [ABIERTO] sin decidir. Si algo está abierto, se pregunta; Claude no decide.

## 1. Concepto
- [DECIDIDO] Reinterpretación moderna de *Pang* + pesca exprés + progresión roguelike. Arcade 2D rápido, frenético, centrado en game feel y dopamina.
- [DECIDIDO] Protagonista: marinero gallego da Mariña, chubasquero amarillo.
- [DECIDIDO] Enemigos: gaviotas y aves marinas que botan por la pantalla con física parabólica de rebote estilo Pang y se dividen en dos al ser impactadas por el arpón vertical. Van mutando de lo costero a lo cósmico según avanzan los Actos.
- [ABIERTO] Título final del juego.
- [ABIERTO] Plataforma objetivo (PC/Steam, móvil...).

## 2. Movimiento del marinero
- [DECIDIDO] Movimiento lateral rápido + salto con gravedad (arco parabólico). La diagonal sale de moverse en horizontal mientras se está en el aire. No es vuelo libre.
- [DECIDIDO] Dash con i-frames.
- [DECIDIDO] El dash se activa con doble tap de izquierda o derecha (A-A / D-D), no con un botón propio.
- [PROPUESTA] Dash solo horizontal, anula la gravedad mientras dura, con cooldown corto. Ventana de doble tap ~0.25 s.
- [ABIERTO] Plataformas intermedias en las salas (no se sabe aún). Si las hay, son solo para el jugador.

## 3. Bolas / aves (física Pang)
- [DECIDIDO] Las bolas solo rebotan contra los límites exteriores de la sala. Nunca contra plataformas, aunque las haya.
- [DECIDIDO] Al recibir impacto del arpón, la bola se divide en dos más pequeñas.
- [PROPUESTA] Gravedad constante y altura de rebote fija por tamaño (tier), para que los arcos sean memorizables. 3 tamaños; el más pequeño muere sin dividirse. Las pequeñas van más rápido.
- [PROPUESTA] Las hijas salen en direcciones horizontales opuestas.

## 4. Arpón
- [DECIDIDO] Disparo de arpón vertical.
- [PROPUESTA] El arpón se detiene en el primer impacto (como el Pang original). La perforación sería un buff, no el comportamiento base.
- [PROPUESTA] Cooldown corto entre disparos (~0.35 s).
- [ABIERTO] ¿Carga, combo o límite de arpones en pantalla?

## 5. Pesca táctica on-the-fly
- [DECIDIDO] En cualquier momento del combate el jugador puede pararse y clavar la caña en el suelo (aparece una fisura/charco).
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
- [DECIDIDO] Salas X-1 a X-5 (Acto 5 hasta 5-6). Mini-boss en X-3, boss en X-5 (5-6 en el Acto 5).
- [DECIDIDO] Al terminar un Acto la build se resetea a 0.
- [ABIERTO] Revisar si se mantiene el reset ahora que no hay re-skin (lo planteó Claude: puede hacerse repetitivo).
- [DECIDIDO] Entre niveles hay apuestas condicionadas al rendimiento de la sala anterior (sin daño, pesca perfecta...).
- [ABIERTO] Diseño concreto de las apuestas y su nombre dentro del juego.
- [PROPUESTA] Primer objetivo jugable: vertical slice con 2 Actos, no los 5.

## 8. Vida, daño y derrota
- [ABIERTO] Vida del jugador, qué pasa al tocar una bola, game over. No se ha hablado todavía.

## 9. Arte
- [DECIDIDO] Todo el arte lo dibuja el humano a mano. Nada de arte con IA. Mientras tanto, programmer art por código. El arte final entra cambiando rutas en los datos.
- [PROPUESTA] Dibujo en papel con tinta gruesa, escaneado y coloreado en digital (Krita). Estilo suelto, brutalista. Dibujar las piezas sueltas si se van a animar.
- [ABIERTO] Método de animación (al humano no le convence la animación por huesos).

## 10. Pilares
- [PROPUESTA] Dopamina inmediata, riesgo elegido por el jugador, lectura clara del caos, pocos arquetipos con mucha profundidad, sesiones cortas.
