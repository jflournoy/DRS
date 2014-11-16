% make DSD stimulus
%% set some paths
matDir = '/Users/wem3/Desktop/drs/materials';
coinFile = [matDir,filesep,'coin.png'];
yesFile = [matDir,filesep,'yes-200.png'];
noFile = [matDir,filesep,'no-200.png'];
selfFile = [matDir,filesep,'self-200.png'];
deltaFile = [matDir,filesep,'delta-200.png'];
leftFile = [matDir,filesep,'hand-L-200.png'];
rightFile = [matDir,filesep,'hand-R-200.png'];
% read in the stimuli
[coinImg,~,coinAlpha]=imread(coinFile);
coinImg(:,:,4) = coinAlpha;
coin1 = [zeros(76,105,4),coinImg,zeros(76,105,4)];
coin2 = [zeros(76,70,4),coinImg,zeros(76,10,4),coinImg,zeros(76,70,4)];
coin3 = [zeros(76,35,4),coinImg,zeros(76,10,4),coinImg,zeros(76,10,4),coinImg,zeros(76,35,4)];
coin4 = [coinImg,zeros(76,10,4),coinImg,zeros(76,10,4),coinImg,zeros(76,10,4),coinImg];
coin5 = zeros(size(coin4)); % coin 5 is actually $0.00 
% (it's 5th for convenient indexing)
stim.coins = {coin1, coin2, coin3, coin4, coin5};
%% self icon (for svc)
[~,~,stim.alpha.self] = imread(selfFile);
%% delta icon (for svc)
[~,~,stim.alpha.delta] = imread(deltaFile);
%% yes icon (for svc)
[~,~,stim.alpha.yes] = imread(yesFile);
%% no icon (for svc)
[~,~,stim.alpha.no] = imread(noFile);
%% left icon (for svc)
[~,~,stim.alpha.left] = imread(leftFile);
%% left icon (for svc)
[~,~,stim.alpha.right] = imread(rightFile);

% colorscheme
stim.bg     = [29  31  33  255]./255; % bg
stim.grey   = [224 224 224 255]./255; % grey
stim.white  = [255 255 255 255]./255; % white
stim.red    = [244  82  82 255]./255; % red
stim.orange = [252 147  55 255]./255; % orange
stim.yellow = [190 168  36 255]./255;  % yellow
stim.green  = [ 60 218  96 255]./255; % aquagreen
stim.sky    = [ 59 190 213 255]./255; % sky
stim.blue   = [ 79  82 230 255]./255; % blurple
stim.pink   = [167  47 187 255]./255; % pinkle

% set up screen positions
xDim = 1920; % hardcoded here, but built to work on 3/4 as well
yDim = 1080;
unit = xDim/16;
xCenter = xDim/2;
yCenter = yDim/2;
box.xDim = xDim;
box.yDim = yDim;
box.unit = unit;
box.xCenter = xCenter;
box.yCenter = yCenter;
% posLR is an N x 3 matrix for making symmetrical boxen 
posLR = [... % [ left x position, y position, right x position ]
(xCenter - 3*unit), (yCenter - 2.5*unit), (xCenter + 3*unit) % 1. choiceBoxen
(xCenter - 3*unit), (yCenter - 1.5*unit), (xCenter + 3*unit) % 2. coinBoxen
(xCenter - 5*unit), (yCenter + 2.5*unit), (xCenter + 5*unit) % 3. handBoxen
(xCenter - 2*unit), (yCenter + 0.5*unit), (xCenter + 2*unit) % 4. respBoxen
];
% structure to hold boxen...
box.L.choice = CenterRectOnPointd([0 0 4*unit unit],posLR(1,1),posLR(1,2));
box.R.choice = CenterRectOnPointd([0 0 4*unit unit],posLR(1,3),posLR(1,2));
box.L.coin = CenterRectOnPointd([0 0 270 76],posLR(2,1),posLR(2,2));
box.R.coin = CenterRectOnPointd([0 0 270 76],posLR(2,3),posLR(2,2));
box.L.hand = CenterRectOnPointd([0 0 200 200],posLR(3,1),posLR(3,2));
box.R.hand = CenterRectOnPointd([0 0 200 200],posLR(3,3),posLR(3,2));
box.L.resp = CenterRectOnPointd([0 0 200 200],posLR(4,1),posLR(4,2));
box.R.resp = CenterRectOnPointd([0 0 200 200],posLR(4,3),posLR(4,2));
box.statement = CenterRectOnPointd([0 0 6*unit unit],xCenter,yCenter);

%% prefacbricate color boxen (?)
for rgbCount = 1:3
  box.bg(:,:,rgbCount)      = ones(200,200).*stim.bg(rgbCount);
  box.grey(:,:,rgbCount)    = ones(200,200).*stim.grey(rgbCount);
  box.white(:,:,rgbCount)   = ones(200,200).*stim.white(rgbCount);
  box.red(:,:,rgbCount)     = ones(200,200).*stim.red(rgbCount);
  box.orange(:,:,rgbCount)  = ones(200,200).*stim.orange(rgbCount);
  box.yellow(:,:,rgbCount)  = ones(200,200).*stim.yellow(rgbCount);
  box.green(:,:,rgbCount)   = ones(200,200).*stim.green(rgbCount);
  box.sky(:,:,rgbCount)     = ones(200,200).*stim.sky(rgbCount);
  box.blue(:,:,rgbCount)    = ones(200,200).*stim.blue(rgbCount);
  box.pink(:,:,rgbCount)    = ones(200,200).*stim.pink(rgbCount);
end
  stim.box = box;

%% aliens for rpe
% for aCount = 1:5
%   alienImg{aCount} = imread(alienFiles{aCount});
% end
% stim.aliens = alienImg;
%caBut('stim');
save DRSstim.mat;

