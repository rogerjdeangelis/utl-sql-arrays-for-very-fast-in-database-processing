Sql arrays for very fast in database processing

set value less than mean to missing

github
https://tinyurl.com/ybx5p5ve
https://github.com/rogerjdeangelis/utl-sql-arrays-for-very-fast-in-database-processing

StackOverFlow
https://tinyurl.com/y92v2mru
https://stackoverflow.com/questions/53472409/sas-set-value-less-than-mean-to-missing

INPUT
=====

 WORK.HAVE total obs=3

  ID A B C D E F G H I J K L M N O P Q R S T U V W X Y Z

   1 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6
   2 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 1 2 3 4 5
   3 2 7 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 1 2 3 4 5 6 7 8 9

RULES
-----

 If A is less than the column mean of A then set A to missing

 Mean of A is (1+6+2) / 3 = 3


 ID  A   |          A
         |
  1   1  | 1<3      .
  2   6  | 6 ge 3   6
  3   2  | 2<3      .


 EXAMPLE OUTPUT
 --------------

 ID A B C D E F G H I J K L M N O P Q R S T U V W X Y Z

  1 . . . . 5 6 7 8 9 . . . . . 5 6 7 8 9 . . . . . . .
  2 6 7 8 9 . . . . . 5 6 7 8 9 . . . . . 5 6 . . . . .
  3 . 7 . . 4 5 6 7 8 9 . . . . 4 5 6 . . 3 4 5 6 7 8 9


PROCESS
=======

* this is in my autoexec so you do nat need to write code;
%let letters=A B C D E F G H I J K L M N O P Q R S T U V W X Y Z;

%array(ltrs,values=&letters);

* This should be very fast on big data servers(Teradata) with 1000s of cores.
  Perhaps this would use 32 cores and a partitioded data.;

proc sql;
   create
      table want as
   select
      id
      %do_over(ltrs,phrase=%str(
        ,case when (?<mean(?)) then . else ?  end as ?
      ))
   from
      have;
;quit;

/* generated code
  ,case when (A<mean(A)) then . else A end as A
  ,case when (B<mean(B)) then . else B end as B
  ,case when (C<mean(C)) then . else C end as C
  ,case when (D<mean(D)) then . else D end as D
  ,case when (E<mean(E)) then . else E end as E
  ,case when (F<mean(F)) then . else F end as F
  ,case when (G<mean(G)) then . else G end as G
  ,case when (H<mean(H)) then . else H end as H
  ,case when (I<mean(I)) then . else I end as I
  ,case when (J<mean(J)) then . else J end as J
  ,case when (K<mean(K)) then . else K end as K
  ,case when (L<mean(L)) then . else L end as L
  ,case when (M<mean(M)) then . else M end as M
  ,case when (N<mean(N)) then . else N end as N
  ,case when (O<mean(O)) then . else O end as O
  ,case when (P<mean(P)) then . else P end as P
  ,case when (Q<mean(Q)) then . else Q end as Q
  ,case when (R<mean(R)) then . else R end as R
  ,case when (S<mean(S)) then . else S end as S
  ,case when (T<mean(T)) then . else T end as T
  ,case when (U<mean(U)) then . else U end as U
  ,case when (V<mean(V)) then . else V end as V
  ,case when (W<mean(W)) then . else W end as W
  ,case when (X<mean(X)) then . else X end as X
  ,case when (Y<mean(Y)) then . else Y end as Y
  ,case when (Z<mean(Z)) then . else Z end as Z
*/

*                _              _       _
 _ __ ___   __ _| | _____    __| | __ _| |_ __ _
| '_ ` _ \ / _` | |/ / _ \  / _` |/ _` | __/ _` |
| | | | | | (_| |   <  __/ | (_| | (_| | || (_| |
|_| |_| |_|\__,_|_|\_\___|  \__,_|\__,_|\__\__,_|

;

DATA have;
 INPUT id &letters;
cards4;
1 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6
2 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 1 2 3 4 5
3 2 7 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 1 2 3 4 5 6 7 8 9
;;;;
run;quit;



