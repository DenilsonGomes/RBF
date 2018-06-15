%Autor: Denilson Gomes Vaz da Silva
%Graduando em Engenharia da Computação
%Controle de Sistemas Dinamicos - Prof. Dr. Vandilberto
%Programa para calcular a taxa de acerto da RBF na classificação da base
%iris_log

load iris_log.dat; %Carrega a base de dados

base = iris_log;
[tam, ~] = size(iris_log);
x = base(:,1:4)';
y = base(:,5:7)';

tamTreino = ceil(0.8*tam);
for i=1:50
    [X,Y] = permuta(x,y);    
    net = newrb(X(:,1:tamTreino),Y(:,1:tamTreino));
    Yout = sim(net,X(:,tamTreino:tam));
    acertos = 0;
    for j=tamTreino+1:tam
        [~,indice1] = max(Yout(:,j-tamTreino));
        [~,indice2] = max(Y(:,j));
        if indice1 == indice2
            acertos = acertos + 1;
        end
    end
    vetAcertos(i) = acertos;
end