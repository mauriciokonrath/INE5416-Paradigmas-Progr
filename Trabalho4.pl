%https://swish.swi-prolog.org/example/examples.swinb
%https://rachacuca.com.br/logica/problemas/black-friday/
% solucao(L).

%cores das camisetas
camiseta(amarela).
camiseta(azul).
camiseta(branca).
camiseta(verde).
camiseta(vermelha).

%nomes
nome(anita).
nome(clara).
nome(fernanda).
nome(marietta).
nome(rosana).

%produtos
produto(celular).
produto(fogao).
produto(geladeira).
produto(notebook).
produto(tv).

%descontos
desconto(30).
desconto(40).
desconto(50).
desconto(60).
desconto(70).

%idades
idade(22).
idade(29).
idade(31).
idade(36).
idade(43).

%acompanhantes
companhia(irmao).
companhia(marido).
companhia(namorado).
companhia(pai).
companhia(tio).

% X está entre Y e Z (em qualquer posição no meio)
entre(X,Y,Z,Lista) :- aEsquerda(X,Z,Lista), aDireita(X,Y,Lista).

% X está à esquerda de Y (em qualquer posição à esquerda)
aEsquerda(X,Y,Lista) :- nth0(IndexX,Lista,X),
                        nth0(IndexY,Lista,Y),
                        IndexX < IndexY.

% X está à direita de Y (em qualquer posição à direita)
aDireita(X,Y,Lista) :- aEsquerda(Y,X,Lista).

%X está à direita de Y, se y está à esquerda de X
aDireita(X,Y,Lista) :- aEsquerda(Y,X,Lista).

%X está à ao lado de Y
aoLado(X,Y,Lista) :- nextto(X,Y,Lista);nextto(Y,X,Lista).

%X está no canto se ele é o primeiro ou o último da lista
ponta(X,Lista) :- last(Lista,X).
ponta(X,[X|_]).

% Verifica se X esta na 1a posição
primeira(X,[X|_]).

% Verifica se todos os elementos da lista sao diferentes
todosDiferentes([]).
todosDiferentes([H|T]) :- not(member(H,T)), todosDiferentes(T).

solucao(ListaSolucao) :-
    ListaSolucao = [
     comprador(Camiseta1, Nome1, Produto1, Desconto1, Idade1, Companhia1),
     comprador(Camiseta2, Nome2, Produto2, Desconto2, Idade2, Companhia2),
     comprador(Camiseta3, Nome3, Produto3, Desconto3, Idade3, Companhia3),
     comprador(Camiseta4, Nome4, Produto4, Desconto4, Idade4, Companhia4),
     comprador(Camiseta5, Nome5, Produto5, Desconto5, Idade5, Companhia5)   
    ], 

% A cliente de camiseta Azul está em algum lugar entre a cliente que está acompanhada do Irmão e a cliente mais nova, nessa ordem.
entre(comprador(azul,_,_,_,_,_), comprador(_,_,_,_,_,irmao), comprador(_,_,_,_,22,_), ListaSolucao),

% A mulher de Vermelho está ao lado da mulher que está comprando um Fogão.
aoLado(comprador(vermelho,_,_,_,_,_), comprador(_,_,fogao,_,_,_), ListaSolucao),

% Anita está exatamente à esquerda de quem conseguiu um desconto de 50%.
aoLado(comprador(_,anita,_,_,_,_), comprador(_,_,_,50,_,_), ListaSolucao),
aEsquerda(comprador(_,anita,_,_,_,_), comprador(_,_,_,50,_,_), ListaSolucao),

% Em uma das pontas está a mulher de camiseta Amarela.
ponta(comprador(amarela,_,_,_,_,_), ListaSolucao),

% A cliente que está comprando um Notebook está em algum lugar entre quem conseguiu a maior porcentagem de desconto e quem está comprando uma Geladeira, nessa ordem.
entre(comprador(_,_,notebook,_,_,_), comprador(_,_,_,70,_,_), comprador(_,_,geladeira,_,_,_), ListaSolucao),

% A mulher que está acompanhada do Pai está ao lado da mulher que está comprando um Celular.
aoLado(comprador(_,_,_,_,_,pai), comprador(_,_,celular,_,_,_), ListaSolucao),

% A cliente de Azul está em algum lugar entre a cliente mais velha e a cliente que está comprando um Notebook, nessa ordem.
entre(comprador(azul,_,_,_,_,_), comprador(_,_,_,_,43,_), comprador(_,_,notebook,_,_,_), ListaSolucao),

% Na quarta posição está a cliente de camiseta Verde.
Camiseta4 = verde,

% Fernanda está ao lado da cliente que conseguiu 40% de desconto.
aoLado(comprador(_,fernanda,_,_,_,_), comprador(_,_,_,40,_,_), ListaSolucao),

% A cliente que está acompanhada do Namorado está ao lado da cliente que está comprando um Notebook.
aoLado(comprador(_,_,_,_,_,namorado), comprador(_,_,notebook,_,_,_), ListaSolucao),

% A mulher de 31 anos está em algum lugar entre quem conseguiu 40% de desconto e quem tem 29 anos, nessa ordem.
entre(comprador(_,_,_,_,31,_), comprador(_,_,_,40,_,_), comprador(_,_,_,_,29,_), ListaSolucao),

% A cliente que está acompanhada do Pai está em algum lugar à direita da cliente de Azul.
aDireita(comprador(_,_,_,_,_,pai), comprador(azul,_,_,_,_,_), ListaSolucao),

% A cliente que conseguiu um desconto de 40% está ao lado da cliente que está acompanhada do Irmão.
aoLado(comprador(_,_,_,40,_,_), comprador(_,_,_,_,_,irmao), ListaSolucao),

% A mulher de Branco está ao lado da cliente que conseguiu 50% de desconto.
aoLado(comprador(branca,_,_,_,_,_), comprador(_,_,_,50,_,_), ListaSolucao),

% Quem está acompanhada do Pai está entre quem está acompanhada do Irmão e quem está acompanhada do Namorado, nessa ordem.
entre(comprador(_,_,_,_,_,pai), comprador(_,_,_,_,_,irmao), comprador(_,_,_,_,_,namorado), ListaSolucao),

% Marietta tem 31 anos. DUVIDA AQUI
member(comprador(_,marietta,_,_,31,_), ListaSolucao),

% Anita está ao lado da cliente de camiseta Azul.
aoLado(comprador(_,anita,_,_,_,_), comprador(azul,_,_,_,_,_), ListaSolucao),

% A cliente que conseguiu um desconto de 30% está em algum lugar entre quem conseguiu 70% de desconto e quem está acompanhada do Pai, nessa ordem.
entre(comprador(_,_,_,30,_,_), comprador(_,_,_,70,_,_), comprador(_,_,_,_,_,pai), ListaSolucao),


% Clara está na quinta posição.
Nome5 = clara,

% A cliente de 22 anos está em algum lugar entre a cliente de Azul e a cliente de 31 anos, nessa ordem.
entre(comprador(_,_,_,_,22,_), comprador(azul,_,_,_,_,_), comprador(_,_,_,_,31,_), ListaSolucao),

% A cliente de camiseta Branca está exatamente à direita da mulher que está acompanhada do Marido.
aoLado(comprador(branca,_,_,_,_,_), comprador(_,_,_,_,_,marido), ListaSolucao),
aDireita(comprador(branca,_,_,_,_,_), comprador(_,_,_,_,_,marido), ListaSolucao),

% Testa todas as possibilidades...
camiseta(Camiseta1),
camiseta(Camiseta2),
camiseta(Camiseta3),
camiseta(Camiseta4),
camiseta(Camiseta5),
todosDiferentes([Camiseta1,Camiseta2,Camiseta3,Camiseta4,Camiseta5]),

nome(Nome1),
nome(Nome2),
nome(Nome3),
nome(Nome4),
nome(Nome5),
todosDiferentes([Nome1,Nome2,Nome3,Nome4,Nome5]),

produto(Produto1),
produto(Produto2),
produto(Produto3),
produto(Produto4),
produto(Produto5),
todosDiferentes([Produto1,Produto2,Produto3,Produto4,Produto5]),

desconto(Desconto1),
desconto(Desconto2),
desconto(Desconto3),
desconto(Desconto4),
desconto(Desconto5),
todosDiferentes([Desconto1,Desconto2,Desconto3,Desconto4,Desconto5]),

idade(Idade1),
idade(Idade2),
idade(Idade3),
idade(Idade4),
idade(Idade5),
todosDiferentes([Idade1,Idade2,Idade3,Idade4,Idade5]),


companhia(Companhia1),
companhia(Companhia2),
companhia(Companhia3),
companhia(Companhia4),
companhia(Companhia5),
todosDiferentes([Companhia1,Companhia2,Companhia3,Companhia4,Companhia5]).
