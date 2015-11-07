// ----------------------------- Формулы из методички ---------------------------------- //

function omega=findOmega(f)
  omega=2 * %pi * f;
endfunction

function rad=deg2rad(deg)
  rad = deg * %pi / 180;
endfunction

function Z=f#2_11(U, I)
  Z = U / I;
endfunction

function g=f#2_14(Y, phi)
  g = Y * cos( phi );
endfunction

function b=f#2_15(Y, phi)
  b = Y * sin( phi );
endfunction

function Y=f#2_26(g_R, g_L, b_L)
  Y = ( g_R + g_L ) - %i*b_L;
endfunction

function Y=f#2_28(g_R, b_C)
  Y = g_R + %i*b_C;
endfunction

// ---------------------------- Ввод исходных значений --------------------------------- //

mode( -1 )

// Одинаковы для всех вариантов
I = 20 * 10^-3; //А
f = 400; //Гц

// Результаты измерения:
mprintf( "Введите свои изначения R, L, R_L и C из таблицы 2.1 в заданных единицах.\n" );
mprintf( "Пример ввода для 1-го варианта: [100,50,31.7,2]\n" );
table#2_1( 1, 1:4 ) = input( "Введите значения: " );

// Результаты измерения:
table#2_3( 1:2, 1:2 ) = input( "Заполните значения U и φ из таблицы 2.3 (в квадратных скобках через запятую): " );
table#2_4( 1:2, 1:4 ) = input( "Заполните значения U и φ таблицы 2.4 (в квадратных скобках через запятую): " );

//Приведение данных к единицам СИ:
table#2_1( 1, 2 ) = table#2_1( 1, 2 ) * 10^-3;
table#2_1( 1, 4 ) = table#2_1( 1, 4 ) * 10^-6;

// -------------------------------- Начало расчетов ------------------------------------ //

// Таблица строк (!), нужна для красивого вывода
str_table#2_5( 2:4, 2:11 ) = "-"
str_table#2_5( 1:4, 1 ) = [" "; "R4"; "C4"; "L4"]
str_table#2_5( 1:1, 2:11 ) = ["Z", "R", "X", "_Z_", "Y", "g", "b", "_Y_", "L", "C"]

str_table#2_5( 2, 2:5 ) = string( table#2_5 )
