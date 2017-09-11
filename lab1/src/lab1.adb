with Ada.Text_IO;
use Ada.Text_IO;
with Data;
use Data;
with Ada.Integer_Text_IO;
with Ada.Integer_Text_IO;

procedure lab1 is

   task T1 is
      pragma Priority(3);
   end T1;
   task T2 is
      pragma Priority(2);
   end T2;
   task T3 is
      pragma Priority(1);
   end T3;


   task body T1 is
      A,D,E : Matrix;
      B : Vector;
   begin

      Put_Line ("Task 1:");

      Put_Line("Enter N1:");
      Ada.Integer_Text_IO.Get(N);
      while N>NMax loop
         Put("N must be less than");
         Ada.Integer_Text_IO.Put(NMax);
         New_Line;
         Put_Line("Enter N:");
         Ada.Integer_Text_IO.Get(N);
      end loop;

      Matrix_Generate(A);
      Put_Line ("Matrix A:");
      Matrix_Output(A);
      Matrix_Generate(D);
      Put_Line ("Matrix D:");
      Matrix_Output(D);
      Vector_Generate(B);
      Put_Line ("Vector B:");
      Vector_Output(B);
      E := F1(A,D,B);
      Put_Line ("Matrix E:");
      Matrix_Output(E);
   end T1;

   task body T2 is
      G,K,L,F : Matrix;
      a : Integer;
   begin
      Put_Line ("Task 2:");
      Put_Line("Enter N2:");
      Ada.Integer_Text_IO.Get(N);
      while N>NMax loop
         Put("N must be less than");
         Ada.Integer_Text_IO.Put(NMax);
         New_Line;
         Put_Line("Enter N:");
         Ada.Integer_Text_IO.Get(N);
      end loop;
      Matrix_Generate(G);
      Put_Line ("Matrix G:");
      Matrix_Output(G);
      Matrix_Generate(K);
      Put_Line ("Matrix K:");
      Matrix_Output(K);
      Matrix_Generate(L);
      Put_Line ("Matrix L:");
      Matrix_Output(L);
      Value_Generate(a);
      Put_Line("Variable a:");
      Ada.Integer_Text_IO.Put(a);
      New_Line;
      F := F2(a,G,K,L);
      Put_Line ("Matrix F:");
      Matrix_Output(F);
   end T2;

   task body T3 is
      P,R : Matrix;
      S,T,O : Vector;
   begin
      Put_Line ("Task 3:");
      Put_Line("Enter N3:");
      Ada.Integer_Text_IO.Get(N);
      while N>NMax loop
         Put("N must be less than");
         Ada.Integer_Text_IO.Put(NMax);
         New_Line;
         Put_Line("Enter N:");
         Ada.Integer_Text_IO.Get(N);
      end loop;
      Matrix_Generate(P);
      Put_Line ("Matrix P:");
      Matrix_Output(P);
      Matrix_Generate(R);
      Put_Line ("Matrix R:");
      Matrix_Output(R);
      Vector_Generate(S);
      Put_Line ("Vector S:");
      Vector_Output(S);
      Vector_Generate(T);
      Put_Line ("Vector T:");
      Vector_Output(T);

      O:=F3(P,R,S,T);
      Put_Line ("Vector O:");
      Vector_Output(O);

   end T3;

begin
   Put_Line("Lab1");
--     Put_Line("Enter N:");
--     Ada.Integer_Text_IO.Get(N);
--     while N>NMax loop
--        Put("N must be less than");
--        Ada.Integer_Text_IO.Put(NMax);
--        New_Line;
--        Put_Line("Enter N:");
--        Ada.Integer_Text_IO.Get(N);
--     end loop;
--     Matrix_Generate(A);
--     Matrix_Output(A);


end lab1;
