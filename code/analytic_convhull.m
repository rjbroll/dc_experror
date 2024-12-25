%%%%%%%% Test analytic convex hull %%%%%%%%%%%

% Set parameters
alpha = 0;
beta = 2;
m_z = .25;
N = 50000;

% Draw random pairs of points on each side of Y-Z plane
r0 = m_z.*rand(N,2) - m_z; % X coordinate < 0
r1 = (1-m_z).*rand(N,2); % X coordinate >= 0
v0 = zeros(N,3,2); % 3D array that holds pairs 0
v1 = zeros(N,3,2); % 3D array that holds pairs 1
for i=1:N
    for j= 1:2
        v0(i,:,j) = g_z(r0(i,j),alpha,beta,m_z)';
        v1(i,:,j) = g_z(r1(i,j),alpha,beta,m_z)';
    end
end

%% Randomly-weighted average of each pair
w0 = rand(N,1); % weights 0
w1 = rand(N,1); % weights 1
c0 = v0(:,:,1).*w0 + v0(:,:,2).*(1-w0);
c1 = v1(:,:,1).*w1 + v1(:,:,2).*(1-w1);

d = zeros(N,3);
for i = 1:N
    w = c1(i,1)/(c1(i,1) - c0(i,1));
    d(i,:) = w.*c0(i,:) + (1-w).*c1(i,:);
end


%% Analytic


a0=zeros(101,2);
for i=0:100
    t0 = ana_trace0(i/400 - .25,alpha,beta,m_z);
    a0(i+1,:) = t0(2:3)';
end
a1 = zeros(103,2);
for i = 0:102
    t1 = ana_trace1(.75-(i/136),alpha,beta,m_z);
    a1(i+1,:) = t1(2:3)';
end

%% plot
scatter(d(:,2), d(:,3),MarkerEdgeColor="blue")
hold on
scatter(a0(:,1),a0(:,2),MarkerEdgeColor="red",LineWidth=1)
scatter(a1(:,1),a1(:,2),MarkerEdgeColor="red",LineWidth=1)
hold off



%% functions
function t0 = ana_trace0(u,alpha,beta,m_z)
    w = (1-m_z)/(1-m_z-u);
    t0 = w.*g_z(u,alpha,beta,m_z) + (1-w).*g_z(.75,alpha,beta,m_z);
end

function t1 = ana_trace1(u,alpha,beta,m_z)
    w = u/(u+m_z);
    t1 = w.*g_z(-.25,alpha,beta,m_z) + (1-w).*g_z(u,alpha,beta,m_z);
end



%% scratch
% v0 = arrayfun(@(u) g_z(u,alpha,beta,m_z), r0, 'UniformOutput',false); % turn r0 into vectors
% v1 = arrayfun(@(u) g_z(u,alpha,beta,m_z), r1, 'UniformOutput',false); % turn r1 into vectors
% v0test = reshape(v0,[10000,3,2]);



