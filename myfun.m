function [state,options,optchanged] = myfun(options,state,flag)

%% �ϐ��̐ݒ�
% ����p�I�u�W�F�N�g���O���[�o���錾
global vidObj;
% �i���ϐ��̒�`
persistent BestScoreHistry;     % �x�X�g�X�R�A�̗������i�[
persistent ScatterHandle;       % scatter�R�}���h�̃n���h��
persistent ScatterHandleBest;   % scatter�R�}���h�̃n���h���A�x�X�g�X�R�A�p

%% ����ɂ�����x�X�g�X�R�A�̎擾�A����уC���f�b�N�X�̎擾
BestScore = min(state.Score);
BestScoreIndex = find(state.Score == BestScore);
optchanged = false;

%% �x�X�g�X�R�A�����̊i�[�A�����figure�̏㔼���Ɂu�W�c�v���v���b�g
subplot(5,1,[1:3]);
switch flag
    case 'init' % �T������ɂ����鏈�����e
        BestScoreHistry(1) = BestScore;
        ScatterHandle = scatter(state.Population(:,1),state.Population(:,2));
        
        % �x�X�g�X�R�A�����ԊۂŃv���b�g
        ScatterHandleBest = scatter(state.Population(BestScoreIndex,1),state.Population(BestScoreIndex,2),'MarkerFaceColor','r');
        
    case 'iter' % �T������ȍ~�ɂ����鏈�����e
        BestScoreHistry = [BestScoreHistry, BestScore];
        
        % �n���h�����g���Ċe�v���b�g��x,y���X�V
        ScatterHandle.XData = state.Population(:,1);
        ScatterHandle.YData = state.Population(:,2);
        ScatterHandleBest.XData = state.Population(BestScoreIndex,1);
        ScatterHandleBest.YData = state.Population(BestScoreIndex,2);
        drawnow
        
    case 'done' % �T���������ɂ����鏈�����e
        % �x�X�g�X�R�A�������x�[�X���[�N�X�y�[�X�ɓn��
        assignin('base','BestScoreHistry',BestScoreHistry)
end

%% figure�̉������Ɂu����v�̃x�X�g�X�R�A���v���b�g
subplot(5,1,[4:5]);
plot(state.Generation,BestScore,'.r','MarkerSize',10);hold on; grid on;
axis([0 50 0 1]);

%% �r�f�I�I�u�W�F�N�g��figure����������
writeVideo(vidObj, getframe(gcf));
end