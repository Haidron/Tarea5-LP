% Predicado principal que verifica si una sublista dentro de una lista es es palindroma, utiliza el predicado sublista/4 para extraer la sublista
% y utliza el predicado es_palindromo/1 para realizar la verificacion una vez que ya se ha extraido la sublista
% Parametros:
% - Lista: lista de caracteres que se utilizara
% - [L, R]: son los limites de la sublista que se verificará 
esPalindroma(Lista, [L, R]) :-
    sublista(Lista, L, R, SubSegmento),
    es_palindromo(SubSegmento).

% Predicado para la sublista de una lista dada
% Parametros:
% - Lista: lista de caracteres que se utilizara
% - L: indice de la lista que sera el inicio de la sublista
% - R: indice de la lista que sera el final de la sublista
% - SubSegmento: es la sublista resultante
sublista(Lista, L, R, SubSegmento) :-
    findall(Elem, (nth1(Index, Lista, Elem), Index >= L, Index =< R), SubSegmento).


% Predicado para verificar si una lista es un palindromo, a este predicado solo se le proveera una sublista como parametro
% Parametros:
% - Lista: La lista a verificar
es_palindromo(Lista) :-
    reverse(Lista, Lista).
