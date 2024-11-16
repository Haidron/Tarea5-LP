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


camino(S, _Res) :-  
    findall(Ruta, buscar_camino(S, c, [S], Ruta), Rutas),  
    maplist(invertir_y_imprimir, Rutas). 


invertir_y_imprimir(Ruta) :-
    invertir(Ruta, RutaInvertida),  
    format('RES = ~w.~n', [RutaInvertida]).  


invertir([], []).  
invertir([Cabeza|Cola], Invertida) :- 
    invertir(Cola, ColaInvertida), 
    append(ColaInvertida, [Cabeza], Invertida).


buscar_camino(S, S, Cam, [S|Cam]).  
buscar_camino(S, Dest, Visitados, Res) :- 
    puente(S, P, _),                 
    \+ member(P, Visitados),         
    buscar_camino(P, Dest, [P|Visitados], Res).


combustible(S, V, _Res) :- 
    findall(Ruta, calcular_combustible(S, V, [[S, V]], Ruta), Rutas),
    maplist(imprimir_ruta, Rutas).

calcular_combustible(c, _, Cam, Cam). 
calcular_combustible(S, V, Cam, Res) :-
    puente(S, P, W),              
    VRestante is V - W,           
    VRestante >= 0,               
    \+ member([P, _], Cam),       
    calcular_combustible(P, VRestante, [[P, VRestante] | Cam], Res).

imprimir_ruta(Ruta) :-
    reverse(Ruta, RutaInvertida), 
    format('RES = ~w.~n', [RutaInvertida]).