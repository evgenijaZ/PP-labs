with Ada.Text_IO;
use Ada.Text_IO;
with Data;
use Data;
with Ada.Integer_Text_IO;
with Ada.Integer_Text_IO;
with System.Multiprocessors;
use System.Multiprocessors;

procedure lab1 is
   cpu1 : CPU_Range := 1;
   cpu2 : CPU_Range := 1;
   cpu3 : CPU_Range := 1;

   N : Integer := 50;

   task T1 is
      pragma Priority(3);
      pragma Storage_Size(900_000_000);
      pragma CPU(cpu1);
   end T1;

   task T2 is
      pragma Priority(2);
      pragma Storage_Size(900_000_000);
      pragma CPU(cpu2);
   end T2;

   task T3  is
      pragma Priority(1);
      pragma Storage_Size(900_000_000);
      pragma CPU(cpu3);
   end T3;


   task body T1 is
      A,D,E : Matrix;
      B : Vector;
   begin

      Put_Line ("Task 1:");

      --        Put_Line("Enter N1:");
      --        Ada.Integer_Text_IO.Get(N);

      Matrix_Generate(A,N);
      --        Put_Line ("Matrix A:");
      --        Matrix_Output(A,N);
      Matrix_Generate(D,N);
      --        Put_Line ("Matrix D:");
      --        Matrix_Output(D,N);
      Vector_Generate(B,N);
      --        Put_Line ("Vector B:");
      --        Vector_Output(B,N);
      E := F1(A,D,B,N);
      Matrix_Output(E,N,"Matrix E:");
      Put_Line("End task 1");
   end T1;

   task body T2 is
      G,K,L,F : Matrix;
      a : Integer;
   begin

      Put_Line ("Task 2:");
      --        Put_Line("Enter N2:");
      --        Ada.Integer_Text_IO.Get(N);
      Matrix_Generate(G,N);
      --        Put_Line ("Matrix G:");
      --        Matrix_Output(G,N);
      Matrix_Generate(K,N);
      --        Put_Line ("Matrix K:");
      --        Matrix_Output(K,N);
      Matrix_Generate(L,N);
      --        Put_Line ("Matrix L:");
      --        Matrix_Output(L,N);
      Value_Generate(a);
      --        Put_Line("Variable a:");
      --        Ada.Integer_Text_IO.Put(a);
      --        New_Line;
      F := F2(a,G,K,L,N);
      Matrix_Output(F,N,"Matrix F:");
      Put_Line("End task 2");
   end T2;

   task body T3 is
      P,R : Matrix;
      S,T,O : Vector;

   begin

      Put_Line ("Task 3:");
      --        Put_Line("Enter N3:");
      --        Ada.Integer_Text_IO.Get(N);
      Matrix_Generate(P,N);
      --        Put_Line ("Matrix P:");
      --        Matrix_Output(P,N);
      Matrix_Generate(R,N);
      --        Put_Line ("Matrix R:");
      --        Matrix_Output(R,N);
      Vector_Generate(S,N);
      --        Put_Line ("Vector S:");
      --        Vector_Output(S,N);
      Vector_Generate(T,N);
      --        Put_Line ("Vector T:");
      --        Vector_Output(T,N);

      O:=F3(P,R,S,T,N);
      Vector_Output(O,N,"Vector O:");
      Put_Line("End task 3");
   end T3;

begin
   Put_Line("Lab1");
end lab1;
