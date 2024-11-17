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

% Predicado que encuentra y muestra todas las rutas desde el planeta S hasta el centro galáctico c.
% Utiliza el predicado buscar_camino/4 para encontrar caminos invertidos, los invierte y los imprime.
% Parametros:
% - S: Nodo de inicio (planeta de origen).
% - Res: Camino desde S hasta c, representado como una lista de nodos.
camino(S, Res) :-  
    buscar_camino(S, c, [S], RutaInvertida), 
    invertir(RutaInvertida, Res),          
    format('RES = ~w.~n', [Res]),           
    fail.                                   
camino(_, _).


% Predicado que busca un camino desde el nodo S al nodo Dest, evitando nodos ya visitados.
% - S: Nodo de inicio (actual).
% - Dest: Nodo de destino.
% - Visitados: Lista de nodos visitados para evitar ciclos.
% - Res: Camino encontrado como una lista de nodos en orden inverso.
buscar_camino(S, S, Cam, Cam).  
buscar_camino(S, Dest, Visitados, Res) :- 
    puente(S, P, _),                  
    \+ member(P, Visitados),         
    buscar_camino(P, Dest, [P|Visitados], Res).

% Invierte una lista de elementos utilizando recursión.
% - Lista: Lista original que se desea invertir, la divide en [Cabeza|Cola], y la reduce hasta dejarla vacia []
% - Invertida: Lista resultante con los elementos en orden inverso.
invertir([], []).  
invertir([Cabeza|Cola], Invertida) :- 
    invertir(Cola, ColaInvertida), 
    append(ColaInvertida, [Cabeza], Invertida).

% Encuentra todas las rutas desde S hasta el centro galáctico c, calculando el combustible restante en cada paso.
% Parámetros:
% - S: Planeta de inicio.
% - V: Combustible inicial.
% - _Res: Variable donde se almacenan los resultados
combustible(S, V, _Res) :- 
    findall(Ruta, calcular_combustible(S, V, [[S, V]], Ruta), Rutas),
    maplist(imprimir_ruta, Rutas).


% Calcula el camino y el combustible restante en cada paso.
% Parámetros:
% - S: Nodo actual (planeta).
% - V: Combustible restante en este punto.
% - Cam: Camino actual con el combustible restante en cada paso.
% - Res: Resultado final del camino con los valores de combustible.
calcular_combustible(c, _, Cam, Cam). 
calcular_combustible(S, V, Cam, Res) :-
    puente(S, P, W),              
    VRestante is V - W,           
    VRestante >= 0,               
    \+ member([P, _], Cam),       
    calcular_combustible(P, VRestante, [[P, VRestante] | Cam], Res).


% imprimir_ruta(Ruta)
% Invierte e imprime una ruta con formato.
% Parámetros:
% - Ruta: Ruta a invertir e imprimir.
imprimir_ruta(Ruta) :-
    reverse(Ruta, RutaInvertida), 
    format('RES = ~w.~n', [RutaInvertida]).