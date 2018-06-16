%Autores: Denilson Gomes Vaz da Silva e Sérgio Saraiva de Sousa Neto
%Graduandos em Engenharia da Computação
%Controle de Sistemas Dinamicos - Prof. Dr. Vandilberto
%Programa para calcular a taxa de acerto da RBF na classificação da base
%iris_log

clear
clc

load iris_log.dat; %Carrega a base de dados
base = iris_log; %base recebe a base de dados
[tam, ~] = size(iris_log); %tam recebe o numero de elementos
x = base(:,1:4)'; %x recebe todos os atributos
y = base(:,5:7)'; %y recebe todas as classes
tamTreino = ceil(0.8*tam); %tamTreino calcula os 80% do treino

for i=1:50 %de 1 ate 50
    [X,Y] = permuta(x,y); %X recebe x permutado e Y recebe y permutado
    net = newrb(X(:,1:tamTreino),Y(:,1:tamTreino)); %criamos uma RBF com os conjuntos treino X e Y
    Yout = sim(net,X(:,tamTreino+1:tam)); %obtemos a saida Yout estimada para os Y do teste
    acertos = 0; %Cada rede inicia com acerto 0
    for j=tamTreino+1:tam %j percorre os dados de teste
        [~,indice1] = max(Yout(:,j-tamTreino)); %indice1 recebe o indice onde ocorre o maximo de Yout(:,j)
        [~,indice2] = max(Y(:,j)); %indice2 recebe o indice onde ocorre o maximo de Y(:,j)
        if indice1 == indice2 %se indice1 == indice2
            acertos = acertos + 1; %acrescenta acertos
        end
    end
    vetAcertos(i) = acertos; %vetAcertos(i) recebe o numero de acertos da i-esima rede
end
fprintf('\nResultados obtidos:\n'); %exibe a mensagem
fprintf('Porcentagem media de acerto: %.4f\n',mean(vetAcertos)*100/(tam-tamTreino)); %exibe a taxa media de acerto
fprintf('Percenteagem minima de acerto: %.4f\n',min(vetAcertos)*100/(tam-tamTreino)); %exibe a menor taxa de acerto
fprintf('Percentagem maxima de acerto: %.4f\n',max(vetAcertos)*100/(tam-tamTreino)); %exibe a maior taxa de acerto