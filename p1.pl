esPalindroma(Lista, [L, R]) :-
    sublista(Lista, L, R, SubSegmento),
    es_palindromo(SubSegmento).

sublista(Lista, L, R, SubSegmento) :-
    findall(Elem, (nth1(Index, Lista, Elem), Index >= L, Index =< R), SubSegmento).


es_palindromo(Lista) :-
    reverse(Lista, Lista).
