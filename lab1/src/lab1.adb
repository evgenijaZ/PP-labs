with Ada.Text_IO;
use Ada.Text_IO;
with Data;
use Data;
with Ada.Integer_Text_IO;
with Ada.Integer_Text_IO;

procedure lab1 is

   task T1;
   task body T1 is
   begin
      Put_Line ("Task 1:");
   end T1;

   task T2;
   task body T2 is
   begin
      Put_Line ("Task 2:");
   end T2;

   task T3;
   task body T3 is
   begin
      Put_Line ("Task 3:");
   end T3;


  A:Matrix;

begin
   Put_Line("Enter N:");
   Ada.Integer_Text_IO.Get(N);
   while N>NMax loop
      Put("N must be less than");
      Ada.Integer_Text_IO.Put(NMax);
      New_Line;
      Put_Line("Enter N:");
   Ada.Integer_Text_IO.Get(N);
   end loop;
   Matrix_Generate(A);
   Matrix_Output(A);


end lab1;
