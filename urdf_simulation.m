% 2021 UR3 matlab����
% ɽ����ѧ��������2018�� ���ݿ�ѧʵ��� ������
% UR3��е�۷���-����simscape���ӻ�

% ����ļ�������UR3.slx�ļ����ó�����Բ���ִ��
clear,clc;
% ����������solidwork������urdfģ��
robot = importrobot('UR3/urdf/UR3.urdf');
showdetails(robot);
show(robot,'Frames','on','Visuals','on');
robot_sm = smimport('UR3/urdf/UR3.urdf');

