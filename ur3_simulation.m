% 2021 UR3 matlab����
% ɽ����ѧ��������2018�� ���ݿ�ѧʵ��� ������
% UR3��е�۷���

clc,clear,close all;
% ����dh��������Link����������е��
L(1) = Link('d',151.9,'a',0,'alpha',pi/2,'standard');
L(2) = Link('d',0,'a',-243.65,'alpha',0,'offset',-pi/2,'standard');
L(3) = Link('d',0,'a',-213,'alpha',0,'standard');
L(4) = Link('d',83.4,'a',0,'alpha',pi/2,'offset',-pi/2,'standard');
L(5) = Link('d',83.4,'a',0,'alpha',-pi/2,'standard');
L(6) = Link('d',82.4,'a',0,'alpha',0,'standard');
robot = SerialLink(L,'name','ur3','manufacturer','innfos');

% ѡȡ����ִ�еĹ켣ͼƬ
img = 'shanda_icon.png';

% % ���´���Ϊpython�����������ͼƬ�Ĺ켣�����û��path_cal.mat�������������´���
% % �����������Ҫ������python����
% % command = ['pip install -r requirements.txt'];
% % status = system(command);
% % ִ��python�ļ�
% command = ['python cal_flat_path.py -f',img];
% status = system(command);

% ��������뾶����������
cen = [300 0 000];
r = 150;

% ����ƽ���϶�Ӧ�Ĺ켣
load('path_cal.mat');
P2=writing_path * 2 * r - r;

% ����άƽ��켣ӳ�䵽��ά����
for i=1:length(P2)
    P3(i,1) = P2(i,1)+cen(1);
    P3(i,2) = P2(i,2)+cen(2);
    calsqr = r^2- (P3(i, 1)-cen(1))^2 - (P3(i, 2)-cen(2))^2;
    % �ж��Ƿ񳬳������С�����δ����������������z��߶�
    if calsqr > 0
        P3(i, 3) = sqrt(calsqr)+cen(3)+5;
    else
        P3(i, 3) = cen(3)+5;
    end
end

% ���л�е�����
ikInitGuess=zeros(1,6);
for i=1:length(P3)
    % ������е��ĩ��λ�ˣ�����ĩ��ʼ�ճ���
    T1(:,:,i)=transl(P3(i,:))*rpy2tr([pi,0,0]);
    config=robot.ikunc(T1(:,:,i),ikInitGuess);
    ikInitGuess=config;
    qrt(i,:)=config;
end

% �����ͼ
figure('color','w');
hold on
[X,Y,Z] = sphere;
X2 = X * r;
Y2 = Y * r;
Z2 = Z * r;
surf(X2+cen(1),Y2+cen(2),Z2+cen(3))
xlim([-800 800]) 
ylim([-800 800])
zlim([-800 800])
% ʹ�����ƽ��
grid off 
shading interp 

% ����е�۹켣���ӻ�
W = [-800, +800, -800, +800, -800, +800];
hold on
robot.plot(qrt, 'tilesize', 150, 'workspace', W, 'trail', '-r', 'jointdiam', 1)
robot.plot(qrt, 'tilesize', 150, 'workspace', W, 'trail', '-r', 'jointdiam', 1)
