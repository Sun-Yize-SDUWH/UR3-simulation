% 2021 UR3 matlab����
% ɽ����ѧ��������2018�� ���ݿ�ѧʵ��� ������
% UR3���˶�ѧ���

clc,clear
% �������
syms t1 t2 t3 t4 t5 t6
syms a2 a3 d1 d4 d5 d6
% �ֱ����T01-t56
T0_1 = calTmatrix(90,0,d1,t1)
T1_2 = calTmatrix(0,a2,0,t2)
T2_3 = calTmatrix(0,a3,0,t3)
T3_4 = calTmatrix(90,0,d4,t4)
T4_5 = calTmatrix(-90,0,d5,t5)
T5_6 = calTmatrix(0,0,d6,t6)
% ����T06���򻯱��ʽ
T0_6 = T0_1*T1_2*T2_3*T3_4*T4_5*T5_6;
T0_6 = simplify(T0_6)
