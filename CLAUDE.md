# CLAUDE.md — Fishmaboolla

Reglas obligatorias del proyecto. Léelo siempre al empezar una sesión.

## Qué es
Arcade 2D tipo *Pang* + pesca exprés + progresión roguelike. Marinero gallego, gaviotas que botan y se dividen. Diseño completo en `docs/DISENO.md` (fuente de verdad).

## Reparto de roles
- El humano diseña, decide y dibuja todo el arte a mano. Tú escribes el código.
- **Nada de arte con IA.** Mientras no hay arte, "programmer art": formas dibujadas por código (`_draw()`, polígonos, rectángulos). El arte final entra cambiando rutas en los datos, sin tocar código.
- El humano trabaja casi todo desde una tablet Android (editor de Godot para Android + Termux con git). No asumas escritorio.
- Tú trabajas en un entorno cloud con el repo clonado y el motor en modo headless para validar.

## Stack
- Godot **4.7.2** (la del editor Android del humano). No uses APIs más nuevas ni asumas otra versión.
- Solo GDScript **tipado** (`var x: float`, `func f() -> void`). Sin addons que requieran compilar.
- Escenas en formato texto (`.tscn`). Resources en texto (`.tres`).
- Renderer: Compatibility (es el que funciona bien en Android).
- Nombres de propiedades de Godot 4 exactos (ej. `Camera2D.enabled`, no `current`). Si dudas de un nombre o una señal, compruébalo en headless en vez de suponerlo.
- Una escena arrastrada al árbol se instancia como nodo; arrastrada a un campo `PackedScene` del inspector queda como referencia. Ya causó un bug.
- Los `Control` (ColorRect, ReferenceRect, Label...) dentro de escenas de juego llevan `mouse_filter = Ignore` (2). Por defecto son `Stop` y se comen los clics y toques del juego.
- En `.tscn` escritos a mano, las propiedades que apuntan a nodos necesitan `node_paths=PackedStringArray("propiedad")` en la cabecera del nodo.

## Estructura del repo
- `CLAUDE.md` (este archivo).
- `docs/DISENO.md`: diseño, fuente de verdad. Cada punto lleva una marca:
  - [DECIDIDO]: lo decidió el humano.
  - [PROPUESTA]: lo sugirió Claude y no está confirmado.
  - [ABIERTO]: sin decidir. Si algo está abierto, pregunta; no decidas por él.
- `docs/IDEAS.md`: las ideas nuevas van aquí, no al código. El diseño está congelado hasta que el tramo actual sea jugable.
- `scripts/` por áreas: `jugador/`, `mundo/`, `enemigos/`, `skills/`, `efectos/`, `datos/` (clases de Resource). Añade `red/` solo si se decide multijugador.
- `scenes/`: pocas escenas, en texto.
- `data/`: todo el contenido (peces, enemigos, skills...) como Resources `.tres` con ID. Nunca código por ítem.
- `art/`: PNG del humano.
- `tmp_tests/`: escenas y scripts de prueba temporales. Se borran antes del commit.

## Principios de código
- Lógica separada de lo visual. Posición, vida y cooldowns en un lado; sprites y efectos en otro.
- El input son órdenes ("saltar", "disparar") que ejecuta la lógica. Input solo por acciones del Input Map, nunca por tecla concreta.
- Los valores de feel (duraciones, alturas, cooldowns, daños, alcances) como `@export` o en un Resource, para que el humano los ajuste en el inspector sin pedirte nada.
- Contenido por datos con ID, para añadir cosas sin tocar código.
- **Todo lo que el humano vaya a diseñar o retocar a mano en el editor va en escenas `.tscn` editables**: salas, mapas, decorado, el marinero, enemigos, UI. Nodos con nombres claros, jerarquía simple, valores en el inspector (`@export`) y piezas visuales como nodos sueltos (Sprite2D, Polygon2D...) para que se puedan mover, cambiar y animar sin tocar código. Prohibido montar por código una sala o un mapa que luego haya que diseñar.
- Los nodos por código solo para lo que no se diseña a mano: spawns dinámicos, efectos temporales, lógica interna. Si dudas entre código y escena, escena.
- Las escenas las puede estar editando el humano a la vez: trabaja en rama, avisa de qué `.tscn` tocas y no reescribas una escena entera sin necesidad. Los scripts de prueba (`tmp_tests/`) pueden montar nodos por código.
- Multijugador: el diseño no lo menciona. Si se decide, se hace desde el día 1 (lista de jugadores, nunca uno global; host autoritativo; eventos en lugar de estado por frame).

## Git
- Una rama por fase (`fase-1-movimiento`, `fase-2-combate`...). Un commit por tarea. No se mezclan tareas.
- Tú: escribes, pruebas, commit y push a la rama. El humano: pull en Termux, prueba, ajusta valores en el inspector y hace push de lo suyo.
- Antes de continuar, el humano sube sus cambios del inspector. Respétalos, no los pises.
- Avisa siempre de qué escenas has tocado.
- Los comandos de terminal para el humano van SIEMPRE en bloque de código.
- Cuando el humano tenga que tocar nodos en el editor, dale la jerarquía completa en un bloque fijo (Tipo — Nombre, propiedades, hijos, ruta de guardado).

## Cómo trabajar cada tarea
1. Di en una frase lo que vas a hacer y empieza. Si la petición es clara, no pidas permiso.
2. Tareas pequeñas, cada una termina en algo que corre. Una tarea = un commit.
3. Valida en headless: `godot --headless --path . --import` y luego `godot --headless --path . --quit-after 60`. Debe terminar sin errores de parseo ni de carga.
4. Prueba en ejecución con escenas temporales scripteadas (spawns, daño, movimiento, skills). No des por bueno algo que solo compila.
5. Si algo es incierto, compruébalo en lugar de suponerlo.
6. Commit con mensaje claro y push de la rama.
7. Informa en pocas líneas: qué hay nuevo, cómo hacer pull (comandos en bloque), qué puede ajustar y dónde, y qué queda sin probar o sin pulir. Sin vender de más.

## Tono
- Español, directo, sin relleno, sin tono corporativo ni "pulido de IA". Paso a paso, aprendiendo construyendo.
- Sé crítico: avisa de riesgos y contradicciones con el diseño, da tu opinión honesta y no te limites a decir que sí.
- Si el humano pregunta "¿qué opinas?", responde con opinión y no hagas nada hasta que lo pida.
- Preguntas de diseño de una en una. Nunca decidas por él un punto [ABIERTO].

## Sesiones
El humano dice "inicio" / "fin sesión". Al terminar, apuntar lo hecho.

## Hoja de ruta
Primero lo que hace el juego jugable y divertido (movimiento, combate, enemigos), luego el mundo y el contenido, y el loot o la progresión al final. Hasta que el tramo actual no sea divertido, no se avanza al siguiente.
