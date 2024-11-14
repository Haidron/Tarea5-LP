% Definir los puentes (las conexiones entre los planetas).
puente(p1, c, 4).
puente(p1, p4, 1).
puente(p4, c, 3).
puente(p3, c, 2).
puente(p2, p1, 3).
puente(p10, p3, 3).
puente(p9, p10, 10).
puente(p8, p3, 8).
puente(p8, p9, 3).
puente(p10, p4, 6).
puente(p11, p4, 7).
puente(p11, p12, 3).
puente(p12, p5, 2).
puente(p5, p1, 7).
puente(p6, p2, 2).
puente(p7, p2, 3).
puente(p2, p3, 7).


% Predicado principal para encontrar todos los caminos desde un planeta S hasta el centro galáctico c
camino(S, _Res) :-  % Usamos _Res para ignorar el resultado final
    findall(Ruta, buscar_camino(S, c, [S], Ruta), Rutas),  % Encuentra todos los caminos
    maplist(invertir_y_imprimir, Rutas).  % Aplica invertir e imprimir a cada camino

% Predicado para invertir y mostrar cada lista en el formato deseado
invertir_y_imprimir(Ruta) :-
    invertir(Ruta, RutaInvertida),  % Invierte el camino
    format('RES = ~w.~n', [RutaInvertida]).  % Imprime la lista invertida en el formato solicitado

% Definición para invertir una lista
invertir([], []).  % Caso base: una lista vacía se invierte a sí misma
invertir([Cabeza|Cola], Invertida) :- 
    invertir(Cola, ColaInvertida), 
    append(ColaInvertida, [Cabeza], Invertida).

% Búsqueda recursiva en profundidad para encontrar todos los caminos
buscar_camino(S, S, Cam, [S|Cam]).  % Cuando llegamos al centro, añadimos el planeta de inicio al camino
buscar_camino(S, Dest, Visitados, Res) :- 
    puente(S, P, _),                 % Busca los planetas conectados por puentes
    \+ member(P, Visitados),         % Evita ciclos y repeticiones
    buscar_camino(P, Dest, [P|Visitados], Res).
