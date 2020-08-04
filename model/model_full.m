function [spike] = model_full(s,iter,param)
%==========================================================================
% model_full is a function to simulate the full model from paper
% 'How well do reduced models capture the dynamics in models of interacting
% neurons?' written by Yao Li. 

% In the folder reference, there is a simple note about this full model.

% Here the input param is a struct that contains 
% * param.M, param.Mr: 
% *     Numbers of potential state.
% * param.lambda_e, param.lambda_i: 
% *     Parameters for the external drive's Poisson kicks.
% * param.tau_ee,param.tau_ie, param.tau_i, param.tau_r:
% *     Parameters for the exponential distributed delay time of each kind of spikes.
% * param.ni, param.ne:
% *     Numbers of E,I neurons.
% * param.s_ee, param.s_ei, param.s_ie, param.s_ii:
% *     Parameters for the spike effects.
% * param.p_ee, param.p_ei, param.p_ie, param.p_ii:
% *     The probability about the synaptic neurons.

% The input s is the initial status matrix. If s is false, we will set it
% as a zero matrix.

% The output spike is a matrix where each columns represent the spike times
% of a neuron.The first row is the total num of its spikes.
%==========================================================================
c                                 = zeros(4,param.ne + param.ni);
c(1,1:param.ne)                   = param.lambda_e; 
c(1,param.ne+1:param.ne+param.ni) = param.lambda_i;
c(2,1:param.ne)                   = param.tau_ee; 
c(2,param.ne+1:param.ne+param.ni) = param.tau_ie; 
c(3,:)                            = param.tau_i;
c(4,:)                            = param.tau_r;
%c is time constant matrix. The first row is lambda_e(i), the second row 
%correspond to H_e, the third row correspond to H_i, the fourth row
%correspond to tau_r.

if s == false
s=zeros(4,param.ne+param.ni);
end
%s is state matrix. The first three rows indicate the triplet(V,H_e,H_i)for
%each neuron, the fourth row is 1 and 0 indicating whether a neuron is at refractory
%state(1 means at refractory).

m=zeros(4,param.ne+param.ni);
m(1,:)=c(1,:);
%m is mean matrix of the next random trial. The first row of m is the same as
%the first row of c, while the other three rows is obtained by c(2:4,:)./s(2:4,:)

spike=zeros(iter,param.ne+param.ni);
%spike is the spike time train of each neuron. The first row of spike is spike count.

t=0;

for step=1:iter
    %disp(["iteration: ", step]);
    m(2:4,:)=c(2:4,:)./s(2:4,:);
    a=exprnd(m);
    %exponential distribution random variable
    min_a=min(min(a));
    [x,y]=find(a==min_a);
    %the position of the minimum decides the next operation. 
    t=t+a(x,y);
    if x==1 %external input operates
        if s(4,y)==0
            s(1,y)=s(1,y)+1;
        end
    elseif x==2 %H_e operates
        s(x,y)=s(x,y)-1;
        if s(4,y)==0
            if y<= param.ne
                s(1,y)=s(1,y)+param.s_ee;
            else
                s(1,y)=s(1,y)+param.s_ie;
            end
        end
    elseif x==3 %H_i operates
        s(x,y)=s(x,y)-1;
        if s(4,y)==0 
            if y<=param.ne
                sv=(s(1,y)+param.Mr)*param.s_ei/(param.M+param.Mr);
                ssv=floor(sv);
                if sv-ssv-rand(1)>0
                    s(1,y)=s(1,y)-ssv-1;
                else
                    s(1,y)=s(1,y)-ssv;
                end
            else
                sv=(s(1,y)+param.Mr)*param.s_ii/(param.M+param.Mr);
                ssv=floor(sv);
                if sv-ssv-rand(1)>0
                    s(1,y)=s(1,y)-ssv-1;
                else
                    s(1,y)=s(1,y)-ssv;
                end
            end
        end
    else %recover from refractory
        s(4,y)=0;
    end
    if s(1,y)>=param.M %a neuron reaches threshold and spike
        s(1,y)=0;
        s(4,y)=1;
        if y<=param.ne %an excitatory spike
            %decide the postsynaptic neurons
            p=rand(1,param.ne+param.ni);
            p(1:param.ne)=-p(1:param.ne)+param.p_ee; p(param.ne+1:param.ne+param.ni)=-p(param.ne+1:param.ne+param.ni)+param.p_ie;
            p=sign(abs(p)+p);
            s(2,:)=s(2,:)+p;
        else %an inhibitory spike
            %decide the postsynaptic neurons
            p=rand(1,param.ne+param.ni);
            p(1:param.ne)=-p(1:param.ne)+param.p_ei; p(param.ne+1:param.ne+param.ni)=-p(param.ne+1:param.ne+param.ni)+param.p_ii;
            p=sign(abs(p)+p);
            s(3,:)=s(3,:)+p;
        end
        spike(1,y)=spike(1,y)+1; %write down the spike time
        spike(spike(1,y)+1,y)=t;
    end
end
end

