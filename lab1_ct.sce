mode( -1 )

Rres = input( "Введите сопротивление резисторов в формате [R1;R2;R3;R4;R5;R6]: " )
E = input( "Введите ЭДС источников напряжения в формате [E1;E2]: " )

// Метод контурных токов
Rmatrix = [ Rres(1) + Rres(4), -Rres(4), 0; -Rres(4), Rres(3) + Rres(5) + Rres(4) + Rres(6), -Rres(5); 0, -Rres(5), Rres(5) + Rres(2) ]
Ek = [ E(1); 0; E(2) ]

Ik = linsolve( Rmatrix, -Ek )

disp( "Значения контурных токов:" )
disp( Ik )

disp( "Значения токов в ветвях:" )
Ib = [ Ik(1); Ik(3); Ik(2); Ik(1) - Ik(2); Ik(3) - Ik(2); Ik(2) ]
disp( Ib )

// Метод узловых потенциалов
Gmatrix = [ 1/Rres(1) + 1/Rres(4) + 1/Rres(6), -1/Rres(6), -( 1/Rres(1) + 1/Rres(4) ); -1/Rres(6), 1/Rres(6) + 1/Rres(5) + 1/Rres(2), 0; -( 1/Rres(1) + 1/Rres(4) ), 0, 1/Rres(4) + 1/Rres(3) + 1/Rres(1) ]
Jn = [ E(1) / Rres(1); -E(2) / Rres(2); -E(1) / Rres(1) ]

FIn = linsolve( Gmatrix, -Jn )

disp( "Значения узловых потенциалов:" )
disp( FIn )

Ib2 = [ (FIn(3) - FIn(1) + E(1)) / Rres(1); (FIn(2) + E(2)) / Rres(2); - FIn(3) / Rres(3); (FIn(1) - FIn(3)) / Rres(4); - FIn(2) / Rres(5); (FIn(1) - FIn(2)) / Rres(6) ]

disp( "Тогда значения токов в ветвях:" )
disp( Ib2 )
