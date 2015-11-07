clear;
mode( -1 );
clc;

// ----------------------------- Формулы из методички ---------------------------------- //

function omega=getOmega(f)
  omega=2 * %pi * f;
endfunction

function rad=deg2rad(deg)
  rad = deg * %pi / 180;
endfunction

function Z=f#2_5(R, X)
  Z = R + X * %i;
endfunction

function Z=f#2_7(X_C)
  Z = - X_C * %i;
endfunction

function Z=f#2_11(U, I)
  Z = U / I;
endfunction

function R=f#2_12(Z, phi)
  R = Z * cos( phi );
endfunction

function X=f#2_13(Z, phi)
  X = Z * sin( phi );
endfunction

function g=f#2_14(Y, phi)
  g = Y * cos( phi );
endfunction

function b=f#2_15(Y, phi)
  b = Y * sin( phi );
endfunction

function Z=f#2_18(R, R_L, omega, L)
  Z = R + R_L + omega * L * %i
endfunction

function Z=f#2_20(R, X_C)
  Z = R - X_C*%i;
endfunction

function Y=f#2_26(g_R, g_L, b_L)
  Y = ( g_R + g_L ) - b_L*%i;
endfunction

function Y=f#2_28(g_R, b_C)
  Y = g_R + b_C*%i;
endfunction

// ---------------------------- Ввод исходных значений --------------------------------- //

// Одинаковы для всех вариантов
I = 20 * 10^-3; //А
f = 400; //Гц
omega = getOmega( f );

// Данные варианта:
mprintf( "Введите свои изначения R, L, R_L и C из таблицы 2.1 в заданных единицах.\n" );
mprintf( "Пример ввода для 1-го варианта: [100,50,31.7,2]\n" );
table#2_1( 1, 1:4 ) = [100,50,31.7,2]//input( "Введите значения: " );

mprintf( "Формат ввода для таблиц ниже: в квадратных скобках, столбцы - через запятую, строки - через точку с запятой\n" )
mprintf( "Пример: [1, 2; 3, 4] \n" )

// Результаты измерений:
table#2_2( 1:3, 1:2 ) = [2, 0; 3.8, -90; 2.56, 80]//input( "Заполните значения U и φ из таблицы 2.2 для трёх строк: " );
table#2_3( 1:2, 1:2 ) = [3.61, 46; 4.3, -60]//input( "Заполните значения U и φ из таблицы 2.3 для двух строк: " );
table#2_4( 1:2, 1:2 ) = [1.451, 36; 1.805, -27]//input( "Заполните значения U и φ из таблицы 2.4 для двух строк: " );

// Приведение данных к единицам СИ:
table#2_1( 1, 2 ) = table#2_1( 1, 2 ) * 10^-3;
table#2_1( 1, 4 ) = table#2_1( 1, 4 ) * 10^-6;

// -------------------------------- Начало расчетов ------------------------------------ //

// ---------------------------------- Таблица 2.5 -------------------------------------- //
// Расчет значений

// Инициализация
table#2_5( 1:3, 1:10 ) = 0;

// Резистор: 
Rres = f#2_11( table#2_2( 1, 1 ), I );
Gres = 1 / Rres;

table#2_5( 1, 1 ) = Rres;
table#2_5( 1, 2 ) = Rres;
table#2_5( 1, 4 ) = Rres;

table#2_5( 1, 5 ) = Gres;
table#2_5( 1, 6 ) = Gres;
table#2_5( 1, 8 ) = Gres;

clear Rres;
clear Gres;

// Конденсатор:
phi = deg2rad( table#2_2( 2, 2 ) );

table#2_5( 2,  1 ) = f#2_11( table#2_2( 2, 1 ), I );
table#2_5( 2,  3 ) = f#2_13( table#2_5( 2, 1 ), phi )
table#2_5( 2,  4 ) = f#2_7 ( table#2_5( 2, 3 ) );
table#2_5( 2,  5 ) = 1 / table#2_5( 2, 1 );
table#2_5( 2,  7 ) = f#2_15( table#2_5( 2, 5 ), phi );
table#2_5( 2,  8 ) = 1 / table#2_5( 2, 4 );
table#2_5( 2, 10 ) = 1 / (omega * table#2_5( 2, 3 ));

clear phi;

// Катушка индуктивности:
phi = deg2rad( table#2_2( 3, 2 ) );

table#2_5( 3, 1 ) = f#2_11( table#2_2( 3, 1 ), I );
table#2_5( 3, 2 ) = f#2_12( table#2_5( 3, 1 ), phi );
table#2_5( 3, 3 ) = f#2_13( table#2_5( 3, 1 ), phi );
table#2_5( 3, 4 ) = f#2_5 ( table#2_5( 3, 2 ), table#2_5( 3, 3 ) );
table#2_5( 3, 5 ) = 1 / table#2_5( 3, 1 );
table#2_5( 3, 6 ) = f#2_14( table#2_5( 3, 5 ), phi );
table#2_5( 3, 7 ) = f#2_15( table#2_5( 3, 5 ), phi );
table#2_5( 3, 8 ) = 1 / table#2_5( 3, 4 );
table#2_5( 3, 9 ) = table#2_5( 3, 3 ) / omega;

clear phi;

// Формирование таблицы строк (!) со значениями таблицы 2.5 
str_table#2_5( 1:4, 1 ) = [" "; "R4"; "C4"; "L4"]
str_table#2_5( 1:1, 2:11 ) = ["Z", "R", "X", "_Z_", "Y", "g", "b", "_Y_", "L", "C"]

str_table#2_5( 2:4, 2:11 ) = string( table#2_5 )

// Прочерки
str_table#2_5( 2, 4     ) = "-";
str_table#2_5( 2, 8     ) = "-";
str_table#2_5( 2, 10:11 ) = "-";
str_table#2_5( 3, 3     ) = "-";
str_table#2_5( 3, 7     ) = "-";
str_table#2_5( 3, 10    ) = "-";
str_table#2_5( 4, 11    ) = "-";

// Вывод таблицы
mprintf( "\nТут и далее: «%%i» - мнимая единица.\n" );
mprintf( "\nСодержимое таблицы 2.5:" );
disp( str_table#2_5 );

// ---------------------------------- Таблица 2.6 -------------------------------------- //

// Расчет значений

// Инициализация
table#2_6( 1:2, 1:6 ) = 0;

// Катушка индуктивности:
phi = deg2rad( table#2_3( 1, 2 ) );

table#2_6( 1, 1 ) = f#2_11( table#2_3( 1, 1 ), I   );
table#2_6( 1, 2 ) = f#2_12( table#2_6( 1, 1 ), phi );
table#2_6( 1, 3 ) = f#2_13( table#2_6( 1, 1 ), phi );
table#2_6( 1, 4 ) = f#2_18( table#2_1( 1, 1 ), table#2_1( 1, 3 ), omega, table#2_1( 1, 2 ) );
table#2_6( 1, 5 ) = table#2_6( 1, 3 ) / omega;

clear phi;

// Конденсатор:
phi = deg2rad( table#2_3( 2, 2 ) );

table#2_6( 2, 1 ) = f#2_11( table#2_3( 2, 1 ), I   );
table#2_6( 2, 2 ) = f#2_12( table#2_6( 2, 1 ), phi );
table#2_6( 2, 3 ) = f#2_13( table#2_6( 2, 1 ), phi );
table#2_6( 2, 4 ) = f#2_20( table#2_1( 1, 1 ), table#2_5( 2, 3 ) );
table#2_6( 2, 6 ) = 1 / ( omega * table#2_6( 2, 3 )) ;

clear phi;

// ### Формирование таблицы строк (!) со значениями таблицы 2.6 ###
str_table#2_6( 1:3, 1 ) = [" "; "R+L"; "R+C"]
str_table#2_6( 1:1, 2:7 ) = ["Z", "R", "X", "_Z_", "L", "C"]

str_table#2_6( 2:3, 2:7 ) = string( table#2_6 )

// Прочерки
str_table#2_6( 2, 7 ) = "-";
str_table#2_6( 3, 6 ) = "-";

// Вывод таблицы
mprintf( "\nСодержимое таблицы 2.6:" );
disp( str_table#2_6 );

// ---------------------------------- Таблица 2.7 -------------------------------------- //

// Расчет значений

// Инициализация
table#2_7( 1:2, 1:6 ) = 0;

// Катушка индуктивности:
phi = deg2rad( table#2_4( 1, 2 ) );

table#2_7( 1, 1 ) = 1 / f#2_11( table#2_4( 1, 1 ), I   );
table#2_7( 1, 2 ) = f#2_14( table#2_7( 1, 1 ), phi );
table#2_7( 1, 3 ) = f#2_15( table#2_7( 1, 1 ), phi );
table#2_7( 1, 4 ) = f#2_26( table#2_5( 1, 6 ), table#2_5( 3, 6 ), table#2_5( 3, 7 ) );
table#2_7( 1, 5 ) = 1 / ( omega * table#2_7( 1, 3 ) );

clear phi;

// Конденсатор:
phi = deg2rad( table#2_4( 2, 2 ) );

table#2_7( 2, 1 ) = 1 / f#2_11( table#2_4( 2, 1 ), I   );
table#2_7( 2, 2 ) = f#2_14( table#2_7( 2, 1 ), phi );
table#2_7( 2, 3 ) = f#2_15( table#2_7( 2, 1 ), phi );
table#2_7( 2, 4 ) = f#2_28( table#2_5( 1, 6 ), table#2_5( 2, 7 ) );
table#2_7( 2, 6 ) = table#2_7( 2, 3 ) / omega;

clear phi;

// ### Формирование таблицы строк (!) со значениями таблицы 2.7 ###
str_table#2_7( 1:3, 1 ) = [" "; "R+L"; "R+C"]
str_table#2_7( 1:1, 2:7 ) = ["Z", "R", "X", "_Z_", "L", "C"]

str_table#2_7( 2:3, 2:7 ) = string( table#2_7 )

// Прочерки
str_table#2_7( 2, 7 ) = "-";
str_table#2_7( 3, 6 ) = "-";

// Вывод таблицы
mprintf( "\nСодержимое таблицы 2.7:" );
disp( str_table#2_7 );
