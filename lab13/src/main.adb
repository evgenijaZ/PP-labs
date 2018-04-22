with System;              use System;
with Ada.Text_IO;         use Ada.Text_IO;
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;
procedure Main is
   N : Integer := 12;
   P : Integer := 6;
   H : Integer := N / P;

   type GeneralVector is array (Integer range <>) of Integer;
   subtype Vector is GeneralVector (1 .. N);
   subtype VectorH is GeneralVector (1 .. H);
   subtype Vector2H is GeneralVector (1 .. 2 * H);
   subtype Vector4H is GeneralVector (1 .. 4 * H);
   subtype Vector5H is GeneralVector (1 .. 5 * H);

   type GeneralMatrix is array (Integer range <>) of Vector;
   subtype Matrix is GeneralMatrix (1 .. N);
   subtype MatrixH is GeneralMatrix (1 .. H);
   subtype Matrix2H is GeneralMatrix (1 .. 2 * H);
   subtype Matrix3H is GeneralMatrix (1 .. 3 * H);
   subtype Matrix4H is GeneralMatrix (1 .. 4 * H);
   subtype Matrix5H is GeneralMatrix (1 .. 5 * H);

   task T1 is
      entry Data2 (MB_p : in MatrixH; MK_p : in Matrix);
      entry ShareM (m_p : in Integer);
   end T1;

   task T2 is
      entry Data2 (MB_p : in Matrix2H; MK_p : in Matrix);
      entry Data1 (Z_p : in Vector5H; MO_p : in Matrix5H);
      entry SendMin1 (m1_p : in Integer);
      entry ShareM (m_p : in Integer);
      entry Rezult1 (MA_p : in MatrixH);
   end T2;

   task T3 is
      entry Data2
        (MB_p123 : in Matrix3H;
         MB_p56  : in Matrix2H;
         MK_p    : in Matrix);
      entry Data1 (Z_p : in Vector4H; MO_p : in Matrix4H);
      entry SendMin12 (m1_p, m2_p : in Integer);
      entry SendMin5 (m5_p : in Integer);
      entry SendMin6 (m6_p : in Integer);
      entry ShareM (m_p : in Integer);
      entry Rezult2 (MA_p : in Matrix2H);
      entry Rezult5 (MA_p : in MatrixH);
      entry Rezult6 (MA_p : in MatrixH);
   end T3;

   task T4 is
      entry SendMin12356 (m1_p, m2_p, m3_p, m5_p, m6_p : in Integer);
      entry Data1 (Z_p : in VectorH; MO_p : in MatrixH);
      entry Rezult12356 (MA_p : in Matrix5H);
   end T4;

   task T5 is
      entry Data2 (MB_p : in MatrixH; MK_p : in Matrix);
      entry Data1 (Z_p : in VectorH; MO_p : in MatrixH);
      entry ShareM (m_p : in Integer);
   end T5;

   task T6 is
      entry Data2 (MB_p : in MatrixH; MK_p : in Matrix);
      entry Data1 (Z_p : in VectorH; MO_p : in MatrixH);
      entry ShareM (m_p : in Integer);
   end T6;

   task body T1 is
      Z        : Vector;
      MO, MK   : Matrix;
      m1, m    : Integer;
      MA, MB   : MatrixH;
      from, to : Integer;
   begin
      Put_Line ("T1 started");
      from := 1;
      to   := H;
      --Input Z, MO
      for i in 1 .. N loop
         Z (i) := 1;
         for j in 1 .. N loop
            MO (i) (j) := 1;
         end loop;
      end loop;
      --Send Z, MO to T2
      T2.Data1 (Z (H + 1 .. N), MO (H + 1 .. N));
      --Receive MB, MK from T2
      accept Data2 (MB_p : in MatrixH; MK_p : in Matrix) do
         MB := MB_p;
         MK := MK_p;
      end Data2;
      --Calculate m1
      m1 := 1000;
      for i in 1 .. H loop
         if Z (i) < m1 then
            m1 := Z (i);
         end if;
      end loop;
      --Send m1 to T2
      T2.SendMin1 (m1);
      --Receive m from T2
      accept ShareM (m_p : in Integer) do
         m := m_p;
      end ShareM;
      --Calculate MAH = MBH + m*(MOH*MK)
      for i in from .. to loop
         for j in 1 .. N loop
            MA (i) (j) := 0;
            for K in 1 .. N loop
               MA (i) (j) := MA (i) (j) + MO (i) (K) * MK (K) (j);
            end loop;
            MA (i) (j) := MB (i) (j) + m * MA (i) (j);
         end loop;
      end loop;
      --Send MAH to T2
      T2.Rezult1 (MA (1 .. H));
      --Put_Line ("T1 finished");
   end T1;

   task body T2 is
      Z         : Vector5H;
      MK        : Matrix;
      MO        : Matrix5H;
      MB, MA    : Matrix2H;
      m1, m2, m : Integer;
      from, to  : Integer;
   begin
      Put_Line ("T2 started");
      from := H + 1;
      to   := 2 * H;
      --Receive Z, MO from T1;
      accept Data1 (Z_p : in Vector5H; MO_p : in Matrix5H) do
         Z  := Z_p;
         MO := MO_p;
      end Data1;
      --Send Z, MO to T3;
      T3.Data1 (Z (H + 1 .. 5 * H), MO (H + 1 .. 5 * H));
      --Receive MB, MK from T3;
      accept Data2 (MB_p : in Matrix2H; MK_p : in Matrix) do
         MB := MB_p;
         MK := MK_p;
      end Data2;
      --Send MB, MK to T1;
      T1.Data2 (MB (1 .. H), MK);
      --Calculate m2;
      m2 := 1000;
      for i in H + 1 .. 2 * H loop
         if Z (i) < m2 then
            m2 := Z (i);
         end if;
      end loop;
      --Receive m1 from T1;
      accept SendMin1 (m1_p : in Integer) do
         m1 := m1_p;
      end SendMin1;
      --Send m1, m2 to T3;
      T3.SendMin12 (m1, m2);
      --Receive m from T3;
      accept ShareM (m_p : in Integer) do
         m := m_p;
      end ShareM;
      --Send m to T1;
      T1.ShareM (m);
      --Calculate MAH = MBH + m*(MOH*MK)
      for i in H + 1 .. 2 * H loop
         for j in 1 .. N loop
            MA (i) (j) := 0;
            for K in 1 .. N loop
               MA (i) (j) := MA (i) (j) + MO (i) (K) * MK (K) (j);
            end loop;
            MA (i) (j) := MB (i) (j) + m * MA (i) (j);
         end loop;
      end loop;
      --Receive MA from T1;
      accept Rezult1 (MA_p : in MatrixH) do
         MA (1 .. H) := MA_p;
      end Rezult1;
      --Send MA2H to T3
      T3.Rezult2 (MA);
      --Put_Line ("T2 finished");
   end T2;

   task body T3 is
      m1, m2, m3, m5, m6, m : Integer;
      MA                    : Matrix5H;
      Z                     : Vector4H;
      MO                    : Matrix4H;
      MK                    : Matrix;
      MB                    : Matrix5H;

   begin
      Put_Line ("T3 started");
      --Receive Z, MO from T2;
      accept Data1 (Z_p : in Vector4H; MO_p : in Matrix4H) do
         Z  := Z_p;
         MO := MO_p;
      end Data1;
      --Receive MB, MK from T4;
      accept Data2
        (MB_p123 : in Matrix3H;
         MB_p56  : in Matrix2H;
         MK_p    : in Matrix) do
         MB (1 .. 3 * H)         := MB_p123;
         MB (3 * H + 1 .. 5 * H) := MB_p56;
         MK                      := MK_p;
      end Data2;
      --Send MB,MK to T2;
      T2.Data2 (MB (1 .. 2 * H), MK);
      --Send Z,MO to T4;
      T4.Data1 (Z (H + 1 .. 2 * H), MO (H + 1 .. 2 * H));
      --Send Z,MO  to T5;
      T5.Data1 (Z (2 * H + 1 .. 3 * H), MO (2 * H + 1 .. 3 * H));
      --Send MB,MK to T5;
      T5.Data2 (MB (3 * H + 1 .. 4 * H), MK);
      --Send Z,MO  to T6;
      T6.Data1 (Z (3 * H + 1 .. 4 * H), MO (3 * H + 1 .. 4 * H));
      --Send MB,MK to T6;
      T6.Data2 (MB (4 * H + 1 .. 5 * H), MK);
      --Calculate m3;
      m3 := 1000;
      for i in 1 .. H loop
         if Z (i) < m3 then
            m3 := Z (i);
         end if;
      end loop;
      --Receive m1,m2 from T2;
      accept SendMin12 (m1_p : in Integer; m2_p : in Integer) do
         m1 := m1_p;
         m2 := m2_p;
      end SendMin12;
      --Receive m5 from T5;
      accept SendMin5 (m5_p : in Integer) do
         m5 := m5_p;
      end SendMin5;
      --Receive m6 from T6;
      accept SendMin6 (m6_p : in Integer) do
         m6 := m6_p;
      end SendMin6;
      --Send m1,m2,m3,m5,m6 to T4;
      T4.SendMin12356 (m1, m2, m3, m5, m6);
      --Receive m from T4;
      accept ShareM (m_p : in Integer) do
         m := m_p;
      end ShareM;
      --Send m to T2;
      T2.ShareM (m);
      --Send m to T5;
      T5.ShareM (m);
      --Send m to T6;
      T6.ShareM (m);
      --Calculate MAH = MBH + m*(MOH*MK);
      for i in 2 * H + 1 .. 3 * H loop
         for j in 1 .. N loop
            MA (i) (j) := 0;
            for K in 1 .. N loop
               MA (i) (j) := MA (i) (j) + MO (i) (K) * MK (K) (j);
            end loop;
            MA (i) (j) := MB (i + H) (j) + m * MA (i) (j);
         end loop;
      end loop;
      --Receive MA from T2;
      accept Rezult2 (MA_p : in Matrix2H) do
         MA (1 .. 2 * H) := MA_p;
      end Rezult2;
      --Receive MA from T5;
      accept Rezult5 (MA_p : in MatrixH) do
         MA (3 * H + 1 .. 4 * H) := MA_p;
      end Rezult5;
      --Receive MA from T6;
      accept Rezult6 (MA_p : in MatrixH) do
         MA (4 * H + 1 .. 5 * H) := MA_p;
      end Rezult6;
      --Send MA to T4;
      T4.Rezult12356 (MA);
      --Put_Line ("T3 finished");
   end T3;

   task body T4 is
      MA, MB, MK : Matrix;
      Z          : VectorH;
      MO         : MatrixH;
      m4, min    : Integer;
      from, to   : Integer;
      M          : array (1 .. 6) of Integer;
   begin
      Put_Line ("T4 started");
      from := 3 * H + 1;
      to   := 4 * H;
      --Input MB,MK;
      for i in 1 .. N loop
         for j in 1 .. N loop
            MB (i) (j) := 1;
            MK (i) (j) := 1;
         end loop;
      end loop;
      --Send MB, MK to T3;
      T3.Data2 (MB (1 .. 3 * H), MB (4 * H + 1 .. N), MK);
      --Receive Z, MO from T3;
      accept Data1 (Z_p : in VectorH; MO_p : in MatrixH) do
         Z  := Z_p;
         MO := MO_p;
      end Data1;
      --Calculate m4;
      m4 := 1000;
      for i in 1 .. H loop
         if Z (i) < m4 then
            m4 := Z (i);
         end if;
      end loop;
      M (4) := m4;
      --Receive m1,m2,m3,m5,m6 from T3;
      accept SendMin12356
        (m1_p : in Integer;
         m2_p : in Integer;
         m3_p : in Integer;
         m5_p : in Integer;
         m6_p : in Integer) do
         M (1) := m1_p;
         M (2) := m2_p;
         M (3) := m3_p;
         M (5) := m5_p;
         M (6) := m6_p;
      end SendMin12356;
      --Calculate m;
      min := 1000;
      for i in 2 .. P loop
         if M (i) < min then
            min := M (i);
         end if;
      end loop;
      --Send m to T3;
      T3.ShareM (min);
      --Calculate MAH = MBH + m*(MOH*MK);
      for i in 3 * H + 1 .. 4 * H loop
         for j in 1 .. N loop
            MA (i) (j) := 0;
            for K in 1 .. N loop
               MA (i) (j) := MA (i) (j) + MO (i - 3 * H) (K) * MK (K) (j);
            end loop;
            MA (i) (j) := MB (i) (j) + min * MA (i) (j);
         end loop;
      end loop;
      --Receive MA from T3;
      accept Rezult12356 (MA_p : in Matrix5H) do
         MA (1 .. 3 * H)     := MA_p (1 .. 3 * H);
         MA (4 * H + 1 .. N) := MA_p (3 * H + 1 .. 5 * H);
      end Rezult12356;
      --Output MA;
      if N <= 12 then
         for i in 1 .. N loop
            for j in 1 .. N loop
               Put (MA (i) (j));
               Put (" ");
            end loop;
            Put_Line (" ");
         end loop;
      end if;
      -- Put_Line ("T4 finished");
   end T4;

   task body T5 is
      MK         : Matrix;
      MB, MO, MA : MatrixH;
      Z          : VectorH;
      m5, m      : Integer;
      from, to   : Integer;
   begin
      Put_Line ("T5 started");
      from := 4 * H + 1;
      to   := 5 * H;
      --Receive Z, MO from T3;
      accept Data1 (Z_p : in VectorH; MO_p : in MatrixH) do
         Z  := Z_p;
         MO := MO_p;
      end Data1;
      --Receive MB, MK from T3;
      accept Data2 (MB_p : in MatrixH; MK_p : in Matrix) do
         MB := MB_p;
         MK := MK_p;
      end Data2;
      --Calculate m5;
      m5 := 1000;
      for i in 1 .. H loop
         if Z (i) < m5 then
            m5 := Z (i);
         end if;
      end loop;
      --Send m5 to T3;
      T3.SendMin5 (m5);
      --Receive m from T3;
      accept ShareM (m_p : in Integer) do
         m := m_p;
      end ShareM;
      --Calculate MAH = MBH + m*(MOH*MK);
      for i in 1 .. H loop
         for j in 1 .. N loop
            MA (i) (j) := 0;
            for K in 1 .. N loop
               MA (i) (j) := MA (i) (j) + MO (i) (K) * MK (K) (j);
            end loop;
            MA (i) (j) := MB (i) (j) + m * MA (i) (j);
         end loop;
      end loop;
      --Send MA to T3;
      T3.Rezult5 (MA);
      --Put_Line ("T5 finished");
   end T5;

   task body T6 is
      MK         : Matrix;
      MB, MO, MA : MatrixH;
      Z          : VectorH;
      m6, m      : Integer;
      from, to   : Integer;
   begin
      Put_Line ("T6 started");
      from := 5 * H + 1;
      to   := N;
      --Receive Z, MO from T3;
      accept Data1 (Z_p : in VectorH; MO_p : in MatrixH) do
         Z  := Z_p;
         MO := MO_p;
      end Data1;
      --Receive MB, MK from T3;
      accept Data2 (MB_p : in MatrixH; MK_p : in Matrix) do
         MB := MB_p;
         MK := MK_p;
      end Data2;
      --Calculate m6;
      m6 := 1000;
      for i in 1 .. H loop
         if Z (i) < m6 then
            m6 := Z (i);
         end if;
      end loop;
      --Send m6 to T3;
      T3.SendMin6 (m6);
      --Receive m from T3;
      accept ShareM (m_p : in Integer) do
         m := m_p;
      end ShareM;
      --Calculate MAH = MBH + m*(MOH*MK);
      for i in 1 .. H loop
         for j in 1 .. N loop
            MA (i) (j) := 0;
            for K in 1 .. N loop
               MA (i) (j) := MA (i) (j) + MO (i) (K) * MK (K) (j);
            end loop;
            MA (i) (j) := MB (i) (j) + m * MA (i) (j);
         end loop;
      end loop;
      --Send MA to T3;
      T3.Rezult6 (MA);
      -- Put_Line ("T6 finished");
   end T6;

begin
   null;
end Main;
